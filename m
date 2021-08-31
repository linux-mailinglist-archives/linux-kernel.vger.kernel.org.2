Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189963FCF9C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 00:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbhHaWkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 18:40:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:17393 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhHaWkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 18:40:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="198142851"
X-IronPort-AV: E=Sophos;i="5.84,367,1620716400"; 
   d="scan'208";a="198142851"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 15:39:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,367,1620716400"; 
   d="scan'208";a="466607443"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by orsmga007.jf.intel.com with ESMTP; 31 Aug 2021 15:39:08 -0700
Received: from tjmaciei-mobl5.localnet (10.212.209.231) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 31 Aug 2021 23:39:05 +0100
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, Len Brown <lenb@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to protect dynamic user state
Date:   Tue, 31 Aug 2021 15:39:02 -0700
Message-ID: <2020841.9MqWvG71rC@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To: <CAJvTdKkZ==89-rDeBUDy1GJEzU9FGiAb2m3rtMAGQPJQa1A2fA@mail.gmail.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com> <a96a65fc-061b-e94b-cee7-16201ac0820f@intel.com> <CAJvTdKkZ==89-rDeBUDy1GJEzU9FGiAb2m3rtMAGQPJQa1A2fA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.212.209.231]
X-ClientProxiedBy: orsmsx605.amr.corp.intel.com (10.22.229.18) To
 IRSMSX605.ger.corp.intel.com (163.33.146.138)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 31 August 2021 15:15:55 PDT Len Brown wrote:
> Indeed, I believe that there is universal agreement that a synchronous
> return code
> from a system call is a far superior programming model than decoding
> the location of a failure in a system call.  (no, the IP isn't random -- it
> is always the 1st instruction in that thread to touch a TMM register).

That instruction is actually likely going to be a memory load, probably an 
LDTILECFG. So the developer will see a crashing instruction with a pointer and 
will spend time trying to figure out why that pointer was wrong, when there 
was nothing wrong with it.

That's why I suggested (and Chang implemented) a SIGILL for when #NM is 
received and the arch_prctl() wasn't previously done. The OOM condition, if 
the extra state is dynamically allocated, was meant to stay a SIGSEGV, but 
maybe should change to SIGKILL.

On the other hand, if it it's allocated at the syscall, then the kernel can 
return -ENOMEM for it (which would allow for graceful degradation) or for a 
later clone() syscall starting a new thread (which I don't expect to ever 
gracefully degrade).

> decoding the location of the failure in a *signal hander*

That's a separate problem.

We can't be sure that the portion of the userspace doing the alt-stack crash 
handler is aware of the portion using AMX. There's no way to enforce this. The 
prctl() is a good indication, but I have no clue how high the correlation will 
be.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel DPG Cloud Engineering



