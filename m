Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5705398E5F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhFBPUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:20:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60752 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbhFBPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:20:14 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D433C22E0E;
        Wed,  2 Jun 2021 15:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622647110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0CajeOMnNJBB4wh8qj6KEaEI7/1l4Zc9gcsfQvY7xts=;
        b=0puWBPqvcb8XWW+CV1eq0j+G5gO7xAbIApbn1Mlg+Rnidl63wd9NZa0I37ophoNvKrPg3C
        EpXnRCBe78IHT62Fiv2pGOf8H6I5/bX6grH93GdFJe4gdsU8x85SEfF1ely43Onwq7Y8Cc
        dS8Kbi6TDMjhcmWChaCG/ZBJsBJi0J0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622647110;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0CajeOMnNJBB4wh8qj6KEaEI7/1l4Zc9gcsfQvY7xts=;
        b=83trRDF5ntRAKlXhQEwY1eav//5m8pt9Nz1CijqRgFleCmw/BfqIzRAXqcmf+zXdGEIEYW
        lOsI+SbKasSzNoCQ==
Received: by imap.suse.de (Postfix, from userid 51)
        id C3ECC11CD4; Wed,  2 Jun 2021 15:50:55 +0000 (UTC)
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 0500611D4C;
        Wed,  2 Jun 2021 09:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622627147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0CajeOMnNJBB4wh8qj6KEaEI7/1l4Zc9gcsfQvY7xts=;
        b=eugKB0bhppvhfKta1LCKA3T7HXLnmZ42X3iOcLch+sELpav7UCXwpMqmAqLW92/AU092q0
        q6Dx8WvfjmmHCr/3NPKzURzGSrA5GL/h4G/Rbwl69kMfVjvYy/Ye4gp3/hINLOD1+gjX0e
        9aMSSB8TElQAwwYMr+OFB+YiNAKKxpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622627147;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0CajeOMnNJBB4wh8qj6KEaEI7/1l4Zc9gcsfQvY7xts=;
        b=WAMhXP67cbiqInlXsyUilCMEW48KrD+QERq0lM4sbQ86hhwC/CSqpU2NP3GubO1MKGm4P5
        gJElHLqsYPeOIZCw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 5c0jAEtTt2AaMgAALh3uQQ
        (envelope-from <bp@suse.de>); Wed, 02 Jun 2021 09:45:47 +0000
Date:   Wed, 2 Jun 2021 11:45:42 +0200
From:   Borislav Petkov <bp@suse.de>
To:     kernel test robot <rong.a.chen@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:x86/cpu 4/4] Warning: Kernel ABI header at
 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at
 'arch/x86/include/asm/cpufeatures.h':  111< /* free                                    (
 3*32+29) */
Message-ID: <YLdTRopUV9OyulSq@zn.tnic>
References: <20210602094153.GH1271937@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602094153.GH1271937@shao2-debian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ acme.

On Wed, Jun 02, 2021 at 05:41:53PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
> head:   cbcddaa33d7e11a053cb80a4a635c023b4f8b906
> commit: cbcddaa33d7e11a053cb80a4a635c023b4f8b906 [4/4] perf/x86/rapl: Use CPUID bit on AMD and Hygon parts
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce:
> cd tools/perf && ./check-headers.sh
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> perfheadercheck warnings: (new ones prefixed by >>)
>    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':   87< #define X86_FEATURE_K7			( 3*32+ 5) /* "" Athlon */
>    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':   87> /* FREE, was #define X86_FEATURE_K7			( 3*32+ 5) "" Athlon */
> >> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  111< /* free					( 3*32+29) */
> >> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  111> #define X86_FEATURE_RAPL		( 3*32+29) /* AMD/Hygon RAPL interface */
>    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  239> #define X86_FEATURE_PVUNLOCK		( 8*32+20) /* "" PV unlock function */
>    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  240> #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* "" PV vcpu_is_preempted function */
>    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  295> #define X86_FEATURE_SGX1		(11*32+ 8) /* "" Basic SGX */
>    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  296> #define X86_FEATURE_SGX2		(11*32+ 9) /* "" SGX Enclave Dynamic Memory Management (EDMM) */
>    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  343> #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* Virtual SPEC_CTRL */
>    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  362> #define X86_FEATURE_BUS_LOCK_DETECT	(16*32+24) /* Bus Lock detect */
>    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  383> #define X86_FEATURE_HYBRID_CPU		(18*32+15) /* "" This part has CPUs of more than one type */
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

0day folks, please make a note if you can, to send such cpufeatures.h
header sync warnings to acme as he's verifying the feature bits modified
before synching.

Better yet, you can even ignore those altogether but I'm sure acme has a
preference here.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
