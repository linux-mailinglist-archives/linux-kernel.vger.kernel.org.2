Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2C5352589
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 04:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbhDBCsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 22:48:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:43768 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233665AbhDBCsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 22:48:54 -0400
IronPort-SDR: wV529Fcw12XmVUumTuIDOmgvu6iCTC63Kbc8oBsKBlJ+H2bR0xC47fvAMFLNf53dVCzyAvWvEf
 Js59GvyoWi8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="172406896"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="172406896"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 19:48:53 -0700
IronPort-SDR: 0cZxnLKxQ2igMPiF7I7ZOZm72ImAl9vnmvomzopHCqpBCB4r65MRotijuOEeJ+jhi8Q40bIsZR
 uyFBoxn3nh0A==
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="596570650"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 19:48:53 -0700
Date:   Thu, 1 Apr 2021 19:48:52 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 00/26] Add TDX Guest Support
Message-ID: <20210402024852.GK1285835@tassilo.jf.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <95e97456-478b-c6a2-f851-3b19ce794262@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95e97456-478b-c6a2-f851-3b19ce794262@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I've heard things like "we need to harden the drivers" or "we need to do
> audits" and that drivers might be "whitelisted".

The basic driver allow listing patches are already in the repository,
but not currently posted or complete:

https://github.com/intel/tdx/commits/guest

> 
> What are we talking about specifically?  Which drivers?  How many
> approximately?  Just virtio?  

Right now just virtio, later other drivers that hypervisors need.

> Are there any "real" hardware drivers
> involved like how QEMU emulates an e1000 or rtl8139 device?  

Not currently (but some later hypervisor might rely on one of those)

> What about
> the APIC or HPET?

No IO-APIC, but the local APIC. No HPET.

> 
> How broadly across the kernel is this going to go?

Not very broadly for drivers.

> 
> Without something concrete, it's really hard to figure out if we should
> go full-blown paravirtualized MMIO, or do something like the #VE
> trapping that's in this series currently.

As Sean says the concern about MMIO is less drivers (which should
be generally ok if they work on other architectures which require MMIO
magic), but other odd code that only ran on x86 before.

I really don't understand your crusade against #VE. It really
isn't that bad if we can avoid the few corner cases.

For me it would seem wrong to force all MMIO for all drivers to some
complicated paravirt construct, blowing up code side everywhere
and adding complicated self modifying code, when it's only needed for very
few drivers. But we also don't want to patch every MMIO to be special cased
even those few drivers.

#VE based MMIO avoids all that cleanly while being nicely non intrusive.

-Andi

