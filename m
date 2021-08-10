Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FAA3E851E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhHJVUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:20:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:38958 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233962AbhHJVUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:20:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="300584855"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="300584855"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 14:20:10 -0700
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="515987352"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.69.62]) ([10.209.69.62])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 14:20:09 -0700
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
 <796a4b20-7fa3-3086-efa0-2f728f35ae06@linux.intel.com>
 <f445da8b-c044-3765-65f2-f911dbf6a507@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <3caf5e73-c104-0057-680c-7851476e67ac@linux.intel.com>
Date:   Tue, 10 Aug 2021 14:20:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f445da8b-c044-3765-65f2-f911dbf6a507@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> These boot blips are not the biggest issue in the world.  But, it is
> fully under the guest's control and I think the guest has some
> responsibility to provide *some* mitigation for it.

It sounds more like an exercise in preliminary optimization at this 
point. If it's a real problem we can still worry about it later.


> 1. Do background acceptance, as opposed to relying 100% on demand-driven
>     acceptance.  Guarantees a limited window in which blips can occur.

Like Kirill wrote this was abandoned because it always allocates all 
memory on the host even if the guest doesn't need it.


> 2. Do acceptance based on user input, like from sysfs.

You can easily do that by running "memhog" at boot. No need for anything 
in the kernel.

BTW I believe this is also configurable at the guest BIOS level.

> 3. Add a command-line argument to accept everything up front, or at
>     least before userspace runs.

Same.


> 4. Add some statistic for how much unaccepted memory remains.

Yes that makes sense. We should have statistic counters for all of this.

Also I agree with your suggestion that we should get the slow path out 
of the zone locks/interrupt disable region. That should be easy enough 
and is an obvious improvement.

-Andi

