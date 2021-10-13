Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFC042C2D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbhJMOXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbhJMOXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:23:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD50C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 07:20:59 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1208007640f6707bffede5.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:800:7640:f670:7bff:ede5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 948751EC051F;
        Wed, 13 Oct 2021 16:20:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634134857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nhATRzmWTkICby+ObI3rbAKu3CkyaY6UKLyFkzz1ee8=;
        b=CT/rxpGlYo+TPOdZdA4rQuRHMLMp4VkCODpBfxsn2TBC2EP/YnLYbw7V5aYVVAnNu10Kz/
        YzUD0Q2RVVCh2RDnnwrnaJQPChQWYnL+B0YywnPBg8LBFcUeAtCETGHn6Fyt1Ms14bmneY
        ycHxnUKzRMIcccKVgGEqR5AFx9m3FOw=
Date:   Wed, 13 Oct 2021 16:20:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Michael Matz <matz@suse.de>
Subject: Re: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the
 clobber list
Message-ID: <YWbrR1BqI1CxneN/@zn.tnic>
References: <YWXwQ2P0M0uzHo0o@zn.tnic>
 <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id>
 <YWbUbSUVLy/tx7Zu@zn.tnic>
 <20211013125142.GD5485@1wt.eu>
 <YWbZz7gHBV18QJC3@zn.tnic>
 <20211013140723.GE5485@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211013140723.GE5485@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 04:07:23PM +0200, Willy Tarreau wrote:
> Yes I agree with the "potentially" here. If it can potentially be (i.e.
> the kernel is allowed by contract to later change the way it's currently
> done) then we have to save them even if it means lower code efficiency.
>
> If, however, the kernel performs such savings on purpose because it is
> willing to observe a stricter saving than the AMD64 ABI, we can follow
> it but only once it's written down somewhere that it is by contract and
> will not change.

Right, and Micha noted that such a change to the document can be done.
And we're basically doing that registers restoring anyway, in POP_REGS.

I'm not the least bit convinced it is worth enforcing that stricter
register saving, though.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
