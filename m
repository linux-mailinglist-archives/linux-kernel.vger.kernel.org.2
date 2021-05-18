Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3645138817D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352178AbhERUjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbhERUjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:39:21 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D101C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:38:03 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c17so8300934pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XnFfLl2UDQpNOM7J0sY8oP5lxN10cYtX8CfE86wJNNM=;
        b=IVXC7MHxCxNopOOvt7tAeBgXJFH0RyS8DSFqqLXSOEhPX+5TlfU5S+QtLh4by8bRE9
         7f3XNai4ObMWNRBksw2xxEXMXOFkptJftqzvEP2mYdTiHCTf99oB9Lkcl5yBOiFv5hZ7
         ERbIDimT/pIBZ91j7AvlVsvF2CFa6a0HXYXkL5rpP1yw9Mb+0+61ZLjah9hfeJj6+Nkt
         i5v2kK6uuGmTkoDSJF3VM2/6mNzUPTubCJBh9dGUDxA63iWTatrek0Zei9qYG6DkKC6b
         Mqqf4+RlZSX2YcUZqfgFQgNvvNZQe/W4CFek6fEK10LEtDUSLA67dfKjiP7K6qh8um20
         eKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XnFfLl2UDQpNOM7J0sY8oP5lxN10cYtX8CfE86wJNNM=;
        b=Ic8hEOIYXjN17OdKPEGW385sicwp2SrmT80PIdWu9IB3YUdqjuK5kd1+7ieFI/qE+K
         dU7rbCtwpLAdxg+YqcgkkAodlARg3efTc/cAXvmsI99gMyZHVZK+WdCzcHA9CQgZsI+Q
         x8rRM/6EvRlqv1T7F4+DyTdvyN3xFdVbK5ozuVBsGBoTkCJeGPKgYEBU0FK/Qrj2IlMp
         uqsaFW6hRbF700Y4mwvCDzZ3cK8H4Ronb0a4QgNH+IE6+AgHygR8C3n6LvwHHJ38g+zO
         fvvtor/+Vpwpf7IcNC1oRQmOgrklxjpceBnfR4xp7Fejt8J/quaZib0mhddNLRE20696
         E+eQ==
X-Gm-Message-State: AOAM533qK4nDIUoXpfldqLNP3V0R6gFaPtHB+fOkprHcb5HngciwZZPT
        06qOzfag8OjAQ1pJovPA91lh6Q==
X-Google-Smtp-Source: ABdhPJzaoZFC7TTpp3zIHhl6P5+Ct/dxTj7G56pZG2S9WMJL6cRav/lZxo83MUBRakgj1WROOHHClA==
X-Received: by 2002:a63:4f50:: with SMTP id p16mr6820680pgl.245.1621370282951;
        Tue, 18 May 2021 13:38:02 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id g13sm13521721pfi.18.2021.05.18.13.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:38:02 -0700 (PDT)
Date:   Tue, 18 May 2021 20:37:58 +0000
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
Message-ID: <YKQlpuKHb7DFFG8y@google.com>
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210518004807.258503-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <36cd2665-6d8b-9c0b-eec1-25152dcca2a3@intel.com>
 <43e583a3-ee2b-52d8-5275-e26a6609c126@linux.intel.com>
 <YKP1Xty7EEzHkZ6Y@google.com>
 <8fb0e52c-ed0a-2185-585a-27007c27ed56@linux.intel.com>
 <YKQF08wqTsCQ3qHL@google.com>
 <3a037a43-435b-fc28-63d0-48e543cddfdd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a037a43-435b-fc28-63d0-48e543cddfdd@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021, Andi Kleen wrote:
> 
> On 5/18/2021 11:22 AM, Sean Christopherson wrote:
> > On Tue, May 18, 2021, Andi Kleen wrote:
> > > > The extra bytes for .altinstructions is very different than the extra bytes for
> > > > the code itself.  The .altinstructions section is freed after init, so yes it
> > > > bloats the kernel size a bit, but the runtime footprint is unaffected by the
> > > > patching metadata.
> > > > 
> > > > IIRC, patching read/write{b,w,l,q}() can be done with 3 bytes of .text overhead.
> > > > 
> > > > The other option to explore is to hook/patch IO_COND(), which can be done with
> > > > neglible overhead because the helpers that use IO_COND() are not inlined.  In a
> > > > TDX guest, redirecting IO_COND() to a paravirt helper would likely cover the
> > > > majority of IO/MMIO since virtio-pci exclusively uses the IO_COND() wrappers.
> > > > And if there are TDX VMMs that want to deploy virtio-mmio, hooking
> > > > drivers/virtio/virtio_mmio.c directly would be a viable option.
> > > Yes but what's the point of all that?
> > Patching IO_COND() is relatively low effort.  With some clever refactoring, I
> > suspect the net lines of code added would be less than 10.  That seems like a
> > worthwhile effort to avoid millions of faults over the lifetime of the guest.
> 
> AFAIK IO_COND is only for iomap users. But most drivers don't even use
> iomap. virtio doesn't for example, and that's really the only case we
> currently care about.

virtio-pci, which is going to used by pretty much all traditional VMs, uses iomap.
See vp_get(), vp_set(), and all the vp_io{read,write}*() wrappers.
