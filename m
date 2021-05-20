Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9019938B8F3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhETVaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:30:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:24361 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229923AbhETVaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:30:06 -0400
IronPort-SDR: HqB5wNQzpwSeZ374TG54pT12LddEzFF5sehRb/B9s3bMzefHS/7qTrpN4S+1gHipybuIN9OcXB
 48dnUiFec9iw==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="181627058"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="181627058"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 14:28:43 -0700
IronPort-SDR: 86osZ9CILa9GS9tcJvR5MG/jrJflFKBbbtnx6twdyJv6AOuEIlwqLB96UHe77JVlzF+cHrLgde
 M9WlFXbtaYtQ==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="440628564"
Received: from shaunnab-mobl2.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.65.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 14:28:41 -0700
Subject: Re: [RFC v2 27/32] x86/tdx: Exclude Shared bit from __PHYSICAL_MASK
To:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <87b31425b79df3cc44d2bdc6a79d6aa36c42d116.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3ae38a0b-0676-1543-7015-39a589b2807a@intel.com>
 <0df80c0f-e0da-e86e-0ab8-abc58f0da559@linux.intel.com>
 <YKa5gkwGTIUFpzzH@google.com>
 <b27a6d31-8fd9-e650-0adf-5f7a8fc96a1c@linux.intel.com>
 <YKbDtt2K4Z5gtYRc@google.com>
 <f348c391-c665-2987-898c-718d2c53729f@linux.intel.com>
 <YKbSOJOKBV1Rjb0T@google.com>
 <283b3d47-f1f6-3c53-0909-ba0540993203@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <6d508f80-4a76-64c2-9772-da23bb467e0b@linux.intel.com>
Date:   Thu, 20 May 2021 14:28:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <283b3d47-f1f6-3c53-0909-ba0540993203@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/21 2:23 PM, Dave Hansen wrote:
> Sathya has even mis-typed "tdx" instead of "tdg" this in his own
> changelogs up to this point.  That massively weakens the argument that
> "tdg" is a good idea.

It is not a typo. But when we did the initial rename from "tdx_" -> "tdg_",
somehow I missed the change log change. That's why I am bit reluctant
to go for another rename (since we have scan change log, comments and code)
in all the patches.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
