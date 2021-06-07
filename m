Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403D339DD3E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhFGND5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFGNDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:03:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DBAC061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 06:02:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623070920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zRCDO22t4kLMFzA7WN83SGOeFO0Lxr4G/GjkUNabyeE=;
        b=iFLjDYf8C1e4Nyrf+LBOPpLat6dMxCr2N6opeCe6hmGK9WdCekoAAtTCabcuYvjZZVUMOE
        UuOGoAzVlO+MVTVci40+dUdmMzJJUR3SBVo7fgf5LHDP6VHqjyg9wgsVUZUSB4XFt9cS2C
        +KJea0yF8yPfXrUwu7PVbMUUhjHu+YiSLZzBWXZlcJzOYDLvF+XVje//tiiq67xWeRYjdV
        rBuR9WT9VhETEBm4DKJMpLuExsnG9wdQdsifF1qP19aQbbJben8ch4AMNA6KGKefQsCmo8
        XFieh61qtSPu0960+tCgtphy49uRULioopWlKO+oq0dAh/OyTPu1AW2Bi+8ZpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623070920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zRCDO22t4kLMFzA7WN83SGOeFO0Lxr4G/GjkUNabyeE=;
        b=87bgAmbdMNSVdC3GsWgN4HjokpxPsP8lqii0KR0cZ8/EFiI2/L0ORpY7xXA1DaINFbVZOP
        BxEG1fFtGqNd9QDg==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 00/14] x86/fpu: Mop up XSAVES and related damage
In-Reply-To: <20210605234742.712464974@linutronix.de>
References: <20210605234742.712464974@linutronix.de>
Date:   Mon, 07 Jun 2021 15:02:00 +0200
Message-ID: <87h7i9zv3r.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06 2021 at 01:47, Thomas Gleixner wrote:
> P.S: I picked up Dave's PKRU series from

and while looking deeper at that I found the following existing
inconsistency vs. PKRU:

On exec() the kernel sets PKRU to the default value which is as
restrictive as possible.

But on sigrestore PKRU when the init optimization is used PKRU is reset
to the hardware default (0), which is as permissive as possible:

  1) On XRSTOR from user and the signal handler cleared the PKRU feature
     bit in xsave.header.xfeatures. That's true for the fast and the
     slow path.

  2) For the fx_only case which loads the init_fpstate (with my fixes
     applied that's not longer the case)

So that's inconsistent at best.

As the kernel defines the "init" behaviour of PKRU as non-permissive
on exec() it should do so consequently in sigrestore as well.

Thoughts?

Thanks,

        tglx


