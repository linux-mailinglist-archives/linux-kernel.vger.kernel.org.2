Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AE53E8302
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhHJSbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:31:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:43767 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233165AbhHJSbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:31:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="214951145"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="214951145"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 11:30:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="515943455"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.69.62]) ([10.209.69.62])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 11:30:56 -0700
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
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <9748c07c-4e59-89d0-f425-c57f778d1b42@linux.intel.com>
Date:   Tue, 10 Aug 2021 11:30:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <d091b333-9ef8-ac32-58c5-c325d29f26d7@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> So, this is right in the fast path of the page allocator.  It's a
> one-time thing per 2M page, so it's not permanent.
>
> *But* there's both a global spinlock and a firmware call hidden in
> clear_page_offline().  That's *GOT* to hurt if you were, for instance,
> running a benchmark while this code path is being tickled.  Not just to
>
> That could be just downright catastrophic for scalability, albeit
> temporarily

This would be only a short blib at initialization until the system 
reaches steady state. So yes it would be temporary, but very short at that.

-Andi

