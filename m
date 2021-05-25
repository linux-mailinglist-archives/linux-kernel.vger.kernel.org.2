Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F5D38F708
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 02:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhEYAlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 20:41:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:65122 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhEYAlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 20:41:17 -0400
IronPort-SDR: FcWhXyZPCBUCnlXrmz8gOXqW8wzdHTpyxONcwt9Sk8Uo7JOhgweAVQUEVYfEYx1DTZQOtPshkd
 SimBFK0FWEUQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="287636918"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="287636918"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 17:39:48 -0700
IronPort-SDR: upbQ6XMI6ZuLuP+RJi6KM+ECmBeBD80xGg1WcEn4o5tUJUaBEh+Gy35rWjSIesJojJMGrO53vE
 sRWxappGbp9w==
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="546282116"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.195.214]) ([10.212.195.214])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 17:39:47 -0700
Subject: Re: [RFC v2-fix-v2 2/2] x86/tdx: Ignore WBINVD instruction for TDX
 guest
To:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <37ad50ca-f568-4c62-56e2-9e9b1f34084c@linux.intel.com>
 <20210524233211.802033-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210524233211.802033-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <6d336ac9-72ad-aae5-0b4c-f30a695d198b@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <76dcb466-225b-760b-525b-6aa8f5c8aae8@linux.intel.com>
Date:   Mon, 24 May 2021 17:39:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <6d336ac9-72ad-aae5-0b4c-f30a695d198b@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/24/2021 4:42 PM, Dave Hansen wrote:
> On 5/24/21 4:32 PM, Kuppuswamy Sathyanarayanan wrote:
>> Functionally only DMA devices can notice a side effect from
>> WBINVD's cache flushing.
> This seems to be trying to make some kind of case that the only visible
> effects from WBINVD are for DMA devices.  That's flat out wrong.  It
> might be arguable that none of the other cases exist in a TDX guest, but
> it doesn't excuse making such a broad statement without qualification.

We're describing a few sentences down that guests run with EPT 
IgnorePAT=1, which is the qualification.

>
> Just grep in the kernel for a bunch of reasons this is wrong.
>
> Where did this come from?

Again the logic is very simple: TDX guest code is (mostly) about 
replacing KVM code with in kernel code, so we're just doing the same as 
KVM. You cannot get any more proven than that.


-Andi


