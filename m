Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB0B32E491
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCEJR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhCEJRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:17:21 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA964C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 01:17:20 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l12so1274838wry.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 01:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m0BaSCINjuV6YKS4LQw2bQ0VOXZwqzhx3JH5vS4yw4A=;
        b=dSK8cK8YdJCHbOxvyzk4NaS2W1an+k1SSlSqlbzAfzisIIOT114FG3nmrlwBPZfX/L
         IWpalQMzqqRrpNoJN3JNcSt+XkcD1u5p3Mfw18YrEXh2neL+YKp5CGnvLQ21jChB6el0
         Zr22QATr21AzfIQlNTeAXBJC4bnCpLCjsBMe7/2NVXPnniv2k2OGDq1TnpAx+Vq/tPw4
         uf0A6ZKubbxRsOBfwliKV+8Nh8/1fVB9EzCnyK0IYPAGcHm5fwnl9BLs1Q3yvhz37ycd
         SRZgFuQUQVV3T4Gk4DB+f1O2eaCSx7GeK/l9XkEANOk6165hF7fVKRFToyHmNLxVG636
         xjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m0BaSCINjuV6YKS4LQw2bQ0VOXZwqzhx3JH5vS4yw4A=;
        b=n96U+h8WDaxnWr0YzDi/Je+RLECI20HYpKDaCUYLSlbv9AJiy0n4nJxIVOQ6IP008s
         Da9vKtwA1M4weAMh2yuJgnR/xNPdy1/8ymNLBlDsby0jWZqlgZ+BWKitCdQUuMEm8FQ4
         N7yw4xji8YJJazHR8r6mOCpiDq2I0zGEGpJl53zprJmLdWTiWYiNjw2j5kiqKPNdSWtL
         PQ+56hiiv5panYjo9zgk/P1HnmgS7A2yduzbbtJzFvduIKd9TQZc66Crj1Zsb3qaERlh
         lyAtj1PUqcyro1+5LQ/IOKDfAj9Whe84TZtR+Si/EAhX5Ia1Ji76bj1GHKX2kYmdzO11
         c45w==
X-Gm-Message-State: AOAM532wtKKybYBQ+wUFxZm93aJ2OuZcnUlTzHxfUX0d+i2tk4GQl0CU
        xO+8JxBpxRZiaCiCQFewvdCBvA==
X-Google-Smtp-Source: ABdhPJwkqGaJDZi1qJyXxeSAeeGexX9CiTR+848rPCJ3/MZ5zmUWeN2uI8ddfxcqr8O1iyHfvoSCkg==
X-Received: by 2002:a5d:4dd2:: with SMTP id f18mr8379236wru.366.1614935839616;
        Fri, 05 Mar 2021 01:17:19 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id s20sm3833269wmj.36.2021.03.05.01.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 01:17:19 -0800 (PST)
Date:   Fri, 5 Mar 2021 09:17:16 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 24/32] KVM: arm64: Reserve memory for host stage 2
Message-ID: <YEH3HNn9+Y3UbKPj@google.com>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-25-qperret@google.com>
 <20210304194953.GD21950@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304194953.GD21950@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 Mar 2021 at 19:49:53 (+0000), Will Deacon wrote:
> On Tue, Mar 02, 2021 at 02:59:54PM +0000, Quentin Perret wrote:
> > Extend the memory pool allocated for the hypervisor to include enough
> > pages to map all of memory at page granularity for the host stage 2.
> > While at it, also reserve some memory for device mappings.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/kvm/hyp/include/nvhe/mm.h | 23 ++++++++++++++++++++++-
> >  arch/arm64/kvm/hyp/nvhe/setup.c      | 12 ++++++++++++
> >  arch/arm64/kvm/hyp/reserved_mem.c    |  2 ++
> >  3 files changed, 36 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> > index ac0f7fcffd08..411a35db949c 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> > @@ -53,7 +53,7 @@ static inline unsigned long __hyp_pgtable_max_pages(unsigned long nr_pages)
> >  	return total;
> >  }
> >  
> > -static inline unsigned long hyp_s1_pgtable_pages(void)
> > +static inline unsigned long __hyp_pgtable_total_pages(void)
> >  {
> >  	unsigned long res = 0, i;
> >  
> > @@ -63,9 +63,30 @@ static inline unsigned long hyp_s1_pgtable_pages(void)
> >  		res += __hyp_pgtable_max_pages(reg->size >> PAGE_SHIFT);
> >  	}
> >  
> > +	return res;
> > +}
> > +
> > +static inline unsigned long hyp_s1_pgtable_pages(void)
> > +{
> > +	unsigned long res;
> > +
> > +	res = __hyp_pgtable_total_pages();
> > +
> >  	/* Allow 1 GiB for private mappings */
> >  	res += __hyp_pgtable_max_pages(SZ_1G >> PAGE_SHIFT);
> >  
> >  	return res;
> >  }
> > +
> > +static inline unsigned long host_s2_mem_pgtable_pages(void)
> > +{
> > +	return __hyp_pgtable_total_pages() + 16;
> 
> Is this 16 due to the possibility of a concatenated pgd?

Yes it is, to be sure we have a safe upper-bound.

> If so, please add a comment to that effect.

Will do, thanks.
Quentin
