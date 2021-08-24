Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FE63F5AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 11:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbhHXJPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 05:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbhHXJPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 05:15:22 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAF8C0613D9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 02:14:38 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id b1so16223120qtx.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 02:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=6R9MsfR3gmhuz3nWLZW1kqph4hPawg4BSnB7Fx8sGqE=;
        b=Bkod/r27mUBMfYIfxzoQRvTvoKu3LrmldiZeC8OQKd2wVKA3L0kXx4mV8DpEs9FooS
         s0uI4lOd55Yj5hCVFXYpQKcyc6mjxJdUac2SbV1zufjQvs3JsOdQ9mSGck3QNbYnxCun
         bJJSrbWuBIQX2gWLqcV30IJyDV5cans8oXwj0ihdbhKfThJWDM4iqaBi3NRJpgwW9gZT
         lzx/HYi1qYBkT+Cxsl2BNyEbX9bf8SCIEeYaf6nr2OS32Fw50Kn9GAvWg7oilBwEkYog
         YgzyWJobGdPzWnCa1UW4u6bca2zonAdPUmkzYNOXV7tg+BqRIPOUcN5501/YLT1QqHy9
         nXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=6R9MsfR3gmhuz3nWLZW1kqph4hPawg4BSnB7Fx8sGqE=;
        b=pPNZfS/fotktoqhe+nDQ7SsF/u2VlsnaOSmFcNeRMldG+jPSH3Cg+bKCmLkmErqd4y
         3v4mtVlcnPzHnT98ViOl+SfmNf+6HCZ0oH/xEf1cDH/mh8oKgNlTWzEEBpAkIM906SkW
         KnfrNwPmiPEtYEyOwMHBeCoHqLTvmJE271gqADLFoNh4wTrqCX0UHlRcLVsWCXyE9je2
         wBOaZhNPejrnPBk30kN1EM5OW6OfNSZSFaUOI8xf++H0ZovEAlTiqmvCKlXUNFDLGeWq
         uR9uL2GWDvvPcezN7Cu9UGzyfKySYSouF+5qR2DEQjwYPSpgrDbQbpz1gAlmnjsKjUn+
         4FNw==
X-Gm-Message-State: AOAM531haLZMOtfnNkdnSL/hI80pDfJkWgdAWQECDsm6oGodL/p7XU1J
        N+IUUiRxfIgoNROpTHttB6s=
X-Google-Smtp-Source: ABdhPJx4UqNi4OVETVF3balK/Re4mq/lG32MPqME9IjJObMZxQAPI0HRgPuiL2FB65IYypI6P9seGg==
X-Received: by 2002:ac8:5194:: with SMTP id c20mr24749748qtn.68.1629796477596;
        Tue, 24 Aug 2021 02:14:37 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id z21sm5464570qts.27.2021.08.24.02.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 02:14:37 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-cpufreq-hw: Fix 'make allmodconfig' build
Date:   Tue, 24 Aug 2021 09:14:30 +0000
Message-Id: <20210824091430.20367-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <440653.1629666844@turing-police>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 22 Aug 2021 17:14:04 -0400 "Valdis Klētnieks" <valdis.kletnieks@vt.edu> wrote:

> 
> [-- Attachment #1: Type: text/plain, Size: 270 bytes --]
> 
> On Sun, 22 Aug 2021 14:08:08 -0700, Randy Dunlap said:
> 
> > This fixes one build error for me but I am still seeing another one:
> >
> > ERROR: modpost: "cpu_scale" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!
> 
> That's a different patch, am working on fixing that one now..

I didn't take a deep look here, so I unsure if this is an appropriate fix, but
I was able to work-around this issue for my use case with below change.

```
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -149,6 +149,7 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 }

 DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
+EXPORT_PER_CPU_SYMBOL_GPL(cpu_scale);

 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
 {
```


Thanks,
SJ
