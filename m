Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133EF40B54A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhINQww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhINQwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:52:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E34C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:51:32 -0700 (PDT)
Received: from zn.tnic (p200300ec2f104800a3d420f33d0f872b.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:4800:a3d4:20f3:3d0f:872b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6CEE11EC0531;
        Tue, 14 Sep 2021 18:51:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631638287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1Zs+ZQPJVtM/7blQ3wafkcL3zalQPTngnvvl2WYrAr4=;
        b=Js7aUijH3xYD2ZAc6GsX39Gnlx/Wz7SwYktgFUH1v9OEQaVeaedi/J6Z4awoqGru+Lbs0M
        j9QjWXLjxX220AH09+8uYqqjXr8CgxwNUZcXdq6DtnfXdnJ4wBRIM2bcjLelKZ5ccnSROO
        hM+9ICKDinFUZ9SVFxr+jzzmaG3mJVM=
Date:   Tue, 14 Sep 2021 18:51:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Marcus =?utf-8?Q?R=C3=BCckert?= <mrueckert@suse.com>
Subject: Re: [PATCH] x86/umip: Add a umip= cmdline switch
Message-ID: <YUDTCgEOZ3JOMSl7@zn.tnic>
References: <20210907200454.30458-1-bp@alien8.de>
 <20210911011459.GA11980@ranerica-svr.sc.intel.com>
 <YTx0+0pfyzHuX80L@zn.tnic>
 <20210913213836.GA10627@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210913213836.GA10627@ranerica-svr.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 02:38:36PM -0700, Ricardo Neri wrote:
> That is right. Although, I am not sure programs you can have in
> the same machine that also want to use UMIP-protected instructions.

Sure, another game. :-P

But srsly, looking at those two:

        umip_pr_warn(regs, "%s instruction cannot be used by applications.\n",
                        umip_insns[umip_inst]);

        umip_pr_warn(regs, "For now, expensive software emulation returns the result.\n");

Why are they there at all?

I mean, I can hardly imagine userspace doing anything about them.

They're all likely old, arcane applications or games run in wine which
people have no access to the source code anyway so come to think of it,
the once thing is starting to make more sense to me now.

Sure, that:

        umip_pr_err(regs, "segfault in emulation. error%x\n",
                    X86_PF_USER | X86_PF_WRITE);

should be issued unconditionally but I'm wondering if those warning
messages are needed at all. And if not, I should probably simply rip
them all out.

Or at least silence them by default and flip the cmdline switch logic to
enable them for users who are interested in those things but they should
be silent by default.

I.e., you'd need to supply

	umip=warnings_on

on the cmdline to actually see them.

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
