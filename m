Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C110332EDC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhCITRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhCITRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:17:05 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E34C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 11:17:05 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so4703574wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 11:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eMS1D50aqSjlBFSA6N/+/il0CK6ForkgIZokW5VsYpo=;
        b=pOM60gEHFmfEf9W1RbFaJinf5omi/g1aiS347f2o9irh9AXRBVc1RYC3mxPW2RdTOW
         6G7p+HwbYj1bERao9NKlAuzTZukJ5p8HAf6W59uYSScAsnjv1M/YkhoR8w1+dkJ3ldkr
         IfPD7uFeLp23cvhGGyr8Hkr03FhqagoRSXhOAqYegtHD8fT0STvbi+1ofLpdydeNYUPu
         G7qz/dh0UTzdR+wpOS8f6Q7EOUrXFc+28TKBYzMCnCxXk3XaaUOr8ndJhn9N9zBz9Tdx
         +pE5VmyY4uApd3guddyI40hb6fqSNYR4uVCdfqfKPg++wRJMCkHEdKhd4fXQcRc8ECBN
         44pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eMS1D50aqSjlBFSA6N/+/il0CK6ForkgIZokW5VsYpo=;
        b=LnKXSINXpuL4EL8WNoi0sGEHYI7TdSB+Ez+Jv4gfe5OBqwpwfKEJoTzde7Ezj47tl/
         C3DpGSjdl8LRGqTss5LLO5kRS57Ypx8GYOLF56WNMahgJwTJ8PlzGQUNayK+F90bJ/sB
         DPn9Gc1fqSuLLx+NGCkqE017Hp1wEVoGyEuTCw25UW3s2z0ZnMBEw9x81xfqO/lmMmup
         MYHXL8DMaKJez1ZvbEx2nBOOjvLAPXivggpN3aBDVuZnLLhMVkIlAdc6x617JOGlaXeG
         7KD/Kp8vqtDD7Q0vz+pMk1QKLg4Mww4wdVJGgDtlbyP7rpI21kCK3aroILogdURhFQVi
         C+6Q==
X-Gm-Message-State: AOAM531/5C5UTzh4RkB4GPyZGR9k2vPV34l3GFyedt/qnU3+2sesRjTE
        odUy2oadg5fFkrVbYpWldPAHoQ==
X-Google-Smtp-Source: ABdhPJz1xfmX7KUevchmJBcX85uXBXT2tSS+52QnaWp8jpSNa4PlShPqKoDcJPdhseLynqlkLEwhDA==
X-Received: by 2002:a7b:c0c4:: with SMTP id s4mr5822060wmh.9.1615317423661;
        Tue, 09 Mar 2021 11:17:03 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id y8sm5381418wmi.46.2021.03.09.11.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 11:17:02 -0800 (PST)
Date:   Tue, 9 Mar 2021 19:17:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [GIT PULL] Immutable branch between MFD and Platform/X86 due for
 the v5.13 merge window
Message-ID: <20210309191701.GY4931@dell>
References: <20210128172846.99352-1-david.e.box@linux.intel.com>
 <20210224201005.1034005-1-david.e.box@linux.intel.com>
 <20210309181206.GT4931@dell>
 <4b282693-95c5-a738-e114-ae07f6e113fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b282693-95c5-a738-e114-ae07f6e113fc@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Mar 2021, Hans de Goede wrote:

> Hi Lee,
> 
> On 3/9/21 7:12 PM, Lee Jones wrote:
> > Enjoy!
> > 
> > The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:
> > 
> >   Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)
> 
> I thought we were supposed to avoid using 5.12-rc1 as a base to avoid people
> hitting the swapfile related disk-corruption when bisecting?
> 
> See: https://lwn.net/Articles/848431/

Interesting.  First I'd heard of it.

> So it might be better to redo this branch with 5.12-rc2 as a base ?

I already have 3 immutable branches based on -rc1.

Will need to look further into this to see what I can do.

Please bear with me.

> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-platform-x86-v5.13
> > 
> > for you to fetch changes up to ccafe3126ad3f48ea1cd9ae460c69d1ba879fb65:
> > 
> >   mfd: intel_pmt: Add support for DG1 (2021-03-09 17:05:25 +0000)
> > 
> > ----------------------------------------------------------------
> > Immutable branch between MFD and Platform/X86 due for the v5.13 merge window
> > 
> > ----------------------------------------------------------------
> > David E. Box (2):
> >       mfd: intel_pmt: Fix nuisance messages and handling of disabled capabilities
> >       mfd: intel_pmt: Add support for DG1
> > 
> >  drivers/mfd/intel_pmt.c                    | 112 +++++++++++++++++++----------
> >  drivers/platform/x86/intel_pmt_class.c     |  46 ++++++++++++
> >  drivers/platform/x86/intel_pmt_class.h     |   1 +
> >  drivers/platform/x86/intel_pmt_telemetry.c |  20 ------
> >  4 files changed, 122 insertions(+), 57 deletions(-)
> > 
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
