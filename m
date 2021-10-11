Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBB9429716
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 20:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhJKSt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 14:49:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:56759 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhJKStZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 14:49:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="290437082"
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="290437082"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 11:47:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="625620902"
Received: from spwrigh1-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.252.132.131])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 11:47:23 -0700
Subject: Re: [PATCH v10 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config
 option
To:     Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211011181948.fkt7o2fezmuyynze@treble>
 <2c03ae77-640e-fc25-a65b-2416f090281d@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <205e1070-4ca7-83c4-0bad-47b1bbc0b5bf@linux.intel.com>
Date:   Mon, 11 Oct 2021 11:47:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2c03ae77-640e-fc25-a65b-2416f090281d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/21 11:38 AM, Andi Kleen wrote:
>> Why does it depend on SECURITY?  It should at least be explained in the
>> commit message.
> 
> It can be dropped, it was only needed in an earlier version that used a LSM.

I will remove it next version.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
