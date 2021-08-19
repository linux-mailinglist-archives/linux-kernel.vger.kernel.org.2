Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139123F1D74
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbhHSQID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:08:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:44512 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhHSQIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:08:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="213466149"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="213466149"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 09:07:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="489719547"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by fmsmga008.fm.intel.com with ESMTP; 19 Aug 2021 09:07:24 -0700
Received: from tjmaciei-mobl5.localnet (10.209.35.138) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 19 Aug 2021 17:07:21 +0100
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to protect dynamic user state
Date:   Thu, 19 Aug 2021 09:06:06 -0700
Message-ID: <4972956.jzBc5Dc2ta@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To: <ea7eddc4-decd-47b7-b98b-c04c441495d9@www.fastmail.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com> <3399412.qF98CnctbS@tjmaciei-mobl5> <ea7eddc4-decd-47b7-b98b-c04c441495d9@www.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.209.35.138]
X-ClientProxiedBy: orsmsx605.amr.corp.intel.com (10.22.229.18) To
 IRSMSX605.ger.corp.intel.com (163.33.146.138)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 18 August 2021 18:21:11 PDT Andy Lutomirski wrote:
> But it's not the only possible solution. A future kernel could decide to
> leave
> > some bits off and only enable upon request. That's how macOS/Darwin does
> > its AVX512 support.
> 
> The fact that Darwin does this strongly suggests that real programs can
> handle it, which increases my inclination for Linux to do the same thing.

Yes and no... yes, programs could be made to handle this. I've reached to the 
Intel team responsible for the instructions in the manual on how to detect 
AVX512 and AMX, so the content is extended to say there's an OS-specific part 
that software developers need to be aware of. But until then, it's not very 
discoverable. As a result, there's plenty of software that could enable AVX512 
on the Xeon-based Mac Pros but never do because the developers didn't know 
that there was more than what the manual said. But the worst case that can 
happen here is that the software gracefully falls back to AVX2 or an earlier 
instruction set (unlike the Linux solution).

No, because XSETBV causes a VM exit, so we don't want to execute that on a 
context switch, for performance reasons. That's probably not been a concern 
for Apple developers, but is for Linux.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel DPG Cloud Engineering



