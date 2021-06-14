Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11BD3A661B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhFNL4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:56:43 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:47026 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbhFNL4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:56:42 -0400
Received: by mail-ot1-f49.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso10477767otl.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 04:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ieOvNU/x+INuKn7N76sND0jvwlaKXgF7dEwq8ZAwvEc=;
        b=rCt9Y+sUnZlZqtFz97xO/gzUd+LR+vnvY+fW66IipHT9fm7vGqbidMU6wd4Z0hPMnx
         uypyIgcKDK9VbGCWAjFJZI1HFTtyqDS0XVGFe5gwPrKLbuwbZguERJ+CeNzp4oGnF6ZD
         0qyxQqbE7DdKz9N7/OGYLY8vuIb5u2g08oGEqfXH690V1qu9i/UXo6fdDvZZIU8SvohI
         f9HKQJoNw67loqIWwijfF6dSkU5QB1kAu0uSmc4qY2HS+29Tingut6R+oGjSGCxbMfo8
         HKkiAxpum2aUISoQ3QiGeFMA2QwFAGz1dOJUSrzGyljLAd3go+ATvuiL4qB4VMu6+N6Y
         1SAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ieOvNU/x+INuKn7N76sND0jvwlaKXgF7dEwq8ZAwvEc=;
        b=tLpVbXHEy0KmACQvP+N9NuOMBu+cX8B3M43OhRIHg0rfGwtLh2Wzd09v1ttiVzQ4ER
         TPChQkBi9Kur7hjfN8NL5njJJv4bWq1ApT8djNXrkNh6HEbKXJg3TwZh7CgtbbYdEEsP
         R/4QlqTx/ssjpuocucidPC0JEy5L9l4Qptf8eH1YhAmTtcH0kPvYx2HSyH2HUtKdPgAY
         YIy6AqQ663OGVjEW51HMVbJmhyOy4+uToE8oUnt6LsO6x71tjLdUbgB+V1N/zhO72wNX
         M/LyZHjk4UCOV1n1cY6CPXpEPvbahtgWJeWLDHja//LSZyBmG7lxfc9YU/T09AFbDm52
         5xOg==
X-Gm-Message-State: AOAM531uqge+ESRC2KpE1d6i34nd1AAuncDITk7HBmfMt/jkwDAyhOhu
        qPPp59vS3NsXEWV5bEYnxhtvfmr0WZE=
X-Google-Smtp-Source: ABdhPJy5xjvEqZWExtX5Z5KrBKg9SJAmMRz3WfABPjHiNR0EOUf2mtN6f/ltXC8LAPqeP+EmhvaqOw==
X-Received: by 2002:a05:6830:25d6:: with SMTP id d22mr13067144otu.249.1623671619322;
        Mon, 14 Jun 2021 04:53:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 30sm2749492ott.78.2021.06.14.04.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 04:53:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Jun 2021 04:53:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.13-rc6
Message-ID: <20210614115337.GA3657031@roeck-us.net>
References: <CAHk-=wi9so00V0_ZVBP8oSZpowoWu5VKKTswGz=nuYTpWkkqQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi9so00V0_ZVBP8oSZpowoWu5VKKTswGz=nuYTpWkkqQA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 03:32:22PM -0700, Linus Torvalds wrote:
> Nothing particularly special to say about this - rc6 is certainly
> smaller than rc5 was, so we're moving in the right direction.
> 
> It's also not larger (or smaller) than usual for this stage, nor am I
> aware of any particularly worrying reports, so I think we're all good.
> The diffstat is nice and flat with a couple of small spikes for a few
> specific drivers. It all looks very normal and non-threatening, in
> other words.
> 
> Most of the diff by far is drivers (usb, gpu, regulator, rdma, spi,
> pinctrl, scsi..), with just a few other areas: some x86 fixes (mainly
> kvm), some RISC-V ones, tiny btrfs and nfs client fixes, a couple of
> core kernel (scheduler, tracing) fixes.
> 
> It's all really pretty small.
> 
> Let's hope the trend continues, and we'll have a nice timely 5.13
> release. But please do keep testing and verifying,
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 462 pass: 462 fail: 0

Guenter
