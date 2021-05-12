Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD6437F055
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 02:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbhEMAYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 20:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346258AbhEMAWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 20:22:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1018EC061359
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 16:58:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620863896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=CX9+MuuWEQWnFC1f0v4umjM+QedIzoRjhbbbY3SBY/Y=;
        b=ZNDkANDGwRROjrzWGWRElNOkfA4C5+41NwZ2A9s0gdQwx+QiRLzwLdaNUx8Wf3ThiIpe+b
        n+1R3bNi0O0QftDuxj2Fw6T1I0LntXzBhPb667WmYCLm+Lpodyx1cHkc1pQvoZbmzLHrbm
        ecG+QYYA/4kdnMHBa8BSYfi/2oAu7plqeh81l1/JlUehY5fUVrT4o4AAVHWQDXet5Imc74
        kcDJKfxytEAI4yeEjnK2pA4n64S8S//KKe8G5BfgMcvoF6ufO9FTzqHUm71eHR+HCxNW8a
        cH1FG/qpR3x4qv77ndbn/EUlLb0BWUWW2g0T3EoTBggEaqOt50j7EbheX3KCWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620863896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=CX9+MuuWEQWnFC1f0v4umjM+QedIzoRjhbbbY3SBY/Y=;
        b=o7kCPiWS7RzQ4S/OEGRUHYOByNw8Pm0MPlWue0VP2qZAaMZENXhqfU2lI/HUAOhahAEaS/
        oe6Jw92bhcThLABQ==
To:     Alexey Dobriyan <adobriyan@gmail.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>, x86@kernel.org
Subject: Re: [PATCH 1/4] sched: make nr_running() return 32-bit
In-Reply-To: <20210422200228.1423391-1-adobriyan@gmail.com>
Date:   Thu, 13 May 2021 01:58:16 +0200
Message-ID: <87fsyr5wtj.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey,

On Thu, Apr 22 2021 at 23:02, Alexey Dobriyan wrote:
> Creating 2**32 tasks is impossible due to futex pid limits and wasteful
> anyway. Nobody has done it.
>

this whole pile lacks useful numbers. What's the actual benefit of that
churn?

Just with the default config for one of my reference machines:

   text		data	bss	dec	 hex	 filename
16679864	6627950	1671296	24979110 17d26a6 ../build/vmlinux-before
16679894	6627950	1671296	24979140 17d26c4 ../build/vmlinux-after
------------------------------------------------------------------------
     +30

I'm truly impressed by the massive savings of this change and I'm even
more impressed by the justification:

> Bring nr_running() into 32-bit world to save on REX prefixes.

Aside of the obvious useless churn, REX prefixes are universaly true for
all architectures, right? There is a world outside x86 ...

Thanks,

        tglx



