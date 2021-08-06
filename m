Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6A93E2CA8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 16:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbhHFOei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 10:34:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:39923 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239972AbhHFOeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 10:34:37 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 176EQjC0006372;
        Fri, 6 Aug 2021 09:26:45 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 176EQikA006370;
        Fri, 6 Aug 2021 09:26:44 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 6 Aug 2021 09:26:43 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     sxwjean@me.com, linuxppc-dev@lists.ozlabs.org,
        ravi.bangoria@linux.ibm.com, Xiongwei Song <sxwjean@gmail.com>,
        oleg@redhat.com, npiggin@gmail.com, linux-kernel@vger.kernel.org,
        efremov@linux.com, paulus@samba.org, aneesh.kumar@linux.ibm.com,
        peterx@redhat.com, akpm@linux-foundation.org,
        sandipan@linux.ibm.com
Subject: Re: [RFC PATCH 1/4] powerpc: Optimize register usage for esr register
Message-ID: <20210806142643.GU1583@gate.crashing.org>
References: <20210726143053.532839-1-sxwjean@me.com> <874kc3njxh.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kc3njxh.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 04:53:14PM +1000, Michael Ellerman wrote:
> But I'm not sure about the use of anonymous unions in UAPI headers. Old
> compilers don't support them, so there's a risk of breakage.

More precisely, it exists only since C11, so even with all not-so-ancient
compilers it will not work if the user uses (say) -std=c99, which still
is popular.

> I'd rather we didn't touch the uapi version.

Yeah.

> > -	err = ___do_page_fault(regs, regs->dar, regs->dsisr);
> > +	if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> > +		err = ___do_page_fault(regs, regs->dar, regs->esr);
> > +	else
> > +		err = ___do_page_fault(regs, regs->dar, regs->dsisr);
> 
> As Christophe said, I don't thinks this is an improvement.
> 
> It makes the code less readable. If anyone is confused about what is
> passed to ___do_page_fault() they can either read the comment above it,
> or look at the definition of pt_regs to see that esr and dsisr share
> storage.

Esp. since the affected platforms are legacy, yup.


Segher
