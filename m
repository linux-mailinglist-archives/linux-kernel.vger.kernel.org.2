Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3503380B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 23:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCKWjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 17:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhCKWjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 17:39:22 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BA6C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 14:39:21 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u4so5222566edv.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 14:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uoDXPuEltWUDmhb2tWhGvs+JKaUo3rAAVx8gEHgYL3A=;
        b=wNJ3p351Wwf0EhnLLfleqU4QXb5i4DQy1bkaQS34GVpfwGYK9jDNRy6PLZXw8Ouzij
         ffWdMFhQj46GRebK8TLdMvMF6e9BOFyHfZqZz+zij2D3EhmzudQKFK4De3t0Na/CLtye
         OEeIgqrLDd8YGmpcMJf/kYB7fjsUtWMn7yutV7Zih07QEj9b8xk2PpMOny2L0kEXXkAY
         otlpXQv8OT+EYrEGWOr+LuROUpAGaMO1fub6m+X0lcep+LgVhKlsxWa17RWV7D2HQyrx
         X8Ra9FE9TN6sZB4I7rii6vy9Dvkyn6b9sh4NahQhZnpUE/BSCz1rYfy1VldK4EDFOu3J
         a/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uoDXPuEltWUDmhb2tWhGvs+JKaUo3rAAVx8gEHgYL3A=;
        b=Z9hUvwVir2dDQQKYTrCKdk1uJy8+iepdtJ2CCaxzlJxDylmLWh9nAhwIZlAMZWZ/5a
         flnmoeA0iqcd3M776XfBy7qTkN1EoESHG7ODbflGYP/z9R0P4vVeDe90ipiCrrIGH/sN
         57dOtF9VGLKv41ZKoFtMJjWgpLuti0bqwCIt7NhJcFagPm0XPNNC3rOhlLOc34s+AvnB
         IcXCebq+fs25fOERWorwhIkZM/a6YWKFTY/nr0FDySvw53E93JM2K2zJaqLvMWOvoC9U
         Ybj/MUyFEKUnctehmQqIcA1KLyz1PazZFANNamAKygJ42mE/1QryYv+WJJhSHzbJ+05J
         6Srg==
X-Gm-Message-State: AOAM531RJYYwkxnr9GtdkRd9NfIUGQqKfk5c8DZ6Qay24D9LthNm5OIB
        DEfSts2aTgQB8iyXF+kX6Ny9uidcGFWeKtB6qcAmoQ==
X-Google-Smtp-Source: ABdhPJxFCHW41oZM+KJq47cRWr1Lwi4C6YnH9CA7LscoTteL7r9GHEnz1aWgVD1O7Qa/kZr+pCxb3iU8gTrmbuxUp8M=
X-Received: by 2002:a05:6402:3486:: with SMTP id v6mr10850409edc.109.1615502360302;
 Thu, 11 Mar 2021 14:39:20 -0800 (PST)
MIME-Version: 1.0
References: <20210309220014.22205-1-tharvey@gateworks.com> <8ca5c54140d69307f3c08ca85a09f0b5@walle.cc>
 <3d497991-1470-e188-8be2-e5992dfa914c@microchip.com>
In-Reply-To: <3d497991-1470-e188-8be2-e5992dfa914c@microchip.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 11 Mar 2021 14:39:07 -0800
Message-ID: <CAJ+vNU1urqqDKrH5HNsUz=Wb-Rtr+dMzEnJ3=gMJv6+qz29n2g@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: at25: add Fujitsu MB85RS4MT
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     Michael Walle <michael@walle.cc>,
        Richard Weinberger <richard@nod.at>, p.yadav@ti.com,
        vigneshr@ti.com,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'On Tue, Mar 9, 2021 at 9:34 PM <Tudor.Ambarus@microchip.com> wrote:
>
> On 3/10/21 12:59 AM, Michael Walle wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > Hi Tim,
> >
> > Am 2021-03-09 23:00, schrieb Tim Harvey:
> >> Document the compatible value for the Fujitsu MB85RS4MT SPI
> >> FRAM EEPROM device so that it can be used in DTS files.
> >>
> >> This is a 512KiB FRAM EEPROM.
> >>
> >> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> >> ---
> >>  Documentation/devicetree/bindings/eeprom/at25.yaml | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/eeprom/at25.yaml
> >> b/Documentation/devicetree/bindings/eeprom/at25.yaml
> >> index 6a2dc8b3ed14..f594db72b711 100644
> >> --- a/Documentation/devicetree/bindings/eeprom/at25.yaml
> >> +++ b/Documentation/devicetree/bindings/eeprom/at25.yaml
> >> @@ -26,6 +26,7 @@ properties:
> >>                - anvo,anv32e61w
> >>                - atmel,at25256B
> >>                - fujitsu,mb85rs1mt
> >> +              - fujitsu,mb85rs4mt
> >>                - fujitsu,mb85rs64
> >>                - microchip,at25160bn
> >>                - microchip,25lc040
> >
> > Hm, the driver is spi-nor but this is for the at25 driver. Is
> > this correct? Doesn't it work if you just add the ID to
> > spi-nor/fujitsu.c and use 'compatible = "jedec,spi-nor' ?
> >
>
> Tim,
>
> Can you try and see if you can work with this flash by setting "atmel,at25"
> compatible?

It does not work with 'atmel,at25'. I was fooled into adding it to
at25.yaml because that is where the mb85rs1mt compatible was. I
suppose at some time the drivers were split as mb85rs1mt is clearly in
the spi-nor driver now.

I will drop the patch to at25.yaml and now that I realize all I need
is 'jedec,spi-nor' I won't need any bindings patch.

>
> There are some SPI NOR-like flashes MRAMs, FRAMs, even EEPROMs, that share
> a part of opcodes of SPI NORs, but have slightly different characteristics
> (ex. no erase, no wait times for writes on FRAMs).
> See the patch series submitted by Richard, that I have stalled:
> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=208584&state=*
>

This series makes sense to me. I tested it and indeed it provides a
vast performance improvement. Richards patch would collide with my
patch that adds the mb85rs4mt detection. Let me know what you're going
to do there and if you need me to rebase 'mtd: spi-nor: fujitsu: add
support for MB85RS4MT' on top of it.

Best regards,

Tim
