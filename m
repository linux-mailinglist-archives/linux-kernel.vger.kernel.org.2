Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0F531DE18
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 18:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbhBQRZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 12:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhBQRZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 12:25:17 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE4FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 09:24:37 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v62so4329691wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 09:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=28sKZ6GoDDfm+skTZwXVa7BJ4NxVV664zFdxuUjXxhg=;
        b=P1Rr2sTWnxR8gFceqInN8wXy+MYiOtuyz/fJWPTDDnjaJf2CrCSaZYc6dGFxotRXDT
         54qgwZ5gMWO9xYX+gjI5cXG5CpPyS+8hNYWDfsrnr9PKIUfFQ3ehD0k6DE53Ew+2WMEx
         zFmfZONvPNWBcJSIbUe7EKB4Xuo0Z8qDWpXg2htcKpcs29NGMzcNbdDGEZNgbhcFHCit
         F+kOq0Gzp7NqUNRYPChUFsgOq0YBaz265xjOXNV0qOZ0sR2slGntyGJESD9NxFiXFM6h
         OusM8fzuRzLAEt0CXFlEo51EG2jP4ZmGJtLjoY59XZCaePhGSmsl2npTcW4IQXVnOf94
         wDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=28sKZ6GoDDfm+skTZwXVa7BJ4NxVV664zFdxuUjXxhg=;
        b=pxvvynckiBLyHZUB0OAJGJuh9/zOhwoTKDIcN5VTPOPPSeLYogZrBKCcG4W3Q/jSnK
         szfJ5cH2ZKQ1qrg9bV1E1ntrYFNiWU6w4rde5mMMQ8jMhd094I1B0crvznDdnqlQg21/
         868X0BNR8sywfuhbvTvGmsxiCVzrFpNYRp2im32CErFE/d7ZI504np3Oq2MsyBexGzh1
         +kXbxmh5t1fSWJwhZk6Q60mArzD0PwqhzBm+eD36UXS++5nquv62HjQEhEPLsPtUpNKz
         VD/WGSgzZ2/RF1fAf+w8jaLaKquAXNiTT6IhDiUPvHJ3puHBBKeGLiZTtt+JhMmeksTi
         lKhQ==
X-Gm-Message-State: AOAM533C1ywzwPjSUYEfFuzLA2KPC1/jVP2F9a5fbRi2S/C/LGYwqxLR
        qm7IbeqdehpehW3b433NGBBXyw==
X-Google-Smtp-Source: ABdhPJyqlM3AbEF+i/vd8Ow0XcODR/KRVqiSywaqCamaAIs/m85374DnOOb2h1qv63RmhoHLO+zDBQ==
X-Received: by 2002:a7b:c007:: with SMTP id c7mr7841039wmb.59.1613582675427;
        Wed, 17 Feb 2021 09:24:35 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id v204sm3995339wmg.38.2021.02.17.09.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 09:24:35 -0800 (PST)
Date:   Wed, 17 Feb 2021 17:24:32 +0000
From:   Quentin Perret <qperret@google.com>
To:     Mate Toth-Pal <mate.toth-pal@arm.com>, r@google.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>, nd@arm.com
Subject: Re: [RFC PATCH v2 00/26] KVM/arm64: A stage 2 for the host
Message-ID: <YC1RUGv5eL1+dZDs@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <18756e24-ca87-9c98-0e20-7c7a4c4d5433@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18756e24-ca87-9c98-0e20-7c7a4c4d5433@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mate,

On Wednesday 17 Feb 2021 at 17:27:07 (+0100), Mate Toth-Pal wrote:
> We tested the pKVM changes pulled from here:
> 
> 
> >      https://android-kvm.googlesource.com/linux qperret/host-stage2-v2
> 
> 
> We were using a target with Arm architecture with FEAT_S2FWB, and found that
> there is a bug in the patch.
> 
> 
> It turned out that the Kernel checks for the extension, and sets up the
> stage 2 translation so that it forces the host memory type to write-through.
> However it seems that the code doesn't turn on the feature in the HCR_EL2
> register.
> 
> 
> We were able to fix the issue by applying the following patch:
> 
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 0cd3eb178f3b..e8521a072ea6 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -105,6 +105,8 @@ int kvm_host_prepare_stage2(void *mem_pgt_pool, void
> *dev_pgt_pool)
>                 params->vttbr = kvm_get_vttbr(mmu);
>                 params->vtcr = host_kvm.arch.vtcr;
>                 params->hcr_el2 |= HCR_VM;
> +               if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
> +                       params->hcr_el2 |= HCR_FWB;
>                 __flush_dcache_area(params, sizeof(*params));
>         }

Aha, indeed, this looks right. I'll double check HCR_EL2 to see if I'm
missing any other, and I'll add this to v3.

Thanks for testing, and the for the report.
Quentin
