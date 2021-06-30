Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BF23B802A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 11:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbhF3Jko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 05:40:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43448 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233817AbhF3Jkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 05:40:42 -0400
Received: from zn.tnic (p200300ec2f12c3005601b47fb9547aa2.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:c300:5601:b47f:b954:7aa2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90C741EC0528;
        Wed, 30 Jun 2021 11:38:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1625045892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7/Ij8gtUUK45jvstUT5DxylQ3O9KokzsF1985ci5zq8=;
        b=JvG+JKnBWf9zCbGzM30JoUYM1Knm7WKCM2G1q10IvU4I4dT+328pmpUmldfjlkEwP/JftJ
        kKyzyIj23q0hMe3PvzkadT5nBO86J5z+NqLivX+55UdC8v7OqpqKZ70C5HumMJjANY9btj
        tjmqhOY66I/vpRmXd4f6qY70uFf3mtQ=
Date:   Wed, 30 Jun 2021 11:38:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Marcos Del Sol Vives <marcos@orca.pet>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86: add NOPL and CMOV emulation
Message-ID: <YNw7f1bcjZbzX9ON@zn.tnic>
References: <YNWAwVfzSdML/WhO@hirez.programming.kicks-ass.net>
 <20210626130313.1283485-1-marcos@orca.pet>
 <YNtLlcYasFR84rp5@zn.tnic>
 <b69e0c78-81eb-0d4d-dce5-076b5f239e28@orca.pet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b69e0c78-81eb-0d4d-dce5-076b5f239e28@orca.pet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 10:45:17PM +0200, Marcos Del Sol Vives wrote:
> All the documentation I had previously read suggested that only CMOV and
> NOPL had been introduced with the i686, and hence these were the two
> instructions I emulated only. As stated previously this is also enough to
> boot Debian mostly flawless.
> 
> However, and contrary to what I thought, the i686 also saw the introduction
> of a handful of other x87 instructions (FCMOVB, FCMOVBE, FCMOVE, FCMOVNB,
> FCMOVNBE, FCMOVNE, FCMOVNU, FCMOVU, FCOMI, FCOMIP, FUCOMI, FUCOMIP)

Yah, looka here:

https://en.wikipedia.org/wiki/FCMOV

So before we play with this further, you could try to add a "nofpu"
kernel cmdline param which does what fpu__init_system_early_generic()
does:

	setup_clear_cpu_cap(X86_FEATURE_FPU)

to stop the kernel from setting up FPU support and see how far you can
get there.

I'm afraid glibc does its own feature detection so it will see the FPU
CPUID bit but if the kernel doesn't support an FPU - and glibc needs
the kernel to handle the context - then maybe it'll stop using FPU
instructions.

But you'll have to try it because I fear no one even tested such a
thing.

Good luck. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
