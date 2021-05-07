Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA89376173
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhEGHu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhEGHu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:50:56 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF51BC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 00:49:56 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q15so2337106pgg.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 00:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+0fS9Ofyt4z9zGeEKjhWeFm0HcZLxb/OqAMO5PCmH2Q=;
        b=Q7ZH28CMbsGZDs0NLDg6SLiYSwcIODvFeSm0569dm4hcmwFHm1yw2mepk9GOOJYWgc
         CpxJ4HD0sf9su6Q/1vdgCpDZIikIwMZ7tmoneMHakalYZ17iiY0JlOXzecKhYP+wWJ5o
         ubAUe3ysArldb/tocZi+iQUOcno7nZn3JfPk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+0fS9Ofyt4z9zGeEKjhWeFm0HcZLxb/OqAMO5PCmH2Q=;
        b=TG5+wnsYU7moS0DcccyL6hvgse7mkWvNfuKBpQNhAkQWa+Ha6sifdxpNFOq8ar/DaO
         wkPNRuJKgAEuVn9N6UCj2iBxI1GYHBCmrvHjahekw9nKaZ9osKe2V944fKLfumZyquqM
         TfNyXai3ZbZF0qMTRnMIr4uyGkLxk/qQYnciw6pHKTV4VKEenPQJqacUON1K+gJMEqbp
         lfk7BOES2CZTfOMKaKQyLja/60V4N6XZ48veoec711aiu6f3psfxeMxUUrYtiKFG8yVp
         x0Q2OW229FzDEynhR+rcW9ltON4VDa7OTPkVQjZdKsukiEA4odh5m/9i2TXgp70tbyRt
         hdcA==
X-Gm-Message-State: AOAM532qb+5V6tUQ2cpdHu6imxJGp3TuXFwLd31i5CqtNzdpHz4r6Jeq
        7AwC2zJhY0Ihvh+oqj+vp5VwEA==
X-Google-Smtp-Source: ABdhPJxQ4Ns4bSmDO+hh2dReALewq8WvrjRFObZJbFiODqf0//sGaDKH4o31Fb7CMJ4r+0ARLlYTFQ==
X-Received: by 2002:aa7:946b:0:b029:28e:d912:6be7 with SMTP id t11-20020aa7946b0000b029028ed9126be7mr9075697pfq.26.1620373796567;
        Fri, 07 May 2021 00:49:56 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:35fb:b226:abe6:6928])
        by smtp.gmail.com with ESMTPSA id z65sm4196434pfb.13.2021.05.07.00.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 00:49:56 -0700 (PDT)
Date:   Fri, 7 May 2021 16:49:51 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     luojiaxing <luojiaxing@huawei.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        bobo.shaobowang@huawei.com
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
Message-ID: <YJTxH/VsUEIR7rL5@google.com>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <YJPxj83F1sBjHHAE@alley>
 <YJP4F1UIt/eRZ96s@google.com>
 <YJP5MnkJ8pJevXM6@google.com>
 <72443c6d-b70b-0e36-bab0-87705a1d8019@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72443c6d-b70b-0e36-bab0-87705a1d8019@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/07 15:33), luojiaxing wrote:
> > console_unlock()
> > {
> > 	...
> > 
> > 	if (printed_messages > limit && !console_lock_spinning_disable_and_check()) {
> > 		printk_safe_exit_irqrestore(flags);
> > 
> > 		console_locked = 0;
> > 		up_console_sem();
> > 
> > 		defer_console_output();
> > 		return;
> > 	}
> 
> 
> Hi,  Sergey, I test this,  it works.
> 
> 
> But, I have a doubt. If the log buffer exceeds limit, we can schedule IRQ
> work to become the console lock owner and let current context return.
> 
> So why not just let the IRQ work process the console output without limit?

log buffer can be several tenth of megabytes in size which IRQ work
will have to print to a potentially slow serial console, which will
trigger watchdogs on the CPU that IRQ is running on.

> I wonder if the driver can only cache the print and queue the output tasks
> to a workqueue to return

Work queue task is preemptible, which did cause problems in the past:
huge printing delays under memory pressure. So, ideally, what we want
from a console lock owner is be non-preemptible and to either print
pending messages or handover the lock to another task.
