Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7096352165
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhDAVP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:15:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:10951 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234406AbhDAVPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:15:55 -0400
IronPort-SDR: 9RNyp/CswwWPJnfFyhvYgU3NO+Gi4K4TRHipOhRXAS/qQOeV5W3kDGaIt3CxZBCr4xA0vO1ciE
 lwJuiMqxs9iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="192436624"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="192436624"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 14:15:54 -0700
IronPort-SDR: PhA53mSmCRZ1TXk7sv3w0JZVBESPPWVEmpjzLamuolrdoeFG0mcDUbQHVpx7udqHSRXMwNgGxr
 UnKJlIWkQZhA==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="446443736"
Received: from akleen-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.251.23.191])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 14:15:53 -0700
Subject: Re: [RFC v1 03/26] x86/cpufeatures: Add is_tdx_guest() interface
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <83c8fcff9ac09f73924104cfb534258747e98bff.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0116481d-581b-9433-3641-47e39550b99a@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <8f0bd4e5-195b-7e65-f780-f5e31d72cfe8@linux.intel.com>
Date:   Thu, 1 Apr 2021 14:15:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0116481d-581b-9433-3641-47e39550b99a@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/21 2:08 PM, Dave Hansen wrote:
> On 2/5/21 3:38 PM, Kuppuswamy Sathyanarayanan wrote:
>> +bool is_tdx_guest(void)
>> +{
>> +	return static_cpu_has(X86_FEATURE_TDX_GUEST);
>> +}
> 
> Why do you need is_tdx_guest() as opposed to calling
> cpu_feature_enabled(X86_FEATURE_TDX_GUEST) everywhere?

is_tdx_guest() is also implemented/used in compressed
code (which uses native_cpuid calls). I don't think
we can use cpu_feature_enabled(X86_FEATURE_TDX_GUEST) in
compressed code right? Also is_tdx_guest() looks easy
to read and use.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
