Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CE638007B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 00:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhEMWpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 18:45:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:37799 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhEMWpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 18:45:02 -0400
IronPort-SDR: cpxC4HIjO9XfqOCH/bG83C1bNmRX987LAlHx4E8eBhPFVROImRrHW47A8rIR4t3WMTCx0WpzRm
 +TI2cxTY7YfQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="187192747"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187192747"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 15:43:52 -0700
IronPort-SDR: uR9Zw2x24dBUWUkUjFwl8aJs5tskTuURBrBuERQkXp5s0DEtbW03DGqmWJltIdWx9dUUK7YrcT
 0H9h5wwWC3CA==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="401261059"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.17.244]) ([10.209.17.244])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 15:43:49 -0700
Subject: Re: [RFC v2 08/32] x86/traps: Add #VE support for TDX guest
To:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <8a1d6930f784cb57c957cf20cea870947db91e05.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <afd85e8f-ab26-aa3b-e4e9-a0b3bfd472c8@intel.com>
 <73752227-6eaf-2de6-3ac6-5ee280980c18@linux.intel.com>
 <5b6b1937-d38f-a337-0520-7ce5d3083065@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <35d4aee1-c4cf-dd2a-d651-83a528ad90c3@linux.intel.com>
Date:   Thu, 13 May 2021 15:43:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5b6b1937-d38f-a337-0520-7ce5d3083065@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/13/2021 1:07 PM, Dave Hansen wrote:
> On 5/13/21 12:47 PM, Andi Kleen wrote:
>> "if there is any reason for it to nest the TD would shut down."
> The TDX EAS says:
>
>> If, when attempting to inject a #VE, the Intel TDX module discovers
>> that the guest TD has not yet retrieved the information for a
>> previous #VE (i.e., VE_INFO.VALID is not 0), the TDX module injects a
>> #DF into the guest TD to indicate a #VE overrun.
> How does that result in a shut down?


You're right. It's not a shutdown, but a panic. We'll need to fix the 
comment and replace 'shutdown' with 'panic'


-And





