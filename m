Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D05D3E8663
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbhHJXVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbhHJXVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:21:44 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39344C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:21:21 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id a13so1217737iol.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vy5m00VfsLNO9CsS/oFazoccVf7Kpa1RZDcSI5G7BWw=;
        b=aZpqE3+Y1gZPTqxNXnVXtXvHj4UZ54QHWfI7DmXWaK1HC9h0Gd+UVa0LUaMcPqMqm+
         yzMRyBeQzdTt166dGCWwQA3LDZ5xuEXMnHhMnC3469v2G6jCHG+5SUWdmGBGwSBIP5w8
         cm6Fv14RB5keWd0AbuiNkJwxONtp+WAFhmpb4+Up7C40kb+pgRmQxBokDRWEhVXnTRvv
         Ev/1Z5/KlrBszpE+KySAnB4pmVlTQLawpe0VoLYDLpK+YLWy3pIJFsRjsEhQ04UejHJx
         OLAj0RGvkVA155UYgp61gxKP5oqPasR9OwEOVnMjOTn1weij+N0C6AAnNqvX3V7IO+bi
         uzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vy5m00VfsLNO9CsS/oFazoccVf7Kpa1RZDcSI5G7BWw=;
        b=IVtrUtPNkDNShX9e+39BId/+G8i+YYx39nNWKWsEYhYX0gebCHAOqsqaMTungtSNiO
         t3cUXeCrDYFIAcJlIsn01repuck8D2lm7aQnLfnIkmZUw/adJ+/z3DdPKl5JjIzkT7Eb
         BZqQYFZ1YCsOMvhs+z7AeqEtwMd1sh0AWNIgzleoFIvzXVufaVqdp7+ICbYa12+FHZrt
         xQMWjUlm2QOQaGKCB+N44WOw3ifYU2soVBkG8pBNIUcyR9aDeR4QElbYdhh16g1OsbfT
         rK+NoRDOFtDjzPOPszWADDqGApkhfyg6P+5b5NuojchL1HpT6nmOR6TbRB/5FAXydNe/
         2y+w==
X-Gm-Message-State: AOAM533DgU6XJaRJjVWbkOKw4NH6iO3v8YpoGoVCJfhu6pkrpUTn6K6R
        T2ZsLOW0xvJJCDentXQSPQTwe6su4TKCrUf7DEc=
X-Google-Smtp-Source: ABdhPJxRc5FrSsl0ufJpCk92nsSxqmFmQMmQwXbl+uwBKYL3hTBM/Sdmyll8CXcHPXFQLdK4B7BlahHr3hRtFlVDKqU=
X-Received: by 2002:a5e:da04:: with SMTP id x4mr606250ioj.199.1628637680751;
 Tue, 10 Aug 2021 16:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210810041630.3673406-1-art@khadas.com> <7dbba936-e8ab-4d47-1af8-0d3d1adb8c30@baylibre.com>
In-Reply-To: <7dbba936-e8ab-4d47-1af8-0d3d1adb8c30@baylibre.com>
From:   Art Nikpal <email2tema@gmail.com>
Date:   Wed, 11 Aug 2021 07:21:08 +0800
Message-ID: <CAKaHn9LWCHpAiO8siGmcOxA-FyurwE6x0T5_D7hwpVH72wScNw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: meson: add spdif out to khadas-vim
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>,
        Gouwa Wang <gouwa@khadas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> AFAIK the board doesn't have a physical SPDIF output, but one of the 40pin header can output SPDIF, right ?
Yes it's right

>In this case, following the other boards mainline definitions, we do not enable any function by default
For pins on the 40pin (or other programmable) headers.

ok ! now  i'm understand reason

But maybe it is possible to add this area as commented /* */
and users will have possibilities to uncomment  it.

> DT overlays
Yes but I still don't understand how-to apply dt overlays for EFI+grub
may be somebody can clarify this problem?

On Tue, Aug 10, 2021 at 3:55 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> On 10/08/2021 06:16, Artem Lapkin wrote:
> > Add spdif output audio support to khadas-vim
> >
> > Signed-off-by: Artem Lapkin <art@khadas.com>
> > ---
> >  .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts  | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> > index 60feac0179c0..01f13822a616 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> > @@ -64,6 +64,13 @@ hdmi_connector_in: endpoint {
> >               };
> >       };
> >
> > +     spdif_dit: audio-codec-0 {
> > +             #sound-dai-cells = <0>;
> > +             compatible = "linux,spdif-dit";
> > +             status = "okay";
> > +             sound-name-prefix = "DIT";
> > +     };
> > +
> >       sound {
> >               compatible = "amlogic,gx-sound-card";
> >               model = "KHADAS-VIM";
> > @@ -97,11 +104,21 @@ codec-0 {
> >                               sound-dai = <&hdmi_tx>;
> >                       };
> >               };
> > +
> > +             dai-link-3 {
> > +                     sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
> > +
> > +                     codec-0 {
> > +                             sound-dai = <&spdif_dit>;
> > +                     };
> > +             };
> >       };
> >  };
> >
> >  &aiu {
> >       status = "okay";
> > +     pinctrl-0 = <&spdif_out_h_pins>;
> > +     pinctrl-names = "default";
> >  };
> >
> >  &cec_AO {
> >
>
> AFAIK the board doesn't have a physical SPDIF output, but one of the 40pin header can output SPDIF, right ?
>
> In this case, following the other boards mainline definitions, we do not enable any function by default
> for pins on the 40pin (or other programmable) headers.
>
> There is still ongoing discussions on how to handle that on a more generic level, but you should write a bunch
> of DT overlays for the VIM boards to enable optional functions like SPDIF and store then in a public git
> tree for everybody to use (like armbian or LibreELEC for example) from the U-Boot stage.
>
> Neil
