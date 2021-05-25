Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA3C38F748
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 03:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhEYBEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 21:04:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:38453 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhEYBD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 21:03:57 -0400
IronPort-SDR: CAyfiiiJ58o0jdNogJnrmiThKMEI/BYX1ZBzVAyjbjzPDbpZin7x8YE53SNWRAwJZzJsG7McBE
 K0o02amye7Vw==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="265962511"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="265962511"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 18:02:28 -0700
IronPort-SDR: EGyiz7n1fNCgnQvudXeU1FUOhiKeDE4VmeAOt07PySaWlz2CYSmBA7IyMyQQMaINs+JGjHOjHf
 COuPmrjfaodQ==
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="546288077"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.195.214]) ([10.212.195.214])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 18:02:26 -0700
Subject: Re: [RFC v2-fix-v2 2/2] x86/tdx: Ignore WBINVD instruction for TDX
 guest
To:     Dan Williams <dan.j.williams@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <37ad50ca-f568-4c62-56e2-9e9b1f34084c@linux.intel.com>
 <20210524233211.802033-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210524233211.802033-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jKY0rmewFnyL6My5-b+w8ANAwDY2tLXZk4CYKydoVbtg@mail.gmail.com>
 <b420a7af-5202-fee9-9e0b-39680d0cc9c8@linux.intel.com>
 <CAPcyv4gNz9gKsHVcindp3OsHz4hMRWPZgsNu1A5xrDQg7tYqNA@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <cea7c704-5f1c-3f84-e47b-c62da18e358e@linux.intel.com>
Date:   Mon, 24 May 2021 18:02:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gNz9gKsHVcindp3OsHz4hMRWPZgsNu1A5xrDQg7tYqNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> That makes KVM also broken for the cases where wbinvd is needed,


Or maybe your analysis is wrong?


> but
> it does not make the description of this patch correct.

If KVM was broken I'm sure we would hear about it.

The ACPI cases are for S3, which is not supported in guests, or for the 
old style manual IO port C6, which isn't supported either.

The persistent memory cases would require working DMA mappings, which we 
currently don't support. If DMA mappings were added we would need to 
para virtualized WBINVD, like the comments say.

AFAIK all the rest is for some caching attribute change, which is not 
possible in KVM (because it uses EPT.IgnorePAT=1) nor in TDX (which does 
the same). Some are for MTRR which is completely disabled if you're 
running under EPT.

-Andi
