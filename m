Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6360537BD8E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhELNBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhELNBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:01:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD418C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 06:00:05 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id r5so16390302lfr.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xap++t9BoJl2IuYSh+EBBBTbjARnF0khTcoJ209GXBc=;
        b=XEQ3MPkzgiu+ROcRgQU2v+djK2hR7zxon3gknqwdo1p/YftJClB6BLbmeIwd1XCdgf
         x78iUeS1hM9rRoRbV/4q2JX04bjfc8jpAqYRONcvRhUD/RlgEnnri69MabJ3igJKaTuv
         cuFUkm1Q1gSPVmezasmYuyRe52XPLzBuOJ3GRKDxxS5amkfKi40+fbQFLqT1tcy32nIP
         GWVEEdw2bbfRccKJGCjNVZZq2eJSub7N0ShYZyRose7gdR3jq8q70riUuNHh/SmxOzeP
         zvrtB0S2vAsNR3Mp7VjQFY+f1/GLfzXaKLeKwtfzeiN8AqZYK9LykMLL3nF5A3CV+dXF
         eeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xap++t9BoJl2IuYSh+EBBBTbjARnF0khTcoJ209GXBc=;
        b=nECuIqxJiSPKp3i16PA6oDHmBCjUpeSGd6hLe7qDQNqpcS5QZ+BsQPt99fioVDEros
         bZv1pTKBZs/P55y96SiRzLfRdzrgnTW1fDaRzB5Lu+MuzVkCazo6wouFxrPlCl5trSeQ
         Lm24uKDLRcaSGcI+/5jEZCBfOhmocaYXk1Kglon3+Cx4Lg4LgsmOtDRP+3lIAA3c6MtC
         Uo7cCIGy1N5Qbuo+01jeRzk51bATX0riIHlZu9xpbO5m1D+z7Na91i623rD4Mm0+ldHh
         W2HaERLrcOUCUSRXGzLvnlXB/SquRSSuyA/Rldi54D24jr8RFccm9VtnH7L4r6e77MTC
         +Mew==
X-Gm-Message-State: AOAM530LizYjGetn7hoctldtnCWCKMh84EQMKQxaEtCbm6ItoJIRXbT5
        lijMYT81yrVebcqibfuvUlctHA==
X-Google-Smtp-Source: ABdhPJzUGgPVfvYx5b+WByPlhMttdcGQHZK1x/SEymuRXmKkAwJIsX2gxpYd5ntEQWlHgWx0o2Ia2g==
X-Received: by 2002:a19:4cd7:: with SMTP id z206mr10482663lfa.487.1620824404282;
        Wed, 12 May 2021 06:00:04 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f29sm4091830ljo.69.2021.05.12.06.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 06:00:03 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 9DB1410265F; Wed, 12 May 2021 16:00:04 +0300 (+03)
Date:   Wed, 12 May 2021 16:00:04 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: Re: [RFC v2 10/32] x86/tdx: Wire up KVM hypercalls
Message-ID: <20210512130004.gxiaxj6wlzcjcem5@box.shutemov.name>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <04de6cd6549eee0b77fe3b0937c4b4b7f0e3ff2e.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <bc2e6da5-f35d-6574-52d0-82d996e56920@intel.com>
 <b836a6a2-3bbe-d568-50f0-0b6b8dbe3133@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b836a6a2-3bbe-d568-50f0-0b6b8dbe3133@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 05:59:34PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 5/7/21 2:46 PM, Dave Hansen wrote:
> > I know KVM does weird stuff.  But, this is*really*  weird.  Why are we
> > #including a .c file into another .c file?
> 
> I think Kirill implemented it this way to skip Makefile changes for it. I don't
> see any other KVM direct dependencies in tdx.c.
> 
> I will fix it in next version.

This has to be compiled only for TDX+KVM.

-- 
 Kirill A. Shutemov
