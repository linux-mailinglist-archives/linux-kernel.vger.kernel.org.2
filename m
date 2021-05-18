Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5B4387E45
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 19:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350918AbhERRNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 13:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350806AbhERRNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 13:13:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5471FC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 10:12:03 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 22so7498801pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GmdWHyHk91S0pxmIpKiVSz+mhYNKw0Rzm8xdvRl8ul8=;
        b=Vb4JQWREA7p4JNnLt6WsllSrMDGJ5QAST5bQCJq0p9BHGdCv5ljhzKe4kh81pFTYyO
         oYkZ0KarzNFScsv9I7HL7P6nlLbou7RxZQjVm/OWGfNfw2Ay2kK+xZt1/F2yQns66652
         3wBdCbad+UszZeZz5HWXyRxO2qWvkJRmoDLos7E55mAYymEa+epLZdH5Fj8rI0pE0qQg
         YfIBVio5JbuBPPQr77AuCuQ4PteGxGkQ3XAXMf4XsYCHfZIq6EwcfHNHivkT565ljUkR
         9h6vH0WPc8wrB1J6pPeci5pZmaIY9Fp5kY3IxbnxoJrR1sg9CajAC3U9ivj23EnmikSN
         M7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GmdWHyHk91S0pxmIpKiVSz+mhYNKw0Rzm8xdvRl8ul8=;
        b=R1hseicKp52NtCWcCnCyvnjnOEpe77SU8ObHonzsmIP9YG8gJLoXtI00Xlgz2jepzm
         PGDOXFKTXHp3RQbugVBYYA72AB5uin7KMCo1iYvYZ8DLETVThymNoEFy3FLh//Cp9Dbc
         5fEAaQUXpTRAzPoUOI1FXzlp7B5eI+shJ0zkmkqgDW7ptzSHvzS1XGDAdTvsjNLv5HMR
         8Sdj57/JgwQ8zrnVLnyg/mQlyeHwACXN486z3SmPqQVyaExlKDMwLQpjj15LLgOB+NKh
         NV95o3/wzbRPilKNr9II51MuivunsTTm6vgA28Ql43GxXE+P/C6JhDsYSMxf1T8Sv3fB
         a5fA==
X-Gm-Message-State: AOAM532XZW4W8pwXXh5HE/DDjvM4akgsNykMgvDB6tNpAKa/x0DqrTr+
        nFoqp4IQLrlKuT467OIzfdl33Q==
X-Google-Smtp-Source: ABdhPJy7u0V8AhizJiDfS0Ul2YFEMrcixkTQgmGIy4EWbW4wVZn0CEszJk1PLHXAwBPAii6/smRA5Q==
X-Received: by 2002:a05:6a00:1a92:b029:2ca:4c19:e4c1 with SMTP id e18-20020a056a001a92b02902ca4c19e4c1mr6191833pfv.32.1621357922711;
        Tue, 18 May 2021 10:12:02 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id oa15sm801386pjb.21.2021.05.18.10.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 10:12:02 -0700 (PDT)
Date:   Tue, 18 May 2021 17:11:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Handle in-kernel MMIO
Message-ID: <YKP1Xty7EEzHkZ6Y@google.com>
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210518004807.258503-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <36cd2665-6d8b-9c0b-eec1-25152dcca2a3@intel.com>
 <43e583a3-ee2b-52d8-5275-e26a6609c126@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e583a3-ee2b-52d8-5275-e26a6609c126@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021, Andi Kleen wrote:
> On 5/18/2021 8:00 AM, Dave Hansen wrote:
> > That sounds like something objective we can measure.  Does this cost 1
> > byte of extra text per readl/writel?  10?  100?
> 
> Alternatives are at least a pointer, but also the extra alternative code.
> It's definitely more than 10, I would guess 40+

The extra bytes for .altinstructions is very different than the extra bytes for
the code itself.  The .altinstructions section is freed after init, so yes it
bloats the kernel size a bit, but the runtime footprint is unaffected by the
patching metadata.

IIRC, patching read/write{b,w,l,q}() can be done with 3 bytes of .text overhead.

The other option to explore is to hook/patch IO_COND(), which can be done with
neglible overhead because the helpers that use IO_COND() are not inlined.  In a
TDX guest, redirecting IO_COND() to a paravirt helper would likely cover the
majority of IO/MMIO since virtio-pci exclusively uses the IO_COND() wrappers.
And if there are TDX VMMs that want to deploy virtio-mmio, hooking
drivers/virtio/virtio_mmio.c directly would be a viable option.
