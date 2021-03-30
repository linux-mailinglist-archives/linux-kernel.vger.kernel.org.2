Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD5B34EBE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhC3POa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhC3POP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:14:15 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A89AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:14:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v23so6329116ple.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vIzMPDz04b84H9wLsU0ADnLZmophOnDSnxj9+X0IXio=;
        b=Ihny9oTRRghPDxOl8VGEJNdR4HiMF8IIqO1Xmi1YX3a3C1dUHgY5zVsjjz1hbvx1TT
         +irCvHbgkr3D5lrJduHZh45lJRsmpkQPkeQgjvOhDfm7+JUXAUfsvOME+mc2+24Phjzs
         iL83O0ROQOmC/XZ+/JebRn78JwBU8seS2xt4Sf9BALsohdAmPh9nEhMUhqA9YAqq3/S3
         SRjP7+mroez/wL0A/cIA4xrasUqjTO8gQn7sVvqGfaKEIW7AHK5nCVfSERVLSUw/UhKY
         b7itsE0RdtwVFaSeIgbx5D8ny8WNRWpaEfoxm9Usyq5QWcFvXba458XClp4JoBpsOQa+
         UTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vIzMPDz04b84H9wLsU0ADnLZmophOnDSnxj9+X0IXio=;
        b=bQmWZ/35JWmU+O1tPdqTkak+wYBm4emrfVXWdNbSAKVIdkvuYUdPSmXb5igydJ19eq
         Aeh02S67ks93e0HD3wUHX5apUvAZCxi0SN/+B5Jy4f/8wrcluIHT2alPPlhbAnXeAlcZ
         SFq4Tvuj9RxcP7t4akoZ2LYJIS3rs3bOfrzYH48atGtXtfoaNMpOSza2STqjNJKgknxm
         J6u2Xx1VTnuQA+RbFolapTlTnkYNGwl/WVWJEBUXOMFgmD/LtXzbi2/YiO6vLOfKIUSQ
         s/wAcisDbg8cdFnPyygTxfefyREdtZ7SA5OYxRCvZQYCTMHWM8YNa5hPPhuQJQcgFwnc
         4tYg==
X-Gm-Message-State: AOAM530dje6XL5/QMmu36ukzzgwjn5xX/EWd6gJu8+fxkQpxj0u1OW2t
        zLtcAN7Q9i5zbEe7Ped+6T+GEw==
X-Google-Smtp-Source: ABdhPJyDuA+tWGKMXWpVm1t3j7nCUpiJIcqZP0dvfPoGsHHlGTteZjcA13YGKCQpPHx6Edpy04L0FQ==
X-Received: by 2002:a17:90a:498d:: with SMTP id d13mr4970113pjh.47.1617117254839;
        Tue, 30 Mar 2021 08:14:14 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id j30sm2667854pgm.59.2021.03.30.08.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:14:14 -0700 (PDT)
Date:   Tue, 30 Mar 2021 15:14:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Message-ID: <YGNAQrWMl3AZQ3HG@google.com>
References: <20210330020403.GA1285835@tassilo.jf.intel.com>
 <2FE32855-EA5D-44E4-AACC-25E9B1476547@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2FE32855-EA5D-44E4-AACC-25E9B1476547@amacapital.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021, Andy Lutomirski wrote:
> 
> > On Mar 29, 2021, at 7:04 PM, Andi Kleen <ak@linux.intel.com> wrote:
> > 
> > ﻿
> >> 
> >>> No, if these instructions take a #VE then they were executed at CPL=0.  MONITOR
> >>> and MWAIT will #UD without VM-Exit->#VE.  Same for WBINVD, s/#UD/#GP.
> >> 
> >> Dare I ask about XSETBV?
> > 
> > XGETBV does not cause a #VE, it just works normally. The guest has full
> > AVX capabilities.
> > 
> 
> X *SET* BV

Heh, XSETBV also works normally, relative to the features enumerated in CPUID.
XSAVES/XRSTORS support is fixed to '1' in the virtual CPU model.  A subset of
the features managed by XSAVE can be hidden by the VMM, but attempting to enable
unsupported features will #GP (either from hardware or injected by TDX Module),
not #VE.
