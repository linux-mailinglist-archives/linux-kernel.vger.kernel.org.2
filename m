Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3197A30DF9B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhBCQYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:24:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59932 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231939AbhBCQX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:23:58 -0500
Received: from zn.tnic (p200300ec2f0c8400c151208e8a6ffcb8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8400:c151:208e:8a6f:fcb8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2F6B31EC047F;
        Wed,  3 Feb 2021 17:23:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612369397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GTCVBPK1sLBeSW8DlWA3rONLUDJV7NPSL1LPNBGJMZM=;
        b=Pa02DC+vaDu8dvBcv+xDHWt9Uup5eLynWxm5wua+MfuEamg2hup3s40stO0pni0Jc8kfrs
        Foy7tOVo88N1BzHorWmnqxIM7HOpfKQdo6fjHPkAMHgxOwx36VByzmU2EWnMJUjZk1Y0kt
        B5N/vcTgcWjGnR21fdUQgghtYfTbiOA=
Date:   Wed, 3 Feb 2021 17:23:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 06/11] x86/fault: Improve kernel-executing-user-memory
 handling
Message-ID: <20210203162313.GG13819@zn.tnic>
References: <cover.1612113550.git.luto@kernel.org>
 <05e787a0d0661d0bfb40e44db39bf5ead5f7e4ef.1612113550.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <05e787a0d0661d0bfb40e44db39bf5ead5f7e4ef.1612113550.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 09:24:37AM -0800, Andy Lutomirski wrote:
> Right now we treat the case of the kernel trying to execute from user
> memory more or less just like the kernel getting a page fault on a user
> access.  In the failure path, we check for erratum #93, try to otherwise
> fix up the error, and then oops.
> 
> If we manage to jump to the user address space, with or without SMEP, we
> should not try to resolve the page fault.  This is an error, pure and
> simple.  Rearrange the code so that we catch this case early, check for
> erratum #93, and bail out.

And I'm scratching my head why are you talking about kernel trying
to execute from user memory but doh, that erratum truncates the high
32-bits of rIP and the #PF address looks like a user address but
X86_PF_USER is clear.

Aha.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
