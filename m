Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3393FBD43
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 22:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhH3UIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 16:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbhH3UIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 16:08:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BF1C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 13:07:20 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b3b006b822824b2d93553.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:3b00:6b82:2824:b2d9:3553])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FEFC1EC047D;
        Mon, 30 Aug 2021 22:07:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630354034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=u217dEPyyFYpFn1SDH8A3gtA32XrtHOZLQUu0hd1JPQ=;
        b=GgHWWERPpOZg0TaFyGzlzAG0ksY7eIJRaRz7Ou9sfcM5AJoOUW59QIB24cjzX8povOIKB4
        Lmn3byFSpgeeXKhxGV18qPzTJc7grgDRf/B/8xQFKek2/0CPwE8KoukPvbQ84CM/rPhW6l
        DVssA6dHPPTM/6AKJF43wwrLkpq+0w0=
Date:   Mon, 30 Aug 2021 22:07:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
Message-ID: <YS06l92erXZDYeNW@zn.tnic>
References: <20210830154702.247681585@linutronix.de>
 <20210830162545.374070793@linutronix.de>
 <YS0ylo9nTHD9NiAp@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YS0ylo9nTHD9NiAp@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 09:33:42PM +0200, Borislav Petkov wrote:
> I guess you wanna fixup the comment over XSTATE_OP() too and perhaps
> mention ex_handler_fault() explicitly so that one can make her/his way
> around the code and pinpoint quickly where it sticks that exception
> number into rAX.

Diff ontop. I think it should not say anything about X86_TRAP_PF or
EFAULT or any other error value but simply that it returns one. It is
callers' task to act upon the specific error value returned.

---
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 5771af87e4b4..d59bc5df7438 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -199,7 +199,7 @@ static inline void fxsave(struct fxregs_state *fx)
 
 /*
  * After this @err contains 0 on success or the negated trap number when
- * the operation raises an exception. For faults this results in -EFAULT.
+ * the operation raises an exception, see ex_handler_fault().
  */
 #define XSTATE_OP(op, st, lmask, hmask, err)				\
 	asm volatile("1:" op "\n\t"					\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
