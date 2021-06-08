Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D9D3A04F2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 22:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbhFHUIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 16:08:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34472 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231162AbhFHUIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 16:08:12 -0400
Received: from zn.tnic (p200300ec2f16b100e640acc4c45ae2c4.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:b100:e640:acc4:c45a:e2c4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB5791EC03F0;
        Tue,  8 Jun 2021 22:06:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623182778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/qD0+SnYeOyPC9noFgtAGu54g//5aZL1bQvzqOYQggw=;
        b=YkX29dM9g6kPeyu6JqDQNuALZIlBUfbmvEUQV7DHKHnr+Mp5IRW5KqZze7/aLsWffG+9/T
        eLMhbiFopYhccE0GNbkqgwuf20JCkD6Ojn6KvT3o9RJsdxJThSIbXiGc4jTAHai50gyOQY
        5nZLEjtACsNZx9pQyD6ryjvEdYh+dQU=
Date:   Tue, 8 Jun 2021 22:06:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [patch V3 4/6] x86/pkru: Make PKRU=0 actually work
Message-ID: <YL/Nuuu8zvKvh3D0@zn.tnic>
References: <20210608143617.565868844@linutronix.de>
 <20210608144346.045616965@linutronix.de>
 <YL+PYz/cZPhSVmf2@zn.tnic>
 <87tum8xj4x.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tum8xj4x.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 09:15:42PM +0200, Thomas Gleixner wrote:
> But if nothing touched the FPU between T1 scheduling out and back in,
> then the fpregs_state is still valid which means switch_fpu_return()
> does nothing and just clears TIF_NEED_FPU_LOAD. Back to user space with
> DEFAULT_PKRU loaded. -> FAIL #2!

Ah ok.

> Why? It was clearly wrong and I can reproduce it with a hack which
> forces a schedule to a kernel thread and it fails all the way back to
> user space.

Oh, I was speculating about some weird luserspace's behavior of clearing
PKRU and then relying on the buggy behavior of getting PKRU restored to
DEFAULT_PKRU.

I know, it is nuts but it is user-visible change. And yeah, probably
nothing does that...

> I chased that because I observed sporadic failures when forcing PKRU to
> init state and then observed the default key being written. I had some
> extra trace_printks there to analyze something completely different :)

As you do. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
