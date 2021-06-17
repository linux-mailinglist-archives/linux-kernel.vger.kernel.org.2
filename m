Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D763ABA78
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 19:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhFQRTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 13:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbhFQRTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 13:19:12 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B05C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 10:17:03 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 131so10081052ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+UCmKSCa3QiyF+EVqn93Vr8LzsTTd7mIrDf+DuAyIo8=;
        b=GnIRWtOHp+scyIC0BY9GkWMc6n9RX9972fc1ku9BzR7mGKCasApJoQFVjH+bK68b6b
         nuO7MYsmXkE34O4F++2m2n4VlYsHAsGUuTWd6poGkIJBIaGPRP+gyhi3NeQKdansAuKE
         EnrvYXa7jYZUDOPXQzHXsLLiJhmcbQ/rFcme3BWB9QrEdHrq+qupHgTEUfWRC6gd8g0/
         QWiXmA55VKW5ujqD/HFlrgrWo86hEhnf5TCzPQfkozMhih+2CABhRpdVAcZ7V05l8txb
         XAnZMDk79vW42BxNLCUtSYciT27a6ZeqjLiRFAl5TBrnuHqArdAmWxK8utoCnE6uM400
         vgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+UCmKSCa3QiyF+EVqn93Vr8LzsTTd7mIrDf+DuAyIo8=;
        b=ntl0qeCQifMujvATdVc/P7FbuW+uBn65kUz6IkRlvRSe1mma6wJhiRekbXevc5BmpO
         +/N+LA8rCxTvysI83IdY0gitvfEMqKidMqr64VkmiNYR3FL1Wnnz69onoJximMC+Cqea
         XBmOrp66nDnapZX2gL3iniL0MEWsDjBHVUp2PEeDUs53tBNt81XJiWO99cm6YMQsx0rx
         EEh5EsAAQBF2FK/l3hsCPrKaHa7SqyF2uLYLRI3RbfJmSUnpC5a9MKtaV5slyCWHIIW6
         knOqlQm9H+dU54IAvVRu6aMn7KamnvxRtOqo6aAS3KA4gokhnavlq67EQ5OMg33nizOC
         hqAA==
X-Gm-Message-State: AOAM532zCZ4JlsrsGWdLkw5rQEpMR1RjbFIAdbwrqVEl3pufHuAyA5hD
        roXY8LadbfVZNFRH/GCG/ljVXt9Sl7loKdtHYX0kuw==
X-Google-Smtp-Source: ABdhPJxgWkkL8Fk/SBBmYIYiPs9dkdIiTPmkNy2TuzTzUAeR2E1A8icgKJtMe2NusLT2AwOAjvy60BlA3/Wuf8+dzQM=
X-Received: by 2002:a05:651c:604:: with SMTP id k4mr5605183lje.244.1623950222030;
 Thu, 17 Jun 2021 10:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210617145339.2692-1-joro@8bytes.org>
In-Reply-To: <20210617145339.2692-1-joro@8bytes.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 17 Jun 2021 10:16:50 -0700
Message-ID: <CAKwvOd=8jUsRFKg6+sqq2-DakbRBGR6Z6mR_smuxp+cMEmCHLw@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: Fix W=1 clang warning in intel/perf.c
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 7:54 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Fix this warning when compiled with clang and W=1:
>
>         drivers/iommu/intel/perf.c:16: warning: Function parameter or member 'latency_lock' not described in 'DEFINE_SPINLOCK'
>         drivers/iommu/intel/perf.c:16: warning: expecting prototype for perf.c(). Prototype was for DEFINE_SPINLOCK() instead

I think these warnings are actually produced by kernel-doc? (not clang)

>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 55ee5e67a59a ("iommu/vt-d: Add common code for dmar latency performance monitors")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/intel/perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
> index 73b7ec705552..0e8e03252d92 100644
> --- a/drivers/iommu/intel/perf.c
> +++ b/drivers/iommu/intel/perf.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> +/*
>   * perf.c - performance monitor
>   *
>   * Copyright (C) 2021 Intel Corporation
> --
> 2.31.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210617145339.2692-1-joro%408bytes.org.



-- 
Thanks,
~Nick Desaulniers
