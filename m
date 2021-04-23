Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A55369935
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243556AbhDWSTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:19:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:40579 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243436AbhDWSTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:19:04 -0400
IronPort-SDR: dMpp2uwBA5WKUr6MD6iOhrmra4aI+tP8lkGOO7r0FcmLzakKnsdq3DRSfmXbMWxf3qR5VOHipt
 TjXE9oIFdGdA==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="196172687"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="196172687"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:18:20 -0700
IronPort-SDR: 5nIB+qsphe/0RbF5FlrOb2DXMzNq7Cvfuxm64sqXRdoHiI+czLXYA9y8L2lWNoMWdeAGKRMyHL
 Y+jGdCSQayXQ==
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="456314927"
Received: from aberdasc-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.2.101])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:18:19 -0700
Subject: Re: [PATCH v2 1/1] x86/tdx: Add __tdcall() and __tdvmcall() helper
 functions
To:     Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <8723950c-e07c-9a03-503a-ab232701d1e9@linux.intel.com>
 <c015093fdbc8e6a5aa9fc43f78fec8d9c38295c7.1616801167.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <77a13ae9-0220-030e-7ae4-fd26edd7b110@intel.com>
 <2a3f6b3d-cd80-0734-ce83-c067666c8326@linux.intel.com>
 <14332abf-c78c-3bc2-9a7c-ceacfa7a0661@intel.com>
 <596175e3-9d1e-6c9c-fadb-ad02c396e3ad@linux.intel.com>
 <d99941db-6ee6-267e-dece-6220af0ea305@intel.com>
 <9161efc0-fd25-d239-32b7-5d2c726579b0@linux.intel.com>
 <4ac4ed35-212b-f7ad-55f4-937946ffec1a@intel.com>
 <20210423013546.GK1401198@tassilo.jf.intel.com> <YILkl3C4YjGPM5Jr@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d013807c-3b5c-4bb6-6fc9-b7dd9d27c1b2@linux.intel.com>
Date:   Fri, 23 Apr 2021 11:18:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YILkl3C4YjGPM5Jr@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/23/21 8:15 AM, Sean Christopherson wrote:
> Has Intel "officially" switched to "tdg" as the acronym for TDX guest?  As much
> as I dislike having to juggle "TDX host" vs "TDX guest" concepts, tdx_ vs tdg_
> isn't any better IMO.  

When we merged both host and guest kernel into the same code base, we hit some
name conflicts (due to using tdx_ prefix in both host/guest code). So in order to
avoid such issues in future we decided to go with tdg/tdh combination. we thought
its good enough for kernel function/variable names.

The latter looks an awful lot like a typo, grepping for
> "tdx" to find relevant code will get fail (sometimes), and confusion seems
> inevitable as keeping "TDX" out of guest code/comments/documentation will be
> nigh impossible.

tdg/tdh combination is only used within kernel code. But in sections which are
visible to users (kernel config and command line option), we still use
tdx_guest/tdx_host combination.


> 
> If we do decide to go with "tdg" for the guest stuff, then_all_  of the guest
> stuff, file names included, should use tdg.  Maybe X86_FEATURE_TDX_GUEST could
> be left as a breadcrumb for translating TDX->TDG.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
