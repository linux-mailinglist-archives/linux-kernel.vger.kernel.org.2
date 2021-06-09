Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D648F3A0B9D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbhFIEmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:42:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:50937 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231335AbhFIEmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:42:46 -0400
IronPort-SDR: oX5rPxONy4qSXk4ezTPzeGTiToeeKg2BI/nCGZ+yf6UyQRKmgCQHusi8NNyjpHrr6GshpQ7TYo
 XztH+QuOAx9w==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="205027067"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="205027067"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 21:40:43 -0700
IronPort-SDR: CnHLeEBhcNgz2NyLL/DSIPWtc/cAx1WpIR7s09DMJ39lwswXLqZpARCXvJRTDwPxNXCVdqXheD
 jpN3aeGE56UQ==
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="551856239"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.24.11]) ([10.209.24.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 21:40:43 -0700
Subject: Re: [RFC v2-fix-v4 1/1] x86/tdx: Skip WBINVD instruction for TDX
 guest
To:     Andy Lutomirski <luto@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
 <4e5ac34f-28cb-def6-0b87-e560fa42e5e5@linux.intel.com>
 <e9b2aab2-4a6f-4739-a939-c448414e6af2@www.fastmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <390d6712-35b5-e52a-fb32-205844bad4ef@linux.intel.com>
Date:   Tue, 8 Jun 2021 21:40:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <e9b2aab2-4a6f-4739-a939-c448414e6af2@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> KVM only turns it into a noop if there is no VT-d, because with VT-d you
>> might need it to turn mappings into uncached and vice versa.
> Wow, I found the kvm_arch_register_noncoherent_dma() stuff.  That's horrifying.  What's it for?  e

e.g. if you want to run a GPU it really needs some uncached memory. Same 
is true for other more complex devices.

Now modern Linux of course will be preferring CLFLUSH instead for the 
conversion, but there are old versions that preferred WBINVD.

I don't think it's a DoS, as long as you're not too picky about 
latencies on the host.

-Andi



