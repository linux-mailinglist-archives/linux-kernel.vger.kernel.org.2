Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C15438E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 06:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhJYEUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 00:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhJYEUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 00:20:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D48C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 21:17:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m22so6970359wrb.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 21:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hmyJ+fxOvQKNEomi44KNz6W2UiehRKi6Y9dBpWtAWIM=;
        b=5mmlEeDRAHXnBXiGOM1olXR4Obsou6PuzN3/DjkySxTLtMrDreHK+SoKNV6Hc0+Zc8
         b6U+EtHoTOs5fykLFtvNtn6HrDTt/eqqOTK8NflNa5p+3GR40kc5qlGtRSUDHTpeYVg3
         2Vqgj1DZXnkFeDVK/utQSeiwf2YejSJeGgwWni/TAe9bZeTBysdw4CUEMZbqLRh39md0
         VlCPrHAssmnybfCmpvwzKQFI3OcfBWBPFSRnifB/65uX80gUQN6C11fwCB/3jmEsW0ho
         BtZTfR93p2GpxgeHtaRBb/jZPB5OM9WFXalZOySItkooS3fGRZtaLzwTCcEpHBUyKGXy
         e35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hmyJ+fxOvQKNEomi44KNz6W2UiehRKi6Y9dBpWtAWIM=;
        b=LQ59I+fs/NRA2MUlUvl9/T6o7xJPMm19WbdKsu2105mRLoc23j1Y64cmFia7rKHz8v
         g1fJZ+RigYYAFul+EwToJtpFeF35mO+pFG6d4VsMgIENLAuOb+A4BaT2RGCN8HFgIvsc
         flqENVgGpM5BTYywfzVqQNbzgv3wnYEKh17Nh2ct0nh/eK/LCnUdpSOQ0KKkt0wJPQQJ
         PB9QDndo7cH0/wPPZ9LujB+JnanXNXgI+Xb68h6qkHUB2Qt7GyVlILmR+DPfXhuBhcPZ
         6Hh96lR7oR2YIqqa75VrWsEqA9/JaApHm7ZrpCHBU8Ka5JnfsWd3a7NPptvyPWWfGYgC
         gH8g==
X-Gm-Message-State: AOAM533ZsuwU0/konrekkJZ+I1AxAIjcvPnFD9ngUeeKbmQSgm4FpLbz
        otlUsycn7Pr4dCED7LrFmJ845tU5DAAGkESlCIMzNA==
X-Google-Smtp-Source: ABdhPJxzC3VVjMq24dLsSc1rgpBgZeTWA+LOx570smHg/XMHtuHNwIss71RE7o30ztqQ9+IIIU47U4I9wzzuA1WYgjc=
X-Received: by 2002:adf:fa12:: with SMTP id m18mr15619002wrr.306.1635135467273;
 Sun, 24 Oct 2021 21:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211025040607.92786-1-wefu@redhat.com> <20211025040607.92786-2-wefu@redhat.com>
In-Reply-To: <20211025040607.92786-2-wefu@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 25 Oct 2021 09:47:34 +0530
Message-ID: <CAAhSdy1N-UQFnbFc7PSwf62y=gbvX7pK=vwUaG8m_KzdWx3AgQ@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 1/2] dt-bindings: riscv: add mmu-supports-svpbmt
 for Svpbmt
To:     Wei Fu <wefu@redhat.com>
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Guo Ren <guoren@kernel.org>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com,
        Aniket Ponkshe <aniket.ponkshe@canonical.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Gordan Markus <gordan.markus@canonical.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 9:36 AM <wefu@redhat.com> wrote:
>
> From: Wei Fu <wefu@redhat.com>
>
> Previous patch has added svpbmt in arch/riscv and changed the
> DT mmu-type. Update dt-bindings related property here.
>
> Signed-off-by: Wei Fu <wefu@redhat.com>
> Co-developed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index e534f6a7cfa1..76f324d85e12 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -59,6 +59,11 @@ properties:
>        - riscv,sv48
>        - riscv,none
>
> +  mmu-supports-svpbmt:
> +    description:
> +      Describes the CPU's mmu-supports-svpbmt support
> +    $ref: '/schemas/types.yaml#/definitions/phandle'

There were various proposals from different folks in the previous
email threads.

I think most of us were converging on:
1) Don't modify "mmu-type" DT property for backward
compatibility
2) Add boolean DT property "riscv,svpmbt" under
"mmu" child DT node of each CPU DT node. Same will apply
to boolean DT property "riscv,svnapot" as well.

We also have bitmanip and vector broken down into smaller
extensions so grouping related extensions as separate DT node
under each CPU node will be more readable and easy to parse.

Regards,
Anup

> +
>    riscv,isa:
>      description:
>        Identifies the specific RISC-V instruction set architecture
> --
> 2.25.4
>
