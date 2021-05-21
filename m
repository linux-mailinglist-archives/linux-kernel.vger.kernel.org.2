Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD94638CD80
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbhEUSeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:34:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:33957 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232583AbhEUSeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:34:04 -0400
IronPort-SDR: C4NGxBNoobTzXsEqsxAUfQD+OHDCK/05vPL4pAa3OzlrXzoZJPFzgvlUGjokr9CKyEc4T/meLH
 sSHlIf/xUwNg==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="262764131"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="262764131"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 11:32:40 -0700
IronPort-SDR: xuimTYhQfkQ8M5AjUfAoJr+h9etA8CXp8+j1k+A+K6QRs2+UeRZAgxsesoMUovRMvi40PDj7au
 KgjtoRfxxovA==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441193981"
Received: from orxpovpvmu02.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.181.51])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 11:32:39 -0700
Subject: Re: [RFC v2-fix-v2 1/1] x86/boot: Avoid #VE during boot for TDX
 platforms
To:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <b1aafcbb-c5db-efa5-0343-014585e73191@intel.com>
 <20210521143524.2527690-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <f33c63b2-7b41-4c99-abd6-b47a8e7a4e26@intel.com>
 <YKf5hObmGXNgx0vS@google.com>
 <9a23d1c3-a443-6142-52b4-7594123030fb@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d90b689d-4716-1a3b-1e6d-f32a9a25894a@linux.intel.com>
Date:   Fri, 21 May 2021 11:32:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9a23d1c3-a443-6142-52b4-7594123030fb@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/21 11:30 AM, Dave Hansen wrote:
> That sounds sane to me.  It would be nice to get this into the
> changelog.  Perhaps:
> 
> 	This theoretically makes guest boot more fragile.  If, for
> 	instance, EER was set up incorrectly and a WRMSR was performed,
> 	the resulting (unhandled) #VE would triple fault.  However, this
> 	is likely to trip up the guest BIOS long before control reaches
> 	the kernel.  In any case, these kinds of problems are unlikely
> 	to occur in production environments, and developers have good
> 	debug tools to fix them quickly.
> 
> That would put my mind at ease a bit.

I can add it to change log.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
