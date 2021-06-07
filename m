Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A9F39D6CF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFGINW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGINW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:13:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2F4C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 01:11:31 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b4f006e4c94f9871f2fda.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:4f00:6e4c:94f9:871f:2fda])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 20AEB1EC0301;
        Mon,  7 Jun 2021 10:11:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623053484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E7oPS1JSMIPJij/TKmlCBqAd+aGlcH8CadLEnsW68DE=;
        b=enzfqxWJY0gjeWkjK76WQKivMmbXYViHX0woydlavSAYQXDATAbFFyk023IkjnDaIdS+wS
        VMBpog5qrTQefKTNZuvx7sf8PKDY5Bfs6NbVXK0u2WCRvN/GwpgugXVRU+tKuNBeUra1Fe
        zAOXnj4bIQsLjLcmwfAIS+VcWAIvMjo=
Date:   Mon, 7 Jun 2021 10:11:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     "'hpa@zytor.com'" <hpa@zytor.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Adding A64FX hardware prefetch sysfs interface
Message-ID: <YL3UpAZ6wZi6GyAx@zn.tnic>
References: <OSBPR01MB2037D114B11153F00F233F8780389@OSBPR01MB2037.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSBPR01MB2037D114B11153F00F233F8780389@OSBPR01MB2037.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(not trimming the mail so that ARM folks can see the whole thing)

On Mon, Jun 07, 2021 at 01:39:21AM +0000, tarumizu.kohei@fujitsu.com wrote:
> Hello
> 
> I'm Kohei Tarumizu from Fujitsu Limited. 
> 
> Fujitsu A64FX processor implements a vendor specific function, the HPC extensions[1].
> A64FX has some registers for HPC extensions.
> We would like to use the register IMP_PF_STREAM_DETECT_CTRL_EL0 for tuning the hardware prefetch, but it's not accessible from userspace.
> We are considering to implement a kernel common interface via sysfs as a way to control IMP_PF_STREAM_DETECT_CTRL_EL0 from userspace.
> FYI, A64FX also has registers (e.g. IMP_PF_INJECTION_*) to control the behavior of the hardware prefetch from the software using "HPC tag address override", but this time we don't considered.
> 
> [1]https://github.com/fujitsu/A64FX/tree/master/doc/
>    A64FX_Specification_HPC_Extension_v1_EN.pdf
> 
> This register is similar to the MSR registers 0x1A4(MSR_MISC_FEATURE_CONTROL)[2] and its details are described in [Similarity of each register].
> From the discussion about the MSR driver, I understood it is not good idea to access registers directly from userspace, and that we want to move it to the proper interface.
> 

That's very nice of you that you're asking upfront, thanks!

> We think it would be better to have the common interface which can control these registers in the future.
> Therefore, we would like to design new sysfs interface, could you give me some advice?
> 
> [2]https://software.intel.com/content/www/us/en/develop/articles/disclosure-of-hw-prefetcher-control-on-some-intel-processors.html
> 
> [Similarity of each register]
> * Settings for Hardware Prefetch
>   These registers enable or disable hardware prefetching for L1/L2 cache.
>   The A64FX's register also have "Prefetch Distance (bit: [27:24], [19:16])" and "Reliableness attribute for prefetch access (bit: [55], [54])".
> * Not accessible from userspace
>   In the expected usage scene (e.g. User wants to disable hardware prefetch), it is necessary to be able to access from the userspace.
> * Share settings on a per-CPU basis
>   A64FX's register is used in HPC applications and assumes that the process is bound to one core.
> 
> Currently, the path name has not been decided yet, but we consider of the following structure like cpufreq(/sys/devices/system/cpu/[CPUNUM]/cpufreq).
> 
> /sys/devices/system/cpu/[CPUNUM]/prefetcher/

For that we already have a hierarchy:

tree /sys/devices/system/cpu/cpu0/cache/
/sys/devices/system/cpu/cpu0/cache/
├── index0
│   ├── coherency_line_size
│   ├── id
│   ├── level
│   ├── number_of_sets
│   ├── physical_line_partition
│   ├── shared_cpu_list
│   ├── shared_cpu_map
│   ├── size
│   ├── type
│   ├── uevent
│   └── ways_of_associativity
├── index1
│   ├── coherency_line_size
│   ├── id
│   ├── level
│   ├── number_of_sets
...

that's cpu<NUM>/cache/ and I believe ARM shares some of that code too.

>     l1_enable   : This sets or displays whether hardware prefetch is enabled for L1 cache.
>     l2_enable   : This sets or displays whether hardware prefetch is enabled for L2 cache.
>     l1_dist     : This sets or displays whether hardware prefetch distance for L1 cache.
>     l2_dist     : This sets or displays whether hardware prefetch distance for L2 cache.
>     l1_reliable : This sets or displays whether reliableness attribute for prefetch access for L1 cache.
>     l2_reliable : This sets or displays whether reliableness attribute for prefetch access for L2 cache.

Right, that I'd design differently:

	.../cache/prefetcher/l1/
		            /l1/enable
			    /l1/dist
		            /l1/reliable
	...		    /l2/
	...		    /l3/

so that you have a directory per cache level and in that directory you
have each file.

But let's loop in ARM folks as this is an ARM CPU after all and they'd
care for that code.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
