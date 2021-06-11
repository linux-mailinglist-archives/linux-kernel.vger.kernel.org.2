Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77B03A461F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhFKQGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:06:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:51671 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhFKQF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:05:58 -0400
IronPort-SDR: 5OIHDzvxAAoKgl5svT5oP50fW2pmeBLlrGhv+D9topKEdpBQ4QjRGT5Lr8J43z76qVAnf23VJO
 m6LKEUG1hZNA==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="266703600"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="266703600"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 09:03:31 -0700
IronPort-SDR: s5AhoQuHO/vL5TlJ+8ZIF74JVKGiQ72cuJO/f5+S8Cgp3XdKioq0ftZPXf0pNTzEcHHxRPevSv
 XVghCgziNGAw==
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="553448552"
Received: from czanatax-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.184.187])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 09:03:29 -0700
Subject: Re: [PATCH v1 6/7] x86/kvm: Use bounce buffers for TD guest
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210609215537.1956150-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210609215537.1956150-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <5f4dd90d-3761-3e1d-4f7b-86f504f769ae@amd.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <ab7dfaea-af87-3cec-d5cc-f2a187518326@linux.intel.com>
Date:   Fri, 11 Jun 2021 09:03:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5f4dd90d-3761-3e1d-4f7b-86f504f769ae@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/21 7:52 AM, Tom Lendacky wrote:
> The sme_me_mask is checked in amd_mem_encrypt_init(), so you should just
> invoke amd_mem_encrypt_init() unconditionally.

Ok. I will fix it in next version.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
