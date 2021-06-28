Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3540A3B5C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 12:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhF1KOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 06:14:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:21428 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232735AbhF1KOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 06:14:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="229541755"
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="229541755"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 03:11:43 -0700
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="419115990"
Received: from unknown (HELO [10.238.130.181]) ([10.238.130.181])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 03:11:40 -0700
Subject: Re: [PATCH v5 14/28] x86/fpu/xstate: Prevent unauthorised use of
 dynamic user state
To:     Dave Hansen <dave.hansen@intel.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-15-chang.seok.bae@intel.com>
 <af093744-6f68-ff51-f40b-4db234b363d8@intel.com>
 <872cb0a2-3659-2e6c-52a8-33f1a2f0a2cd@kernel.org>
 <36D0486A-D955-4C32-941A-A2A4985A450C@intel.com>
 <48e86785-838d-f5d4-c93c-3232b8ffd915@intel.com>
 <16681A30-59EA-4E35-8A51-CCD403026C92@intel.com>
 <6cdba263-889f-ce98-b7da-4a1380cedc65@intel.com>
From:   "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <4411de99-e827-6119-394b-b994131d6554@linux.intel.com>
Date:   Mon, 28 Jun 2021 18:11:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <6cdba263-889f-ce98-b7da-4a1380cedc65@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/2021 3:28 AM, Dave Hansen wrote:
> On 6/16/21 12:23 PM, Bae, Chang Seok wrote:
>> On Jun 16, 2021, at 12:01, Hansen, Dave <dave.hansen@intel.com> wrote:
>>> On 6/16/21 11:47 AM, Bae, Chang Seok wrote:
>>>> Reading XINUSE via XGETBV is cheap but not free. I don't know spending a
>>>> hundred cycles for this WARN is big deal but this is one of the most
>>>> performance-critical paths.
>>> Is XGETBV(1) really a hundred cycles?  That seems absurdly high for a
>>> non-serializing register read.
>> This was checked to convince the benefit intended by PATCH25 --
>> https://lore.kernel.org/lkml/20210523193259.26200-26-chang.seok.bae@intel.com/
> That's odd.  How is it possible that the performance of XGETBV(1)
> informed the design of that patch without there being any mention of
> XGETBV in the comments or changelog?
Hi Chang,

I noticed the XGETBV(1) cycles you ran, however I calculated only ~16 
cycles
in the corresponding machine.

BRs,
Jing

