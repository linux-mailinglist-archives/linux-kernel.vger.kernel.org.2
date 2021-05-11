Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4921B379BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhEKA6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:58:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:41091 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhEKA6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:58:05 -0400
IronPort-SDR: lqu/X6UteCN/t1XqVWaCN3x8EGa1HBXem+blhnWQ/o9GGkwDjOsJeTrqErGiQJrBcC6Etshjil
 dAfNmdXrtcbQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="178914936"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="178914936"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 17:57:00 -0700
IronPort-SDR: WUv2E4eXYfwDyhrA/lvKTldiswLPuB87I6iCKNz96u+SrTOd2+mtfQJaca3kHBuYv6U3/iyKw2
 Ey5mSQRLZDow==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="609297151"
Received: from kcmorris-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.165.53])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 17:56:59 -0700
Subject: Re: [RFC v2 14/32] x86/tdx: Handle port I/O
To:     Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>
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
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <648fe68f-c521-dbba-4495-9a4d0498a3be@linux.intel.com>
Date:   Mon, 10 May 2021 17:56:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iuRdXooQvCzEWd9babzPij4nXpM-z5fai9+SGaeFYswQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/21 4:34 PM, Dan Williams wrote:
>>> Surely there's an existing macro for this pattern? Would
>>> PUSH_AND_CLEAR_REGS + POP_REGS be suitable? Besides code sharing it
>>> would eliminate clearing of %r8.
>>
>> There used to be SAVE_ALL/SAVE_REGS, but they have been all removed in
>> some past refactorings.
> Not a huge deal, but at a minimum it seems a generic construct that
> deserves to be declared centrally rather than tdx-guest-port-io local.

I can define SAVE_ALL_REGS/RESTORE_ALL_REGS. Do you want to move it outside
TDX code? I don't know if there will be other users for it?



-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
