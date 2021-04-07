Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949BD3560B3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347706AbhDGBZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347695AbhDGBZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:25:07 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C1AC061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:24:58 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id x189so18328488ybg.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 18:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f51iZjknc5u2AWAwTDyD4aSak7KE5kMCHStgrZoI5UA=;
        b=Lb8ixtya79eOwQ/bxt7clK7iVx4183UImzCSc7Z5LI4d2dPk6R0YAlDjEhoWHVgy9o
         Ku6wQqKgNOB897sIWqMsYBYQkl1w2IVBf34PfW30cAi1F3LXC78/oUVw1fZIsxh5SubN
         Grkxz5s7Cm3C43qkMp1TmCXMzqt5x/ZpeBTtoaydSRfdYVj4G9elS/u6Bo6RQnQXr6ey
         0dGH9B04ye0LOp2Tc2nN8U1HPqSLrSXBxyNbxSKZBZm+iQS/6YqG7hgVn7Cq7Hv1vlwi
         2Ehv0quyoZY6qJqfumpP0UpdkTfYOl2mgDjbq/vr9PLw4JvgNxoVkmggcr9anue7Wks0
         taLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f51iZjknc5u2AWAwTDyD4aSak7KE5kMCHStgrZoI5UA=;
        b=asY81wkg0aLUmrJf64Q1PX9EYBFiyQu3vQXOIeqjbCSkfgQ/TkvDCPm8ecU9MrzpAW
         FS3dE9leLchDwr72w8k0X0JX8sd7+mNh3EH64O4YXTt8h+H9TuvuZKUQHR2aJUs+iPL8
         T2X/TzJv7DOorwzE6e0pLvJCDYtttbqhm1SJh29UXSHnhYckFmqz3b9cfrc5MibNTuE+
         SdtKqpSYBQL5/QhGxgGjF+nr/0y0QHYWHrlATyeAdNPIhwkDAbf0JscgyK1q+wrTMxBL
         iaNeJutQbn8DGUaLbJI5sLH+VJlRgTTDQSqv403rU/UzUve9R7JcYmF2GxWzFoCWQC1S
         Oy7g==
X-Gm-Message-State: AOAM530Dvfkubu3EQKNWEOEwk+J47obhT+nfECSsteXeRUqDj73T36sp
        /GFeUMdsrpNvNfAmUtoYkm5ms4xzOrbjtIdKBHP/7g==
X-Google-Smtp-Source: ABdhPJziXA3cYD18qd8f0vEBXDCxDI8SA8pagWx4cuMAOp7Xxj8iRWPuWkU2CiBsh5SfsGzraBa324Ea0SUZNC05PXs=
X-Received: by 2002:a25:907:: with SMTP id 7mr1140032ybj.346.1617758697690;
 Tue, 06 Apr 2021 18:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210405031436.2465475-1-ilya.lipnitskiy@gmail.com>
 <20210405222540.18145-1-ilya.lipnitskiy@gmail.com> <CAGETcx-gF4r1TeY2AA4Vwb5e+5O+_O3E2ENo5tKhh=n_EOJnEQ@mail.gmail.com>
 <20210407003408.GA2551507@robh.at.kernel.org> <CAGETcx8=sSWj_OmM1GPXNiLcv3anEkJnb_C7NoO9mNwS-O0KhQ@mail.gmail.com>
 <CAL_JsqLs4c3+9WwV6Vnk9Tovb6HiyH7t+_WXYP-ZDO72mOcO+w@mail.gmail.com>
In-Reply-To: <CAL_JsqLs4c3+9WwV6Vnk9Tovb6HiyH7t+_WXYP-ZDO72mOcO+w@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 6 Apr 2021 18:24:21 -0700
Message-ID: <CAGETcx-W_K9NFV51iBvyZ-Q+1LCUM3qipMmap9yEW_eu9B7CCg@mail.gmail.com>
Subject: Re: [PATCH v2] of: property: fw_devlink: do not link ".*,nr-gpios"
To:     Rob Herring <robh@kernel.org>
Cc:     Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 6:10 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Apr 6, 2021 at 7:46 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Tue, Apr 6, 2021 at 5:34 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Tue, Apr 06, 2021 at 04:09:10PM -0700, Saravana Kannan wrote:
> > > > On Mon, Apr 5, 2021 at 3:26 PM Ilya Lipnitskiy
> > > > <ilya.lipnitskiy@gmail.com> wrote:
> > > > >
> > > > > [<vendor>,]nr-gpios property is used by some GPIO drivers[0] to indicate
> > > > > the number of GPIOs present on a system, not define a GPIO. nr-gpios is
> > > > > not configured by #gpio-cells and can't be parsed along with other
> > > > > "*-gpios" properties.
> > > > >
> > > > > nr-gpios without the "<vendor>," prefix is not allowed by the DT
> > > > > spec[1], so only add exception for the ",nr-gpios" suffix and let the
> > > > > error message continue being printed for non-compliant implementations.
> > > > >
> > > > > [0]: nr-gpios is referenced in Documentation/devicetree/bindings/gpio:
> > > > >  - gpio-adnp.txt
> > > > >  - gpio-xgene-sb.txt
> > > > >  - gpio-xlp.txt
> > > > >  - snps,dw-apb-gpio.yaml
> > > > >
> > > > > [1]:
> > > > > Link: https://github.com/devicetree-org/dt-schema/blob/cb53a16a1eb3e2169ce170c071e47940845ec26e/schemas/gpio/gpio-consumer.yaml#L20
> > > > >
> > > > > Fixes errors such as:
> > > > >   OF: /palmbus@300000/gpio@600: could not find phandle
> > > > >
> > > > > Fixes: 7f00be96f125 ("of: property: Add device link support for interrupt-parent, dmas and -gpio(s)")
> > > > > Signed-off-by: Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
> > > > > Cc: Saravana Kannan <saravanak@google.com>
> > > > > Cc: <stable@vger.kernel.org> # 5.5.x
> > > > > ---
> > > > >  drivers/of/property.c | 11 ++++++++++-
> > > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > > index 2046ae311322..1793303e84ac 100644
> > > > > --- a/drivers/of/property.c
> > > > > +++ b/drivers/of/property.c
> > > > > @@ -1281,7 +1281,16 @@ DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
> > > > >  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
> > > > >  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
> > > > >  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
> > > > > -DEFINE_SUFFIX_PROP(gpios, "-gpios", "#gpio-cells")
> > > > > +
> > > > > +static struct device_node *parse_gpios(struct device_node *np,
> > > > > +                                      const char *prop_name, int index)
> > > > > +{
> > > > > +       if (!strcmp_suffix(prop_name, ",nr-gpios"))
> > > > > +               return NULL;
> > > >
> > > > Ah I somehow missed this patch. This gives a blanked exception for
> > > > vendor,nr-gpios. I'd prefer explicit exceptions for all the instances
> > > > of ",nr-gpios" we are grandfathering in. Any future additions should
> > > > be rejected. Can we do that please?
> > > >
> > > > Rob, you okay with making this list more explicit?
> > >
> > > Not the kernel's job IMO. A schema is the right way to handle that.
> >
> > Ok, that's fine by me. Btw, let's land this in driver-core? I've made
> > changes there and this might cause conflicts. Not sure.
>
> It merges with linux-next fine. You'll need to resend this to Greg if
> you want to do that.
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Hi Greg,

Can you pull this into driver-core please? I touch this file a lot and
might need to do so again if any fw_devlink=on issues come up. So
trying to preemptively avoid conflicts.

-Saravana
