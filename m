Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040FC38F64D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhEXXlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEXXlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:41:25 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A2AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 16:39:56 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q15so21263589pgg.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 16:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScP+JQEFIOUy2qItnppcbf9xv+MC926aHBMDbL0Nw9U=;
        b=M6urPmM3g0V4emOnatNp6BiNMDnYW7u0A/GnhbIndDOjpI9JBwEjf6ywlQgDHNI2yG
         6QDiQkG9ekynmu8cvn58g0l18O3M4UtkdbYeaKsEYT6ghXHfi2wfl/rWLlzKtZqBJJuC
         fPl4wlWafumvVE7M25KxTo8Um95KtkuAVAGBvhB0Fqdk/fncZbHE8fSniiBkEo9h6ctQ
         NWo69A1xoalGvD+1biY79Y3oGnYi/Thb9MUqvHjhQiyb3WeLRWHzXCnZvj/7NEFzjD7v
         fD08n9qqIJK1I4QEEQtngsyg+vm3Bhwe3rXKAhaTlO6uI8H/5UUNWyvB383Z+lXAIo0Z
         CIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScP+JQEFIOUy2qItnppcbf9xv+MC926aHBMDbL0Nw9U=;
        b=VroUsZze5tTZoDcPBXuspqqCk53sWnb61gF9nSv8ukrVUpJyQzUyixf2/2U4SXgUBX
         Qfmx1zpZQJ/ysrtF46syIRIRtPkuPQ0wpBilbW8MAF43DStFlsyKh7EuIBYn/8fm2X+L
         OvB97KB96QJozOKEy0wSStILsBzQOLlDqWZydezhhniPxWPE0Y0PBwnVCkilHqLYAD6v
         ggH5EEEH42AcMsHL0OTtO/pp46KtdzBKspz/BL9sAWCLxeWZRioJaIqw7liHd2j4Z9GD
         8jVa9Zdo2l2IVWNiYpS7pcaemOrJ+4o+/e4UgoTjZFBrrT/aA9vv6ZwxGdqSQYmGUMi9
         fU+A==
X-Gm-Message-State: AOAM533uSs3696W+X1qImC0OfT7xPPiUx0dDcsMY2MptyxKtxW2f8b0Q
        i4Z8YaoKcBkz9LKODNtZEfgBsnYitB0MhJojsa7bqQ==
X-Google-Smtp-Source: ABdhPJyRJfXU68yrQteEganVzmViGo6gUtallvPH1XMRPbIoWbA74YZ6kkO+I2kGrrPpJs0wcqtZzmtvljHRFzxacPU=
X-Received: by 2002:a63:4b43:: with SMTP id k3mr15974638pgl.450.1621899595958;
 Mon, 24 May 2021 16:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <37ad50ca-f568-4c62-56e2-9e9b1f34084c@linux.intel.com>
 <20210524233211.802033-1-sathyanarayanan.kuppuswamy@linux.intel.com> <20210524233211.802033-2-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210524233211.802033-2-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 24 May 2021 16:39:49 -0700
Message-ID: <CAPcyv4jKY0rmewFnyL6My5-b+w8ANAwDY2tLXZk4CYKydoVbtg@mail.gmail.com>
Subject: Re: [RFC v2-fix-v2 2/2] x86/tdx: Ignore WBINVD instruction for TDX guest
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 4:32 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Functionally only DMA devices can notice a side effect from
> WBINVD's cache flushing. But, TDX does not support DMA,
> because DMA typically needs uncached access for MMIO, and
> the current TDX module always sets the IgnorePAT bit, which
> prevents that.

I thought we discussed that there are other considerations for wbinvd
besides DMA? In any event this paragraph is actively misleading
because it disregards ACPI and Persistent Memory secure-erase whose
usages of wbinvd have nothing to do with DMA. I would much prefer a
patch to shutdown all the known wbinvd users as a precursor to this
patch rather than assuming it's ok to simply ignore it. You have
mentioned that TDX does not need to use those paths, but rather than
assume they can't be used why not do the audit to explicitly disable
them? Otherwise this statement seems to imply that the audit has not
been done.
