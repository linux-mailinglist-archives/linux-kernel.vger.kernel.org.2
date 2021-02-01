Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8EB30A8CD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhBANdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhBANdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:33:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1267EC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 05:32:44 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612186363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r82uxta4XDi55BkAqxOkhqSJhZBf6cvt5RLzHkBDbNg=;
        b=L3Hwt1obaxZ2YsvL6Iv2YkOKkaIdBeoc/wumawwA0H7jWvoZmY7to222JOU+IPafapdyd7
        HxXyFglPecAXPjl0Tef2zulm5q0PBfFTPD97pzqRrXRdcqLBUNvAUTyX3wKkJEbUBHm08t
        6wbd/WKZe6S1OYJoELWe5TvBAoIwodLl5xZlQ0RsZkKPEUGci7KlXweD1XRHdVdwQ3OgLW
        pGNIOCsnUKDujFEurKfFs+b9W4/uUzyYMjqHqXGkGRpsrGQkdvaEmXPWK8QrXmy6cL/Ja4
        UoEc0K6wnDhplLduuMUTjex0EaWLsnsx4cD2wDtqzlRjTLK/aFgEAddSTtYX/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612186363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r82uxta4XDi55BkAqxOkhqSJhZBf6cvt5RLzHkBDbNg=;
        b=VP85MJaV5fcPyRmMx/JdQFus53ncdvLjCLdUCkYZWj0AYdlj90RiDLsj4NiSmnZRsSqFbe
        tEWp06yJWZ5d2RBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 08/12] printk: introduce a kmsg_dump iterator
In-Reply-To: <YBf/XUmgflhMHtBx@alley>
References: <20210126211551.26536-1-john.ogness@linutronix.de> <20210126211551.26536-9-john.ogness@linutronix.de> <YBf/XUmgflhMHtBx@alley>
Date:   Mon, 01 Feb 2021 14:38:42 +0106
Message-ID: <87eehzkj5x.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-01, Petr Mladek <pmladek@suse.com> wrote:
>> Rather than store the iterator information into the registered
>> kmsg_dump structure, create a separate iterator structure. The
>> kmsg_dump_iter structure can reside on the stack of the caller,
>> thus allowing lockless use of the kmsg_dump functions.
>> 
>> This is in preparation for removal of @logbuf_lock.
>
>> diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
>> index 76cc4122d08e..ecc98f549d93 100644
>> --- a/include/linux/kmsg_dump.h
>> +++ b/include/linux/kmsg_dump.h
>> @@ -29,6 +29,18 @@ enum kmsg_dump_reason {
>>  	KMSG_DUMP_MAX
>>  };
>>  
>> +/**
>> + * struct kmsg_dumper_iter - iterator for kernel crash message dumper
>> + * @active:	Flag that specifies if this is currently dumping
>> + * @cur_seq:	The record to dump (private)
>> + * @next_seq:	The first record of the next block (private)
>
> Just to be sure. This description should get update if you agree with
> the alternative one in the 1st patch.

Yes, I assumed so and adjusted my preparation-v2 series accordingly.

John
