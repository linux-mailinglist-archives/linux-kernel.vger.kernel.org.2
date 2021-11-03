Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3F44449C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 21:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhKCUvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 16:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhKCUvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 16:51:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5215C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 13:48:39 -0700 (PDT)
Received: from zn.tnic (p200300ec2f132900245c5fbaf582f40b.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:2900:245c:5fba:f582:f40b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BBA961EC0532;
        Wed,  3 Nov 2021 21:48:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635972516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FdTzAjyte3r+pR9FqYNRQwuq1MBlXqVbeaq4ye630ww=;
        b=KysHob/L+jKKjNiaMFINi1NCmYAxexw9Ku9EzWOW5QH68s+uTyeOiNR8QaWoue47SqbRil
        YuAk1A5YNCQgb5NEjwAt6shK6GG9nSd7muWHEGJgJzoEMMnX9W5wAdBVxoSMs8jyB0ctEq
        wbVfrfHBjh4oiq7XI29YtATZUx35fgs=
Date:   Wed, 3 Nov 2021 21:48:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, X86 ML <x86@kernel.org>,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] x86/xstate: Make AVX512 status tracking more
 accurate
Message-ID: <YYL1nyfbjXCMvw+7@zn.tnic>
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <20211027162615.1989004-1-goldstein.w.n@gmail.com>
 <20211027162615.1989004-2-goldstein.w.n@gmail.com>
 <YXmIP2EPg12N7foP@zn.tnic>
 <CAFUsyf+Y76TxLnxMSfHiNqY3OOZPtBR4m_EbTcow=N65nvGdKA@mail.gmail.com>
 <YXmQSG7BYCcZ6jqZ@zn.tnic>
 <CAFUsyfKVistpw8eL9L6qwypac7JL9ecAL2W4reZtAMOq7xL+2g@mail.gmail.com>
 <CAFUsyfLp6hqc1KOupFKLMoFHhDmEOQDZsMxEBF7BFABRYmH9-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFUsyfLp6hqc1KOupFKLMoFHhDmEOQDZsMxEBF7BFABRYmH9-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 03:22:38PM -0500, Noah Goldstein wrote:
> Ping.

Dear Noah,

in case you don't know, we have a merge window now. See below for a
lenghty explanation what that means about new patches.

Also, there's no need to constantly ping people - your patch has landed
on my TODO list and will be dealt with when its time comes.

If it is a serious bug fix, it will be handled with a higher priority
but that is not the case, as far as I see it.

So please sit back and be patient - it'll happen.

Thx.

"Merge window
^^^^^^^^^^^^

Please do not expect large patch series to be handled during the merge
window or even during the week before.  Such patches should be submitted in
mergeable state *at* *least* a week before the merge window opens.
Exceptions are made for bug fixes and *sometimes* for small standalone
drivers for new hardware or minimally invasive patches for hardware
enablement.

During the merge window, the maintainers instead focus on following the
upstream changes, fixing merge window fallout, collecting bug fixes, and
allowing themselves a breath. Please respect that.

The release candidate -rc1 is the starting point for new patches to be
applied which are targeted for the next merge window."

from Documentation/process/maintainer-tip.rst

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
