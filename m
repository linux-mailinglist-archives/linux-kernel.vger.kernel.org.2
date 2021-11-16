Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9D34537C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbhKPQjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:39:53 -0500
Received: from mga18.intel.com ([134.134.136.126]:17584 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233055AbhKPQjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:39:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="220615341"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="220615341"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 08:36:54 -0800
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="735301860"
Received: from sksekwao-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.20.115])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 08:36:53 -0800
Subject: Re: [PATCH v1 1/1] x86: Skip WBINVD instruction for VM guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211116005027.2929297-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YZPbQVwWOJCrAH78@zn.tnic>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <f38216d7-4dcd-8eba-1825-c5bc79b0e1f5@linux.intel.com>
Date:   Tue, 16 Nov 2021 08:36:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YZPbQVwWOJCrAH78@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/16/21 8:24 AM, Borislav Petkov wrote:
> On Mon, Nov 15, 2021 at 04:50:27PM -0800, Kuppuswamy Sathyanarayanan wrote:
>> -#define ACPI_FLUSH_CPU_CACHE()	wbinvd()
>> +#define ACPI_FLUSH_CPU_CACHE()				\
>> +do {							\
>> +	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))	\
> 
> cpu_feature_enabled()
> 
> If you wanna query a X86_FEATURE_* bit, from now on, use only this
> function.
> 

Ok. I will change it in next version.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
