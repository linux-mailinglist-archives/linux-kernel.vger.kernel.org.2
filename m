Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C3739D1C6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 00:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhFFWJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 18:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhFFWJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 18:09:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD196C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 15:08:05 -0700 (PDT)
Received: from zn.tnic (p200300ec2f3a7d00ac6b86a87c3b23f6.dip0.t-ipconnect.de [IPv6:2003:ec:2f3a:7d00:ac6b:86a8:7c3b:23f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 904EA1EC0407;
        Mon,  7 Jun 2021 00:08:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623017283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=K6uYifQ5D1ExMd/dZl+zmjDEJmLTqaUKjABvv0ndK48=;
        b=QFw38partLRXOIZhu+C4t6A8EIrVFy2d+4xxs4+icXriidRDgZiRrdwETzBJlm9C8jU3vb
        B4Bryw+XNHIx35HGBsAXgKg/1rVN20Cbe41YuMwewqDFh0v40imp8GXAFBcQferC8m8I4R
        r1y751Fm64cg3Yq4TSegD2bn98SJ8Fg=
Date:   Mon, 7 Jun 2021 00:07:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/urgent for v5.13-rc5
Message-ID: <YL1HLdmh55uGAIs/@zn.tnic>
References: <YLx/iA8xeRzwhXJn@zn.tnic>
 <CAHk-=wjXKsJVk+LPiOSiBACchPJLne7O+U+jmvw8CaLBYn-3=Q@mail.gmail.com>
 <YL029aQZb09G3ShY@linux.ibm.com>
 <CAHk-=wg7+-Q-jvrwQmyZtQ3pirAUcAQmvUpiLu=0nJv8NObntg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg7+-Q-jvrwQmyZtQ3pirAUcAQmvUpiLu=0nJv8NObntg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 02:23:21PM -0700, Linus Torvalds wrote:
> On Sun, Jun 6, 2021 at 1:58 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > A while ago hpa said:
> >
> >         As far as I know, Windows 7 actually reserves all memory below
> >         1 MiB to avoid BIOS bugs.
> >
> > (https://bugzilla.kernel.org/show_bug.cgi?id=16661#c2)
> 
> It would be good to have that checked somehow.
> 
> I don't think this matters on any machine with gigs of RAM, but I do
> wonder about the people who want to do small configurations. Maybe
> they've given up on x86?
> 
> It also eats into that somewhat precious legacy DMA resource and eats
> up a fair chunk of that. Again, not an issue on modern hardware, but
> ..
> 
> > I believe that reserving everything below 1M after the real mode trampoline
> > is allocated reduces amount of hidden dependencies and makes things simpler
> > overall.
> 
> Simpler, perhaps, and _I_ personally don't care about about 512kB of
> memory any more on any machines I have, but ..

Let's see if Sasha can dig out something... CCed.

@Sasha, can you figure out who we can talk to whether Windoze reserves
the first megabyte of memory unconditionally?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
