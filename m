Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CCF34FAC2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbhCaHvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbhCaHup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:50:45 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101BFC061574;
        Wed, 31 Mar 2021 00:50:45 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c4so18516901qkg.3;
        Wed, 31 Mar 2021 00:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvFE5J3FezlEE8pnDN5zAGS+SdlnCyime9vQnsZ9wkY=;
        b=PTGFvl2RypZxM0OoGUctoQGNsTqmeQLWPd4faKZB3LNwJY5otlqSbQokWFD+XxB4cZ
         k7JcAGMHpQ6KFSA1ShU4X+lxf2geDdc31fr0WaZmQY56ejVKYekOO2OgPZ+IUK3N0tjk
         rXeVUBoRE+TKa8974Zv0HzFjrsw95+klEl990=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvFE5J3FezlEE8pnDN5zAGS+SdlnCyime9vQnsZ9wkY=;
        b=m8r5aiSO5rUpGB3pdak1r0kDB+UcAuqR+L51G8RtFU6oiISpNMIoTVD6SY9wQgHHj9
         Dfj3GbTXQZM3edaetZevTVU6MfOiiwqCw5eo38bpnMR9P5P2cj1RZ7x+pQQW3wqGgSW3
         whF3keRxgjf6Z3G4zTxYYcO5A87mJ0IwvtEulyuJNRN4oN4I6Qukq2HuohZim7jBRSEN
         /5DTD+HWlsdhXkQLZJUxf3lhf5ogWW91+jtfYu1LYo2kDMFvGw2orde/u1JhhO+EcWxf
         tPS3eM1TQW+aswufZeB1puuJ6FN8ypf63cHVDEb2Pk3lrzpv4AW9ML9u/UfCJQdHJQmQ
         AV7w==
X-Gm-Message-State: AOAM532BObE6OBum/xsSwpPbJ25nzXgERGxpNnNBJEpfGbPg4L5q1v72
        znerAuRSQaJATo3UrdQ/YrKwAGDVuVYbGgeFSO1gE75gExTbhA==
X-Google-Smtp-Source: ABdhPJyMt3JEgZQNa/c4w8WpbFN1v/ZWTRBHzplPfi6vA5v5QT21JEeEclDxFGpB1WMPbDt6DMynOc5coOB4FZ/iNj0=
X-Received: by 2002:a37:d202:: with SMTP id f2mr1940297qkj.273.1617177044244;
 Wed, 31 Mar 2021 00:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210330002338.335-1-zev@bewilderbeest.net> <20210330002338.335-4-zev@bewilderbeest.net>
 <CACPK8XcwMYgc9R24KuGa0hqKQAxawDScHp1+y62aeEvcpvPiSw@mail.gmail.com>
In-Reply-To: <CACPK8XcwMYgc9R24KuGa0hqKQAxawDScHp1+y62aeEvcpvPiSw@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 31 Mar 2021 07:50:32 +0000
Message-ID: <CACPK8XfBsq6H5qsSNgwqdRhHXTUYnNQKekSNMnxXoVaAzMc=MQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: aspeed: add ASRock E3C246D4I BMC
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 at 07:41, Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 30 Mar 2021 at 00:25, Zev Weiss <zev@bewilderbeest.net> wrote:
> >
> > This is a relatively low-cost AST2500-based Xeon E-2100/E-2200 series
> > mini-ITX board that we hope can provide a decent platform for OpenBMC
> > development.
> >
> > This initial device-tree provides the necessary configuration for
> > basic BMC functionality such as host power control, serial console and
> > KVM support, and POST code snooping.
> >
> > Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
>
> > ---
> >  .../boot/dts/aspeed-bmc-asrock-e3c246d4i.dts  | 188 ++++++++++++++++++
> >  1 file changed, 188 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
> >
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
> > new file mode 100644
> > index 000000000000..27b34c3cf67a
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts

When adding the device tree please also add it to the makefile in
arch/arm/boot/dts.
