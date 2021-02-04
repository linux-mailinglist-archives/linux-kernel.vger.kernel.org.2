Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE4230F4E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbhBDO1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbhBDOZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:25:33 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA49C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 06:24:51 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m1so3157631wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R1KAZ4C9ZeFSR+FFennp2QasFQcPFSyFTyZPPFMkXU8=;
        b=fCG8+WqCngaRVeR+fwhWXAcIWBn5Sl2e4mDoXuHKx8d69fodkwnVanTjcKzun/Oq1F
         aTuzHpifYoZkmVn9bAHqWJgOJOooBfSwFajyd2zSvXQqpExigCq2XXq0+QtPS5k0mrbC
         x0q4/10MpavYzq68sUQS9x65l72az1O6NDyfucEPMbG4JeQlFbs9Q2nyOXha6I4TQIEc
         PO/rwCmZ4HiKjmoHcQS6UP/eZBjC0WutDWRCjo2hkH2sCoVsGdcL/3M82SEwcTCBi9Vn
         dH03nNLXfcRs2DN/nVxzrDRf5njO6cbdUEANrH34er4ju+uET6WVTEZVNMKVoC/U2Mmk
         aF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R1KAZ4C9ZeFSR+FFennp2QasFQcPFSyFTyZPPFMkXU8=;
        b=cHj8M/xBwOEx2gSo10JnLiMi6IYXU7ZTclzYQt6tFQMTeqAMGA/9Llr5UQ5Zea0X1S
         hFUApddGdaTnU2teqeokCAoyjHlWpP3Uf2nKxBsRct22hk/6S57oUwWv4ksAiVFDgLqA
         XJ47vg1YM807dRD4mvQq4WeETayNH06xWoXNKrOakpzVfI3ts5aD9bUu5DnSQLvg54RM
         LOtKDnonFvPCj5xckn9ke16gOO1IGrsjf/8KObf8qz8th9QNqQuTTJr/jbDBPZyL6gJ2
         xV7/4bLtDqyDb3So/9qdAP6q0welgBOoNh9Pyb/sp3drMURCeskYrlRKjI11FKiOCM8+
         cH1Q==
X-Gm-Message-State: AOAM531asycB0aYnRWpeJhTXkZd8E2ZBUgB9ijV0sB3wwzb5f0NAlHpt
        76zABPhIsDyQnmpk/D+V+PNyQw==
X-Google-Smtp-Source: ABdhPJyG/2NylKDcXm3Y18fIrqWKuc6sdceMpQkq33NZ0aiLb5JS4Ixo+Ft8ux+j9u+mNAQt0C8/Cw==
X-Received: by 2002:a7b:c153:: with SMTP id z19mr7657226wmi.87.1612448690019;
        Thu, 04 Feb 2021 06:24:50 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id v6sm8568185wrx.32.2021.02.04.06.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 06:24:49 -0800 (PST)
Date:   Thu, 4 Feb 2021 14:24:44 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
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
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 24/26] KVM: arm64: Make memcache anonymous in
 pgtable allocator
Message-ID: <YBwDrBH8p0aEpKKC@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-25-qperret@google.com>
 <20210203155944.GH18974@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203155944.GH18974@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 Feb 2021 at 15:59:44 (+0000), Will Deacon wrote:
> On Fri, Jan 08, 2021 at 12:15:22PM +0000, Quentin Perret wrote:
> > The current stage2 page-table allocator uses a memcache to get
> > pre-allocated pages when it needs any. To allow re-using this code at
> > EL2 which uses a concept of memory pools, make the memcache argument to
> > kvm_pgtable_stage2_map() anonymous. and let the mm_ops zalloc_page()
> > callbacks use it the way they need to.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_pgtable.h | 6 +++---
> >  arch/arm64/kvm/hyp/pgtable.c         | 4 ++--
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > index 8e8f1d2c5e0e..d846bc3d3b77 100644
> > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > @@ -176,8 +176,8 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt);
> >   * @size:	Size of the mapping.
> >   * @phys:	Physical address of the memory to map.
> >   * @prot:	Permissions and attributes for the mapping.
> > - * @mc:		Cache of pre-allocated GFP_PGTABLE_USER memory from which to
> > - *		allocate page-table pages.
> > + * @mc:		Cache of pre-allocated memory from which to allocate page-table
> > + *		pages.
> 
> We should probably mention that this memory must be zeroed, since I don't
> think the page-table code takes care of that.

OK, though I think this is unrelated to this change -- this is already
true today I believe. Anyhow, I'll pile a change on top.

Cheers,
Quentin
