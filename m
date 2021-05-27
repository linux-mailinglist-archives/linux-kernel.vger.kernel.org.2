Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CDA3935E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbhE0TDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbhE0TDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:03:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA5CC061761;
        Thu, 27 May 2021 12:01:39 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f02007e50b358e2406320.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:200:7e50:b358:e240:6320])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 05AE51EC01DF;
        Thu, 27 May 2021 21:01:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622142097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3McnNCepB5hW/fju+vVEoOY+HqLuey0+yRIpnzxlez8=;
        b=BQ3DtOWZmcw2ASN1yYM0XjgySvZ2JuWGx5TB1e7aQFx3lFDZzauJQ4xr5m/3soSaMkrG+b
        K23V3prSqm1wCykboY6Z/V1DuQinqBcdQLVtaKwS2Y9YC5hiHJcZc8LNXiKz/obMfIyyN9
        iEZpMgNjNzwUhFOuvcmv0r1jG2MYTnI=
Date:   Thu, 27 May 2021 21:01:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Borislav Petkov <bp@suse.de>, James Feeney <james@nurealm.net>,
        linux-smp@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, x86-ml <x86@kernel.org>
Subject: Re: [PATCH] x86/thermal: Fix LVT thermal setup for SMI delivery mode
Message-ID: <YK/sjypdlYbk/NHC@zn.tnic>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2d7d50f274d5143305282c99491ebe590f33ccd.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 11:09:59AM -0700, Srinivas Pandruvada wrote:
> My guess is that system is booting hot sometimes. SMM started fan or
> some cooling and set a temperature threshold. It is waiting for thermal
> interrupt for temperature threshold, which it never got.

Are you saying that that replication of lvtthmr_init to the APs in
intel_init_thermal() is absolutely needed on those SMI machines running
hot?

That thing:

         * If BIOS takes over the thermal interrupt and sets its interrupt
         * delivery mode to SMI (not fixed), it restores the value that the
         * BIOS has programmed on AP based on BSP's info we saved since BIOS
         * is always setting the same value for all threads/cores.

?

Me moving that lvtthmr_init read later would replicate the wrong value
because we'd soft-disable the APIC and thus the core would lockup
waiting...

The other interesting thing is that the core would always lockup when
trying to IPI another core to remote-flush the TLBs.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
