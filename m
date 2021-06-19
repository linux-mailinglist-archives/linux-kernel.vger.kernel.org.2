Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C541C3ADB0C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 19:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbhFSROI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 13:14:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:13757 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234868AbhFSROG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 13:14:06 -0400
IronPort-SDR: YxvSfXXT9UBv0pR4pUnNp15Vs2XXdDb33+ubSeBgDBfj/lzTFkp2f5vLxRCZDuFJ3OSBpp0D2f
 n61OiGD03lng==
X-IronPort-AV: E=McAfee;i="6200,9189,10020"; a="187057548"
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="187057548"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2021 10:11:55 -0700
IronPort-SDR: pd1/Q8tuuyZ+ZcB4WjZPwX73ZEXTX3SdY70DSnaHFqDol5MLSvv1QYnJb1Liwe/XSxadudRZn3
 9uqXRAJJQ+Yw==
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="486022106"
Received: from rcabe-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.118.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2021 10:11:54 -0700
Subject: Re: [PATCH v3 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config option
To:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210618225755.662725-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <57b35f69-54c7-1dd5-599b-4099d3a9a671@suse.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <a275d5a0-3881-05e6-1f37-ac07a1692d31@linux.intel.com>
Date:   Sat, 19 Jun 2021 10:11:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <57b35f69-54c7-1dd5-599b-4099d3a9a671@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/21 4:59 AM, Juergen Gross wrote:
> PARAVIRT_XL? Didn't you drop that?

Yes. I removed it from previous patch. But forgot to remove it here.

I will fix this in next version.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
