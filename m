Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833F03116E5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhBEXTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhBEO1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:27:11 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031FCC06121D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:05:17 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j21so3600266wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eGOOutKLxLHuDWRvK+M8dRwnjyV72qCzemkFRaNjMd0=;
        b=fajAIsUFsEn4Zox3hchXK3vs/wPdWRAysHjxWZzANo1O3gtJ32uY2DiCuvME2i4zDK
         O87Tjlsrl+61Q5a6eUigMA8GbqtSh8miE/QXb4VGXirIHPwtxgr6+x/5OuWKUUXXtL34
         vyfUjYHxEyVKs5YH0gMptOf+LMq/AwJAfdvNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eGOOutKLxLHuDWRvK+M8dRwnjyV72qCzemkFRaNjMd0=;
        b=jgWoNwHyNIhye34724+ESafrqakva9Uu5qi1qvs/mDdCIN1uDOeEITiyOgNQOqnrmr
         ahmPW6Jw5V078MbyQjjN7YF36MpI69QPOcnmlypYMQX4eEuwGO0v6eesbTdWxblUJTsD
         pWxQLofNOBcc+USmnoNFnOTQn4DDXXLrx0iziVMDrX8ea6dhoZjFJrBYy+/HL8mVNA8k
         IQ7UtdAE7tZxG09n10/kemLleKYcQSI8ukUgLrN4IS2s1//klRwRehVRLq8W16LdFp1P
         OdGtfySvpbO0KWwQeQXLYiRfchy7yECkZ8ICJSUBYkvep2iUU3yHHtKzwfNy95TUqOd/
         3Uvw==
X-Gm-Message-State: AOAM530ckZ+jhXNN7OdLWpODxNlwsWFalTpS4Q8zzH6Lcrp7mkbzBuVY
        +yRNFqxXi2AnxytDlC6SZOdFkWNfmTlXZ/+x
X-Google-Smtp-Source: ABdhPJzVY1Wty3cQYEGg/TFE7XsX6gbwEIFJQKAVo2mtiCCQ4MOafpSIrKve4YKVGrfOZnmtFFyvHA==
X-Received: by 2002:a1c:ba44:: with SMTP id k65mr3733927wmf.25.1612535172614;
        Fri, 05 Feb 2021 06:26:12 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id 35sm13879101wrn.42.2021.02.05.06.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:26:12 -0800 (PST)
Date:   Fri, 5 Feb 2021 14:26:11 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com
Subject: Re: [PATCH] printk: Userspace format enumeration support
Message-ID: <YB1Vgyi11cBkL1P7@chrisdown.name>
References: <YBwU0G+P0vb9wTwm@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YBwU0G+P0vb9wTwm@chrisdown.name>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, and one more I just spotted and will fix in v2 after other feedback is in:

Chris Down writes:
>+static void store_printk_fmt_sec(const struct module *mod, const char **start,
>+				 const char **end)
>+{
>+	struct printk_fmt_sec *ps = NULL;
>+	const char **fptr = NULL;
>+	size_t size = 0;
>+
>+	ps = kmalloc(sizeof(struct printk_fmt_sec), GFP_KERNEL);
>+	if (!ps)
>+		return;
>+
>+	ps->module = mod;
>+	ps->start = start;
>+	ps->end = end;
>+
>+	for (fptr = ps->start; fptr < ps->end; fptr++)
>+		size += strlen(*fptr) + 1;

This still works, but is out of date and doesn't account for the module and 
comma, so results in one more unnecessary round trip doing seq_buf_alloc.
