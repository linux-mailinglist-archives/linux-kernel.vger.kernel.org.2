Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F252314081
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbhBHUag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:30:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:6956 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234795AbhBHTLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:11:55 -0500
IronPort-SDR: rVuC4hJgLWvHP/L/Z4xRzoordzZWh09xnNDJJrpu2Xb2MdzBW4AsYJsaXI74aIsABPwzbvuDRT
 B4kMESjuEsQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="245835296"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="245835296"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 11:10:03 -0800
IronPort-SDR: /Zh3bFdxtHAoXEmSBbtCZKTK+CVCvNq9Ivt+MYdxYOax0m/Cd1ubpDtmL59C4Q/8BN1CjXHB2N
 st5IYUVtUb2Q==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="509574450"
Received: from uonwuzur-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.251.25.106])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 11:10:02 -0800
Subject: Re: [RFC v1 04/26] x86/tdx: Get TD execution environment information
 via TDINFO
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <a5757dafc54932a6661fc94f51e413467b61fecf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YCELtLeZnax8JNMU@hirez.programming.kicks-ass.net>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <75d092c8-ba24-e6e2-b583-89cf5ba246cc@linux.intel.com>
Date:   Mon, 8 Feb 2021 11:10:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YCELtLeZnax8JNMU@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/21 2:00 AM, Peter Zijlstra wrote:
> This needs a binutils version number.
Yes, we will add it in next version.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
