Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAAE3992C4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhFBSqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:46:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:36510 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhFBSqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:46:51 -0400
IronPort-SDR: Fc12ajYhnSKBYVkhQq8b88/T9URm8y+9plGh0UW4sQeVxkvwhs3Rzanox4I9mjAfOIYCv123qF
 dTHKltIYsW5A==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="191213275"
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="191213275"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 11:45:06 -0700
IronPort-SDR: /gL1Eef7kzHub+/elUJMAaB8z0BstUvfcPH32C3C2UqV5pKLkDGnqLZt/3ZiuN9IDxrts/nE8d
 6p+gBcWbYh/w==
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="417002216"
Received: from sboinap-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.150.149])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 11:45:05 -0700
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstraction
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLe92NXx1jZPtPqB@google.com> <3036a655-9d09-0f04-62a2-7a72ba9af5c7@amd.com>
 <YLfOApYdX/KL1wKF@zn.tnic>
 <23225953-2052-8e72-5eb0-6b30f2a5c84b@linux.intel.com>
 <YLfQf6quDHIVeRhH@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <c12aba4a-36c7-d51e-cc76-eae585204aad@linux.intel.com>
Date:   Wed, 2 Jun 2021 11:45:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLfQf6quDHIVeRhH@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/21 11:39 AM, Borislav Petkov wrote:
> Ok, and which branch or tag?
> 
> tdx-guest-v5.12-7 or "guest"?
> 
> The github interface is yuck when one wants to look at commits...

please use guest branch.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
