Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14295430BF9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 22:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242892AbhJQUTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 16:19:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:41756 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242844AbhJQUTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 16:19:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10140"; a="215303326"
X-IronPort-AV: E=Sophos;i="5.85,380,1624345200"; 
   d="scan'208";a="215303326"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 13:17:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,380,1624345200"; 
   d="scan'208";a="565237080"
Received: from ericalo-mobl.gar.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.45.96])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 13:17:29 -0700
Subject: Re: [PATCH v7 01/10] x86/io: Allow to override inX() and outX()
 implementation
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211005204136.1812078-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005204136.1812078-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <874k9f4fll.ffs@tglx>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <8ec409e1-3b0c-6fc3-7796-e1d7cbf7cf13@linux.intel.com>
Date:   Sun, 17 Oct 2021 13:17:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <874k9f4fll.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/17/21 12:27 PM, Thomas Gleixner wrote:
> On Tue, Oct 05 2021 at 13:41, Kuppuswamy Sathyanarayanan wrote:
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>
>> The patch allows to override the implementation of the port IO
> git grep 'This patch' Documentation/process


Sorry, I will fix the commit log in next version.


>
>> helpers. TDX code will provide an implementation that redirect the
>> helpers to paravirt calls.
> Thanks,
>
>          tglx

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

