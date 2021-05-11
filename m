Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A44379CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 04:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhEKCU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 22:20:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:13354 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhEKCUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 22:20:25 -0400
IronPort-SDR: 8RWUe7W8jqX16NB4wgz9Y8Qz8fAFpgVjhOEKri6h/N/RAR4P3WcnXMMtYWQuEfM5W0LWhLND67
 juV8Q/L/150g==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="220288820"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="220288820"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 19:19:19 -0700
IronPort-SDR: FLN5JysCA+Gp5Oc3E4ZlMPbIVXuZ078nnQ1dj4cmnyZTtO81lkHOAFUSkrV7NLxaP+StjhuAQN
 Sjjvf87FUNnQ==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="434075669"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.32.217]) ([10.209.32.217])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 19:19:18 -0700
Subject: Re: [RFC v2 14/32] x86/tdx: Handle port I/O
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0e7e94d1ee4bae49dfd0dd441dc4f2ab6df76668.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jPLGs6p0PNZQB6yKB3QDtEcGb234zcgCbJutXxZZEGnA@mail.gmail.com>
 <e8ac31bc-e307-f277-f928-24ebba4cbca7@linux.intel.com>
 <CAPcyv4iuRdXooQvCzEWd9babzPij4nXpM-z5fai9+SGaeFYswQ@mail.gmail.com>
 <648fe68f-c521-dbba-4495-9a4d0498a3be@linux.intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <96ffe033-9f60-b56e-d159-c1d0e8ae532b@linux.intel.com>
Date:   Mon, 10 May 2021 19:19:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <648fe68f-c521-dbba-4495-9a4d0498a3be@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/10/2021 5:56 PM, Kuppuswamy, Sathyanarayanan wrote:
>
>
> On 5/10/21 4:34 PM, Dan Williams wrote:
>>>> Surely there's an existing macro for this pattern? Would
>>>> PUSH_AND_CLEAR_REGS + POP_REGS be suitable? Besides code sharing it
>>>> would eliminate clearing of %r8.
>>>
>>> There used to be SAVE_ALL/SAVE_REGS, but they have been all removed in
>>> some past refactorings.
>> Not a huge deal, but at a minimum it seems a generic construct that
>> deserves to be declared centrally rather than tdx-guest-port-io local.
>
> I can define SAVE_ALL_REGS/RESTORE_ALL_REGS. Do you want to move it 
> outside
> TDX code? I don't know if there will be other users for it?

The old name was SAVE_ALL / SAVE_REGS.

Yes please put it outside tdx code into some include file.

-Andi


