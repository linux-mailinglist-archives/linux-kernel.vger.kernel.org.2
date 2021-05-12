Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF1D37BC3F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhELMIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhELMIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:08:42 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05603C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 05:07:34 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id v5so29238452ljg.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 05:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KHy1jvonypHY1PVvtBVNiZG6J8HrF2PSi5nvjXdw7fg=;
        b=yDxMwV6RjIr4H55bS3sal4v4ypfoppfN+kwyHHiwnw4KKcP/JCbLTeDhFCRy0z3eSE
         eqTJtTDp/ovZmPbn60DJNxzFbPUa/JjyRgYqzmlUsdvZCR399XvxomiQc1obinMfrvOj
         Ev5EpCvES+aWM5QGxPqqxrXEX0aV4oZF0tOtEUn0v5h7qMQAejh/khksEPCzGuEoFztu
         SeogP63zqikgOrVkRIouqHAMI95EDhX7kfs57K8AuEvykdWH2KTIo6buhT+Uqbu5sHA5
         LkJvgos2DrBJDW+SO5aKZqE+qzzM94CK8T4b5m6IzJkRF4WS3OIzWd+Y9o2qjt/apqPh
         5zXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KHy1jvonypHY1PVvtBVNiZG6J8HrF2PSi5nvjXdw7fg=;
        b=Vxa+T71ZGjGNsvbk1COBDRwsTe9wCBMtObMitovB5qPMmvM/oyMV+PTd1Q7zSXfnGW
         lN81hY9NlFOx8hc5Lu56tmMUL52orzJ+a5bJG3OErHobd6OmuUNbYEQDm4BSeeCYi34f
         PzaHYvRqw73wS3zl3LjmHDFAEYTkzxcHJnFKfpUHRyr36Ds1MUm6mdFaRyTc6f1uuFrm
         Eadix+DhAbqdSrj0VeHLe7rXIkEFi8Qjon9W0ySheBC3T/pVCbKbrkS1RUD1hIZa45/R
         QP7S3OcTbkZ0HboUdXMDpwx4fz0lRJRVMd4nLeDRKsNoYGYSLS9vTmc+XBMl3AifTDgg
         FZFw==
X-Gm-Message-State: AOAM530hVOd8WNSwSiXjNi6AfdSfMQT4MxNBwXd9o+JSphgZOpenzWST
        c8k6QLa5hD45ThzWj7Xi1qqvFA==
X-Google-Smtp-Source: ABdhPJzTkizqFBu8TPKA08E0YDjXlDFwu9p8b+lk3l1QOjUEYSNII7C6tjcDP5ZpewRSZ89auljhlg==
X-Received: by 2002:a2e:83cb:: with SMTP id s11mr28219873ljh.462.1620821252460;
        Wed, 12 May 2021 05:07:32 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w16sm2973340lfu.160.2021.05.12.05.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 05:07:31 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8A53010265F; Wed, 12 May 2021 15:07:32 +0300 (+03)
Date:   Wed, 12 May 2021 15:07:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Juergen Gross <jgross@suse.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 01/32] x86/paravirt: Introduce CONFIG_PARAVIRT_XL
Message-ID: <20210512120732.dtdg3vompizse6df@box.shutemov.name>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <4f8c9559dd04d8e8485c419c5ebc9471613f7928.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YIhKXcNuinL0ar0O@zn.tnic>
 <f62354fe-e202-ad38-5466-03e79954f757@suse.com>
 <a24884ac-452e-751f-fb3e-82b3a9978ed1@linux.intel.com>
 <41463493-48bb-0e69-dcb2-3072e2ddf208@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41463493-48bb-0e69-dcb2-3072e2ddf208@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 05:56:05PM +0200, Juergen Gross wrote:
> On 10.05.21 17:52, Andi Kleen wrote:
> > \
> > > > > CONFIG_PARAVIRT_XL will be used by TDX that needs couple of paravirt
> > > > > calls that were hidden under CONFIG_PARAVIRT_XXL, but the rest of the
> > > > > config would be a bloat for TDX.
> > > > 
> > > > Used how? Why is it bloat for TDX?
> > > 
> > > Is there any major downside to move the halt related pvops functions
> > > from CONFIG_PARAVIRT_XXL to CONFIG_PARAVIRT?
> > 
> > I think the main motivation is to get rid of all the page table related
> > hooks for modern configurations. These are the bulk of the annotations
> > and  cause bloat and worse code. Shadow page tables are really obscure
> > these days and very few people still need them and it's totally
> > reasonable to build even widely used distribution kernels without them.
> > On contrast most of the other hooks are comparatively few and also on
> > comparatively slow paths, so don't really matter too much.
> > 
> > I think it would be ok to have a CONFIG_PARAVIRT that does not have page
> > table support, and a separate config option for those (that could be
> > eventually deprecated).
> > 
> > But that would break existing .configs for those shadow stack users,
> > that's why I think Kirill did it the other way around.
> 
> No. We have PARAVIRT_XXL for Xen PV guests, and we have PARAVIRT for
> other hypervisor's guests, supporting basically the TLB flush operations
> and time related operations only. Adding the halt related operations to
> PARAVIRT wouldn't break anything.

Yeah, I think we can do this. It should be fine.

-- 
 Kirill A. Shutemov
