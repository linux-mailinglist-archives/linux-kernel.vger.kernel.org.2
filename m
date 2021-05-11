Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D047837A90D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhEKOZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhEKOZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:25:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE85DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 07:23:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620743034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o9RHciGCOQ4OdS30lWv6gdzpynUH0CEfSGJK89DLKkE=;
        b=bZgbdH94XMR0JuLoYg940MWH3lvjdcF+rpL6uK/mu8+G82IXWb8zAxp7rtww13YfxLAQzY
        4dLHA/5TtRaH2k15hfuYmeLArzUSmldDeeEWrrgAE/I6L/2L7hQlYsL9SVoPPOo8pZEoQD
        QRhh1ExuIEO0Sm0/OEFDWTfPkyL5hYArPsmgmZLZJ4mFYQ7qmiVn5GiFynTRTmW+ABvBPW
        msamn4iu4kIu1EtfUpT8briAZILSD8bcBGu06Qkw80D+RXneiIxPNIQ8QayidCxHNmf5lg
        F/ealklKzZR8LqWdVizrzRvHbvViqgiqFqa0vglcyT0psPPCUnUEwgZEZ8Cslw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620743034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o9RHciGCOQ4OdS30lWv6gdzpynUH0CEfSGJK89DLKkE=;
        b=a+n3CeL/m8p4Cfdt6pUVmGOUTaW49dVJIeXZFEvLZ1Y13kcW1l6wibsKOjyFqyiCkk4GZ3
        XYXW0J9nN2WcelCw==
To:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin \(Intel\)" <hpa@zytor.com>
Subject: Re: [PATCH 5/6] x86/irq: WARN_ONCE() if irq_move_cleanup is called on a pending interrupt
In-Reply-To: <20210511005531.1065536-6-hpa@zytor.com>
References: <20210511005531.1065536-1-hpa@zytor.com> <20210511005531.1065536-6-hpa@zytor.com>
Date:   Tue, 11 May 2021 16:23:53 +0200
Message-ID: <87im3pfix2.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10 2021 at 17:55, H. Peter Anvin wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
>
> The current IRQ vector allocation code should be "clean" and never
> issue a IRQ_MOVE_CLEANUP_VECTOR IPI for an interrupt that could still
> be pending. This should make it possible to move it to the "normal"
> system IRQ vector range. This should probably be a three-step process:
>
> 1. Introduce this WARN_ONCE() on this event ever occurring.
> 2. Move the IRQ_MOVE_CLEANUP_VECTOR to the sysvec range.
> 3. Remove the self-IPI hack.

Actually 2+3 must be combined because _if_ this ever happens then the
self-IPI loops forever.

Thanks,

        tglx
