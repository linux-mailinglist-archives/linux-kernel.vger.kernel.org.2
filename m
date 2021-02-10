Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D0B316DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 19:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhBJSHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 13:07:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33286 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhBJSAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:00:49 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612980007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VVaz0IfL2E09co0Q9gha9+MbY3zsBtFKkJzzyGGZ4ck=;
        b=lnXI4mqtiZKe/PSZaFirN123iMcJeSpQSmS1r1VGQkTwJK/fbz82IxKWOc5N909VzZM4m0
        Gtz/PXavtRcv4K8eiEjOePEoXo+M5tLdSOMrL8rzeTAaUGgJniGiwPTnE8DKhd6fOP07qD
        vZvqILfxKYwZOcU4EiSybtrwrwUKhK77V0DZx5ce/hWQN3Yscg3R6cOtDgBqhavuKe/jx8
        P2p1h9UHUOI9QfPpPqKTPlYY2gYRmhXf0tw/nG9i0FSAEbWFhecZLQXbV6QeO83OvX4GNy
        v5qTDJ6cXOx3NlXFVXw57t8mgGb4vdw5vnlR8wd0rc50sGFyVHVvfnbC6BLBHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612980007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VVaz0IfL2E09co0Q9gha9+MbY3zsBtFKkJzzyGGZ4ck=;
        b=kQcVkkEjzNJpDvt/R9ad5yAjImmeSy0oKKM+gUWAWnsbln6aWlAnTas+pku3swqwKJZjsY
        SZrQWzaLdkW6vMCA==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, "J. Avila" <elavila@google.com>,
        Oliver Sang <oliver.sang@intel.com>
Subject: Re: [PATCH] printk: avoid prb_first_valid_seq() where possible
In-Reply-To: <87ft26oqya.fsf@jogness.linutronix.de>
References: <20210205141728.18117-1-john.ogness@linutronix.de> <YCDdwY8mMb9JZkXn@jagdpanzerIV.localdomain> <87ft26oqya.fsf@jogness.linutronix.de>
Date:   Wed, 10 Feb 2021 19:06:07 +0106
Message-ID: <877dnf4xco.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-08, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>> Can we please also ask the kernel test robot to test this patch?

Oliver Sang from LKP was able to verify that the RCU stall problem is
not seen anymore on their side. See his response below.

Thanks Oliver!

John Ogness

On 2021-02-10, Oliver Sang <oliver.sang@intel.com> wrote:
> On Mon, Feb 08, 2021 at 10:35:27AM +0106, John Ogness wrote:
>> Hello LKP Project,
>> 
>> Thank you for your valuable and excellent work!
>> 
>> You recently detected a problem:
>> 
>> https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/STZF3OODVA5KOG447JR2AJJXREWIPRXD/
>> 
>> We have posted a patch to fix the issue:
>> 
>> https://lkml.kernel.org/r/20210205141728.18117-1-john.ogness@linutronix.de
>
> Hi John Ogness,
>
> by applying the patch upon below commit:
> commit: b031a684bfd01d633c79d281bd0cf11c2f834ada ("printk: remove logbuf_lock writer-protection of ringbuffer")
>
> we didn't reproduce the previous INFO:rcu_tasks_detected_stalls_on_tasks
> issue in 30 runs:
>
> b031a684bfd01d63: ("printk: remove logbuf_lock writer-protection of ringbuffer")
> 7e926a042bfad8b7: ("printk: avoid prb_first_valid_seq() where possible")
>
> b031a684bfd01d63  7e926a042bfad8b7334b4677d3
> ----------------  --------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>          10:21         -48%            :30    dmesg.INFO:rcu_tasks_detected_stalls_on_tasks
>          19:21         -90%            :30    last_state.is_incomplete_run
>           1:21          -5%            :30    last_state.post_run
>
>
>> 
>> Using a local lkp installation I can verify the problem is fixed. But we
>> would like to know if there possibilities to verify fixes using the LKP
>> test robot? Or is there any way to check that the test robot sees the
>> problem is fixed?
>> 
>> Thanks.
>> 
>> John Ogness
