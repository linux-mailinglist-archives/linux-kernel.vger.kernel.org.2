Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE866380D97
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbhENPxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhENPxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:53:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02467C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:51:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lg14so3397560ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5xc58wXzFhmzYNMz3NL2UHsy1H39sUGpBVj4z2qmuk0=;
        b=NpM1Y/3YSGQNBeOJC868yxwTLLcB+N6wOGDO+o09ehnKaajaPPcxDjAcVQ8V6FFO8U
         SUgPjDDje6e36vqe5vJ0FV56odwnRhlbUjnKAK1q2OL4AAnAdLj8fXmAMKk5iKjT4xKX
         NEaRUZhF2l7+Rmxm8aRfQp9T6ZBEQf0TtSdSGY29AVwmX4SLaQXRkZv2Q2UFQX53EeK1
         4f+bK96wHocjnqUF87HOMqA/rYN/bZte5sfAKlFhRi17AOKj1xPxinUZGRsAvwL5lpN6
         97E5mOovTUW3/No8g1z4F+E9SnG3jnZOE1i7afNrQQVKI34HGbo417C/s8viAw0tWRXf
         X5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5xc58wXzFhmzYNMz3NL2UHsy1H39sUGpBVj4z2qmuk0=;
        b=HNuYDk1ER370a/7K74GefMtDgo7uVMjD5mpw2+GDt69GUHE48SVaSI74d38F/u4uKM
         5n499R3dXcGIB9/6YOAM2csZ7iw4Z2rnl7cJ6X3rfsypJcmdrd2v6Tn7RAFLpVOsZAO+
         B9ULrhLgsqBlVuW7pOV4wb90FgG2HlBmNvBu54cJFKPuvWgbOKU8nVb2c2dbQj5nkl1y
         gJ06pSjr415lULVbAqzc+twp4KhxuTktvCnRopON+23i4jBVAeU3XxuUcLjsooru78XU
         HIMfir36qdfbO04PkEP0xhZIwi6r+W9aKJqZJ6Pvxovpf1C0M4zCJ+ZJ2keK49/huboj
         UFFw==
X-Gm-Message-State: AOAM531NUPDYLYaTStbSB6cT2NX5jH92+JlUJqqa+oE57x5Ip5NfUkjF
        OdPwsjzU+Fc3Qt8ER/NPARDxJ0NOrMi1Ji2M
X-Google-Smtp-Source: ABdhPJzvGKx34vRfvn09GhewBVYxTXKJkYwGZ7aTF9DMXGkqxv+Z77paeT2VX2HxBWMFWMnerK2HPA==
X-Received: by 2002:a17:906:7fd9:: with SMTP id r25mr4358868ejs.417.1621007509531;
        Fri, 14 May 2021 08:51:49 -0700 (PDT)
Received: from localhost.localdomain (p200300d9970469005bb43495a574ac97.dip0.t-ipconnect.de. [2003:d9:9704:6900:5bb4:3495:a574:ac97])
        by smtp.googlemail.com with ESMTPSA id p13sm3712040ejr.87.2021.05.14.08.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 08:51:48 -0700 (PDT)
Subject: Re: [RFC PATCH] ipc/mqueue: avoid sleep after wakeup
To:     Hillf Danton <hdanton@sina.com>, Davidlohr Bueso <dbueso@suse.de>
Cc:     Matthias von Faber <matthias.vonfaber@aox-tech.de>,
        Varad Gautam <varad.gautam@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210514030130.3253-1-hdanton@sina.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <7f00542c-748f-e4ff-7596-d18525664811@colorfullife.com>
Date:   Fri, 14 May 2021 17:51:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514030130.3253-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

On 5/14/21 5:01 AM, Hillf Danton wrote:
> The pipeline waker could start doing its job once waiter releases lock and
> get the work done before waiter takes a nap, so check wait condition before
> sleep to avoid waiting the wakeup that will never come, though that does not
> hurt much thanks to timer timeouts like a second.

First: The timeout could be infinity, thus the code must not rely on a 
timeout wakeup.

A wrong wait is would be a bug.


>
> Check signal for the same reason.
>
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
>
> --- y/ipc/mqueue.c
> +++ x/ipc/mqueue.c
> @@ -710,15 +710,24 @@ static int wq_sleep(struct mqueue_inode_
>   		__set_current_state(TASK_INTERRUPTIBLE);
>   
>   		spin_unlock(&info->lock);
> -		time = schedule_hrtimeout_range_clock(timeout, 0,
> -			HRTIMER_MODE_ABS, CLOCK_REALTIME);
>   

I do not see a bug:

We do the __set_current_state() while holding the spinlock. If there is 
a wakeup, then the wakeup will change current->state to TASK_RUNNING.

schedule() will not remove us from the run queue when current->state is 
TASK_RUNNING. The same applies if there are pending signals: schedule() 
checks for pending signals and sets current->state to TASK_RUNNING.

Since the __set_current_state() is done while we hold info->lock, and 
since the wakeup cannot happen before we have dropped the lock [because 
the task that wakes us up needs the same lock], I do not see how a 
wakeup could be lost.

Thus: Which issue do you see?

--

     Manfred

