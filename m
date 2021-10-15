Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547EF42F83C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241408AbhJOQeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241386AbhJOQeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:34:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36B6361245;
        Fri, 15 Oct 2021 16:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634315519;
        bh=Jmc4W5XlxGxY2LFigXZkPqtUcluVcFYpogIjPlqF/7g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tANHC8vauO8UwCq3eZBHC+1Bbvrev4NAiS01KKx+AW2nudMo2euJL9qDrqDsjAWm7
         8wcg8iweg4D35CFyWr3VpSsxbwjQFIXK2aUm6ACt0v+iLMcT9lcvllBFpJOiVN9cAm
         9YWwZwM9/xztrTRuIMnjtIwq4ZKJgu0yzl/IJGSKw1i5ucu8SOKTS1EznMA7mZ/aMK
         7tkv3Mf+uWTCDcZZSPVfyNu/Qr1D+5APizTnQ1Wok7CXzZ6OsNFXY1iUY+XmIxwGvK
         omJMC1wv0BB84hzQHmZW68BwTdfLsadjXwEsWkh4FHl91KtKhmAV5CVlEXCfp4tQwG
         t6lgeBvthT/eQ==
Received: by mail-ed1-f46.google.com with SMTP id r18so40415174edv.12;
        Fri, 15 Oct 2021 09:31:59 -0700 (PDT)
X-Gm-Message-State: AOAM531UX/XmFTI+u+q4skAOKotTysaOQzhO3ErxMoF6n3UgSDU+mghB
        NoDoP73dyAwhdjwhW5vsq7UmGXPR1Lv02ZENqw==
X-Google-Smtp-Source: ABdhPJzgJwR5w3qmrgz+cqGYeLEFxDU1gqO3ezp6X+Y2gF0uOKhbfhUzbqdZyXGHy+MrtBfx0kbUvOR1l0y4TTHvScU=
X-Received: by 2002:a05:6402:84d:: with SMTP id b13mr19440726edz.6.1634315517635;
 Fri, 15 Oct 2021 09:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211013220532.24759-1-agust@denx.de> <20211013220532.24759-5-agust@denx.de>
In-Reply-To: <20211013220532.24759-5-agust@denx.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 15 Oct 2021 11:31:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLW=6AuKKT5cA0RYhgg268O9yiZRLuKh7HK3i_N24wWGA@mail.gmail.com>
Message-ID: <CAL_JsqLW=6AuKKT5cA0RYhgg268O9yiZRLuKh7HK3i_N24wWGA@mail.gmail.com>
Subject: Re: [PATCH 4/4] powerpc/5200: dts: fix localbus node warnings
To:     Anatolij Gustschin <agust@denx.de>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 5:05 PM Anatolij Gustschin <agust@denx.de> wrote:
>
> Fix build warnings like:
> localbus:ranges: 'oneOf' conditional failed, one must be fixed
> ...
> Warning (unit_address_vs_reg): /localbus: node has a reg or ranges property, but no unit name
> Warning (simple_bus_reg): /localbus/flash@0,0: simple-bus unit address format error, expected "0"
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
>  arch/powerpc/boot/dts/a3m071.dts    | 12 +++++-----
>  arch/powerpc/boot/dts/a4m072.dts    | 20 ++++++++---------
>  arch/powerpc/boot/dts/charon.dts    | 14 ++++++------
>  arch/powerpc/boot/dts/cm5200.dts    |  7 ++++--
>  arch/powerpc/boot/dts/digsy_mtc.dts | 16 ++++++++------
>  arch/powerpc/boot/dts/lite5200.dts  |  4 ++--
>  arch/powerpc/boot/dts/lite5200b.dts |  6 +++--
>  arch/powerpc/boot/dts/media5200.dts | 20 +++++++++--------
>  arch/powerpc/boot/dts/motionpro.dts | 32 +++++++++++++++------------
>  arch/powerpc/boot/dts/mpc5200b.dtsi |  2 +-
>  arch/powerpc/boot/dts/mucmc52.dts   | 34 +++++++++++++++--------------
>  arch/powerpc/boot/dts/o2d.dts       | 10 +++++----
>  arch/powerpc/boot/dts/o2d.dtsi      | 12 +++++-----
>  arch/powerpc/boot/dts/o2d300.dts    | 10 +++++----
>  arch/powerpc/boot/dts/o2dnt2.dts    | 10 +++++----
>  arch/powerpc/boot/dts/o2i.dts       |  4 ++--
>  arch/powerpc/boot/dts/o2mnt.dts     |  4 ++--
>  arch/powerpc/boot/dts/o3dnt.dts     | 10 +++++----
>  arch/powerpc/boot/dts/pcm030.dts    |  2 +-
>  arch/powerpc/boot/dts/pcm032.dts    | 26 ++++++++++++----------
>  arch/powerpc/boot/dts/tqm5200.dts   |  4 ++--
>  arch/powerpc/boot/dts/uc101.dts     | 14 +++++++-----
>  22 files changed, 151 insertions(+), 122 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/a3m071.dts b/arch/powerpc/boot/dts/a3m071.dts
> index 034cfd8aa95b..14e59aaa0ba7 100644
> --- a/arch/powerpc/boot/dts/a3m071.dts
> +++ b/arch/powerpc/boot/dts/a3m071.dts
> @@ -87,15 +87,15 @@
>                 };
>         };
>
> -       localbus {
> +       localbus@80000000 {

That's not right, as 0x80000000 doesn't exist in 'reg' or 'ranges'.
Without 'reg', the correct unit-address is 'fc000000'.  Perhaps there
should be a 'reg' entry though.

>                 compatible = "fsl,mpc5200b-lpb","simple-bus";
>                 #address-cells = <2>;
>                 #size-cells = <1>;
> -               ranges = <0 0 0xfc000000 0x02000000
> -                         3 0 0xe9000000 0x00080000
> -                         5 0 0xe8000000 0x00010000>;
> +               ranges = <0 0 0xfc000000 0x02000000>,
> +                        <3 0 0xe9000000 0x00080000>,
> +                        <5 0 0xe8000000 0x00010000>;
>
> -               flash@0,0 {
> +               flash@0 {

This change is debatable. Normally, if we have chipselects, then
that's a separate field and a comma is appropriate. However, h/w with
chip selects require setup and aren't a simple-bus. I guess the
bootloader does the setup, so kind of a gray area.

The warning for this is off by default, so I'd leave it alone.

Rob
