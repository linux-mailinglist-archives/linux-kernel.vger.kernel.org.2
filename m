Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147AC357021
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353482AbhDGPYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:24:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:37622 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231579AbhDGPYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:24:31 -0400
IronPort-SDR: LmHq+2fnsAQ5px8h9OhWAgAxhlraOm13asDDg0eg2s0txJz9gvlw+MesJNJNnvg1NRbqMs3SUR
 CLEyOJIX4igQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="180464345"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="180464345"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 08:24:21 -0700
IronPort-SDR: 75+igPB4OKJBCJ97rxPE+M2owKYHWZCa5M+tjR8PpGDzpaCeP58tFetO/OuJiJsJtRew3Xa5gP
 w6eIs/VM6UOQ==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="415314114"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 08:24:19 -0700
Date:   Wed, 7 Apr 2021 08:24:17 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20210407152417.GM1285835@tassilo.jf.intel.com>
References: <YGNAQrWMl3AZQ3HG@google.com>
 <4DD05B91-13B3-4842-A215-C8DC6F34F219@amacapital.net>
 <YGNYhWXe57FMm6Ku@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGNYhWXe57FMm6Ku@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, I forgot about that quirk.  I would expect the TDX Module to inject a #GP
> for that case.  I can't find anything in the spec that confirms or denies that,
> but injecting #VE would be weird and pointless.
> 
> Andi/Sathya, the TDX Module spec should be updated to state that XSETBV will
> #GP at CPL!=0.  If that's not already the behavior, the module should probably
> be changed...

I asked about this and the answer was that XSETBV behaves architecturally inside
a TD (no #VE), thus there is nothing to document.

-Andi
