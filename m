Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72521399FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhFCLYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:24:20 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:40574 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhFCLYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:24:18 -0400
Received: by mail-ej1-f49.google.com with SMTP id jt22so8674991ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 04:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wClgp04RN7aLhMajb1Rqp1rHHQpQjnZQWfTz3/PKYyM=;
        b=cs4LzVXsu3LDFKSYwPHkXtlPickNc4QBxiGyKUJZGZCzlpMbATz9PykF+fADJfaM+s
         peokMQU7x1OS33lZrSPlvKzL4tci3nnuR3lDDDW5HSFmXYB3WtnLIkrzjPEKTyP+GdO+
         uUtm27ez3dCwUVEXnmvswPOYCSx+xC69l4wvIB2Z5sUgpOg/dNPntVmAmjcpM80pN395
         U5sedA2+vWuJcYfml6I8dM8gXc2tW+ofp7U66fyPOVjxoujt2Rrqn31eTzmEtZ+v98qZ
         K5d+E/SFAD9bDELpor+NGDRZLe4E68prEAOtdxpKsTCFkOdYM/DPnmoeBQAOPhkV4Q2O
         f/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wClgp04RN7aLhMajb1Rqp1rHHQpQjnZQWfTz3/PKYyM=;
        b=h8EKVZrMzu53nTpw3b9izhJrQpAeGxtx1CcAi3hNGzQdRGOMbETSj4L+ImoOyCSA6l
         unzjXbUGOruOoErDP18PCFDMau31DLc8PZZbndKZyRCXn7m3w5Vp69fR3ZBn9up2OKNo
         C88fuBX7pu6FoDszeFmKTCDaq5N+fX1Pxsy4piWzSqyzFVGHgxw/OT6ILhkWOk6efdn2
         r3AOUUnz89J+vy0YjOQltC0glqtL2xJ0hwgCw3Bgj2RYV4meqP3y6MAhgW+1Y6hEbHZS
         50GAl+/q6gfIg/ZSn6to/T27UK91ZB0JsBamlS1whCu3wrqUbhf6pPpSySMnWCa4/Ouw
         sA1A==
X-Gm-Message-State: AOAM530mu4Llw5c+WPht5mts9MW31ssyRFPpUceD83KpchKd6CeZqi7o
        QdOdNM1GTMguignfTIIGlo4iTorE0J8m+o6arADUvmdZvC5JO0fl
X-Google-Smtp-Source: ABdhPJxYNdWEvkmPl733VfinlfeDNGZ86ACY4kETbIyLzjtuZeqnKkHsae92wMdCT5tMKxkK/7Q43SrSeYdupJ268u0=
X-Received: by 2002:a17:906:56ca:: with SMTP id an10mr26154470ejc.328.1622719293754;
 Thu, 03 Jun 2021 04:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210603094944.1114156-1-axel.lin@ingics.com> <1622716791.1034.13.camel@richtek.com>
In-Reply-To: <1622716791.1034.13.camel@richtek.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Thu, 3 Jun 2021 19:20:57 +0800
Message-ID: <CAFRkauCQ-BTbad8dgDgduDA8QCFTxbocmLxU+sKErUB8WO4bzQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: rt4801: Fix NULL pointer dereference if
 priv->enable_gpios is NULL
To:     =?UTF-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F) <cy_huang@richtek.com> =E6=96=BC 2021=
=E5=B9=B46=E6=9C=883=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:39=E5=
=AF=AB=E9=81=93=EF=BC=9A
>
> Hi, Axel:
>
> Which case will cause this error? I'm not really sure.
> But if devm_gpiod_get_array_optional will return null, then it must be ch=
eck
> earlier in probe function
>
>         priv->enable_gpios =3D devm_gpiod_get_array_optional(&i2c->dev, "=
enable",
> GPIOD_OUT_HIGH);
> -       if (IS_ERR(priv->enable_gpios)) {+       if (IS_ERR_OR_NULL(priv-=
>enable_gpios)) {
>
> If so, this change will be more reasonable.
> Cause in binding document, I already write the min item must be '1'.

Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
  enable-gpios:
    description: GPIOs to use to enable DSVP/DSVN regulator.
      The first one is ENP to enable DSVP, and second one is ENM to enable =
DSVN.
      Number of GPIO in the array list could be 1 or 2.
      If only one gpio is specified, only one gpio used to control ENP/ENM.
      Else both are spefied, DSVP/DSVN could be controlled individually.
      Othersie, this property not specified. treat both as always-on regula=
tor.
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ this  imply it's optional.

If it's cannot be optional, you should use devm_gpiod_get_array() instead.

Regards,
Axel
