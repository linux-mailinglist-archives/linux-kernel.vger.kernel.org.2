Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB0134DC89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhC2Xhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:37:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:36270 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhC2XhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:37:22 -0400
IronPort-SDR: au4yAXltEfuJLtduDfcsq7D4RPCOOUCFFO2FL03khYjkKdPDeP17Z6OdpE8LWT5CHxp6K5ZddP
 8lSNOvlbaZcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="276813212"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="276813212"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 16:37:21 -0700
IronPort-SDR: UG4alv6Ix5ImdAI8wQ8xG58wQ8RHFtP0i+1Iso15tIUsqM5vAIrYDGtJNh455GsStNvOJ3Fb5/
 v1DyIpll1pqA==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="444834611"
Received: from ajzangar-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.145.70])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 16:37:20 -0700
Subject: Re: [PATCH v3 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <837afe840f5826bf7fcba07a5e483d7e2283db34.1617059703.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <377A7B0B-9959-4AFC-A575-7AC20FEE6077@amacapital.net>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <10834a17-cae4-d0e3-c82b-f69da7f9141a@linux.intel.com>
Date:   Mon, 29 Mar 2021 16:37:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <377A7B0B-9959-4AFC-A575-7AC20FEE6077@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/21 4:23 PM, Andy Lutomirski wrote:
> 
>> On Mar 29, 2021, at 4:17 PM, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> ﻿In non-root TDX guest mode, MWAIT, MONITOR and WBINVD instructions
>> are not supported. So handle #VE due to these instructions
>> appropriately.
> 
> Is there something I missed elsewhere in the code that checks CPL?
We don't check for CPL explicitly. But if we are reaching here, then we
executing these instructions with wrong CPL.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
