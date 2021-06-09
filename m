Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A275D3A2064
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhFIWtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:49:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:9305 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhFIWtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:49:51 -0400
IronPort-SDR: AMEx/luihKnpU7pOnQlf700uYXsILGT+sYBrJoASqbZb3ABpL1W1mdlcVFUuhQoKnvXJBaRLBW
 KgDSBju9r52w==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="269040065"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="269040065"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 15:47:56 -0700
IronPort-SDR: yHpuMu/acn0IGwZcythz4RDWWZWAffXNU1nEht22deQlkSRNa2gZcdlGRgrFByjFfOQ35hDsY8
 jrYBayZqvOwg==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="402595444"
Received: from davidhok-mobl3.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.9.9])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 15:47:55 -0700
Subject: Re: [PATCH v1 04/10] x86/tdx: Handle early IO operations
To:     Sean Christopherson <seanjc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210609214555.1955404-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210609214555.1955404-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YME8aZVqI8x/a/Ld@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <8aba06f4-f0b1-502c-f9cb-67a69f817996@linux.intel.com>
Date:   Wed, 9 Jun 2021 15:47:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YME8aZVqI8x/a/Ld@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/21 3:10 PM, Sean Christopherson wrote:
> If y'all insist on shoving "tdg" down people's throats, at least get it right.

I will fix it in next version.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
