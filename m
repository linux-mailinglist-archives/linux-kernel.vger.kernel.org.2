Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5227439AA8B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhFCS4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:56:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:14410 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhFCS4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:56:42 -0400
IronPort-SDR: 4cxVX1emJECtk7WQibT1LhHTD6MTD7DbTPFxTHs6DgG3B+Z6ew81RVrtjiMPsxcqzn8K0K4zdh
 ZNVvr3un5PDQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="202264746"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="202264746"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 11:54:54 -0700
IronPort-SDR: cX8H+mQzf8xMh4D17tdHxI5UHTCEw0j6FlJsDp0Bgs6WiplOwV1JNv58xNph/YRAXL3Ex1F2w3
 XfpvsM9YdyZg==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="480338329"
Received: from jacobmon-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.36.217])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 11:54:53 -0700
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstraction
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLkcIuL2qvo0hviU@zn.tnic>
 <d062aedf-29d9-a83f-a727-109aaf766bf9@linux.intel.com>
 <YLkiZFzkSfED3BFB@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <0db0402c-390f-2c5b-8fdc-36462b49e029@linux.intel.com>
Date:   Thu, 3 Jun 2021 11:54:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLkiZFzkSfED3BFB@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/3/21 11:41 AM, Borislav Petkov wrote:
>> Since you are checking for AMD vendor ID, why not use amd_protected_guest_has()?
> Because, as Sean already told you, we should either stick to the
> technologies: TDX or SEV or to the vendors: Intel or AMD - but not
> either or.

Ok. We can go with technologies for now. In future, if protected_guest_has() is extended
for other technologies like MKTME, then we can generalize it base on vendor.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
