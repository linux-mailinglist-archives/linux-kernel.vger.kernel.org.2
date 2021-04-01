Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FF4351882
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbhDARpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbhDARid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:38:33 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A391C0610D3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 05:33:59 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y32so1405242pga.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 05:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EsqA9Xv1llCUvLw8edrdaV5ZoeKuJnc13OOMvfzSgxY=;
        b=HvEMU+9tQn1GkFvgVgNpDGEMAtzN3iWIIpIqpjHnH3PuIQx/41BH4FPhlsrxmzJ7B8
         L2ALnq3tSypyjY5/I2dj+e7l2fmL2+pioKtbUoAHVuat+G7R/l0ATYHxFN3e0HYVKZ3N
         X1KRmPPuu+zjjTXiovmOa6heMHJcGPRPsUrrU/c+ic0Tew8Dk/4lDGWHd8bcswuBcB9K
         fG85AyStYAbSqXDb5FHrCg6IrLsMpA92c/Cj927Tkg/YZ3ETIp4iRUIQGTj1yiEllcW+
         fepykwK5q6/UsV9VB3RqNAxZZxkkNuKoyG9wmDf/2PiEeesDmmNmV4qw0GUKKYmnzISi
         168g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EsqA9Xv1llCUvLw8edrdaV5ZoeKuJnc13OOMvfzSgxY=;
        b=Gj9IyX2kCvUWiBgtPbmkjACVkDyCztK9a7iz9DqBOsfjJuiNZv8IoVZZty6hD7UE02
         y3RVhv0h7xrzma3UQ63YszPQFmnRfypDnV0bylv7k18j+/83Zc+Rx9OXX0MONcjkmxp5
         l2AY5FEgw1xtYrE7DuXjQtIH9iBexsIfYDiKPsPspyClezfcSSUREHmGHa0ky1ogk6qf
         zk0F0EEeahAipbzYiWtvgAFahBQiYVyiPiAgOx2GUhGjduxnCSptT217o9kGcMggije+
         JQVKhgHExg/NGggW0EzqP9u51NZ8RSrdD9HWIgRKYHAJOxyh7XHl9juxR9i7/+jR+k/+
         xmsg==
X-Gm-Message-State: AOAM533R/6hN/V9OUy0X1oOM2XdqQ+qTWoaEofIulMWjRDR1V/BdXe6Z
        t4Xu27Xp1vGTfR3GwKrw4BWMNsraDK/0fNxCFmKxSnwPJW8=
X-Google-Smtp-Source: ABdhPJyaGyv5cIOFak7z5jWf50xKVPz9OGnuR20y6+iAsqhPnXNOISrhs8/7nH+WsYv0DxswgJgz0ro4GehSANLiKgw=
X-Received: by 2002:a62:80cf:0:b029:1f3:1959:2e42 with SMTP id
 j198-20020a6280cf0000b02901f319592e42mr7324814pfd.39.1617280439001; Thu, 01
 Apr 2021 05:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616135353.git.xji@analogixsemi.com> <4b09b40ce53c5b5fe7d2ba65a3c7a1b23f6eec04.1616135353.git.xji@analogixsemi.com>
 <YFc1ZlmSiNJOAoOl@pendragon.ideasonboard.com> <20210324075108.GA1466804@anxtwsw-Precision-3640-Tower>
In-Reply-To: <20210324075108.GA1466804@anxtwsw-Precision-3640-Tower>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 1 Apr 2021 14:33:47 +0200
Message-ID: <CAG3jFyt8EigCBkZHXgy1E-XcfpfdC5FEWW4Gb8bZqMT1tFW3ow@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] dt-bindings:drm/bridge:anx7625:add vendor define flags
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Nicolas Boichat <drinkcat@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Bernie Liang <bliang@analogixsemi.com>,
        Sheng Pan <span@analogixsemi.com>,
        Zhen Li <zhenli@analogixsemi.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Xin,

This series no longer applies to drm-misc/drm-misc-next, please rebase it.

On Wed, 24 Mar 2021 at 08:52, Xin Ji <xji@analogixsemi.com> wrote:
>
> On Sun, Mar 21, 2021 at 02:00:38PM +0200, Laurent Pinchart wrote:
> > Hi Xin,
> >
> > Thank you for the patch.
> >
> > On Fri, Mar 19, 2021 at 02:32:39PM +0800, Xin Ji wrote:
> > > Add 'bus-type' and 'data-lanes' define for port0. Define DP tx lane0,
> > > lane1 swing register array define, and audio enable flag.
> > >
> > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > ---
> > >  .../display/bridge/analogix,anx7625.yaml      | 58 ++++++++++++++++++-
> > >  1 file changed, 57 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > index c789784efe30..3f54d5876982 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > @@ -34,6 +34,26 @@ properties:
> > >      description: used for reset chip control, RESET_N pin B7.
> > >      maxItems: 1
> > >
> > > +  analogix,lane0-swing:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +    minItems: 1
> > > +    maxItems: 20
> > > +    description:
> > > +      an array of swing register setting for DP tx lane0 PHY, please don't
> > > +      add this property, or contact vendor.
> >
> > DT properties need to be documented. Contacting the vendor doesn't count
> > as documentation I'm afraid.
>
> Hi Laurent Pinchart, thanks for your comment. For the DP phy swing
> setting, it is hard to describe in here, needs to refer the anx7625
> datasheet and programming guide. Basically, no need to change the DP phy
> swing setting.
>

Laurent is right. But if the value practically is a constant, you can
move the swing register into the driver. It should still be documented
as well as possible, but we can be a little bit more flexible.

> > > @@ -73,6 +123,10 @@ examples:
> > >              enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
> > >              reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
> > >
> > > +            analogix,audio-enable;
> > > +            analogix,lane0-swing = <0x14 0x54 0x64 0x74 0x29 0x7b 0x77 0x5b>;
> > > +            analogix,lane1-swing = <0x14 0x54 0x64 0x74 0x29 0x7b 0x77 0x5b>;
> > > +
> > >              ports {
> > >                  #address-cells = <1>;
> > >                  #size-cells = <0>;
