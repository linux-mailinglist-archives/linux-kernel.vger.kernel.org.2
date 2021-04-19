Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA239364DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 00:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhDSWfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 18:35:23 -0400
Received: from foss.arm.com ([217.140.110.172]:51976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhDSWfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 18:35:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B99C61435;
        Mon, 19 Apr 2021 15:34:51 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 823453F792;
        Mon, 19 Apr 2021 15:34:50 -0700 (PDT)
Date:   Mon, 19 Apr 2021 23:34:48 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-arm-kernel@lists.infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 0/3] ARM: Implement MODULE_PLT support in FTRACE
Message-ID: <20210419223448.vummlz37nyc3a64i@e107158-lin.cambridge.arm.com>
References: <20210330114035.18575-1-alexander.sverdlin@nokia.com>
 <20210409153309.wbebto3eufui35qs@e107158-lin>
 <be48adb2-c838-1a9b-37bc-da783f3d5dd3@nokia.com>
 <20210412110810.t7pqkwawn5zmqbca@e107158-lin.cambridge.arm.com>
 <b26651f2-a5ca-ff5d-23e4-05b7eb7d9583@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b26651f2-a5ca-ff5d-23e4-05b7eb7d9583@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/21 14:54, Florian Fainelli wrote:
> 
> 
> On 4/12/2021 4:08 AM, Qais Yousef wrote:
> > Hi Alexander
> > 
> > Fixing Ard's email as the Linaro one keeps bouncing back. Please fix that in
> > your future postings.
> > 
> > On 04/12/21 08:28, Alexander Sverdlin wrote:
> >> Hi!
> >>
> >> On 09/04/2021 17:33, Qais Yousef wrote:
> >>> I still think the ifdefery in patch 3 is ugly. Any reason my suggestion didn't
> >>> work out for you? I struggle to see how this is better and why it was hard to
> >>> incorporate my suggestion.
> >>>
> >>> For example
> >>>
> >>> 	-       old = ftrace_call_replace(ip, adjust_address(rec, addr));
> >>> 	+#ifdef CONFIG_ARM_MODULE_PLTS
> >>> 	+       /* mod is only supplied during module loading */
> >>> 	+       if (!mod)
> >>> 	+               mod = rec->arch.mod;
> >>> 	+       else
> >>> 	+               rec->arch.mod = mod;
> >>> 	+#endif
> >>> 	+
> >>> 	+       old = ftrace_call_replace(ip, aaddr,
> >>> 	+                                 !IS_ENABLED(CONFIG_ARM_MODULE_PLTS) || !mod);
> >>> 	+#ifdef CONFIG_ARM_MODULE_PLTS
> >>> 	+       if (!old && mod) {
> >>> 	+               aaddr = get_module_plt(mod, ip, aaddr);
> >>> 	+               old = ftrace_call_replace(ip, aaddr, true);
> >>> 	+       }
> >>> 	+#endif
> >>> 	+
> >>>
> >>> There's an ifdef, followed by a code that embeds
> >>> !IS_ENABLED(CONFIG_ARM_MODULE_PLTS) followed by another ifdef :-/
> >>
> >> No, it's actually two small ifdefed blocks added before and after an original call,
> >> which parameters have been modified as well. The issue with arch.mod was explained
> >> by Steven Rostedt, maybe you've missed his email.
> > 
> > If you're referring to arch.mod having to be protected by the ifdef I did
> > address that. Please look at my patch.
> > 
> > My comment here refers to the ugliness of this ifdefery. Introducing 2 simple
> > wrapper functions would address that as I've demonstrated in my
> > suggestion/patch.
> 
> What is the plan to move forward with this patch series, should v8 be
> submitted into RMK's patch tracker and improved upon from there, or do
> you feel like your suggestion needs to be addressed right away?

There's no objection from my side to submitting this and improve later.

Thanks

--
Qais Yousef
