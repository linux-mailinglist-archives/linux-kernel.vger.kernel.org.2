Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708583799EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhEJWUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:20:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:52294 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231807AbhEJWUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:20:20 -0400
IronPort-SDR: IOLs2pMuMV2FlQhMyFbxacrl45NnJf565KqMVYGXOWQF5k9tfzc3R1VNRbTWns6sJFE1ulOLQl
 FdGIgOwd9OSQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="186434643"
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="186434643"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 15:19:13 -0700
IronPort-SDR: OwFO49KfvhE+Xw8i3QMr4NJEKXZ6uegf/77SDYWuFvfKNGGoKGAr1tZQxOLN162Sfll5qeh5by
 5QtqKWQqGH6g==
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="609255395"
Received: from kcmorris-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.165.53])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 15:19:13 -0700
Subject: Re: [RFC v2 26/32] x86/mm: Move force_dma_unencrypted() to common
 code
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <7c5adf75d69ea327b22b404b7c37b29712d73640.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5536639a-918d-de8d-ff32-934a13902a03@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d04e5992-8800-a8df-99de-4dbb40e45d09@linux.intel.com>
Date:   Mon, 10 May 2021 15:19:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5536639a-918d-de8d-ff32-934a13902a03@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/21 2:54 PM, Dave Hansen wrote:
> This doesn't seem much like common code to me.  It seems like 100% SEV
> code.  Is this really where we want to move it?

Both SEV and TDX code has requirement to enable
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED and define force_dma_unencrypted()
function.

force_dma_unencrypted() is modified by patch titled "x86/tdx: Make DMA
pages shared" to add TDX guest specific support.

Since both SEV and TDX code uses it, its moved to common file.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
