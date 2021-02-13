Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6655031AC8F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 16:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhBMPQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 10:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhBMPQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 10:16:19 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0A7C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 07:15:39 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v7so3235426eds.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 07:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+53dwZq7zsOO2pgcY0g5mhQkV+ogJkALjGneKeNgxcg=;
        b=jawz1GjvM04O15Neojs9DXosrwwzyBWno6vjqMUD3vTZ49QwGdlpYxfxHsM6JfUwGP
         XjbW+hNGnGEnMX56sK6rQ864PvVStpp1S3F/SpBFMxWrRRov6STvv8iQL/ht4aPMBfki
         CbQGCbKVoBwJHcaduKxpX57E7YJGlxvIL9SOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+53dwZq7zsOO2pgcY0g5mhQkV+ogJkALjGneKeNgxcg=;
        b=O0IfFyDsYRL66ZRl2HHFJx+UJN8JNygxwhy18XuYwLO12uelgekuXAv1h19g6U9esP
         gWEXStv2BYqsxv5ngir4XKHbmWYnRjJVnxJq9DNdDLU4LATEHLFzfuhz0mc469b44RAL
         Njo6D2IwRf/mTrnLFWQxIMipxpcQu1onGCXwweU3WbvJlMgtHhSfAHeUsal4v6ZEK6qV
         Nc9t2eWJ1nbZsn9VnheG8sBc0n+WZ+yrSiBYQJBuYGS2o3pib96dwjqsYdFhy2j6ogBj
         3aYbUCwhqTHgQwisgPWvXTzgFCQIk3WHlhxGwRdyBj27w/4czTaSMmscLTkMYjJVnB0V
         y+iQ==
X-Gm-Message-State: AOAM533PVE7t7i3qEDaGeftUXHapS81KlHKvBChN+6Zv4K4oUx+BqlPa
        2K6NBPU8VQyQ9oXB7wyEHq+o1Q==
X-Google-Smtp-Source: ABdhPJyS1xTR/auRilP5asQTKC5DJi0vP+fInYFjo5PXFzCSI2uj25o9lT4UXgNA7pT4BkVZj787AQ==
X-Received: by 2002:a05:6402:3553:: with SMTP id f19mr8199580edd.271.1613229337967;
        Sat, 13 Feb 2021 07:15:37 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id b6sm8150659ejb.8.2021.02.13.07.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 07:15:37 -0800 (PST)
Date:   Sat, 13 Feb 2021 15:15:37 +0000
From:   Chris Down <chris@chrisdown.name>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4] printk: Userspace format enumeration support
Message-ID: <YCftGWAKe1rUbWll@chrisdown.name>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <202102130158.8qvFdZvE-lkp@intel.com>
 <YCfiYKvuW4DxgICH@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YCfiYKvuW4DxgICH@chrisdown.name>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Down writes:
>kernel test robot writes:
>>Hi Chris,
>>
>>Thank you for the patch! Yet something to improve:
>
>I'm pretty sure !CONFIG_PRINTK && CONFIG_IA64_DEBUG_CMPXCHG has been 
>broken like this long before this change.

I sent "ia64: Depend on non-static printk for cmpxchg debug"[0] to ia64 folks.  
It shouldn't block this patch, this is already broken.

0: https://lore.kernel.org/patchwork/patch/1380380/
