Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D04339950F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 23:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhFBVDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 17:03:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:44909 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhFBVDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 17:03:48 -0400
IronPort-SDR: vu1nzEQCRwtGrmv/puk5JPep95Hn+0KktcbWosg1H/s3zWvjoH9dggb9anDP2geNlEFJaWw1Lx
 MJ1NR4/3p9iw==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="225189230"
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="225189230"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 14:01:28 -0700
IronPort-SDR: J2wKdPazg82ORk0RGAZtvxrW6bZfilHAJDJ3Z2cv1VC3xjRHF8j0sev2eNp+5JM8uSkjojzilB
 XOCGnoqCS2hw==
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="550322215"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.87.193]) ([10.209.87.193])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 14:01:27 -0700
Subject: Re: [RFC v2-fix-v2 2/2] x86/tdx: Handle in-kernel MMIO
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210602194220.2227863-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210602194220.2227863-3-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <aac39d2e-c812-71c0-c769-e505ff6c5b40@linux.intel.com>
Date:   Wed, 2 Jun 2021 14:01:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602194220.2227863-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User-space
> access triggers SIGBUS.

Actually it looks like it's implemented below now, so that sentence 
could be dropped.


> +
> +	if (user_mode(regs)) {
> +		ret = insn_fetch_from_user(regs, buffer);
> +		if (!ret)
> +			return -EFAULT;
> +		if (!insn_decode_from_regs(&insn, regs, buffer, ret))
> +			return -EFAULT;
> +	} else {
> +		ret = copy_from_kernel_nofault(buffer, (void *)regs->ip,
> +					       MAX_INSN_SIZE);
> +		if (ret)
> +			return -EFAULT;
> +		insn_init(&insn, buffer, MAX_INSN_SIZE, 1);
> +		insn_get_length(&insn);
> +	}
> +
