Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43253A44D8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 17:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhFKPZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 11:25:39 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:51077 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhFKPZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 11:25:38 -0400
Received: by mail-pj1-f52.google.com with SMTP id g4so5905556pjk.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zDELvCcEl/roHFnu9m1VHxPMUFNGvlvXPDIVOdM9ikI=;
        b=XdxzAeVCHwLfBHz8cwbbMnqGUVYc1UhOgikbpV/QktNU4q2i1dFv67gEJlMo9w9vqk
         6DmFYF01OeGiGvCjs66NOqLz1lA2x/t0gDvPQea3oBfwg8118Oqzcm2z/WWrn6BYo8o1
         f1Ud2F18s4JEDyeimOlfyCEjTy7xPV3cWAEPHezp7t4OPoEzT4CAZTzr+4bYZKMELOkL
         gF6s/tyAoCfzLFMi5Z5KY0ESOyToo7l5owGWE4mSM9Abc42rNL12HVlHneqXsfQO8XOT
         9EB7GFITgOryG+zIJJ+YeVMdsA8FM2E+z6yNqIELqrzPUHz03D3xJ0Ln96v8RhXI2FLS
         xeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zDELvCcEl/roHFnu9m1VHxPMUFNGvlvXPDIVOdM9ikI=;
        b=CjueBHc/ExHzoD11Xsq3MnLs7o+wEnsLE4KhfYt5ausoiRfY51tlEZ/Sue5GDq6xyD
         FdBuZ4+AGAQO5d3a0RfN8fF3Yr6trE5YIfXj9typI3OUrZyn6gOmR3gWp/w4MC49EVq3
         J/JB4/MZvEXCHyw0nPArN+9b9XPGR2zveRdWP9ycCSpj2YjZZx1Tiex+jyrG4sB87zYi
         +/T41DIA5MJWHZcvqqEjk7QJbAqwqraHUwUxCy/ZYMM3STx/lJaISykepxXkfxknrKRu
         Tf6FVKvJ67a/+VSfvN9agR9Brx9dadP8T0sEi7GKlamLsyvGes4UCQ3U/AX2yEXmiXjz
         Ek4g==
X-Gm-Message-State: AOAM531f5BMicJKtAT50DLCGdUl9U/oiqxMrNJuhWyLVS3aCh4eHCdmi
        tkm89C6mhcgNHfNZwgq2lOY+Gw==
X-Google-Smtp-Source: ABdhPJzZQDlzV2QvMony8EkHB9Mw0VaryeIHIZB8UdY/fsJL2Env/3MvBvtiqwkxgZuKQaWtek2cKw==
X-Received: by 2002:a17:90a:4a12:: with SMTP id e18mr5070251pjh.213.1623424960138;
        Fri, 11 Jun 2021 08:22:40 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id r6sm10590322pjm.12.2021.06.11.08.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 08:22:39 -0700 (PDT)
Date:   Fri, 11 Jun 2021 15:22:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Erdem Aktas <erdemaktas@google.com>
Cc:     "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, x86 <x86@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        isaku.yamahata@gmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@linux.intel.com>
Subject: Re: [RFC PATCH 64/67] KVM: TDX: Add "basic" support for building and
 running Trust Domains
Message-ID: <YMN/u3Xip2Do5dGR@google.com>
References: <cover.1605232743.git.isaku.yamahata@intel.com>
 <b7004ea31380e113f38965f21f86a10cb7be1dc9.1605232743.git.isaku.yamahata@intel.com>
 <CAAYXXYwHp-wiAsSjfsLngriGZpdQHUVY6o7zdGrN2fNm_RJZAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAYXXYwHp-wiAsSjfsLngriGZpdQHUVY6o7zdGrN2fNm_RJZAQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021, Erdem Aktas wrote:
> Hi Isaku,
> 
> I know you are going to submit a set of new patch series so here are
> few feedbacks thatI have encounter:
> 
> 
> KVM_TDX_INIT_VM has a parameter that user space VMM can provide the
> CPUID entries but it is not clear if any of those entries are
> mandatory.  If userspace VMM does not provide guest_supported_xcr0 and
> guest_supported_xss, TDX init will fail as their default values are
> set to 0.
> 
> It is expected but would be nice to document (or return an error
> message with more information) that KVM_CAP_X2APIC_API and
> KVM_IRQCHIP_SPLIT CAPS need to be enabled.
> 
> When CPUID entries are queried from KVM (using
> KVM_GET_SUPPORTED_CPUID) and provided back to the  KVM_TDX_INIT_VM,
> the default GPAW size requires 5 level SEPT but KVM still tries to
> create 4 level SEPT and fails to add private pages. Error messages are
> also not very helpful to figure out what was happening.

Please trim your replies and try to avoid top-posting.  Thanks for the input!

https://people.kernel.org/tglx/notes-about-netiquette
