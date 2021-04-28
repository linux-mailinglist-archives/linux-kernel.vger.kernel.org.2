Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800BF36DF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 21:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbhD1TWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 15:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhD1TWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 15:22:36 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E1CC061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 12:21:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n2so96264642ejy.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 12:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcj8vNPDk3FDhQ6clAy/SNYeBodSqFbI83mzXpZ8R+c=;
        b=ZCAnPCt1x6Rv2yKO1xiKn4fveq4YaByb553kQuEjX5P6ohkXQk1exlrpNXu4/uaRDb
         5DRR35ghiC2+rkENnSiAlnmVEImxq0wZEIO68vyDgnCm63JOFsbaDuGqdU6jaR/Xkfrb
         4ZqLogKE07dRK6kPaYOed7VoQnd57iRDqZL8oQLX0KfM4JesY7NfJeDHyVc+Ii3cdCua
         pTG7Ur7e05b70UK6IQo7rDf9h5SO88BiUCTpteQTLkHeR4C2IjWsaeAv6N6asbaqjviz
         R7bPVm0yNoyQPjiIdyJ6oxSQJHzhKAMSE4e3Zaptxkw8sn2fbiw3X+R5+1Wbng4OpJbl
         /+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcj8vNPDk3FDhQ6clAy/SNYeBodSqFbI83mzXpZ8R+c=;
        b=Lzf1FUvGglnhwEE/ZctNkywXQIe5seWA1njC31+bdqiByu9dArUnlyDU0uQGTONRj1
         FuMQD8IgamedXv+6bmwnFmdPYLQXGw9BqWVgVIGzDCahgr01fnMD/c5418ZMwst4B+bE
         2IJ6aM3k1hDDvucV2wCK1KphSfkcFZL+Fzqb4pKLG525QbLouKtfYrnZuKYhZWnyeQH6
         FN3Jub0diN1mIgUw9/JxC4QL8At3t37OjPlwPdPZMTqpTE+f4TozGbUUviNdbshUdbbM
         b5P9iayXDoFIQFE42oKCK7lkZzf8IyLFc25a+bYGN2DshvtRPA3S2xQpdnhV45cakCbU
         /yfA==
X-Gm-Message-State: AOAM532Us3iFXwgYrzPsD4qL7/hCm0zJZQuSgzTOL0c+fLXs1lmKHdlc
        5aSmcgQtrdX0DL+kExTbN/9+wOV9dD0ysPThTmBV
X-Google-Smtp-Source: ABdhPJzGpEOneJaVW4PIyyqelG6nvAwMa8da598rUXH8ftOLZAFN9iAIYRbhdJM5ZeOpO7jspXxQ/DgEv0RXPxSF8Bw=
X-Received: by 2002:a17:906:b2cd:: with SMTP id cf13mr31564448ejb.419.1619637709726;
 Wed, 28 Apr 2021 12:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210423205159.830854-1-morbo@google.com> <20210428172847.GC4022@arm.com>
 <20210428174010.GA4593@sirena.org.uk>
In-Reply-To: <20210428174010.GA4593@sirena.org.uk>
From:   Bill Wendling <morbo@google.com>
Date:   Wed, 28 Apr 2021 12:21:38 -0700
Message-ID: <CAGG=3QUATefn9AG+HvnCfEOBv3iRu4fzFwfmA7Djrh2CmP_weA@mail.gmail.com>
Subject: Re: [PATCH] arm64/vdso: Discard .note.gnu.property sections in vDSO
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Daniel Kiss <Daniel.Kiss@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 10:40 AM Mark Brown <broonie@kernel.org> wrote:
> On Wed, Apr 28, 2021 at 06:28:47PM +0100, Catalin Marinas wrote:
> > On Fri, Apr 23, 2021 at 01:51:59PM -0700, Bill Wendling wrote:
>
> > > Since the note.gnu.property section in the vDSO is not checked by the
> > > dynamic linker, discard the .note.gnu.property sections in the vDSO.
>
> > Can we not instead fix the linker script to preserve the
> > .note.gnu.property, correctly aligned? It doesn't take much space and
> > while we don't use it now, it has the BTI information about the binary.
>
> > Cc'ing a few others who were involved in the BTI support.
>
> Not just BTI, we also flag PAC usage in there too and could add other
> extensions going forwards.  While the note isn't actively used by
> anything right now due to the kernel mapping the vDSO prior to userspace
> starting it is part of the ABI and something could end up wanting to use
> it and getting confused if it's not there.  It would be much better to
> fix the alignment issue.

If there's only one of the 8-byte aligned sections guaranteed, we
could place it first in the note. Otherwise, we will have to change
the alignment of the note (or somehow merge multiple notes).

-bw
