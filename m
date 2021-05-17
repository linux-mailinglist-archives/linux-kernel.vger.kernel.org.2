Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC54A383C35
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 20:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbhEQS25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 14:28:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:17147 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233592AbhEQS2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 14:28:55 -0400
IronPort-SDR: YjMTZCGkoQQhWyf2PNgqEJZtPuHOILB7a5+vP/cxJOOimoLOwVQYRY1UAEJ4YAfss3U+feT/4P
 HQ0L7870ming==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="180812523"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="180812523"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 11:27:37 -0700
IronPort-SDR: 3g4wahcMquEIn9pC7wPTvUqmPsuxEsWz+PdKJfmj7EJmI6N6zOBV03b3r+ixWosiRLhSetr7pq
 ICUV4CvXG3Ig==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="393625340"
Received: from jtshade-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.100.65])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 11:27:35 -0700
Subject: Re: [RFC v2 26/32] x86/mm: Move force_dma_unencrypted() to common
 code
To:     Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <7c5adf75d69ea327b22b404b7c37b29712d73640.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5536639a-918d-de8d-ff32-934a13902a03@intel.com>
 <d04e5992-8800-a8df-99de-4dbb40e45d09@linux.intel.com>
 <bbcb688c-5aa0-eeb1-192a-45edaccc2f32@intel.com>
 <20210512130821.7r2rtzcyjltecun7@box.shutemov.name>
 <e8886298-83fa-212e-ab3a-5e5b21a7ab6c@intel.com>
 <YJv6EWJmDYQL4Eqt@google.com>
 <c6b40305-d643-6023-907b-e6858d422a36@linux.intel.com>
 <943645b7-3974-bf05-073c-03ef4f889379@intel.com>
 <a72bce3a-d7da-c595-9456-cfda42d9cdc3@linux.intel.com>
 <YKKzCOW9u6q06E5I@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d5fb2565-110e-17d1-ea00-35cf4d196f1e@linux.intel.com>
Date:   Mon, 17 May 2021 11:27:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKKzCOW9u6q06E5I@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/21 11:16 AM, Sean Christopherson wrote:
> What generic code needs access to SEV vs. TDX?  force_dma_unencrypted() is called
> from generic code, but its implementation is x86 specific.

When the hardening the drivers for TDX usage, we will have requirement to check
for is_protected_guest() to add code specific to protected guests. Since this will
be outside arch/x86, we need common framework for it.

Few examples are,
  * ACPI sleep driver uses WBINVD (when doing cache flushes). We want to skip it for
   TDX.
  * Forcing virtio to use dma API when running with untrusted host.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
