Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5412E3912B0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhEZIs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbhEZIs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:48:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC88C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:25 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d490061818bcc6f3e1c2b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4900:6181:8bcc:6f3e:1c2b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 821EF1EC01DF;
        Wed, 26 May 2021 10:47:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622018843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dDbqcN7yPNZ7DXqdwmtnFTmSQPgsADBgy42h99rlSic=;
        b=FkuIyLU8R5xYoTpbaviKFDBYEBRKhT8xXPBltG6593nog/obko6w9uzCSWXqb6meAZZYTt
        FlfZyEdUOfJ1Zy6nTEAIZKIP7isWnF5kngboWUk1Uhp7GNEcmXmruZ3fXvgi7q2k7FZmLx
        BbwpXnoqJqLi2THEopInA4wu6SYClVQ=
Date:   Wed, 26 May 2021 10:47:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        untaintableangel@hotmail.co.uk, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/Kconfig: decrease maximum of X86_RESERVE_LOW to 512K
Message-ID: <YK4LGUDWXJWOp7IR@zn.tnic>
References: <20210526081100.12239-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210526081100.12239-1-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 11:11:00AM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> After the consolidation of early memory reservations introduced by the
> commit a799c2bd29d1 ("x86/setup: Consolidate early memory reservations")
> the kernel fails to boot if X86_RESERVE_LOW is set to 640K.
> 
> The boot fails because real-time trampoline must be allocated under 1M (or
> essentially under 640K) but with X86_RESERVE_LOW set to 640K the memory is
> already reserved by the time reserve_real_mode() is called.
> 
> Before the reordering of the early memory reservations it was possible to
> allocate from low memory even despite user's request to avoid using that
> memory. This lack of consistency could potentially lead to memory
> corruptions by BIOS in the areas allocated by kernel.

Hmm, so this sounds weird to me: real-time trampoline clearly has
precedence over X86_RESERVE_LOW because you need former to boot the
machine, right?

In that case, real-time trampoline should allocate first and *then* the
rest of low range requested to be reserved should be reserved, no?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
