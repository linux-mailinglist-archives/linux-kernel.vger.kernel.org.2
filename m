Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60682350A44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 00:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhCaWcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 18:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhCaWc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:32:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFB4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:32:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so1965998pjc.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Aop3qUolUDRtTavGsx945TafURy+GfTOKX2vL8Fgjt4=;
        b=Qroi6UI/g7NZ14dcFdZJ6B3OQOPJpPjRI7Brdh5J9c7opgdTIwhdhUu+OxMRLZK45w
         eRqHMZwU5fXEzH8y9JTZ6dc+QujEsMGPzidTA+xvP/AsufOdpFYiw8doJAnPi2+i3DF6
         qjiHtqPerOPKLKaAJPhxtnIVX5vhX1YuSr/aKBVYHOxUvTJXaRoHvmg7jMetw38zUFzc
         uBMuHi7SQ29sysPmszEO4yEJsHrLhix6Q1beM6tgtJ7lXtM85EoGBQxHcDKW6ebJeZ75
         6G9DopQDpXEjNdGMkQR+zhCP1qdTv2soC42YtKzY0El9RfdzvVYVrBt4V2REGZOxIG/K
         119Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Aop3qUolUDRtTavGsx945TafURy+GfTOKX2vL8Fgjt4=;
        b=dIlX1ApbWywepp4xSkWFmfIiDSFPSOh06pFf5MH9hG2b8QIODv7iQQuID3cxLw6d8m
         CJw8D2Vf8BJEiR1cval4lITdbp/DVTyfi/Le1Y4xRH2Nw/PVb0NndwN191cXjgI1IqYl
         n5ioCTg7Rt/83jnWtzKTN8s5Xv+7MiVVsnawtpRPo7tpzQvQgDA3VCKuU+a3uIjt5gL2
         DWfcW36kQJZeSp4nrRV4xOoewlvE0BTAuOXDCGRulPFkQxk67fPiyLYfuMXJ8I3vg+BE
         ocgB8vWq8dPp7gnuyWj4fpZk98b/zIZUGoKGDY3Yd2JxemCtUyoDRusLrM+KyqoszUgB
         rhzQ==
X-Gm-Message-State: AOAM531mtylJy+R8qx5VnNGve9wt+/u3BgfFU6HuXWqu0JaECVzQ5aOP
        G5Pxsyxnd3+ZClVftH10UJ4JyQ==
X-Google-Smtp-Source: ABdhPJyL9mlW6359EY8CrK8Si6BL4MoBJftPJ46BIRVpDD9P/tT9t3qMUZJtI3/Gs2wDm2LjUMGThQ==
X-Received: by 2002:a17:90a:a88d:: with SMTP id h13mr5417366pjq.61.1617229945575;
        Wed, 31 Mar 2021 15:32:25 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id j30sm3541022pgm.59.2021.03.31.15.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 15:32:24 -0700 (PDT)
Date:   Wed, 31 Mar 2021 22:32:21 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Message-ID: <YGT4dXn7Jd4r1zTU@google.com>
References: <2FE32855-EA5D-44E4-AACC-25E9B1476547@amacapital.net>
 <e62cfd0ae90de435e6819979d9027f76d835a22a.1617224710.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YGTvSvr2T2v3t3XA@google.com>
 <5d961c25-3dee-4a5d-4bba-a97d157a5a49@intel.com>
 <YGTyWUQbxVZeeko+@google.com>
 <d8078f5d-735c-2b0f-98eb-663be2118762@intel.com>
 <ef49222a-8ffc-dacc-4f21-3bd1ef13a2ac@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef49222a-8ffc-dacc-4f21-3bd1ef13a2ac@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021, Kuppuswamy, Sathyanarayanan wrote:
> 
> On 3/31/21 3:11 PM, Dave Hansen wrote:
> > On 3/31/21 3:06 PM, Sean Christopherson wrote:
> > > I've no objection to a nice message in the #VE handler.  What I'm objecting to
> > > is sanity checking the CPUID model provided by the TDX module.  If we don't
> > > trust the TDX module to honor the spec, then there are a huge pile of things
> > > that are far higher priority than MONITOR/MWAIT.
> > 
> > In other words:  Don't muck with CPUID or the X86_FEATURE at all.  Don't
> > check it to comply with the spec.  If something doesn't comply, we'll
> > get a #VE at *SOME* point.  We don't need to do belt-and-suspenders
> > programming here.
> > 
> > That sounds sane to me.
> But I think there are cases (like MCE) where SEAM does not disable them because
> there will be future support for it. We should at-least suppress such features
> in kernel.

MCE is a terrible example, because the TDX behavior for MCE is terrible.
Enumerating MCE as supported but injecting a #GP if the guest attempts to set
CR4.MCE=1 is awful.  I'm all for treating that as a one-off case, with a very
derogatory comment :-)
