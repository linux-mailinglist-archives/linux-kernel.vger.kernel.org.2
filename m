Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E4F39372B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbhE0Uai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:30:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:41701 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235696AbhE0Uae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:30:34 -0400
IronPort-SDR: cNgY7cTfF+xgfO+NovXsdIzLEqU0+QbWWL2qtTHAdeBHLCMfhckFt3IvpaL8mqXRm/eanypNlx
 VUZ0SHBGr3eg==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="288419120"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="288419120"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 13:28:59 -0700
IronPort-SDR: JLiZzsfA6DBo/toa1dn7JuXcq5kVfGrWsmm/qi6D4P/Bb78eNqi42xAfQH+2N6lMgpgPNFmxyG
 kdfV8wqGwMhA==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="443717461"
Received: from pcotting-mobl.amr.corp.intel.com ([10.209.101.152])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 13:28:59 -0700
Message-ID: <7e45be0d83c823fa48bac3494bed0eb9b71b8425.camel@linux.intel.com>
Subject: Re: [PATCH] x86/thermal: Fix LVT thermal setup for SMI delivery mode
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Borislav Petkov <bp@suse.de>, James Feeney <james@nurealm.net>,
        linux-smp@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, x86-ml <x86@kernel.org>
Date:   Thu, 27 May 2021 13:28:59 -0700
In-Reply-To: <YK/sjypdlYbk/NHC@zn.tnic>
References: <YKYqABhSTTUG8cgV@zn.tnic>
         <a264eaef-1c94-77e1-dfbf-e436a41588be@nurealm.net>
         <YKjJfu4kRDflQS5e@zn.tnic>
         <373464e3-b8a0-0fe0-b890-41df0eecf090@nurealm.net>
         <YKqLSqIM7Gi5x+IA@zn.tnic>
         <b550a241-2097-cf4b-cc41-e4d0a45cda72@nurealm.net>
         <YKtbBXZGpVZS1M4R@zn.tnic>
         <1f6c70f4-6680-d6ea-465a-548dc7698317@nurealm.net>
         <YK905sC/2cVOYo6I@zn.tnic>
         <d2d7d50f274d5143305282c99491ebe590f33ccd.camel@linux.intel.com>
         <YK/sjypdlYbk/NHC@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-05-27 at 21:01 +0200, Borislav Petkov wrote:
> On Thu, May 27, 2021 at 11:09:59AM -0700, Srinivas Pandruvada wrote:
> > My guess is that system is booting hot sometimes. SMM started fan
> > or
> > some cooling and set a temperature threshold. It is waiting for
> > thermal
> > interrupt for temperature threshold, which it never got.
> 
> Are you saying that that replication of lvtthmr_init to the APs in
> intel_init_thermal() is absolutely needed on those SMI machines
> running
> hot?

We have seen some SMM uses thermal interrupts. We had one issue in one
Yoga systems several years back where SMM handling of thermal interrupt
related to HWP caused hard hang as it crashed there.
So yes, there may be special thing for cooling also.

> 
> That thing:
> 
>          * If BIOS takes over the thermal interrupt and sets its
> interrupt
>          * delivery mode to SMI (not fixed), it restores the value
> that the
>          * BIOS has programmed on AP based on BSP's info we saved
> since BIOS
>          * is always setting the same value for all threads/cores.
> 
> ?
> 
> Me moving that lvtthmr_init read later would replicate the wrong
> value
> because we'd soft-disable the APIC and thus the core would lockup
> waiting...
I think so.
I will try to force replicate wrong value in Yoga system which used to
crash in thermal interrupt handling of SMM code and check what happens.
 This shouldn't crash as it will not get thermal interrupt. Since the
system is not with me, I can try next week.

> 
> The other interesting thing is that the core would always lockup when
> trying to IPI another core to remote-flush the TLBs.
> 
Here I think the other core didn't exit SMM mode.

Thanks,
Srinivas


