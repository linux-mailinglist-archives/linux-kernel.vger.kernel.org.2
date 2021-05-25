Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA9538F704
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 02:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhEYAh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 20:37:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:45301 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhEYAh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 20:37:57 -0400
IronPort-SDR: 7YlEPWpkftMZy2rzp3KBrccBNSX+LDLc5oEUQJBQXGlI/gFI9vmOHNPwbJdkjTHKE6WYzc/wga
 lBWqNqBdnfSA==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="181702956"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="181702956"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 17:36:23 -0700
IronPort-SDR: PNiE8R7tlZZxl6b4LbKo4BLWsWIzK93sQ+05/lDy6TClUiBMGpG5c5+bmpK0ukdbJ2HOkupc6Z
 uEzwQ2eLmDEQ==
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="546281419"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.195.214]) ([10.212.195.214])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 17:36:22 -0700
Subject: Re: [RFC v2-fix-v2 2/2] x86/tdx: Ignore WBINVD instruction for TDX
 guest
To:     Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <37ad50ca-f568-4c62-56e2-9e9b1f34084c@linux.intel.com>
 <20210524233211.802033-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210524233211.802033-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jKY0rmewFnyL6My5-b+w8ANAwDY2tLXZk4CYKydoVbtg@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <e932f6f4-fe64-8937-b982-b9987324d83e@linux.intel.com>
Date:   Mon, 24 May 2021 17:36:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jKY0rmewFnyL6My5-b+w8ANAwDY2tLXZk4CYKydoVbtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  that.

> I thought we discussed that there are other considerations for wbinvd
> besides DMA? In any event this paragraph is actively misleading
> because it disregards ACPI and Persistent Memory secure-erase whose
> usages of wbinvd have nothing to do with DMA.


In this case they would be broken in KVM too.


> I would much prefer a
> patch to shutdown all the known wbinvd users as a precursor to this
> patch rather than assuming it's ok to simply ignore it. You have
> mentioned that TDX does not need to use those paths, but rather than
> assume they can't be used why not do the audit to explicitly disable
> them? Otherwise this statement seems to imply that the audit has not
> been done.

We're not assuming it. We know it because KVM does it since forever.

All we want to do is do the same as KVM.

-Andi


