Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9021D391D0C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 18:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhEZQby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 12:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234544AbhEZQbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 12:31:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D8D8613CE;
        Wed, 26 May 2021 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622046616;
        bh=K2m+rOb2f5WbHdz8pamr+WIQ2N26pRLHMfuwQxJHfRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhC4cjoVWCu6lSiiL7n4CJy8Ikr7zv8QwzE4SuU9kh/vXEJNpGroSZ+/An5/5Q4Xu
         j/7s5x/MeU2UllKWl30Ze5nDPJR61nSny+59D5CA4DN3RVOGUN7t4X2/d6hQAWPNfW
         m+ZIbdk14b+IRidC/kV+eEkG6wXYGcJAioi8/i2EVibXtBy+oitp6xc1eZDIHGsfQb
         +VSRYHpgX9BYreoUIxRTlB+RbTRCLPwSnw9sFY6ZKXPXs5EKh03Q/uUKRwTWdiOvey
         dslvDCRl08RxnTkYx1u4Sv1kMDFQZgy7dArO0+77lYOCEsbG0d17t2ErWzLqZ4CnMu
         STGbT5UzBOX1A==
Date:   Wed, 26 May 2021 19:30:09 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        untaintableangel@hotmail.co.uk, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/Kconfig: decrease maximum of X86_RESERVE_LOW to 512K
Message-ID: <YK53kWHb4cPeeHsd@kernel.org>
References: <20210526081100.12239-1-rppt@kernel.org>
 <YK4LGUDWXJWOp7IR@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK4LGUDWXJWOp7IR@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 10:47:21AM +0200, Borislav Petkov wrote:
> On Wed, May 26, 2021 at 11:11:00AM +0300, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > After the consolidation of early memory reservations introduced by the
> > commit a799c2bd29d1 ("x86/setup: Consolidate early memory reservations")
> > the kernel fails to boot if X86_RESERVE_LOW is set to 640K.
> > 
> > The boot fails because real-time trampoline must be allocated under 1M (or
> > essentially under 640K) but with X86_RESERVE_LOW set to 640K the memory is
> > already reserved by the time reserve_real_mode() is called.
> > 
> > Before the reordering of the early memory reservations it was possible to
> > allocate from low memory even despite user's request to avoid using that
> > memory. This lack of consistency could potentially lead to memory
> > corruptions by BIOS in the areas allocated by kernel.
> 
> Hmm, so this sounds weird to me: real-time trampoline clearly has
> precedence over X86_RESERVE_LOW because you need former to boot the
> machine, right?
> 
> In that case, real-time trampoline should allocate first and *then* the
> rest of low range requested to be reserved should be reserved, no?
 
We can restore that behaviour, but it feels like cheating to me. We let
user say "Hey, don't touch low memory at all", even though we know we must
use at least some of it. And then we sneak in an allocation under 640K
despite user's request not to use it.

-- 
Sincerely yours,
Mike.
