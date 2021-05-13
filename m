Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9E437FFC3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 23:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhEMVYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 17:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhEMVYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 17:24:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EABC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 14:22:50 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e7so9644691wrc.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 14:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/MEq+UBCU+l4RH36NSzRMAhZN26XnoAxAxQgfJvnkbk=;
        b=hHulSSfXiocRxyAAgB/J9GXLcM1fw45I2P+M7hLg80kRIMqcUXIfQaJXSUysKhegud
         /q7y1JP9zrxY7DNzFAwN8bPrPIRBIqw8DyNbZp9VLiVPlybgi/CzJ9v4qA2YuR/L3Jsw
         +CjLLKoVYS67v4qO2szqXzwVo7CmVLecWTnM5KDIIrA3qkqbkI0Ier7GkmKjvaOOXt5C
         oqeIXvoC7NEBRmq8y1YhQOdXAmhIKoKHnAt3d2xXD57xFUsatsCz4dzjTbsqwcFVUL0s
         xLg3Q81jjUrxHmL+8e40GpvL92K8lKSmMphFhA54lu6VpWkKZgbYy7IkwFUkIbKDlKJ6
         NsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/MEq+UBCU+l4RH36NSzRMAhZN26XnoAxAxQgfJvnkbk=;
        b=U5qIhLsXmSyPP9YpR59Ra7IQeUpG3JXXmian/tMw3A1La2+jQSGQfVeRyT+YRXHrbr
         y7hGs11cnd2PCoBbqXww/oMRqQk2UZb5kfR/i7AdUCNnrfsQ1FfKi/S6Sf84EIUpIWBe
         x/UXzFoBK8AE5X/pi4lT7aMVksnxZrImqBYP6IsQ7xwQlMSRMh5V3JN2rCfb+QY3n4Jh
         nThQ8u7Lv3AD4c25gUWwE0w+ixr4HbcAMasnQjMd/qo9jTwptiiPK2SD6hAQZQxLkZ9b
         A7DHFqoioFF3ZdMPItLzoirf3u0wXHEbzjeq/Z+yrGmuehj3bp6dpHmBuQwP+zR92Yrn
         dD/Q==
X-Gm-Message-State: AOAM533zRQW18r53gl7eTfE3KwieXCUqmsy4Zk+LZgcJVRz2JtJrvumy
        +IcyWFs6BJS+gZdcndmDEDMfC6P2WQ==
X-Google-Smtp-Source: ABdhPJy6DdNlnS6Ej9egDlsUP83P8Rk18YXNTP8PBygbN4xPZOFbdcVyH2HE8OqWtyJOYS8FIhUMLg==
X-Received: by 2002:adf:ed52:: with SMTP id u18mr4959523wro.379.1620940969254;
        Thu, 13 May 2021 14:22:49 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.105])
        by smtp.gmail.com with ESMTPSA id v18sm4876680wro.18.2021.05.13.14.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 14:22:48 -0700 (PDT)
Date:   Fri, 14 May 2021 00:22:46 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/4] sched: make nr_running() return 32-bit
Message-ID: <YJ2YphIIwMEQ5mIh@localhost.localdomain>
References: <20210422200228.1423391-1-adobriyan@gmail.com>
 <87fsyr5wtj.ffs@nanos.tec.linutronix.de>
 <YJz4TmZ7fmKFchRe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJz4TmZ7fmKFchRe@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 11:58:38AM +0200, Ingo Molnar wrote:
> 
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 

> > Just with the default config for one of my reference machines:
> > 
> >    text		data	bss	dec	 hex	 filename
> > 16679864	6627950	1671296	24979110 17d26a6 ../build/vmlinux-before
> > 16679894	6627950	1671296	24979140 17d26c4 ../build/vmlinux-after
> > ------------------------------------------------------------------------
> >      +30
> 
> Using '/usr/bin/size' to compare before/after generated code is the wrong 
> way to measure code generation improvements for smaller changes due to 
> default alignment creating a reserve of 'padding' bytes at the end of most 
> functions. You have to look at the low level generated assembly directly.

This is bloat-o-meter output with Fedora 33 .config:

This is how they look like, something gets bigger but total is smaller
(otherwise why would I send it). Apparently something got one 1 byte too
many and pushed padding.

add/remove: 0/0 grow/shrink: 6/21 up/down: 18/-42 (-24)
Function                                     old     new   delta
calc_load_fold_active                         50      56      +6
calc_load_nohz_start                         100     103      +3
calc_load_nohz_remote                         85      88      +3
calc_global_load_tick                         86      89      +3
pull_dl_task                                 901     903      +2
switched_from_dl                             613     614      +1
update_rt_migration                          165     164      -1
update_dl_migration                          141     140      -1
ttwu_do_activate                             181     180      -1
tick_nohz_idle_exit                          225     224      -1
tick_irq_enter                               227     226      -1
print_rt_rq.cold                             238     237      -1
print_rt_rq                                  413     412      -1
nr_iowait_cpu                                 31      30      -1
init_rt_rq                                   143     142      -1
show_stat                                   1745    1743      -2
nr_running                                    75      73      -2
nr_iowait                                     83      81      -2
get_cpu_iowait_time_us                       260     258      -2
get_cpu_idle_time_us                         260     258      -2
find_lock_later_rq                           507     505      -2
enqueue_task_rt                              777     775      -2
enqueue_task_dl                             2461    2459      -2
dequeue_rt_stack                             576     574      -2
menu_select                                 1492    1489      -3
__dequeue_dl_entity                          419     414      -5
init_dl_rq                                    88      81      -7
Total: Before=25729849, After=25729825, chg -0.00%
