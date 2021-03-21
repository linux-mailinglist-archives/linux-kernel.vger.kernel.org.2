Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E394343139
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 06:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCUFeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 01:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCUFeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 01:34:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05031C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 22:34:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so8730688pjc.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 22:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EDsrsnyyRS848k4xgEE8eaKol44OUTL4I6MXcc1wR3Q=;
        b=lP5dTw+xepXkZgjsY6IVVKYUWUNndeJDc9tux5IblYKVz81tQFuBedJCm+FtltWa8x
         VHw/Vzqb1fLnn8AIAD0L+9s1pmGO5WAo4cfCISckCVBPi4ZbqihFUUUJcbZEt8qFqKfo
         Jp9TYxJMx1WVtSWqxVdVO8I8MGmXGQjZL1FU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EDsrsnyyRS848k4xgEE8eaKol44OUTL4I6MXcc1wR3Q=;
        b=CqQTwOLXUU7bl5Zabq5qFvv0FF0LtYMC2JDx/XUtJ7yQIksbYRtziClZyEl80E2Xj9
         FVM5iEi0wCElRHRy1dkGCBAoKdpSZyu2xmY+V7b5kIt493eOBrUXoqM7U8LvPBTGoHlz
         R8KBkbSO9OoUPI5mCz5VBgvaFfcAwx0mX+L2tGs+uaY4z/EnH+XdikB1nJsebK79MKUj
         VBOasS/1Om0GbtQ+KCkSyIPEQNnKE4i/2ubhygrru/FfExme26IdSNFx1JfcV21/C5RJ
         RxRaJwr1j4/VylsZfFDkudxki9bBsadmDoYz/EMYo4LpM4qeZVY3xaS9gRn067FBL0O/
         2ORQ==
X-Gm-Message-State: AOAM530+XLmzkHSN30njdU/bGh0BIOS1jOjPPznE32xu6MnBNzDBoyVL
        YMxJAvKzcmx/UhMwrPeewMAsTMuYDxyxHg==
X-Google-Smtp-Source: ABdhPJy1LE6DD3+K1rYbQtPUDDzu+L0FxnBBmSToTOwI3op/P9qZ5/pqlPUN9yN2EykI2/u+JSolXA==
X-Received: by 2002:a17:90b:388d:: with SMTP id mu13mr6765142pjb.34.1616304857662;
        Sat, 20 Mar 2021 22:34:17 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:2dfa:a0a:77ff:3953])
        by smtp.gmail.com with ESMTPSA id mp1sm9498500pjb.48.2021.03.20.22.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 22:34:17 -0700 (PDT)
Date:   Sun, 21 Mar 2021 14:34:12 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v1 1/3] printk: track/limit recursion
Message-ID: <YFba1Fje6+TeIiGW@google.com>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
 <20210316233326.10778-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316233326.10778-2-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/03/17 00:33), John Ogness wrote:
[..]
>  static inline void printk_delay(void)
> @@ -2040,11 +2105,13 @@ int vprintk_store(int facility, int level,
>  	struct prb_reserved_entry e;
>  	enum log_flags lflags = 0;
>  	struct printk_record r;
> +	unsigned long irqflags;
>  	u16 trunc_msg_len = 0;
>  	char prefix_buf[8];
>  	u16 reserve_size;
>  	va_list args2;
>  	u16 text_len;
> +	int ret = 0;
>  	u64 ts_nsec;
>  
>  	/*
> @@ -2055,6 +2122,9 @@ int vprintk_store(int facility, int level,
>  	 */
>  	ts_nsec = local_clock();
>  
> +	if (!printk_enter_irqsave(&irqflags))
> +		return 0;

I guess it can be interesting to somehow signal us that we had printk()
recursion overflow, and how many messages we lost.

3 levels of recursion seem like reasonable limit, but I maybe wouldn't
mind one extra level. And maybe we could add some sort of message prefix
for high levels of recursion nesting (levels 3+), so that things should
not be normal will be on the radars and, possibly, will be reported.

	-ss
