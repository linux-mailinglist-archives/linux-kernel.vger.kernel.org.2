Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2DB3A9E08
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhFPOuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233914AbhFPOuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:50:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E00D560C41;
        Wed, 16 Jun 2021 14:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623854878;
        bh=qwFzlNJ04k6sHwdqK2lPHiFKDvUxsyrimKNVrLGVNus=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BW+O+K34ZrUlK3Qeyn1xh0qNXfJmlW6xGP+wjvLG+7fob198unv8919jWdLy35gco
         ECRpvSzZ1bsY415puegBVgstUjnypUyWHzIqXOe+4HutPZP597VMWdAOlXoZPL2JDV
         GTKcVqqdXLN9ZguRSwz40nhavI2fcRTyxDoYBLUV+47L0XTmgKIS2oJugcc6V+HrbU
         bsOXdW53Kb7JUmF1+XINpSL5LOdBxHWowya5AyS8NxPHbiJg9OVqFv3vVDTIkpHgjS
         PggFG+CivK2OrxvEeGjmt0hvzf/GvxbMhQND0H3IfXkihosQuXcPvPInxSyS7yGqln
         Axrk1ck0c877g==
Received: by mail-ed1-f54.google.com with SMTP id z12so3089136edc.1;
        Wed, 16 Jun 2021 07:47:58 -0700 (PDT)
X-Gm-Message-State: AOAM533/MGi4yHA0oQFui/kmIxopqmZ6uiI3EGxf65qxg3ilzqrhCFA9
        j+nk/ZABHnfcmShBwdETySG/tZctN9CClNW0ag==
X-Google-Smtp-Source: ABdhPJz6uzVahBrIhJvzhgaD8yThinebto90daMlvuqzzG4qQ4bE0zduK+dYUvSlcpZgFhisvC9dMBrri3xqlqei3zU=
X-Received: by 2002:aa7:dc4c:: with SMTP id g12mr4860375edu.258.1623854877530;
 Wed, 16 Jun 2021 07:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623780059.git.geert+renesas@glider.be> <bcc5c666f4ada9a8bbc26f559751f0da67f769f8.1623780059.git.geert+renesas@glider.be>
 <abadee118c1945c44d9bff7675b12ec4@mailhost.ics.forth.gr> <CAL_JsqLU7GWDxdnR2-Yd2vbj7w=5pNr_fFocDQgPbs17EpBG0g@mail.gmail.com>
 <bdfbf7cc997a10a94331d77332dbe88e@mailhost.ics.forth.gr> <CAMuHMdVRcN+y0kwxxEH8UGo6bRT9SvxRSLU8VzWJFx=yLQ5S0g@mail.gmail.com>
 <ef1a9a97e0238a0ff2d8e044487602a5@mailhost.ics.forth.gr>
In-Reply-To: <ef1a9a97e0238a0ff2d8e044487602a5@mailhost.ics.forth.gr>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 16 Jun 2021 08:47:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKJgz=ixNAJProoVFmQXGEOsTYX=bXTdtf7RLQErL1VRg@mail.gmail.com>
Message-ID: <CAL_JsqKJgz=ixNAJProoVFmQXGEOsTYX=bXTdtf7RLQErL1VRg@mail.gmail.com>
Subject: Re: [PATCH 2/3] riscv: Remove non-standard linux,elfcorehdr handling
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 4:43 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2021-06-16 10:56, Geert Uytterhoeven =CE=AD=CE=
=B3=CF=81=CE=B1=CF=88=CE=B5:
> >
> > I can't comment on the duplication on arm64, but to me, /chosen
> > sounds like the natural place for both "linux,elfcorehdr" and
> > "linux,usable-memory-range".  First rule of DT is "DT describes
> > hardware, not software policy", with /chosen describing some software
> > configuration.
> >
>
> We already have "linux,usable-memory" on /memory node:
> https://elixir.bootlin.com/linux/v5.13-rc6/source/drivers/of/fdt.c#L1011
> and it makes perfect sense to be there since it overrides /memory's reg
> property.
>
> Why define another binding for the same thing on /chosen ?

Go look at the thread adding "linux,usable-memory-range". There were
only 35 versions of it[1]. I wasn't happy with a 2nd way either, but
as I've mentioned before we don't always have /memory node.

Rob

[1] https://lore.kernel.org/linux-arm-kernel/20170403022606.12609-1-takahir=
o.akashi@linaro.org/
