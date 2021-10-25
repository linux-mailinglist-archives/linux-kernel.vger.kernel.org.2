Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBEE438F25
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhJYGLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhJYGLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:11:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C85A61073
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 06:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635142172;
        bh=ZPPzxfjbR+mfJDK5TtOWY4ucM9+GEi+ARIcc/M7V0uw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fOk8LNlo6H77I3KYJDz7nOeVRLxus5wch0xE6Lu1VIOdULr0rlGqO5HGinpl243KT
         dRbedKHzilgT+hb21cwEixG2ndrOO+QqVlkKgK+sm1Xxd0fdElfmXy0c/4GhegJPiU
         q2TOcypGJu1hbKOvlRuNAJtl0rX3OEtCM8a8vjDMIqLQ2jlRQyO++61lC4XcK0C3WV
         voLKFCK1bztZtzsqDmCwCNpBTyQAN3Fw9+pFdccoViLT3mVOQKgGGjvI4s2GfaFnDb
         R+aDeCHhJLMvViDJysxd98Js9PLjSWIoZwuWAa/6/YcZrCX11XB+qviY4O+SgKSY+t
         qnnareQGYAB3w==
Received: by mail-ua1-f42.google.com with SMTP id b4so7677012uaq.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 23:09:32 -0700 (PDT)
X-Gm-Message-State: AOAM533tsCgBBJiiNA+SdWe2sK/MrW0NkWMfsZKo9z/4qS8jKI9wqjSF
        Lb3wssgYAOFUc7NonNY0BI4Z3h3o0PEvFLSbuQg=
X-Google-Smtp-Source: ABdhPJxK0iXo2bm0rsM4SbUtDFJlB+Z2ri93um5z6gjaYl4w+hpAQeIaaSZ2BpRAyrb0jhGiAodHX5oWzTUoWMNdTOI=
X-Received: by 2002:a67:ca1c:: with SMTP id z28mr12857215vsk.11.1635142171258;
 Sun, 24 Oct 2021 23:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211025040607.92786-1-wefu@redhat.com> <20211025040607.92786-2-wefu@redhat.com>
In-Reply-To: <20211025040607.92786-2-wefu@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 25 Oct 2021 14:09:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRn2USuN+jdVjC-8Ug2hXZWCbzVues5_B8-P1wM9KvYhA@mail.gmail.com>
Message-ID: <CAJF2gTRn2USuN+jdVjC-8Ug2hXZWCbzVues5_B8-P1wM9KvYhA@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 1/2] dt-bindings: riscv: add mmu-supports-svpbmt
 for Svpbmt
To:     Wei Fu <wefu@redhat.com>
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        "Xinhaoqu (Freddie)" <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 12:06 PM <wefu@redhat.com> wrote:
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
We need a "type: boolean" here.

ref: Documentation/devicetree/bindings/serial/8250.yaml
  used-by-rtas:
    type: boolean
    description: |
      Set to indicate that the port is in use by the OpenFirmware RTAS and
      should not be registered.

> +    description:
> +      Describes the CPU's mmu-supports-svpbmt support
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
