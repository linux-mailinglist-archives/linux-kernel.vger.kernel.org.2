Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE47A35A211
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhDIPdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:33:32 -0400
Received: from foss.arm.com ([217.140.110.172]:53788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhDIPd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:33:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7384F1FB;
        Fri,  9 Apr 2021 08:33:13 -0700 (PDT)
Received: from e107158-lin (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C9483F694;
        Fri,  9 Apr 2021 08:33:12 -0700 (PDT)
Date:   Fri, 9 Apr 2021 16:33:09 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 0/3] ARM: Implement MODULE_PLT support in FTRACE
Message-ID: <20210409153309.wbebto3eufui35qs@e107158-lin>
References: <20210330114035.18575-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210330114035.18575-1-alexander.sverdlin@nokia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Linus Walleij back to CC

On 03/30/21 13:40, Alexander A Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> FTRACE's function tracer currently doesn't always work on ARM with
> MODULE_PLT option enabled. If the module is loaded too far, FTRACE's
> code modifier cannot cope with introduced veneers and turns the
> function tracer off globally.
> 
> ARM64 already has a solution for the problem, refer to the following
> patches:
> 
> arm64: ftrace: emit ftrace-mod.o contents through code
> arm64: module-plts: factor out PLT generation code for ftrace
> arm64: ftrace: fix !CONFIG_ARM64_MODULE_PLTS kernels
> arm64: ftrace: fix building without CONFIG_MODULES
> arm64: ftrace: add support for far branches to dynamic ftrace
> arm64: ftrace: don't validate branch via PLT in ftrace_make_nop()
> 
> But the presented ARM variant has just a half of the footprint in terms of
> the changed LoCs. It also retains the code validation-before-modification
> instead of switching it off.
> 
> Changelog:
> v8:
> * Add warn suppress parameter to arm_gen_branch_link()

I still think the ifdefery in patch 3 is ugly. Any reason my suggestion didn't
work out for you? I struggle to see how this is better and why it was hard to
incorporate my suggestion.

For example

	-       old = ftrace_call_replace(ip, adjust_address(rec, addr));
	+#ifdef CONFIG_ARM_MODULE_PLTS
	+       /* mod is only supplied during module loading */
	+       if (!mod)
	+               mod = rec->arch.mod;
	+       else
	+               rec->arch.mod = mod;
	+#endif
	+
	+       old = ftrace_call_replace(ip, aaddr,
	+                                 !IS_ENABLED(CONFIG_ARM_MODULE_PLTS) || !mod);
	+#ifdef CONFIG_ARM_MODULE_PLTS
	+       if (!old && mod) {
	+               aaddr = get_module_plt(mod, ip, aaddr);
	+               old = ftrace_call_replace(ip, aaddr, true);
	+       }
	+#endif
	+

There's an ifdef, followed by a code that embeds
!IS_ENABLED(CONFIG_ARM_MODULE_PLTS) followed by another ifdef :-/

And there was no need to make the new warn arg visible all the way to
ftrace_call_repalce() and all of its users.

FWIW

Tested-by: Qais Yousef <qais.yousef@arm.com>

If this gets accepted as-is, I'll send a patch to improve on this.


Thanks

--
Qais Yousef
