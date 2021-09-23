Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45EF415BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240316AbhIWKJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbhIWKJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:09:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9583BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:08:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d21so15462563wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull-eu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i7IsEz0+TmFkryE0xyDQDEXuyo40G1KZMcgl/iAYgo4=;
        b=q2W+u1f2RRvpTmOehNT9mdT9VyMO5bHBoZ7RGb1K94+Qtr1Ba+ju3E5g3rJq6SXDaa
         myQ3hGatvAFK1KPtzux15zrB34XK2sBlweuBw/L2F9EpW6dm71BrCx/IkKbIXOYOkCT4
         PHWbSlBxe1QerHRWGudBQ1FteEWKb5HLgmvRydXFxKC7FOA2DYS7OtMBJ1lASGeisr81
         KGmfYS7SDcpygf0GzIFuIfbiKUYoCCkrpdNkZWiauSP+6ajDm2/5azk2axruxStN0FLU
         l5r0tw/TJ/sssCpV3CpAfn1bfdyFwKapBVSkIVNXkmRSh6MHsACHni44GO3gHnp4ljq4
         j0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i7IsEz0+TmFkryE0xyDQDEXuyo40G1KZMcgl/iAYgo4=;
        b=nAws47/aerTCjq3tMJqfrx48SxCNt7/NqW07owYLfBzhxkRhboCNXJj243f4LmJHag
         0TRNWpxD4RQX81YvHiqr1zi5kJhOytyfhDp8N3lhTTkzBo+ydBCmfaJsmiHRrqm2Fnhg
         /PB3e6xTvRecv/IbIyf6TQRtRH+lwG89IKVIn61IzFp7gELrScW4wDXwY3i2RRET2dpt
         LVJmh0qNmJEzowoxzKyI36ypec3hlpeqj1U2djSCvezAYN3M1LbTdAwu8i4U/1dmCWCV
         /nhWp5AE0pRPsL+gxCxImvkTz3TACBi6PaKL7gA6ySG4gQa24KfalsTtkXwiB/uwlAZ8
         MMsg==
X-Gm-Message-State: AOAM532yW/vXlMPHpcQgcdUmbONywj2fcClmD9yAgCBqqOkqsgDqakZO
        /AIFuqRpK8UR3Mc0HpltPqk4QQng2qNeov0sEl1yyg==
X-Google-Smtp-Source: ABdhPJwGNrmZBdCaAuiMHYcDdjm8dp+KCSXZu2axXhUghWj03xWT691jPsqVIga9dNDPzUfTnoHhAPw+J3qSWXCfqa4=
X-Received: by 2002:adf:eec3:: with SMTP id a3mr4191548wrp.276.1632391686063;
 Thu, 23 Sep 2021 03:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210923072716.913826-1-guoren@kernel.org> <6d7b1668c1f562a5ef426bb2519f9784@mailhost.ics.forth.gr>
 <CAAhSdy0YDP3Nk8N9fnrKgS+3Rjt=5tLCh20upmUGK9SK67nNvg@mail.gmail.com>
 <0861cc74d3886e685e9aa5d13ddcd781@mailhost.ics.forth.gr> <16de95480d279b086cf0c612461e4235@mailhost.ics.forth.gr>
In-Reply-To: <16de95480d279b086cf0c612461e4235@mailhost.ics.forth.gr>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Thu, 23 Sep 2021 12:07:55 +0200
Message-ID: <CAAeLtUChjjzG+P8yg45GLZMJy5UR2K5RRBoLFVZhtOaZ5pPtEA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add RISC-V svpbmt extension
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        gordan.markus@canonical.com, Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sept 2021 at 11:48, Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2021-09-23 12:42, Nick Kossifidis =CE=AD=CE=B3=
=CF=81=CE=B1=CF=88=CE=B5:
> > =CE=A3=CF=84=CE=B9=CF=82 2021-09-23 12:37, Anup Patel =CE=AD=CE=B3=CF=
=81=CE=B1=CF=88=CE=B5:
> >> On Thu, Sep 23, 2021 at 2:55 PM Nick Kossifidis <mick@ics.forth.gr>
> >> wrote:
> >>>
> >>> Hello Guo,
> >>>
> >>> =CE=A3=CF=84=CE=B9=CF=82 2021-09-23 10:27, guoren@kernel.org =CE=AD=
=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
> >>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>> b/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>> index e534f6a7cfa1..1825cd8db0de 100644
> >>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>> @@ -56,7 +56,9 @@ properties:
> >>>       enum:
> >>>         - riscv,sv32
> >>>         - riscv,sv39
> >>> +      - riscv,sv39,svpbmt
> >>>         - riscv,sv48
> >>> +      - riscv,sv48,svpbmt
> >>>         - riscv,none
> >>>
> >>> Isn't svpbmt orthogonal to the mmu type ? It's a functionality that
> >>> can
> >>> be present on either sv39/48/57 so why not have another "svpbmt"
> >>> property directly on the cpu node ?
> >>
> >> Actually, "mmu-type" would be a good place because it's page based
> >> memory attribute and paging can't exist without mmu translation mode.
> >>
> >> Also, "svpmbt" is indeed a CPU property so has to be feature
> >> individual
> >> CPU node. Hypothetically, a heterogeneous system is possible where
> >> some CPUs have "svpmbt" and some CPUs don't have "svpmbt". For
> >> example, a future FUxxx SoC might have a E-core and few S-cores
> >> where S-cores have Svpmbt whereas E-core does not have Svpmbt
> >> because it's an embedded core.
> >>
> >
> > I should say cpuX node, not the root /cpu node. We can have an svpbmt
> > property in the same way we have an mmu-type property.
> >
>
> I'm also thinking of future mmu-related extensions, e.g. what about
> svnapot ? Should we have mmu-type be riscv,sv39,svnapot and e.g.
> riscv.sv39,svpbmt,svnapot ? It'll become messy.

How if we expand this to a mmu subnode in cpu@x and add a booleans for
adornments like svnapot and svpbmt?

The older mmu-type could then treated to indicate a mmu w/o any adornments
specified.  I am aware that this generates an additional parsing-path
that will be
maintained, but it will allow future properties to be grouped.

This could like like the following:

  cpu@0 {
    ...
    mmu {
       type =3D "riscv,sv39";
       supports-svpbmt;
    }
    ...
  }

Cheers,
Philipp.
