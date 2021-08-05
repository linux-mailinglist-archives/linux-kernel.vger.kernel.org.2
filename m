Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604F33E1038
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbhHEI0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbhHEI0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:26:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D532C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 01:26:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d8so5393817wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 01:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kclX3gByjCAhoDtvMp3Zho8AUMRM4K+I23+S3hZow1Q=;
        b=m8gcCXhtsZBn3R0+JO3Cy7mtSX0/ddV+O/LTOkhdNyf0DJmw+7nUKOOLbbFeHWEwgm
         RWfrCblXLN9/n61sUy3XSjUbReKD5yvILMTjDH6KTHdEZEXu/RMTnZgjGLTa4F8j9udc
         LcMY6tcq7XVyoZcB/7R5majfcL0wShQdq1yU9AyW2CtSTFGgU/u39mtczY58ThxlL0XT
         QxFUg9L1vWTtRqQd15tLbP8MYXJ2kuQgBvIqnsYIj5pV5giM6ODzARlKzPcsnLhvYktR
         Jw3EmeIWphhc/j2IVSVoLGQdgJCnjCz2thZyuq74UlyQBUP8XPYp8zI7PEc+pjlK1yD4
         EE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kclX3gByjCAhoDtvMp3Zho8AUMRM4K+I23+S3hZow1Q=;
        b=onPSIy6oAZj/6+PDGR+PAAPG/D8b2VWOVVcbwYe4pqWJjx/0/EdeMF1yZ3z7HChrJ3
         6R8pCSUpJRyDUwEfba8nS+QS+gGRoz1VlZhjIrwj37w5/ZCREkOYQNhDCRJtdTNfXVCE
         K5+6Bov1UTu2gOS1dtnSyVcBDxFeh0VwNmDU9MTWvJ6zMbl2um+Ajmbydi6Ha5QRyH4g
         geSQ0rNo3Hz3xgCOFTWePv1lQ34K+3lpJ3t2l3qUjk+7bbZj8zyTObkcGoPqzBgB6Mva
         ex+vF+xeUuMOrY+mey+kD1i+Z4fXbiLL4F5NmnogneNb7smuXmUfE0Bn1MH4uGGYsoBo
         JFHA==
X-Gm-Message-State: AOAM5306MXKzvZU2oGNpylbHv/mlZCIear/nnWFRf5V/WhT8CZMeaXfu
        eZ2IMah7FZ+/npl8NxRTmMyJLg==
X-Google-Smtp-Source: ABdhPJwtyCJtXAGClx2XTcVIguJ+BWNlO2NAXzVn32gpdwy/nSjcf7coWknE9v+fg/2oIjbpiwFzEg==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr3672908wrq.273.1628151983187;
        Thu, 05 Aug 2021 01:26:23 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id i18sm1917563wmb.17.2021.08.05.01.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 01:26:22 -0700 (PDT)
Date:   Thu, 5 Aug 2021 09:26:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 09/11] ARM: dts: imx7d: remarkable2: Enable
 silergy,sy7636a
Message-ID: <YQugrBPkiSTfh8qB@google.com>
References: <20210803084456.198-1-alistair@alistair23.me>
 <20210803084456.198-9-alistair@alistair23.me>
 <YQqLiAtAtREWTvD7@google.com>
 <CAKmqyKO_QeNTRZx9P9vhX7DQoBfE6igOtJroTEer-OKoVO-RGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKO_QeNTRZx9P9vhX7DQoBfE6igOtJroTEer-OKoVO-RGQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2021, Alistair Francis wrote:

> On Wed, Aug 4, 2021 at 10:43 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Tue, 03 Aug 2021, Alistair Francis wrote:
> >
> > > Enable the silergy,sy7636a and silergy,sy7636a-regulator on the
> > > reMarkable2.
> > >
> > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > ---
> > >  arch/arm/boot/dts/imx7d-remarkable2.dts | 42 +++++++++++++++++++++++++
> > >  1 file changed, 42 insertions(+)
> >
> > I don't see the DT documentation for this device.
> 
> Which device?
> 
> The imx7d-remarkable2 is in current master and there is a single line
> at `Documentation/devicetree/bindings/arm/fsl.yaml`
> 
> The silergy,sy7636a-regulator is also already in master, but it isn't

I think this is currently in -next.

It won't land in Mainline (what I believe you're calling "master")
until the next merge window, which is about a month.

> exposed to device tree and the compatible string shouldn't be included
> in this patch. I'll fix that.

Okay, this is essentially what I was getting at.

The node should really be documented and Acked by the DT guys.

..

Anyway, I have a new toy for you to play with.

I'll Cc you on the patch.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
