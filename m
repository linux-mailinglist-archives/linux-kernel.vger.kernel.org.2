Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF552314619
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 03:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhBICSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 21:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBICSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:18:01 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D958C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 18:17:21 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id g15so11491789pgu.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 18:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ik38m4IjcFLsdwQI0HpvP26246DHILYTF24fdWKk08Y=;
        b=tmMXxTh/2F4edrYUOQigogZEfG5mpJje42FVNrAslBy3B7onZFqw4ocOUlaG2fNwd/
         +5ZJNj8MfAnBydeOq72rMwSS2QzbDL4LpemyLMO8XMFdMX8C1fpzTF/bKGAKPFk4Nnwd
         edQTzzW7oSw/4a/pOZFxiACvHSwJEw8eJlrew7YXdCmwNJzngd9WJywg60zvBmDOXjo0
         yO2dylbodn/vn/hmpw4Gi+jlwQ8S9doYzqS8aJVkZXaWkasJb54ng2WU2Bx8slSCLUWo
         NI+SgbYsoYZROOJ9x7uP7Yx9AQhaAFi+TNqnj2GHqOik+o2bsT5JLNV1KIRhPXKW7xsx
         fBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ik38m4IjcFLsdwQI0HpvP26246DHILYTF24fdWKk08Y=;
        b=E8G2ywKDY/dtuXMBZPreye1Vzt34m3D4XR/qaGIQQF+hFB+V39vwtgLm78XjIRmhwj
         vddzeHvHqiG/3awEdLwQ7McvBE/gg16VWgWAp/CxKocz7mY5ACRuA2wGSVeW4KFq6KFZ
         0nbI0LsoNwGfGGTf/pnp1PXS4kCwziCh/LL+OSsE/AfaZkCrUmUmaEdQ2okYHX/yhX2Y
         ze7YiLyVLFNK9mX2/n8RCx6dN/m5X9hwW8MqDjhhBqJRXGaovZNx9xoDKx3PYjsMAgAb
         lPsUL7qd8GB5ZRIs+n0lV5sDBGclSaiQFP+WJ9bp0ydiR8UfhplL9i4jWKRPK09Z6MtX
         6Atw==
X-Gm-Message-State: AOAM532TK00BY4P09wdyGltnH29VQ85/AY8DXQMr5jWBAMYf5okFHp9P
        XFiQpFrSdqdhXQg+TxJIpPg=
X-Google-Smtp-Source: ABdhPJxjL9WDOGhDfIffN21IoL/wEQMHKr+tIuSkIgIywtF5AzY7qGhAPWaMxSD+iTRMl84d0pNHZw==
X-Received: by 2002:a63:4521:: with SMTP id s33mr17345380pga.16.1612837040883;
        Mon, 08 Feb 2021 18:17:20 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id h70sm18654407pfe.70.2021.02.08.18.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 18:17:19 -0800 (PST)
Date:   Tue, 9 Feb 2021 11:17:18 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, "J. Avila" <elavila@google.com>
Subject: Re: [PATCH] printk: avoid prb_first_valid_seq() where possible
Message-ID: <YCHwruhEJ7yi/tK3@jagdpanzerIV.localdomain>
References: <20210205141728.18117-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205141728.18117-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/02/05 15:23), John Ogness wrote:
> If message sizes average larger than expected (more than 32
> characters), the data_ring will wrap before the desc_ring. Once the
> data_ring wraps, it will start invalidating descriptors. These
> invalid descriptors hang around until they are eventually recycled
> when the desc_ring wraps. Readers do not care about invalid
> descriptors, but they still need to iterate past them. If the
> average message size is much larger than 32 characters, then there
> will be many invalid descriptors preceding the valid descriptors.
> 
> The function prb_first_valid_seq() always begins at the oldest
> descriptor and searches for the first valid descriptor. This can
> be rather expensive for the above scenario. And, in fact, because
> of its heavy usage in /dev/kmsg, there have been reports of long
> delays and even RCU stalls.
> 
> For code that does not need to search from the oldest record,
> replace prb_first_valid_seq() usage with prb_read_valid_*()
> functions, which provide a start sequence number to search from.
> 
> Fixes: 896fbe20b4e2333fb55 ("printk: use the lockless ringbuffer")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: J. Avila <elavila@google.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>


Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>


> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 5a95c688621f..035aae771ea1 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -735,9 +735,9 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
>  		logbuf_lock_irq();
>  	}
>  
> -	if (user->seq < prb_first_valid_seq(prb)) {
> +	if (r->info->seq != user->seq) {
>  		/* our last seen message is gone, return error and reset */
> -		user->seq = prb_first_valid_seq(prb);

Yeah, I can see how this pattern can be expensive, it would have been
less obvious and harder to spot had it been something like this

	valid_seq = prb_first_valid_seq(prb);
	if (user->seq < valid_seq) {
		user->seq = valid_seq;
		...
	}

Great analysis, John.

I wonder if Intel test robot measures all test execution times; I do
recall "we saw N% performance improvement after patch P" emails, but
not sure if all of the tests are being tracked.

	-ss
