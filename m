Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF73F3881C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352291AbhERU7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:59:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:41709 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352289AbhERU7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:59:02 -0400
IronPort-SDR: IgyXoJmBZkaajogfx8ybYilrVDzrluWbW9roPSdR9PLMkEKtM8e4YyRMKak2vkX5CRwxY3hpHu
 +Qk9ueMwm4cA==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="221878672"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="221878672"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 13:57:42 -0700
IronPort-SDR: +uF6fv2tkeznLv6ikYF292KM5yILporYZjrKjkNff5cMwMEYSaAlnJuiyYdbrWADr7elBwnR8k
 zkRXzChaCfDQ==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439631812"
Received: from dwchow-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.41.14])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 13:57:40 -0700
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Wire up KVM hypercalls
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
References: <2a4e9702-5407-aa95-be9b-864775bbaabd@intel.com>
 <20210518001551.258126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <f9bbc6b2-c7ac-3f36-08e3-9c4da68a6a9d@intel.com>
 <d669889f-23e0-5f21-60ab-b550d5934364@linux.intel.com>
 <36760dae-2f61-2072-460a-f8359224fcf1@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <20a595f1-f6ca-702e-b718-55c84a984e51@linux.intel.com>
Date:   Tue, 18 May 2021 13:57:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <36760dae-2f61-2072-460a-f8359224fcf1@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/21 1:19 PM, Dave Hansen wrote:
> But, seriously, you don't need to preserve a SoB for a one-line patch.
> Just pull the line in and make a note in the changelog.

Ok. Makes sense. I will leave the comment and remove SOB from Isaku.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
