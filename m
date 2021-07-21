Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E3D3D18BF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhGUU3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:29:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49626 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhGUU3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:29:15 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626901791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HC6sBQQL/yFbN3z83fR4A79zmBPFOOIOqpp7NC+b4ac=;
        b=p5ikUKdqKYdr8BJ3Q6GqwbpK1PNYySdCV09Uw+jhrmnoE452G87oNHm7vtFSpNCYJyj/Nh
        r3qN9BUiEPKmVgq9HGC3TdNpruXPBnzyENi6fFbC1+NKXEEaDmL3hYINLcqnwZfR+ib2Ei
        tkMNeiU45cxLxcZ1MHMCOs4KH8B8W2HfQlEivjZ30izV0j3RQ+77ZEHyy5WCXGy8pckhMp
        AURryWAwbYd8g8+3jegO/LPZm23K7V2/5OorlI87Ab3CWqIVwUgMfioUdYqDLZdsCAAnGl
        CILqe0pnUjtgm4uRLj2KOxTX2WintqZHdgm8kINCa5fTNLcBcLH3F35BF0HYeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626901791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HC6sBQQL/yFbN3z83fR4A79zmBPFOOIOqpp7NC+b4ac=;
        b=nJW983xbnD1bPL9ip4kfLhGgeHHdcP5zHZ7AANTRHHtVRdVgZcOHrV4Lq6VbJcXOkxABn3
        s1TKhA/Z3yY3p0BA==
To:     Carlos Bilbao <bilbao@vt.edu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, jianyong.wu@arm.com,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] include: linux: Reorganize timekeeping and ktime headers
In-Reply-To: <4663325.31r3eYUQgx@iron-maiden>
References: <5729424.lOV4Wx5bFT@iron-maiden> <CAK8P3a0LCZmHjwTjr6bWQ+uuO_3MentMfnHy2M_6iysyN9fP1g@mail.gmail.com> <11790008.O9o76ZdvQC@iron-maiden> <4663325.31r3eYUQgx@iron-maiden>
Date:   Wed, 21 Jul 2021 23:09:50 +0200
Message-ID: <87fsw7pe5d.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos,

On Mon, Jul 19 2021 at 11:19, Carlos Bilbao wrote:
> Reorganize and separate the headers by making ktime.h take care of the 
> ktime_get() family of functions, and reserve timekeeping.h for the actual 
> timekeeping. This also helps to avoid implicit function errors and strengthens
> the header dependencies, since timekeeping.h was using ktime_to_ns(), a static 
> function defined in a header it does no include, ktime.h.

I have no objections against this change per se, but I'm missing the
actual problem it is trying to solve. What's the fail it fixes or is it
just a general consolidation? The above is blury in that regard.

> This patch also includes the header timekeeping.h wherever it is
> necessary for a successful compilation after the header code
> reorganization.

Please do:

  git grep 'This patch' Documentation/process/

and follow the instructions there.

Aside of that I assume that you only covered x86 in build testing which
is not cutting it as this is generic infrastructure affecting _all_
architectures.

Thanks,

        tglx
