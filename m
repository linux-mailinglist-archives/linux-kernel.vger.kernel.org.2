Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C47D400860
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 01:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350791AbhICXoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 19:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350681AbhICXoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 19:44:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA4CC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 16:43:21 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so613238pjq.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 16:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xRkv29REOmSpayMHsTkGf88hkJrd3OSMBUh/MVM03EU=;
        b=hRlgRtj75/kwKOrlL2OIJhrxM7LbBozXmixbMseIrNTO2s5AoYiarFZwNZR/UDEtgX
         IYUEwCmnIy4ZrdoGE9/WbV/BHZ1BinSUkdNowoQ8iC0PhNIsWdbDRQXNtnWBiUaOXU4z
         3yI7suOOaLaTRmptZ/v/yo4Ge1iMNORjFcV2E+sHf93QM2OFDRtQ9mgM0Ihq4ighCiss
         r8yhPJfKCTIJouvKw4Nl2zRO9O6u45egqkjakhwQ/TOIPCfEYWpYUXRV5xHS8+kT09ZW
         0Nth0XJdNUaAnbVufh6MUewuKOWzUBLD52QhDrTSDfO6LY7emZ3/WRPdD1i0hJZZbd/i
         XpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xRkv29REOmSpayMHsTkGf88hkJrd3OSMBUh/MVM03EU=;
        b=I4oJQIH6cFcz3j70n1WlAFtcTu5l6eDo7xbUjGV0awA8vDrPMeTcWfKePf9S13NbZB
         dnvwn6jP9Ikd5a54/5svNGSVDiB0y4KXnOdlHR7KQAhlBqn0vDAgkjU5AN+MhbZ9Lp2t
         znDbS9/DcJJNYAmGJhJ9xzPu8j/dc5S20FxxFYx3TZ7YIND/gKAipTs1LFBtEMVzTlcO
         akpQ5+j8YoDl88nSyZkDngEuZOsG6om/j101RJeB9JQ9xKk70lQ/qYqWDsF2/K62pFS1
         shK1iDTncxS9V7ps0xyWD7eDYhOWPvgt2CYsu1RMDrBBf1tY+jcKyyLVVpZd3DNDULFf
         Y5ZA==
X-Gm-Message-State: AOAM530zt8gv4UsjXDMUe67Ab8sQ4KMLBXb7zj+BEzMOzJWoDSr46NuZ
        npw+ucFswMKMtuRBJPQjqxuq7g==
X-Google-Smtp-Source: ABdhPJwkF3YkkYTDEcShQ/QXpN4m6cdDfCBxfj2mBgfCufPVdsLLaDcrgBX+NTQM5L7AtLCnSgARlw==
X-Received: by 2002:a17:90a:1c8:: with SMTP id 8mr1384851pjd.81.1630712600442;
        Fri, 03 Sep 2021 16:43:20 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z8sm403765pfa.113.2021.09.03.16.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 16:43:19 -0700 (PDT)
Date:   Fri, 3 Sep 2021 23:43:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/11] x86/tdx: Handle CPUID via #VE
Message-ID: <YTKzFJYy0CECENRX@google.com>
References: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210903172812.1097643-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <24d0fe72-78b4-6550-e5d8-dd511dcbfef3@intel.com>
 <26e79e8f-ba96-9087-04dd-283eadd8c693@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26e79e8f-ba96-9087-04dd-283eadd8c693@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 9/3/21 11:35 AM, Dave Hansen wrote:
> > On 9/3/21 10:28 AM, Kuppuswamy Sathyanarayanan wrote:
> > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > 
> > > TDX has three classes of CPUID leaves: some CPUID leaves are always
> > > handled by the CPU, others are handled by the TDX module, and some
> > > others are handled by the VMM. Since the VMM cannot directly intercept
> > > the instruction these are reflected with a #VE exception to the guest,
> > > which then converts it into a hypercall to the VMM, or handled
> > > directly.
> > 
> > Does this patch do any of the "handled directly" leaves?  If not, why
> > mention it?
> 
> It was added to give more information about CPUID leaves handling. Since
> it has nothing to do with this patch, I can remove it.

What leaves are "always handled by the CPU"?  VTx doesn't allow disabling
CPUID exiting, let alone conditionally exiting on a specific CPUID leaf.  I don't
see anything in the TDX specs that suggests that's any different in SEAM non-root
mode.
