Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6B13FBCB3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 20:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhH3Swc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 14:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhH3Sw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:52:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C2BC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 11:51:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630349493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=39r6jkCo9wse4D+ZKeqS3OGFsifyxRSimJoi7w1hf3s=;
        b=PRWOPeDBK5MidCh/epBhpwt1N4TP0udPCf5XK8Lb98goIk2SREY79gG/vIH5WejihumrWE
        m2QsfzDld/A/CNs+RADiJ1qXsiA7kAZnSW/cqd8yryIbBszVk2ENIA6wMURe4HyE+/7vwn
        xOc/X32qk8urjvavxOFvEsetUy9Pm5K/f4XZMZ+2gZpcnScBTdZ+zATj+BTFfRxqXn6FZP
        Xusk09ySgTFF+4M0/LghdmnGYCFIORHyDnuQaRIzgL4KNzavKkhSV/DBsF0gJWavXU8OgV
        Di4taqIW7xrcV6lAOr6wQk/2k5ylojSGXVCkP1Kpto01zaEbqVX2NYszakyRjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630349493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=39r6jkCo9wse4D+ZKeqS3OGFsifyxRSimJoi7w1hf3s=;
        b=YoctAuEO50D2KMAq1gZZnLdKG20Bh49fiuPKVDsOpPBJHZBZX7j+7c5nebx86KGBKD6ihQ
        d2Rnxe1FKuvcRlDA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [patch 00/10] x86/fpu: Clean up error handling in sigframe
 related code
In-Reply-To: <CAHk-=wiWxv7baa91W_0CXFtG+FW_Obp5Y=4BqZD7EZ+nqcRvqg@mail.gmail.com>
References: <20210830154702.247681585@linutronix.de>
 <CAHk-=wiWxv7baa91W_0CXFtG+FW_Obp5Y=4BqZD7EZ+nqcRvqg@mail.gmail.com>
Date:   Mon, 30 Aug 2021 20:51:32 +0200
Message-ID: <878s0ihikr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30 2021 at 10:39, Linus Torvalds wrote:
> On Mon, Aug 30, 2021 at 9:27 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> The following series cleans this up. As a side effect the resulting text
>> size of fpu/signal.o shrinks by about 150 bytes.
>
> Well, some of the patches in the middle were confusing because of how
> 0/ERROR was mixing with a success true/false thing, but the end result
> seems to be a whole lot more sensible.

Yes, I know. I tried various approaches but they mostly ended up being
unreviewable because they changed too many things at once.

So at the end I went for this step wise approach which seemed to be
manageable at least for my restricted brain capacity.

Thanks,

        tglx
