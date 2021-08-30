Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ECB3FBEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbhH3W1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 18:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhH3W1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 18:27:53 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB8CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 15:26:58 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id p15so28476982ljn.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 15:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8bTVy6xugm2ewLkHD1CCCjL7QHYEiq4IESbLuCXtbA=;
        b=gJ2r8UITknbqczk85Qy7F+XABKxxjTy3zh9UV4KWQdsrd8WVIb63Qa/u1yKbsquFTW
         rztawTW+gZw9XYsXgrwOlph0C9EAKzhDmwE1BLbjXTK7/xVGN0xVzs1u3PkwJxpTmIZg
         pKnTP5a6ybwUyX409eBLyquVjIWirZzqqSyFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8bTVy6xugm2ewLkHD1CCCjL7QHYEiq4IESbLuCXtbA=;
        b=r1ZOD3IFQobY4ahUo6ZFsfr/ecFcqkkmTowoOgHo5z2puK9ih/vU2/vO6tmgjw6z1v
         KGiVoaiYhZVh0ImgMloWrJMugQSDeGBwL1bsv0OAp57PyF43LuSjYFkA0GjdtVjJ/zkV
         W2fp2tAnt6exKGai7iB7PYXGlVVOyqs9ktNtxwX/s0XQndjVwaIT5CjJ9EkUSzu0MPEu
         jGHht4mgixCri0gMTn1HmMY5oP6aDmb+Ed6yTarBpzhK41+fVfQKEEX3lDH5+nmWyKPv
         dIaOIdyXp/iACkss7AvB0eK+xMI/c2xT91rs3BJZpDQZikk+j7nGlshx9jfAQHSqyg8y
         LKlw==
X-Gm-Message-State: AOAM532R4bZaJQdV6eWW1Bf6WzLKPFG7Lmj6pVhHNoaM+vbnn5ZnEoBQ
        CzWbqiXkeKqib0p+hLDh9ZHStVCRh5HuTELVS2w=
X-Google-Smtp-Source: ABdhPJzYjJoETJK6mNprdmiDpFtAbWZVL5eahB2HrEHTYW/pbm+r6FjkFFQGLLFBRxKTgvPFo0UVrw==
X-Received: by 2002:a2e:bd89:: with SMTP id o9mr21312690ljq.246.1630362416594;
        Mon, 30 Aug 2021 15:26:56 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id bt38sm1513008lfb.213.2021.08.30.15.26.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 15:26:56 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id p15so28476922ljn.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 15:26:55 -0700 (PDT)
X-Received: by 2002:a2e:3004:: with SMTP id w4mr21512773ljw.465.1630362415442;
 Mon, 30 Aug 2021 15:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210830154702.247681585@linutronix.de> <20210830162545.374070793@linutronix.de>
 <YS0ylo9nTHD9NiAp@zn.tnic> <87zgsyg0eg.ffs@tglx> <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
 <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
 <YS1OE6FRi4ZwEF8j@zeniv-ca.linux.org.uk> <CAHk-=wh57tMaJxcH=kWE4xdKLjayKSDEVvMwHG4fKZ5tUHF6mg@mail.gmail.com>
 <87o89efupd.ffs@tglx>
In-Reply-To: <87o89efupd.ffs@tglx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Aug 2021 15:26:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_29VY5rpchsw8NWz6=akW1Sgj9rYUtUmYvJAkbVa=3w@mail.gmail.com>
Message-ID: <CAHk-=wj_29VY5rpchsw8NWz6=akW1Sgj9rYUtUmYvJAkbVa=3w@mail.gmail.com>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in restore_fpregs_from_user()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 3:12 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> It's not only about #MC. *RSTOR can also trigger #GP in case that the
> user buffer contains garbage and we clearly don't want to loop forever
> on that either.

Ok, that does seem to merit a the error code check.

Ugh. It leaves that #MC case for other random accesses, though.

         Linus
