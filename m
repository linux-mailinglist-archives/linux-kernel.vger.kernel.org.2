Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11712438F32
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhJYGQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:16:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:30470 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229841AbhJYGQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:16:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="216743074"
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="216743074"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 23:14:32 -0700
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="496637810"
Received: from cqiang-mobl.ccr.corp.intel.com (HELO [10.238.2.71]) ([10.238.2.71])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 23:14:30 -0700
Message-ID: <4a757c43-dfc8-6da4-944e-9bf687d7e3bc@intel.com>
Date:   Mon, 25 Oct 2021 14:14:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.2.0
Subject: Re: [PATCH] x86/bus_lock: Don't assume the init value of
 DEBUGCTLMSR.BUS_LOCK_DETECT to be zero
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20210901084004.5393-1-chenyi.qiang@intel.com>
 <YW766qk0W6K5rhrU@google.com>
From:   Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <YW766qk0W6K5rhrU@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2021 1:05 AM, Sean Christopherson wrote:
> On Wed, Sep 01, 2021, Chenyi Qiang wrote:
>> It's possible that BIOS/firmware has set DEBUGCTLMSR_BUS_LOCK_DETECT, or
>> this kernel has been kexec'd from a kernel that enabled bus lock
>> detection.
> 
> This feels like the kernel should explicitly zero out the entire MSR somewhere
> in the generic boot flow.  E.g. something like this somewhere.
> 

Yes. Meanwhile, I think kernel code prefers to explicitly set/clear the 
control bit according to the parameter. Maybe both changes should be 
applied.

> #ifndef CONFIG_X86_DEBUGCTLMSR
> 	if (boot_cpu_data.x86 < 6)
> 		return;
> #endifa
> 
> 	wrmsrl(MSR_IA32_DEBUGCTLMSR, 0);
> 
