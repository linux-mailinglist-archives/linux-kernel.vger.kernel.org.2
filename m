Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C043AFE8D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 09:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhFVIBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 04:01:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55508 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhFVIBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:01:37 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624348760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZGSlWICB2h4Dw7LZ9WqyZyhUMTccSBCuksiu26HMfqU=;
        b=os0r35UqNpXteZH22a/5pzwbxjcwZ/UKWBDqtNXLsO67qmN/lCJm+il3VIXTsd4Y+Bdcqj
        ttwSelnr9KOOwHhx2q9UfDYQPEZnYo0iRFA1zHIJ4rXya6Flsv2JUhiHEGLhntxTJLrstX
        up/tlm5JalzTzzqzuxYivcHdQYtR80PLD2QgLlkwmQdXQtW0izVpMnPbxIVY+DKcCNi1zW
        WZ1hqZYz6y7LWk645i3nXIfAw4q52bp9d+84RP6SRH6tvUg/YsZfamKlUhLGBn7R3kibLU
        rctmibQycEkr+g7N3r67xuXH4xihGfrjivj4mo4VsX2CcigbyLmYcTJa/+QLFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624348760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZGSlWICB2h4Dw7LZ9WqyZyhUMTccSBCuksiu26HMfqU=;
        b=daSmgyNTiFSqeCJWgsGpRDkh1aBhbwTTEAJuXc9zKTvCcF78LL/mybgRgr8crYx7p2xTMq
        hR/N5QvaCu41T9AQ==
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     syzbot <syzbot+0bac5fec63d4f399ba98@syzkaller.appspotmail.com>,
        axboe@kernel.dk, christian@brauner.io, ebiederm@xmission.com,
        elver@google.com, linux-kernel@vger.kernel.org, pcc@google.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] signal: Prevent sigqueue caching after task got released
In-Reply-To: <20210622063405.GA7570@redhat.com>
References: <000000000000148b4b05c419cbbb@google.com> <878s32g6j5.ffs@nanos.tec.linutronix.de> <20210622063405.GA7570@redhat.com>
Date:   Tue, 22 Jun 2021 09:59:20 +0200
Message-ID: <87zgvie3dz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22 2021 at 08:34, Oleg Nesterov wrote:
> On 06/22, Thomas Gleixner wrote:
>
> I guess you mean the race with exit_notify() ? Could you spell please?

Yes let me rephrase that.

> I am just curious how exactly this problem was found.

I was looking at that syzbot report

  https://lore.kernel.org/r/000000000000148b4b05c419cbbb@google.com

and analyzed it how this ends up leaking memory.

> This doesn't really matter, because damn yes, a task T can call
> release_task(another_task)->sigqueue_cache_or_free() after
> exit_task_sigqueue_cache(T) was already called. For example, a last non-leader
> thread exits and reaps a zombie leader.
>
> Somehow I thought that exit_task_sigqueue_cache() at the end of __exit_signal()
> should fix this problem, but this is obviously wrong.
>
>
>> @@ -463,13 +469,18 @@ void exit_task_sigqueue_cache(struct tas
>>  	struct sigqueue *q = tsk->sigqueue_cache;
>>  
>>  	if (q) {
>> -		tsk->sigqueue_cache = NULL;
>>  		/*
>>  		 * Hand it back to the cache as the task might
>>  		 * be self reaping which would leak the object.
>>  		 */
>>  		 kmem_cache_free(sigqueue_cachep, q);
>>  	}
>> +
>> +	/*
>> +	 * Set an error pointer to ensure that @tsk will not cache a
>> +	 * sigqueue when it is reaping it's child tasks
>> +	 */
>> +	tsk->sigqueue_cache = ERR_PTR(-1);
>>  }
>
>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
