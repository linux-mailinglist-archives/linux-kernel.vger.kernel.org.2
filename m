Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B263FBCEE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 21:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhH3TeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 15:34:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44380 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233345AbhH3TeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 15:34:04 -0400
Received: from zn.tnic (p200300ec2f0b3b00e45097ba10a336d1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:3b00:e450:97ba:10a3:36d1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 751701EC047D;
        Mon, 30 Aug 2021 21:33:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630351985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1llOG+4aVLenbxxM8V4oYVpsZZa8XSxqm1/J7XZsjws=;
        b=chrAWpe/0lJO87yH0RaPEi0hngo+79/X7jJvTrA446Zlq8aVYFRNtyBVOD+XqLOeaMBQaV
        HOzLllYhYTTwJVb2O51tmfVG0H9G9ahsygSFyDVqaDJ/wm6ma8MI7iq3zj1w0xmzk2y8V0
        i+4vb/7l3KVutlqNJHuZmvCRYrMp+Ww=
Date:   Mon, 30 Aug 2021 21:33:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
Message-ID: <YS0ylo9nTHD9NiAp@zn.tnic>
References: <20210830154702.247681585@linutronix.de>
 <20210830162545.374070793@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210830162545.374070793@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 06:27:22PM +0200, Thomas Gleixner wrote:
> FPU restore from a signal frame can trigger various exceptions. The
> exceptions are caught with an exception table entry. The handler of this
> entry sets the error return value to the negated exception number.
> 
> Any other exception than #PF is fatal and recovery is not possible. This
> relies on the fact that the #PF exception number is the same as EFAULT, but
> that's not really obvious.
> 
> Check the error code for -X86_TRAP_PF instead of checking it for -EFAULT to
> make it clear how that works.

I guess you wanna fixup the comment over XSTATE_OP() too and perhaps
mention ex_handler_fault() explicitly so that one can make her/his way
around the code and pinpoint quickly where it sticks that exception
number into rAX.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
