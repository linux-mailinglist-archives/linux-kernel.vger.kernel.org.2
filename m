Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B393EEDBB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 15:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbhHQNun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 09:50:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:34571 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233288AbhHQNul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:50:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="196354485"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="196354485"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 06:50:08 -0700
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="510479079"
Received: from favalosr-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.164.120])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 06:50:08 -0700
Subject: Re: [PATCH v5 01/12] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
To:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YRTLO0eQOEChETId@zn.tnic> <057170db-9382-eb40-7bcb-4ec1de4aae62@suse.com>
 <fd603d12-1897-1f5f-17fa-b5ac643bc334@linux.intel.com>
 <fcc8c2f1-f33f-96fa-8fc7-1e6e2e6a3936@suse.com>
 <ddb9c140-caf9-ef46-d5af-ac9a1283c5df@linux.intel.com>
 <d700658f-8466-46c5-5fff-9e65a6a24720@suse.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <bf10500b-e8f8-ad28-d725-c70040a59e88@linux.intel.com>
Date:   Tue, 17 Aug 2021 06:50:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d700658f-8466-46c5-5fff-9e65a6a24720@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/21 6:47 AM, Juergen Gross wrote:
> I don't see a reason to have two "#include <asm/paravirt.h>" lines in
> one file. Why don't you use:
> 
> #ifdef CONFIG_PARAVIRT
> #include <asm/paravirt.h>
> #else
> #ifndef __ASSEMBLY___
> ...
> #endif
> #endif
> 
> #ifndef CONFIG_PARAVIRT_XXL
> ...
> #endif

Ok. I will use your format.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
