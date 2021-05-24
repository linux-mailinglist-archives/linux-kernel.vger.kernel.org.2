Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90B938E83D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 16:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhEXOD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 10:03:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:57733 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232685AbhEXODw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:03:52 -0400
IronPort-SDR: iPdetV0H2PEBbh00KjiG2xYeGimYoxkODx+Njp+NNPX1iEPwDTiHFmjPX/Ug9BAk6+sK6cHi3j
 BFLnM1xsijiw==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="189062136"
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="scan'208";a="189062136"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 07:02:24 -0700
IronPort-SDR: jI7ZS3h/4UbJECht2U+futzaJOpalxKkYo6SM5/TK/275LD5dMWDY1DkD4i7hq/YQRmff+FP6u
 B6ht9E1LEp+A==
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="scan'208";a="442836126"
Received: from imadu-mobl.amr.corp.intel.com (HELO [10.212.195.214]) ([10.212.195.214])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 07:02:22 -0700
Subject: Re: [RFC v2-fix 1/1] x86/traps: Add #VE support for TDX guest
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <afd85e8f-ab26-aa3b-e4e9-a0b3bfd472c8@intel.com>
 <20210518000957.257869-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <4fc32900-412d-fa10-520e-afa6caade33e@intel.com>
 <81c0f447-44b8-c2b6-ce41-a39ec0a1832b@linux.intel.com>
 <CAPcyv4i5a7ERZ8n=_Ucffx1cLru7C08xz3cB6X0iG+4yLTUYQQ@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <4031ffc2-a442-5da7-e793-ac1053533bb3@linux.intel.com>
Date:   Mon, 24 May 2021 07:02:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAPcyv4i5a7ERZ8n=_Ucffx1cLru7C08xz3cB6X0iG+4yLTUYQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Only drivers that are not supported in TDX anyways could do it (mainly
>> watchdog drivers)
> What about apei_{read,write}() for ACPI error handling? Those are
> called in NMI to do MMIO accesses. It's not just watchdog drivers.

We expect the APEI stuff to be filtered in the normal case to reduce the 
attack surface. There's no use case for APEI error reporting in a 
normally operating TDX guest.

But yes that's why I wrote mainly. It should work in any case, we fully 
support #VE nesting after TDVEREPORT.

-Andi

