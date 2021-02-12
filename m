Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109D131A5CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhBLUHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhBLUHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:07:21 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E36C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:06:41 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id my11so759037pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o1P4JemX5J+i5nAkTEumF3u9rjmcEBtmi1IYaMYgYNs=;
        b=n5BlLvwz/MS7vwkbwkidddTXXLQywbrX4trcafMxoKNOhmnu1BRmXbY2zfVYcftQsw
         dupfU597OK2ac7WfVVKqOmvMA55W5X3eztQgO19NjGds/dS2lftAGPMNvYHJEpj2tH0a
         GvmG2zE6hfF0t/6FjqTl5kiAhHhsIhsWoJtg6HuF3CVn143O31XuAcC7MZljH16cvmzE
         ZzBZgbVsnzegnfYy/Ofky/GUEmKiZ4tBy3SsxRMLqU/5YyOEFDFSIudqwMhWYjXIEL43
         mXTZQa4F9DTEoG8nAMLsXCRpBvxknWVdTwiyIor6upRDUZHBpe2+t2j/9Hi2/5Ep4TJb
         fwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o1P4JemX5J+i5nAkTEumF3u9rjmcEBtmi1IYaMYgYNs=;
        b=MUKolu50Z+NPY3bD8o45ItjCSFbj2TuNp+uhertsCKJouuBhdgABAntOJ/DeZFZcvE
         BZB/ZzcgQehGUh5xUnnxIeL4/3Tp98d43COcN+SLpiKn3ZLBAjSjZovxP5SLTWmjz1xj
         u3cHwnUlzBTjTNhHKHP1Qcoyg5rSRZIgY3MfHwcESOgfLIfDTD929m6HTkpjX5CoferK
         UVdhdiRakAl60tyg3Mug12I9ZtksLQUuDBAv04Q+u271ZOf6q6KLj6HwvZkFDRvLTceG
         g34DZWBbLNleTt3CMd6OIG+dwFmhpdhXMiI3vukqNRhIL53VIWjwyhABlw4WUsL8jv4r
         RyAQ==
X-Gm-Message-State: AOAM531fJqKNVkpAx82v+jsjhzCXmj3s1tDRUY2Lgq6PP54qri1dcFlt
        TV+44pgKI8hEq8IA3hVnO8ypnQ==
X-Google-Smtp-Source: ABdhPJz2zqYnpa+EYvCqNn/UCnbsTiVIk2RxTbFHhZ3Yc6npa49ZdFPr96tmWQxUgnEwGivDzA+fMA==
X-Received: by 2002:a17:902:b28a:b029:e3:2067:3e04 with SMTP id u10-20020a170902b28ab02900e320673e04mr4172154plr.18.1613160400720;
        Fri, 12 Feb 2021 12:06:40 -0800 (PST)
Received: from google.com ([2620:15c:f:10:b407:1780:13d2:b27])
        by smtp.gmail.com with ESMTPSA id w187sm6301128pfb.208.2021.02.12.12.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 12:06:39 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:06:33 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC v1 05/26] x86/traps: Add #VE support for TDX guest
Message-ID: <YCbfyde9jl7ti0Oz@google.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <48a702f536ccf953eee5778023ed6d1a452f6dcf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CALCETrWPCTmoeFBEJvw98zwNpw316Xii_16COZAWoYNC=obF+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWPCTmoeFBEJvw98zwNpw316Xii_16COZAWoYNC=obF+w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021, Andy Lutomirski wrote:
> On Fri, Feb 5, 2021 at 3:39 PM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> >
> > The TDX module injects #VE exception to the guest TD in cases of
> > disallowed instructions, disallowed MSR accesses and subset of CPUID
> > leaves. Also, it's theoretically possible for CPU to inject #VE
> > exception on EPT violation, but the TDX module makes sure this does
> > not happen, as long as all memory used is properly accepted using
> > TDCALLs.
> 
> By my very cursory reading of the TDX arch specification 9.8.2,
> "Secure" EPT violations don't send #VE.  But the docs are quite
> unclear, or at least the docs I found are.

The version I have also states that SUPPRESS_VE is always set.  So either there
was a change in direction, or the public docs need to be updated.  Lazy accept
requires a #VE, either from hardware or from the module.  The latter would
require walking the Secure EPT tables on every EPT violation...

> What happens if the guest attempts to access a secure GPA that is not
> ACCEPTed?  For example, suppose the VMM does THH.MEM.PAGE.REMOVE on a secure
> address and the guest accesses it, via instruction fetch or data access.
> What happens?

Well, as currently written in the spec, it will generate an EPT violation and
the host will have no choice but to kill the guest.
