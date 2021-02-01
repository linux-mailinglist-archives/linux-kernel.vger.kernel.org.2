Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CD730A5B3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbhBAKoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbhBAKnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:43:35 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04A5C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:42:54 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l12so16032520wry.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KdljAzvVi5//s6op/UovX5xLDFP4TmnwHCTlJ043Sgk=;
        b=oDc7dLdep+fwQDEfn8GKNdZwRpnBo6pbFxId8749NzFRiSokjVe3DGWPKGRscTKK+K
         4uwbAOmL8cdT5tnvzsCWkSs17w/qwu2amo5Z3VgvXadbhwvMy/gOM08WBIcfdYRG+Fwf
         8/rN00FPZygg5ZVzcKauVFZnt6AtClTUkTAe+vOJ08sDUqm6VXcefnNio8jJswex+lkZ
         YpGywOvETDx/20tlLBCaFeJTUyiPAB7ttMps/767ajZUfsCgiWKWZNmPfpbW72jJu2h5
         hOea0XYe7cUUPfWv9aVdiuqCXNBrRZB/uBMqg8j5LUwlx9PaUOzVEXXgZCBtKYs+XwsF
         53/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KdljAzvVi5//s6op/UovX5xLDFP4TmnwHCTlJ043Sgk=;
        b=lMqiDFq0wRwcWhIe1+atF2thVmSEVMyrK0RpSCpg2/6Iw0QNNMYqvvyCMM/ktmGCEF
         iA2ZzKZ++j7tZLKthLxanaJ+fr5FnoF+R5iGBJFZUG7QJkwh8JXi0Ih/QXNYYS3bS7DS
         6C6F+tQie5jzjZWqw3VUGN5BEEMjN+sxxKRR4OEhVNtI/Y71cye4MQirrBcFrd1Rlb0I
         2SuegzwdftgI4sPvVPsFXjDT0K2GSAKMqJF1d7k5XIeuPHeTaHNc3kDXvUwJ4y1lnnTI
         Hzx0slVLs9G5gYXFHHw1+CaTDXw2nELVU/Xyc/lRR/kuORVzOBJNUC/UiA58NIRY2RbC
         BzKg==
X-Gm-Message-State: AOAM5334pm5k/RPYXq45B+vYfExqqB8z+xArGCZ74vJ/vWL8EsfRbiYD
        Ynlg2r2M0ifjisot/bTQqD5BCA==
X-Google-Smtp-Source: ABdhPJydmzBGxSKJDIIxBGPgQq5UBMTmfHPMLAkRE0ySxb9liEtdsEzf3CE1EZZkSpxZNhIt/1nYkA==
X-Received: by 2002:adf:e90d:: with SMTP id f13mr17047307wrm.371.1612176173319;
        Mon, 01 Feb 2021 02:42:53 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:1007:9eb8:9b35:92ae])
        by smtp.gmail.com with ESMTPSA id t15sm4716534wmi.48.2021.02.01.02.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 02:42:52 -0800 (PST)
Date:   Mon, 1 Feb 2021 10:42:51 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, kvmarm@lists.cs.columbia.edu,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: Re: [PATCH v2 4/8] KVM: arm64: Generate hyp relocation data
Message-ID: <20210201104251.5foc64qq3ewgnhuz@google.com>
References: <20210105180541.65031-1-dbrazdil@google.com>
 <20210105180541.65031-5-dbrazdil@google.com>
 <20210129214325.GA195322@roeck-us.net>
 <87r1m2lets.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1m2lets.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for writing the fix, Marc! There are no corner cases in this code so
if it boots, that should be a good indicator that all BE inputs were converted.

Just one little thing I noticed below, otherwise:
Acked-by: David Brazdil <dbrazdil@google.com>

>  arch/arm64/kvm/hyp/nvhe/Makefile     |  1 +
>  arch/arm64/kvm/hyp/nvhe/gen-hyprel.c | 57 ++++++++++++++++++++--------
>  2 files changed, 42 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> index 268be1376f74..09d04dd50eb8 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -7,6 +7,7 @@ asflags-y := -D__KVM_NVHE_HYPERVISOR__
>  ccflags-y := -D__KVM_NVHE_HYPERVISOR__
>  
>  hostprogs := gen-hyprel
> +HOST_EXTRACFLAGS += -I$(srctree)/include
This should be $(objtree), autoconf.h is generated.

David
