Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51F6415B92
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 11:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbhIWJ7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 05:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240306AbhIWJ7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:59:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92517C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 02:57:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t8so15549605wrq.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 02:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/MJxVwGRbg1XNHDbbmS7hPzYeAHYCJbwGGA7R+iY3hA=;
        b=Rp77Ru0njGFEMH0FEC1SblZEZxv6H00mID60x2gBAsJXZsrh3KOWU8rPHIOlVNxBL0
         3ZRq07ZNjG7wsnyn5XX1Vj3a9vaCJUJwobD5+UlkffYsIWfnnQeMK5yxqdiqNQeRsL2O
         09GrDGKL3ImHMcs9KuFU7AEzX4ooYNtIn9Z8EkjjOMTSH9PuRo6HZzpQOPDmhmJTRl8y
         vlaMq0VUzrNFcZaxefQrMcXHfROfCFKkds0IHSgjQ6llIwKNUUBLZ9xu9tZlevAUMcYi
         03o+Rh4xWL57/dR4nVffQ6PU3YPqSRjsmyWL79WjrCkLQO1sWH4ChWmPmhmS1pdn9qcd
         ss4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/MJxVwGRbg1XNHDbbmS7hPzYeAHYCJbwGGA7R+iY3hA=;
        b=g/bqa1WEBMnMGA/jxVpsVsx9CHRtTlaDGdjlY7myk8t5qBSBCpwDceBy+1iCRDIjKW
         LjRPUPxY1MOfEVLxJ7Su8qfBRS7nhig/wHNGMaCKik5IOtXxfGyVW5gbXHi1zWfBIzbd
         ekblpxAUv6AVMHYy5jMjx5sUgcodl/b4Hf4pHglLcSNVqmomrJVRVlADjqVuFYj6BU/a
         p++bVENPUkDrvJkotxCh52A9iFdIOsl3TlNN9vm0KRydpJ7VouPE29VQwZ+6s3yGhLy4
         zULbjtlIz7DYl80JFyOXdNgvTlzR9wBUmGQRmFbo8n4FamjOJZ/0tFOmWGQGvldACETJ
         a6dw==
X-Gm-Message-State: AOAM533+xCq2fgvV1djYViAzPvkajRG8uOFRpVZQZhMRn6mbV2aWfJi9
        SHwT0/aNbvY7vEzvTxVuno2a+XQTmiklcWYZQ2v/zQ==
X-Google-Smtp-Source: ABdhPJy429633mcPj36zJ+Apb9XpxpDQLWxLxkJL3gUdR5i+aJK8o3tcCu6K6BPmar7CN6QU26qCVhqSRQj03KrWFPA=
X-Received: by 2002:a1c:4d01:: with SMTP id o1mr3471606wmh.61.1632391066056;
 Thu, 23 Sep 2021 02:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210923072716.913826-1-guoren@kernel.org> <6d7b1668c1f562a5ef426bb2519f9784@mailhost.ics.forth.gr>
 <CAAhSdy0YDP3Nk8N9fnrKgS+3Rjt=5tLCh20upmUGK9SK67nNvg@mail.gmail.com>
 <0861cc74d3886e685e9aa5d13ddcd781@mailhost.ics.forth.gr> <16de95480d279b086cf0c612461e4235@mailhost.ics.forth.gr>
In-Reply-To: <16de95480d279b086cf0c612461e4235@mailhost.ics.forth.gr>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 23 Sep 2021 15:27:34 +0530
Message-ID: <CAAhSdy0eu4-iABvTnyU6HSxqbC7d--is3iZfU7Css9KWd_HTYA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add RISC-V svpbmt extension
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Guo Ren <guoren@kernel.org>, Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
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

On Thu, Sep 23, 2021 at 3:18 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
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

I agree, "mmu-type" can become longer in future but I was thinking
if all MMU related features can simply be comma-separated values
of one DT property.

Alternately, we can have "riscv,svpmbt" bool DT property in each
CPU node which will keep things simpler as compared to parsing
comma-separate string in "mmu-type" DT property.

Regards,
Anup

>
> Regards,
> Nick
