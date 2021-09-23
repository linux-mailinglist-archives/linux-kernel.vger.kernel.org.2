Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B700415C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240418AbhIWKiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhIWKiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:38:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B253CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:36:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t28so2415173wra.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eMbiNurWfkJzojRgNNmqasqLNlJJs+jiiHsMdIwNVvs=;
        b=Mwn70RgnJsBKz3l3RmCUghBXc3LumiQmyrULnyQImLHG6yGPcLa87NYIu4vIKWpj+7
         HsmQt7OdQYRxnEZ7kD2gRlNXluGZtgsrFEtw24Cwh+mPOI9x9yKQPBAOU51SdlIKO8gV
         ms0imbOC38OgFS5Zir7zmafkscVxQqhxU5+r3RfAEkAh8DoslDTS2+te9bYpkJejTDr6
         Ta5NyqItGdg7krlS/sv6L4Vz4Ne+JFElZQUd+X+ZKbSF5GcmfoKvbgccKi5DxLF0ChtO
         Nq8UNXm4FEDGsxZKKhIIrH1YSmtmlAzfG83PlAvIBCzWFuGCR9x2xPnSkFoicK46yijm
         ewtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eMbiNurWfkJzojRgNNmqasqLNlJJs+jiiHsMdIwNVvs=;
        b=TLhQnMgz3kOpg0XEQLDFsvaXl7Zyj/2xqrbs0/qI1hKukhSmo8RU25CgSn1C+8hSLz
         SdVxmV3c1TDYaJFQlvPgQMrLR7EIe39aEXy+2rL7Br8jcLnA5FLFJ3Lm6+a7gdN55rZb
         92TKt49bZ56xZi/R195vCRqteqqATpSn3tFKGKEn/8CGBPm4a+Cm1oiqfl/Y1nrw8I/L
         EFahaYNVKzJcibaOtmWkz2RXLtjHAmyYugDI0DO0q3JkwKnb30ftg6LfdxO64u6jnIcO
         XsxhJhgWLvV7VBzk4EO62azTMFjhOGJNWCIweuKcZ9RuY36OmpVgQVtOZNeZlbMaZOU5
         nwCg==
X-Gm-Message-State: AOAM532ZhiBAmfJH15eC86rC/h+CbA3YM4WDa4d8vNxWBrrhT6ZL3m9j
        xP/HoEuXIRElL/wiN3PhJ3eAX65G4i2a5VqxJDaAxIzMSq2FKg==
X-Google-Smtp-Source: ABdhPJzzzFNBBTQmornwaObih+0At8/n2L7giwGym3fL/FkOZkJtM7I96eIKvv/VP5+qdPQ2rdvgL3j+CZLbStAfjJE=
X-Received: by 2002:a5d:688a:: with SMTP id h10mr4146098wru.331.1632393392871;
 Thu, 23 Sep 2021 03:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210923072716.913826-1-guoren@kernel.org> <6d7b1668c1f562a5ef426bb2519f9784@mailhost.ics.forth.gr>
 <CAAhSdy0YDP3Nk8N9fnrKgS+3Rjt=5tLCh20upmUGK9SK67nNvg@mail.gmail.com>
 <0861cc74d3886e685e9aa5d13ddcd781@mailhost.ics.forth.gr> <16de95480d279b086cf0c612461e4235@mailhost.ics.forth.gr>
 <CAAeLtUChjjzG+P8yg45GLZMJy5UR2K5RRBoLFVZhtOaZ5pPtEA@mail.gmail.com>
In-Reply-To: <CAAeLtUChjjzG+P8yg45GLZMJy5UR2K5RRBoLFVZhtOaZ5pPtEA@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 23 Sep 2021 16:06:21 +0530
Message-ID: <CAAhSdy33=4AWaYWT8P5iCrvTcoOEgwm1NgcxJCq53Pp6zzNruQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add RISC-V svpbmt extension
To:     Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc:     Nick Kossifidis <mick@ics.forth.gr>, Guo Ren <guoren@kernel.org>,
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

On Thu, Sep 23, 2021 at 3:38 PM Philipp Tomsich
<philipp.tomsich@vrull.eu> wrote:
>
> On Thu, 23 Sept 2021 at 11:48, Nick Kossifidis <mick@ics.forth.gr> wrote:
> >
> > =CE=A3=CF=84=CE=B9=CF=82 2021-09-23 12:42, Nick Kossifidis =CE=AD=CE=B3=
=CF=81=CE=B1=CF=88=CE=B5:
> > > =CE=A3=CF=84=CE=B9=CF=82 2021-09-23 12:37, Anup Patel =CE=AD=CE=B3=CF=
=81=CE=B1=CF=88=CE=B5:
> > >> On Thu, Sep 23, 2021 at 2:55 PM Nick Kossifidis <mick@ics.forth.gr>
> > >> wrote:
> > >>>
> > >>> Hello Guo,
> > >>>
> > >>> =CE=A3=CF=84=CE=B9=CF=82 2021-09-23 10:27, guoren@kernel.org =CE=AD=
=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
> > >>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > >>> b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > >>> index e534f6a7cfa1..1825cd8db0de 100644
> > >>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > >>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > >>> @@ -56,7 +56,9 @@ properties:
> > >>>       enum:
> > >>>         - riscv,sv32
> > >>>         - riscv,sv39
> > >>> +      - riscv,sv39,svpbmt
> > >>>         - riscv,sv48
> > >>> +      - riscv,sv48,svpbmt
> > >>>         - riscv,none
> > >>>
> > >>> Isn't svpbmt orthogonal to the mmu type ? It's a functionality that
> > >>> can
> > >>> be present on either sv39/48/57 so why not have another "svpbmt"
> > >>> property directly on the cpu node ?
> > >>
> > >> Actually, "mmu-type" would be a good place because it's page based
> > >> memory attribute and paging can't exist without mmu translation mode=
.
> > >>
> > >> Also, "svpmbt" is indeed a CPU property so has to be feature
> > >> individual
> > >> CPU node. Hypothetically, a heterogeneous system is possible where
> > >> some CPUs have "svpmbt" and some CPUs don't have "svpmbt". For
> > >> example, a future FUxxx SoC might have a E-core and few S-cores
> > >> where S-cores have Svpmbt whereas E-core does not have Svpmbt
> > >> because it's an embedded core.
> > >>
> > >
> > > I should say cpuX node, not the root /cpu node. We can have an svpbmt
> > > property in the same way we have an mmu-type property.
> > >
> >
> > I'm also thinking of future mmu-related extensions, e.g. what about
> > svnapot ? Should we have mmu-type be riscv,sv39,svnapot and e.g.
> > riscv.sv39,svpbmt,svnapot ? It'll become messy.
>
> How if we expand this to a mmu subnode in cpu@x and add a booleans for
> adornments like svnapot and svpbmt?
>
> The older mmu-type could then treated to indicate a mmu w/o any adornment=
s
> specified.  I am aware that this generates an additional parsing-path
> that will be
> maintained, but it will allow future properties to be grouped.
>
> This could like like the following:
>
>   cpu@0 {
>     ...
>     mmu {
>        type =3D "riscv,sv39";
>        supports-svpbmt;
>     }
>     ...
>   }

This is better but we will have to support the old "mmu-type" DT
property as well because we can't break compatibility in DT bindings.

Regards,
Anup
