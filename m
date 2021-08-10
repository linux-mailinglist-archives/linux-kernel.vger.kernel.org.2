Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1ED3E839B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 21:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhHJTYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 15:24:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:48238 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231152AbhHJTYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 15:24:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="214962085"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="214962085"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 12:23:51 -0700
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="515958752"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.69.62]) ([10.209.69.62])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 12:23:49 -0700
Subject: Re: [PATCH 1/5] mm: Add support for unaccepted memory
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
 <20210810062626.1012-2-kirill.shutemov@linux.intel.com>
 <d091b333-9ef8-ac32-58c5-c325d29f26d7@intel.com>
 <9748c07c-4e59-89d0-f425-c57f778d1b42@linux.intel.com>
 <17b6a3a3-bd7d-f57e-8762-96258b16247a@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <796a4b20-7fa3-3086-efa0-2f728f35ae06@linux.intel.com>
Date:   Tue, 10 Aug 2021 12:23:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <17b6a3a3-bd7d-f57e-8762-96258b16247a@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> But, not everyone is going to agree with me.

Both the Intel TDX and the AMD SEV side independently came to opposite 
conclusions. In general people care a lot about boot time of VM guests.


>
> This also begs the question of how folks know when this "blip" is over.
>   Do we have a counter for offline pages?  Is there any way to force page
> acceptance?  Or, are we just stuck allocating a bunch of memory to warm
> up the system?
>
> How do folks who care about these new blips avoid them?

It's not different than any other warmup. At warmup time you always have 
lots of blips until the working set stabilizes. For example in 
virtualization first touch of a new page is usually an EPT violation 
handled to the host. Or in the native case you may need to do IO or free 
memory. Everybody who based their critical latency percentiles around a 
warming up process would be foolish, the picture would be completely 
distorted.

So the basic operation is adding some overhead, but I don't think 
anything is that unusual compared to the state of the art.

Now perhaps the locking might be a problem if the other operations all 
run in parallel, causing unnecessary serialization If that's really a 
problem I guess we can optimize later. I don't think there's anything 
fundamental about the current locking.


-Andi


