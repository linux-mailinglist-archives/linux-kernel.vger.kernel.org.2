Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4099E3119E7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhBFDXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:23:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:27691 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231228AbhBFCml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:42:41 -0500
IronPort-SDR: EQ5XTD5b7cXr2CpjQgyzRf7wKCDYv4Yanwk2TB8fl6QnKrFsK+Pih3pqYhVOcvABb6CUNSUqCN
 r8cj63zhnkgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181652181"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181652181"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:54:36 -0800
IronPort-SDR: eHAREXYRgqw2x8lipaHQNOTl9L8qH9kCWgOpPYBbvk0c8ygVZVMDC3Hnh0M3/dVR9JwNX2SGB8
 PdZAos9bRxBA==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="397650722"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:54:36 -0800
Subject: Re: [RFC v1 13/26] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <f443f4a2d80ea3717bd1865ae61cec2a100805c3.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CALCETrWQm+4ocEjDM2e1z=ewmjf4r--6UeqnTwKEtKRa_o-mNg@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <64109360-c45b-2a2f-b5c0-956386fc7168@linux.intel.com>
Date:   Fri, 5 Feb 2021 15:54:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWQm+4ocEjDM2e1z=ewmjf4r--6UeqnTwKEtKRa_o-mNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 2/5/21 3:43 PM, Andy Lutomirski wrote:
> MWAIT turning into NOP is no good.  How about suppressing
> X86_FEATURE_MWAIT instead?
Yes, we can suppress it in tdx_early_init().

  + setup_clear_cpu_cap(X86_FEATURE_MWAIT);

But do you want to leave the MWAIT #VE handler as it as
(just in case)?


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
