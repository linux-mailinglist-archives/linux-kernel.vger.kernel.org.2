Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412B6342D78
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 15:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCTO4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 10:56:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48954 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhCTOzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 10:55:48 -0400
Received: from zn.tnic (p200300ec2f1b9100ea3d68bf503f75fb.dip0.t-ipconnect.de [IPv6:2003:ec:2f1b:9100:ea3d:68bf:503f:75fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 11AAF1EC04E2;
        Sat, 20 Mar 2021 15:55:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616252147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4hdXxlVL/sinx6V+bEeBITq05HiOk83RoDFI/ITA/vc=;
        b=VlRXwrN+5kLux73xSlR82yiiuj1ORlQ1kEjCYdR8W34Oh3yWwn7wy8kWPPMEfB4bShWMUl
        uvIv9lnCu0OwJXw0jRbBQTw9e+t6bizWbvGWSelw+DkpL8ta6o7tdBrMZXvCsVBRd79mBU
        CmzAIAnyla0BmOhzyUs1uaWAY5XGpkw=
Date:   Sat, 20 Mar 2021 15:55:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Pontes, Otavio" <otavio.pontes@intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] x86/microcode: Check for offline CPUs before
 checking for microcode update
Message-ID: <20210320145546.GC3338@zn.tnic>
References: <20210319165515.9240-1-otavio.pontes@intel.com>
 <20210319165515.9240-2-otavio.pontes@intel.com>
 <MW3PR11MB45559DAC0B495A4262C9121BF8689@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MW3PR11MB45559DAC0B495A4262C9121BF8689@MW3PR11MB4555.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 06:48:14PM +0000, Pontes, Otavio wrote:
> Turn off one core (2 threads)
> $ echo 0 > /sys/devices/system/cpu/cpu3/online
> $ echo 0 > /sys/devices/system/cpu/cpu1/online
> 
> Install the ucode fails because there's one core off
> $ cp intel-ucode/06-8e-09 /lib/firmware/intel-ucode/
> $ echo 1 > /sys/devices/system/cpu/microcode/reload
> bash: echo: write error: Invalid argument
> 
> Turn the core back on
> $ echo 1 > /sys/devices/system/cpu/cpu3/online
> $ echo 1 > /sys/devices/system/cpu/cpu1/online
> $ cat /proc/cpuinfo |grep microcode
> microcode : 0x30
> microcode : 0xde
> microcode : 0x30
> microcode : 0xde

Yeah, I'm looking at that check_online_cpus() thing and wondering why we
even need that:

0. So you have CPUs 1 and 3 offline.
1. We can update on the subset of cores which are online
2. If a core is offline and comes online, we have the hotplug notifier:

        cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
                                  mc_cpu_online, mc_cpu_down_prep);

which takes care of updating the microcode when that CPU comes online.

So unless your microcode folks don't come back with a real requirement
why all CPUs must absolutely be online for a late update, then the
proper fix is to get rid of check_online_cpus() altogether and update
what's online and the rest will get updated when they come online.

I know Ashok did:

commit 30ec26da9967d0d785abc24073129a34c3211777
Author: Ashok Raj <ashok.raj@intel.com>
Date:   Wed Feb 28 11:28:43 2018 +0100

    x86/microcode: Do not upload microcode if CPUs are offline

    Avoid loading microcode if any of the CPUs are offline, and issue a
    warning. Having different microcode revisions on the system at any time
    is outright dangerous.

but those cores are offlined so they're executing some idle routine...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
