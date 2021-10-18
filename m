Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296C1432989
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 00:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhJRWGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 18:06:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:45414 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233633AbhJRWGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 18:06:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="314573181"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="314573181"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 15:04:05 -0700
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="443623890"
Received: from jkpeteho-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.7.230])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 15:04:03 -0700
Subject: Re: [PATCH v10 03/11] x86/cpufeatures: Add TDX Guest CPU feature
To:     Borislav Petkov <bp@alien8.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YWaWSmWn6AZ6OLx+@zn.tnic> <20211013194251.ndbyj45egz6msl63@treble>
 <1a6220a5-3abd-dea1-4b2f-2acade311236@linux.intel.com>
 <YW3uTfHbooni2iVE@zn.tnic>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <09a099b2-ef7a-0aba-c9dd-4f115d754b4f@linux.intel.com>
Date:   Mon, 18 Oct 2021 15:04:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YW3uTfHbooni2iVE@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/18/21 2:59 PM, Borislav Petkov wrote:
> On Mon, Oct 18, 2021 at 02:05:10PM -0700, Sathyanarayanan Kuppuswamy wrote:
>> Any consensus on this?
> Well, you can simply not put any comment there now because this patchset
> doesn't add those debug options.
>
> The patch which adds them, should add that comment explaining why that
> order needs to be the way it is.

For now I will remove the comment as you have suggested.

>
> In general, I get the impression from review that you add stuff for
> future patchsets which only confuses reviewers and instead, you should
> simply not do that but do only the required changes, only for the
> current aspect of functionality being added.

I will check the patch list again and re-organize the patch set, If I
find any such changes.

>
>> I think SME code also talks about future use case in its comment.
> No, this has nothing to do with a future use case: you should look at
> what that function does and then read that comment again.

Sorry, I will check the details correctly.

>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

