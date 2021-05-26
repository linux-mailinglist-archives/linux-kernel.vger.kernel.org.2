Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A8B391ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 20:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbhEZSQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 14:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhEZSQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 14:16:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E880CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 11:14:55 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d4900a10086c04c57b79b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4900:a100:86c0:4c57:b79b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F13821EC04A6;
        Wed, 26 May 2021 20:14:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622052891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3xmEF/K2LnnBVy6PxdIzYYp3iPIXDRA9mR275WMcJO8=;
        b=rvLwmmyUWDzwJfROcttctvb+E29HyIstvseDmjy4W9/zCYDr7AuHy6cH5n62EYwZ1/+jZ6
        bYhfV42XmOd1Y01Ve2wf1CxB4ZkZOvXNf3VRHsYpdVCWi7oP4pyajuC+fprVlCTRzCYsPK
        ftyA3UhWe3ZapYdAKTGUO+C4nPLDe1A=
Date:   Wed, 26 May 2021 20:14:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        untaintableangel@hotmail.co.uk, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/Kconfig: decrease maximum of X86_RESERVE_LOW to 512K
Message-ID: <YK6QFLUoPZ7btQfH@zn.tnic>
References: <20210526081100.12239-1-rppt@kernel.org>
 <YK4LGUDWXJWOp7IR@zn.tnic>
 <YK53kWHb4cPeeHsd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YK53kWHb4cPeeHsd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 07:30:09PM +0300, Mike Rapoport wrote:
> We can restore that behaviour, but it feels like cheating to me. We let
> user say "Hey, don't touch low memory at all", even though we know we must
> use at least some of it. And then we sneak in an allocation under 640K
> despite user's request not to use it.

Sure but how are we going to tell the user that if we don't sneak that
allocation, we won't boot at all. I believe user would kinda like the
box to boot still, no? :-)

Yeah, you have that now:

+         Note, that a part of the low memory range is still required for
+         kernel to boot properly.

but then why is 512 ok? And why was 640K the upper limit?

Looking at:

d0cd7425fab7 ("x86, bios: By default, reserve the low 64K for all BIOSes")

and reading that bugzilla

https://bugzilla.kernel.org/show_bug.cgi?id=16661

it sounds like it is the amount of memory where BIOS could put crap in.

Long story short, we reserve the first 64K by default so if someone
reserves the total range of 640K the early code could probably say
something like

"adjusting upper reserve limit to X for the real-time trampoline"

when the upper limit is too high so that a trampoline can't fit...

Which is basically what your solution does...

But then the previous behavior used to work everywhere so if it is only
cheating, I don't mind doing that as long as boxes keep on booting.

Or am I missing an aspect?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
