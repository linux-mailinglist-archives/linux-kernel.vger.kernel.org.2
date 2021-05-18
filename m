Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928AB387D03
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350179AbhERQCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:02:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:41086 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350152AbhERQCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:02:09 -0400
IronPort-SDR: W4TYZhhDaSJQl63AdY29orL+Ue1TPw92qUMk18FoMKhBI4lXkfyKTXJWCUP0psNCIzQB4D4PY7
 JT7WOSjJxTeA==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="286279279"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="286279279"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 09:00:37 -0700
IronPort-SDR: NI4ABGutW7/7yJwf/5I5+JeeEMD5rGLuw48looEUPSGDwztR404Vv9PZkGM0rxfZMzKsXY6ztO
 9pXSt6WPIlTw==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439502267"
Received: from msaber-mobl.amr.corp.intel.com (HELO [10.209.65.183]) ([10.209.65.183])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 09:00:36 -0700
Subject: Re: [RFC v2-fix 1/1] x86/traps: Add #VE support for TDX guest
To:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <afd85e8f-ab26-aa3b-e4e9-a0b3bfd472c8@intel.com>
 <20210518000957.257869-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <4fc32900-412d-fa10-520e-afa6caade33e@intel.com>
 <81c0f447-44b8-c2b6-ce41-a39ec0a1832b@linux.intel.com>
 <f390e073-e867-e102-742b-1c79c9269f60@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <7e4b74a9-2de6-4d10-c68f-a41a5ad8c07f@linux.intel.com>
Date:   Tue, 18 May 2021 09:00:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <f390e073-e867-e102-742b-1c79c9269f60@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> No APIC access either?


It's all X2APIC inside TDX which uses MSRs

>
> Also, shouldn't we have at least a:
>
> 	WARN_ON_ONCE(in_nmi());
>
> if we don't expect (or handle well) #VE in NMIs?

We handle it perfectly fine. It's just not needed.


-Andi

