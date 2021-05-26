Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDC9391CE0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 18:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhEZQW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 12:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbhEZQW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 12:22:27 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C833C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 09:20:55 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id p20so2406203ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ACs5Rl3DK1N4Ca+Pvr9cXnCEW3IY2qw+ccZrCgkzOc0=;
        b=As/2EqTLCKJ/yJKNqg6zFE3a4KWtp3I6DT9rwcOBWk0BG9M9E4AaRHfSFlFkxoPq1S
         F6X1LxGOWzW+8q5INftO97YwmeuJpMll+/kl4Y8yBLfn49m3AFnLnR3iiar+mfkrszCr
         SKydZyoiTnlmh/L9UEtI9nz9lGoeK0l1PEI6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACs5Rl3DK1N4Ca+Pvr9cXnCEW3IY2qw+ccZrCgkzOc0=;
        b=T4XNW0mOHQ7V5q+9Pwo+yD6w+jPmvU4qJTGrJ12TMYQWeYxeXBYwgu9M5LwD3IYCjL
         7uCA/lV81ytnxjry9mgdJtlf7nDkzBmj2BDCGs82IpyPK1IsySyL3rQ1E2azPUI6bYHg
         iXfeEZsDy1MJOb2t5PJ7N7nTZzbqX1t4x3Iw3e7R8PAZg7VPf0soyjiCFy/6Qk+U1n3p
         uQ64hWCdlt2JhqWcgW7IhQALEDdhb5tWDonw+4u5Rnta0Qq5/cJNMF2f0+0esmzwdeNE
         MdNKiv59xeNC4A0eLnrmRDKB/6EygpwnbwaDx4FOuE6gOJmWNTagrFa1yPB/jOGpcrsL
         cwLg==
X-Gm-Message-State: AOAM532wrEm+gaQJDK7Gx1FIsA5tjxQv1ZH2zWlvurmauqCylmLUwQfU
        atsIwtRDuNbE1s0dk9E+E20tFcnpTc39FVfo
X-Google-Smtp-Source: ABdhPJza8SYb6lQK3A3BbfbXr7FUNcdhopEYfn1lvpFrkwgCea84JquoQanSxuiMfenmgfzygN9fWg==
X-Received: by 2002:a05:651c:b28:: with SMTP id b40mr2895081ljr.9.1622046052877;
        Wed, 26 May 2021 09:20:52 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id w23sm2628325ljh.126.2021.05.26.09.20.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 09:20:52 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id w7so2417048lji.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 09:20:51 -0700 (PDT)
X-Received: by 2002:a2e:b04c:: with SMTP id d12mr2814321ljl.465.1622046051160;
 Wed, 26 May 2021 09:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210526175924.4f9ab124@xps13>
In-Reply-To: <20210526175924.4f9ab124@xps13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 May 2021 06:20:35 -1000
X-Gmail-Original-Message-ID: <CAHk-=wh_ZHF685Fni8V9is17mj=pFisUaZ_0=gq6nbK+ZcyQmg@mail.gmail.com>
Message-ID: <CAHk-=wh_ZHF685Fni8V9is17mj=pFisUaZ_0=gq6nbK+ZcyQmg@mail.gmail.com>
Subject: Re: [GIT PULL] mtd: Changes for v5.13-rc4
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 5:59 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Raw NAND:
> * txx9ndfmc, tmio, sharpsl, ndfc, lpc32xx_slc, fsmc, cs553x:
>   - Fix external use of SW Hamming ECC helper

Why are these guys all pointlessly duplicating the ecc wrapper
functions for their ecc 'correct' functions?

The whole "the Hamming software ECC engine has been updated to become
a proper and independent ECC engine" excuse makes no sense. If
multiple chips just want a basic sw hamming helper, then they should
have one. Not have to be forced to each write their own pointless
wrapper like this.

These chip drivers just want 'ecc_sw_hamming_correct()' with the
proper arguments, and it seems entirely wrong to duplicate the helper
five times or whatever. There should just be a generic helper - the
way there used to be.

In fact, I would generally strongly recommend that if there used to be
a generic helper that different chip drivers used (ie the old
rawnand_sw_hamming_correct()), then such a helper should be left alone
and not change the semantics of it.

The new "proper independent ECC engine" that had new semantics should
have been the one that got a new name, rather than breaking an old and
existing helper function and then making the chip drivers pointlessly
write their own new helper functions.

I've pulled this, but under protest. The patch honestly just looks
like mindless duplication.

               Linus
