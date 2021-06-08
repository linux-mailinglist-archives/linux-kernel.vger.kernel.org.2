Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C3A39FFE7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhFHShS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:37:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42412 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234831AbhFHSfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:35:15 -0400
Received: from zn.tnic (p200300ec2f16b100c5fecac073351e7b.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:b100:c5fe:cac0:7335:1e7b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 988341EC0501;
        Tue,  8 Jun 2021 20:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623177200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BvXD955/vh9zOiTaAAzr9SuB56O6NcaiNom7DRYhgK4=;
        b=b1L4JXMUHJzBSqJSF2Ex/T/jDrAquFtQMZleDBw0cpkBxSH82HRhOOraSXEnTzlxIa2oZc
        Ws2GQJK9rfU25lmYNSnMbWs8Ofo8TWQuGuBS/EnVkXnTmRouMQFj0vbDyIFyEi4Klz4M8l
        w6BaRF6hrzcQSCZLyEotQA/mnZKXzyY=
Date:   Tue, 8 Jun 2021 20:33:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Kelley <mikelley@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        James Morris <James.Morris@microsoft.com>
Subject: Re: [GIT PULL] x86/urgent for v5.13-rc5
Message-ID: <YL+368+oKRORwUzx@zn.tnic>
References: <YLx/iA8xeRzwhXJn@zn.tnic>
 <CAHk-=wjXKsJVk+LPiOSiBACchPJLne7O+U+jmvw8CaLBYn-3=Q@mail.gmail.com>
 <YL029aQZb09G3ShY@linux.ibm.com>
 <CAHk-=wg7+-Q-jvrwQmyZtQ3pirAUcAQmvUpiLu=0nJv8NObntg@mail.gmail.com>
 <YL1HLdmh55uGAIs/@zn.tnic>
 <YL1UucKH0GfXddZo@sashalap>
 <eaf8e14-12d6-6e3a-f5e5-8b504647eb48@namei.org>
 <MWHPR21MB159330952629D36EEDE706B3D7379@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MWHPR21MB159330952629D36EEDE706B3D7379@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 05:53:15PM +0000, Michael Kelley wrote:
> I checked with the Windows team.  Peter Anvin's statement from 11
> years ago is true.  On Intel and AMD processors, Windows unconditionally
> reserves the 1st megabyte of memory, minus one page used for real
> mode startup.   This is done to work around BIOS bugs.

Thanks for checking!

I guess us doing the same is probably fine.

Linus, maybe we should at least give it a try and see whether someone
complains and revert, potentially...?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
