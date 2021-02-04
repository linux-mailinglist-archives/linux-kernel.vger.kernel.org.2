Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0D830F56F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbhBDOx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbhBDOwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:52:19 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169BFC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 06:51:38 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e9so1895547plh.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j2b0oOc+rzmzi38W+sTrovSj5jDaFAC2TznS4DZxElU=;
        b=soWUtNJ9rxQTjmER1hm91KKYjx1D2hTUbleBe3U3hCVjwO4eY8NS8NDaAfLP364QdJ
         x0N62cGzoJOUzxf7o4kpGpqTEO0dMCK9GYj8A3kPFCAEeTPNzqZoP4Maj7xZeinOCCTa
         XzOzVTL8cdIZUyBb2sR2ubIHIHAk07QzIkD1hCJM14rbEznL4BKjT8R4WGix86c+YGIf
         47169whurzBYY8RW3AriKDY+Z/5S19xhPHW5qeMLPNgPUd1M9YS8cB+ia3XtVxoKqwhg
         dfoqp+1nZiIcrGU78eAwRlfJ6WwbWxWRFCrnOd2A1MwvahD1X0kuFbsQ4HmlUb2MlfAq
         m+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2b0oOc+rzmzi38W+sTrovSj5jDaFAC2TznS4DZxElU=;
        b=aA4ugm2IA091VYbU8ZRrlJxFVGL083YP5SgjENM84sgikfoUXEsHEVEiXVvf+KbEyC
         d3GTL8Wj15OERGd/Z50SZljjWrsHYoyiYXv/KA9j0Ay0BGknOltm2airKOW6Enn04UaX
         XBcbtVNZ3U02KFBEar3yQXX4NEyUnY4kzCLmKR5nCU0xgL1OSuOXNXo32dLwZmECtwXu
         aO13gm+Z7XdyQGs4yMwpG5OC3ijBcUolmAxWrVrh8tTCyVgx8SGoWzJY11eXfopvFfyU
         pzWc2G3TwLWYFAhrqZs7WcEAMM5CSdkZCpnNdlCEincxe2O+HsdNCCauauLdoXYtL7t/
         aqFg==
X-Gm-Message-State: AOAM530gCu8JoeRm+eicYDQsxSF5Vy9pwil8UGSVCj455tNZmUvsL4I8
        IKlu3y2Tpy74IuPcMbUxF/gvnV4ytl0=
X-Google-Smtp-Source: ABdhPJx7fA7KLsWP2F4d34Pj5VS0YAoanRrPZirQ5OS3yJ5pM2+RSI6hhGsHvsCd6yxeh/96BDE3Kw==
X-Received: by 2002:a17:90a:6a43:: with SMTP id d3mr9043689pjm.224.1612450297639;
        Thu, 04 Feb 2021 06:51:37 -0800 (PST)
Received: from localhost.localdomain (61-230-45-44.dynamic-ip.hinet.net. [61.230.45.44])
        by smtp.gmail.com with ESMTPSA id u3sm6866224pfm.144.2021.02.04.06.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 06:51:36 -0800 (PST)
From:   Lecopzer Chen <lecopzer@gmail.com>
To:     will@kernel.org
Cc:     akpm@linux-foundation.org, andreyknvl@google.com, ardb@kernel.org,
        aryabinin@virtuozzo.com, broonie@kernel.org,
        catalin.marinas@arm.com, dan.j.williams@intel.com,
        dvyukov@google.com, glider@google.com, gustavoars@kernel.org,
        kasan-dev@googlegroups.com, lecopzer.chen@mediatek.com,
        lecopzer@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mm@kvack.org, linux@roeck-us.net, robin.murphy@arm.com,
        rppt@kernel.org, tyhicks@linux.microsoft.com,
        vincenzo.frascino@arm.com, yj.chiang@mediatek.com
Subject: Re: [PATCH v2 2/4] arm64: kasan: abstract _text and _end to KERNEL_START/END
Date:   Thu,  4 Feb 2021 22:51:27 +0800
Message-Id: <20210204145127.75856-1-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204124658.GB20468@willie-the-truck>
References: <20210204124658.GB20468@willie-the-truck>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Jan 09, 2021 at 06:32:50PM +0800, Lecopzer Chen wrote:
> > Arm64 provide defined macro for KERNEL_START and KERNEL_END,
> > thus replace them by the abstration instead of using _text and _end.
> > 
> > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > ---
> >  arch/arm64/mm/kasan_init.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> > index 39b218a64279..fa8d7ece895d 100644
> > --- a/arch/arm64/mm/kasan_init.c
> > +++ b/arch/arm64/mm/kasan_init.c
> > @@ -218,8 +218,8 @@ static void __init kasan_init_shadow(void)
> >  	phys_addr_t pa_start, pa_end;
> >  	u64 i;
> >  
> > -	kimg_shadow_start = (u64)kasan_mem_to_shadow(_text) & PAGE_MASK;
> > -	kimg_shadow_end = PAGE_ALIGN((u64)kasan_mem_to_shadow(_end));
> > +	kimg_shadow_start = (u64)kasan_mem_to_shadow(KERNEL_START) & PAGE_MASK;
> > +	kimg_shadow_end = PAGE_ALIGN((u64)kasan_mem_to_shadow(KERNEL_END));
> >  
> >  	mod_shadow_start = (u64)kasan_mem_to_shadow((void *)MODULES_VADDR);
> >  	mod_shadow_end = (u64)kasan_mem_to_shadow((void *)MODULES_END);
> > @@ -241,7 +241,7 @@ static void __init kasan_init_shadow(void)
> >  	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
> >  
> >  	kasan_map_populate(kimg_shadow_start, kimg_shadow_end,
> > -			   early_pfn_to_nid(virt_to_pfn(lm_alias(_text))));
> > +			   early_pfn_to_nid(virt_to_pfn(lm_alias(KERNEL_START))));
> 
> To be honest, I think this whole line is pointless. We should be able to
> pass NUMA_NO_NODE now that we're not abusing the vmemmap() allocator to
> populate the shadow.

Do we need to fix this in this series? it seems another topic.
If not, should this patch be removed in this series?

Thanks,
Lecopzer
