Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37CB38983D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 22:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhESUu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 16:50:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:43681 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhESUuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 16:50:25 -0400
IronPort-SDR: kdWjDbTKOZB0jBldUpMXf2YqxNfgOsIK8qDum356yV30MGhIjb7b91TR0ISGjtdwPvmqaAlaTa
 i3oYB4sbc46w==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="188203176"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188203176"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 13:49:02 -0700
IronPort-SDR: vlvBR4yYWAXNC1jO2cHTsGh3eijnJJitLO21wSAOekzigRdN0wXgHk9C6osOc9ebYHjxHA4m+3
 UR4XfuxjBZnw==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="411887513"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.100.118]) ([10.209.100.118])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 13:49:01 -0700
Subject: Re: [RFC v2-fix-v1 1/1] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
To:     Sean Christopherson <seanjc@google.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <3a7c0bba-cc43-e4ba-f7fe-43c8627c2fc2@intel.com>
 <20210519055842.2048957-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <568d2929-f366-e3be-96f9-0bfa91991ef2@intel.com>
 <02e7b229-4b6f-c1c7-bb63-48e5e9eca5db@linux.intel.com>
 <YKVwjdspTazTXlam@google.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <77545da6-d534-e4c2-a60b-085705e3f0b7@linux.intel.com>
Date:   Wed, 19 May 2021 13:49:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKVwjdspTazTXlam@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/19/2021 1:09 PM, Sean Christopherson wrote:
> On Wed, May 19, 2021, Kuppuswamy, Sathyanarayanan wrote:
>> On 5/19/21 8:31 AM, Dave Hansen wrote:
>>> Was this "older compiler" argument really the reason?
>> It is a speculation. I haven't tried to reproduce it with old compiler. So
>> I have removed that point.
> It's not "older" compilers.  gcc does not support R8-R15 as input/output
> constraints,

Yes that's true, but they can be in clobbers. So it usually just needs a 
mov from the input arguments for output, or a mov to the output 
arguments for output.



