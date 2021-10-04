Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B484208F3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhJDKHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhJDKHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:07:07 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B25DC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 03:05:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id a11-20020a7bc1cb000000b0030d6aae48b5so2557751wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 03:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vbaYN6Cj0naTpTKsC/ilkJz/q62BHSUwgRaYb1zy820=;
        b=LluNYf2Z05QVWW3ZMGQu7ViGnKRokxh8x9obFg78/LobCRNeHuSjcYtPJ8nsGZ7Y3a
         oSErIdBzV56H4zULb8mhOSjzbHshp2yY/bbB1Ckja475D5j27k9cpbv4SqaKqOrSR106
         K5uwNEZobD09+yLG0U8fGSijBJLNmaiHW8pGKM0ZDc+Nc4NVFkhg9eVxEoimDsmjUAUW
         5SnFBm7ycmllCe9LrxSMfJTbgawR/68sw41PAZa1BungeaKMjD2rC7cXR0GjePmdYpo1
         hfxUumMppw/hJxPsrh8wIaAVleboSvxMSBPzKwoL1RZOcQrCxmUAnAe+CBFw6QufGT93
         ncGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vbaYN6Cj0naTpTKsC/ilkJz/q62BHSUwgRaYb1zy820=;
        b=REpUeX5cOVTF0kDpu/HVVkksGa57Zy7daxTKodMU2n58g6AkrCCHUgtRDgkm7hL/Cg
         2iXK5Aht6b4F+LcVVOV/SDQD6H9NxtwIj1W+Q6+TJ7QgctNs8/XLggcpTI3CwQfZd3he
         8oQR5xR8YNnya8Vbxn6nsPDG74w/+ghzcPEKYNoKdOaQ0QAURM0ZoyIJcfYYUWN+vb5I
         7dHM2bXBIDjMw/UyZkXLb9+NCHuwwsrrRAfQkhpXy8KuS49ZGw0GTv3x8oFGsMB21X2f
         tDUcMSA44GMNFBHaHfZVOubt2Awf1BSjwI8mFP6E3u+OxBHFldFsGrQ3/ub+kKr4LZA3
         68Yw==
X-Gm-Message-State: AOAM530zHoH3UPhip5QBkjjTE1lI3YErObLetpIlfT3Jv8IA74Bqs1Fx
        yrHhQMwOl1aGkrLcUpr7T+ruww==
X-Google-Smtp-Source: ABdhPJzctEI2RjiPKdjlUZAMqkTfZuBtvB97o4FGjBX56pMR2EnD7CcYgItKQi/sFeYGsYqR7QX98w==
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr18110666wmh.3.1633341916520;
        Mon, 04 Oct 2021 03:05:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:669b:5b16:60b7:a3d4])
        by smtp.gmail.com with ESMTPSA id d2sm8169477wrs.73.2021.10.04.03.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 03:05:16 -0700 (PDT)
Date:   Mon, 4 Oct 2021 11:05:12 +0100
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] KVM: arm64: Fix host stage-2 PGD refcount
Message-ID: <YVrR2M8OmU6ug1Yk@google.com>
References: <20211004090328.540941-1-qperret@google.com>
 <20211004090328.540941-2-qperret@google.com>
 <87bl45ru66.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl45ru66.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Marc,

On Monday 04 Oct 2021 at 10:55:13 (+0100), Marc Zyngier wrote:
> Hi Quentin,
> 
> On Mon, 04 Oct 2021 10:03:13 +0100,
> Quentin Perret <qperret@google.com> wrote:
> > 
> > The KVM page-table library refcounts the pages of concatenated stage-2
> > PGDs individually. However, the host's stage-2 PGD is currently managed
> > by EL2 as a single high-order compound page, which can cause the
> > refcount of the tail pages to reach 0 when they really shouldn't, hence
> > corrupting the page-table.
> 
> nit: this comment only applies to the protected mode, right? As far as
> I can tell, 'classic' KVM is just fine.

Correct, this really only applies to the host stage-2, which implies
we're in protected mode. I'll make that a bit more explicit.

> > Fix this by introducing a new hyp_split_page() helper in the EL2 page
> > allocator (matching EL1's split_page() function), and make use of it
> 
> uber nit: split_page() is not an EL1 function. more of a standard
> kernel function.

Fair enough :)

> > from host_s2_zalloc_page().
> > 
> > Fixes: 1025c8c0c6ac ("KVM: arm64: Wrap the host with a stage 2")
> > Suggested-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/kvm/hyp/include/nvhe/gfp.h |  1 +
> >  arch/arm64/kvm/hyp/nvhe/mem_protect.c |  6 +++++-
> >  arch/arm64/kvm/hyp/nvhe/page_alloc.c  | 14 ++++++++++++++
> >  3 files changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
> > index fb0f523d1492..0a048dc06a7d 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
> > @@ -24,6 +24,7 @@ struct hyp_pool {
> >  
> >  /* Allocation */
> >  void *hyp_alloc_pages(struct hyp_pool *pool, unsigned short order);
> > +void hyp_split_page(struct hyp_page *page);
> >  void hyp_get_page(struct hyp_pool *pool, void *addr);
> >  void hyp_put_page(struct hyp_pool *pool, void *addr);
> >  
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > index bacd493a4eac..93a79736c283 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -35,7 +35,11 @@ const u8 pkvm_hyp_id = 1;
> >  
> >  static void *host_s2_zalloc_pages_exact(size_t size)
> >  {
> > -	return hyp_alloc_pages(&host_s2_pool, get_order(size));
> > +	void *addr = hyp_alloc_pages(&host_s2_pool, get_order(size));
> > +
> > +	hyp_split_page(hyp_virt_to_page(addr));
> 
> The only reason this doesn't lead to a subsequent memory leak is that
> concatenated page tables are always a power of two, right?

Indeed, and also because the host stage-2 is _never_ freed, so that's
not memory we're going to reclaim anyway -- we don't have an
implementation of ->free_pages_exact() in the host stage-2 mm_ops.

> If so, that deserves a comment, because I don't think this works in
> the general case unless you actively free the pages that are between
> size and (1 << order).

Ack, that'll probably confuse me too in a few weeks, so a comment won't
hurt. I'll re-spin shortly.

Thanks,
Quentin
