Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B3F3A0B43
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhFIE1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:27:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:38704 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbhFIE1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:27:08 -0400
IronPort-SDR: uSqZqPHBTmYxLhzw3tiO2+/KV1kdn0+WzJE5IIig/WmvlqiiQzaOWU6oB11ZJBqoKteRE9fboc
 nrWuAyOHXtBg==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="290628618"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="290628618"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 21:25:14 -0700
IronPort-SDR: JH0kAQVFSuekhOPjY6eIIkGeFRDcVgl6/Wn7mKKJtEBv9us6Ts/+jnnHSRM8HNv+S6q4ylGDa5
 X+ZNL/rbdDwQ==
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="551854128"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.24.11]) ([10.209.24.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 21:25:13 -0700
Subject: Re: [RFC v2-fix-v4 1/1] x86/tdx: Skip WBINVD instruction for TDX
 guest
To:     Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
 <20210609011030.751451-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4gLeKPfYOx1kmg-mO1_mNd+XGqVO-CbqX+2d52GZ+DSFw@mail.gmail.com>
 <23418f34-7c03-7477-6fbf-1b36b4718cb9@kernel.org>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <4e5ac34f-28cb-def6-0b87-e560fa42e5e5@linux.intel.com>
Date:   Tue, 8 Jun 2021 21:25:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <23418f34-7c03-7477-6fbf-1b36b4718cb9@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I like this description, but shouldn't the logic be:
>
> if (!CPUID has hypervisor bit set)
>    wbinvd();
>
> As far as I know, most hypervisors will turn WBINVD into a noop and,
> even if they don't, it seems to be that something must be really quite
> wrong for a guest to need to WBINVD for ACPI purposes.

KVM only turns it into a noop if there is no VT-d, because with VT-d you 
might need it to turn mappings into uncached and vice versa.

But yes the change would make sense for reboot. BTW I suspect for the 
reboot path it isn't really needed anywhere modern, so it might actually 
be ok to completely disable it. But that's some risk, so doing it only 
for hypervisor is reasonable.

I can see it making sense for the S3 path, but nobody supports S3 for 
guests.

-Andi


>
> -Andy
