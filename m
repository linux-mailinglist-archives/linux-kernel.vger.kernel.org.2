Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0389A43FEC6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 16:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhJ2O6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhJ2O6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 10:58:34 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CBFC061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 07:56:06 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id m26so9489202pff.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 07:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FjCjcYP+D3o8tv9NFpZxsW155sRvSDfbhIEl3Au16T8=;
        b=fbhsEQHwwevdlsxfPYH0ZOMBGl0MBuTNZ7ZM/mtkL50sTixcSo0LP59DlAS7YgLIeH
         bd5ffqgdd4NPwRRMPVUM41XFNfQEF4lyvY2qy9/Lhh5gdHAF/RlD3+DNaQeeAL7ckacF
         uLBqY/pAqpEJF8p+CdGM/OdDjeEMUXe4vrNhRHmNXMw+kQ6GHr1j51B22WZ2cII8JYkY
         Wtjvk1Ld27LsAm+eskBlsB4uzBEErJsNMfmyQH+nt1IU1CbDeSirNMVr0dGUw9inhgps
         WU7jJ+CB46GNSD+JDiuUTGANWIGnAeQbKrRIJiJ1ISf8+QJDe1v34NYWmrK1yf14lhQk
         8hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FjCjcYP+D3o8tv9NFpZxsW155sRvSDfbhIEl3Au16T8=;
        b=MrSJFbjCgm0BYHDNObT0U37hUtSLgJ+2tJqpM0+WIBujEg6/I6cbBUu7bF0j9EpD+k
         Jbfp2AColM8yAbL3jNx1xw8csisJWucYOcJZb7HwchV0tByHQIPkEuSyrQzA18C1Oorz
         I+bAjHCEE29p/TVoWmhSaPhkoFGOgu2Y97x0f5CcINW5yY5iFLzimF9F+slhqR3K3pzh
         dbJOlbio6CgAIvdKrAsQ60BEaU1ihGsqJtxwESzvoxwA/lRc7sSqjwXTdORnaPIJSmIv
         Ztkkafm2JhlSmeypRuK4p2jeXGIVDNLPwktg8RAIsTwX2DutNjS7Xr8TzkWSPpBEe6Lx
         DAJw==
X-Gm-Message-State: AOAM5335pVAQkP5NZHQwcnB876farLYXCeuRLnLbWK08YPBGygJL2Pty
        yYM3oTABAusPXH7kiznu82rrEA==
X-Google-Smtp-Source: ABdhPJw1r41vo9z6GWts/4z+DJNa7FX6eXkNXDzDgmec/E95Um8w49RuJ9Bh5EuGaGZRKpqNN8QPog==
X-Received: by 2002:a63:9dc5:: with SMTP id i188mr8471251pgd.143.1635519365363;
        Fri, 29 Oct 2021 07:56:05 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f8sm6253333pjq.29.2021.10.29.07.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 07:56:04 -0700 (PDT)
Date:   Fri, 29 Oct 2021 14:56:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>, jarkko@kernel.org,
        linux-sgx@vger.kernel.org, shuah@kernel.org,
        dave.hansen@linux.intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 01/15] selftests/x86/sgx: Fix a benign linker warning
Message-ID: <YXwLgAdOA1jlsSiq@google.com>
References: <cover.1635447301.git.reinette.chatre@intel.com>
 <545aac243037bf5c2640929c4d8ff5c1edfe3ef8.1635447301.git.reinette.chatre@intel.com>
 <d382d0b0-15fb-5e96-accd-c3b59be72dd3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d382d0b0-15fb-5e96-accd-c3b59be72dd3@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021, Dave Hansen wrote:
> On 10/28/21 1:37 PM, Reinette Chatre wrote:
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> > 
> > Pass a build id of "none" to the linker to suppress a warning about the
> > build id being ignored:
> > 
> >   /usr/bin/ld: warning: .note.gnu.build-id section discarded, --build-id
> >   ignored.
> 
> Do we have a good grasp on why this is producing a warning in the first
> place?  This seems like something that could get merged quickly with one
> more sentence in the changelog.

The SGX selftests use a custom linker script, tools/testing/selftests/sgx/test_encl.lds,
to configure the resulting enclave binary so that it's loadable as an enclave
more or less as-is.  One of the things the script does is drop sections the
selftests doesn't want, .note* sections being in that category.  I don't recall
exactly why the script drops sections; I assume it's to simply the loading process.
Anyways, .note.gnu.build-id is collateral damage and the linker complains.
