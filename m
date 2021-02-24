Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E633237D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhBXHV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbhBXHVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:21:25 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FCEC061574;
        Tue, 23 Feb 2021 23:20:45 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o16so904693wmh.0;
        Tue, 23 Feb 2021 23:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=ZQJKsaY21XjjcT1M+qVN1VwATGUDt68e4WwQtZfPm0E=;
        b=gA2c6Bp4NDKDJm8M3Z3ClmKgjlnP8k2VNsKduoQCq8+j5l5IaCO6O8o6cYFAsUyjX3
         e85FLUCj2d9v5e1dnB37qdawdlbg2p4lUyEbS2Amn4V2g58aOytJ1ggUmc99RXqnqNFh
         k9t33TrqQGBiO0YalYInRqR7LieA2oHNIU651XGhoKgVGXE9kmK2ADe+rYHG6GtNnSVr
         SXT6QN2Ga/DBM+cQjsM142PfTUCOk2HMllr54GdIZAp78lIrNJ2Dr+18zBlKtFiIW1RC
         uEtm2jhr4oBMZqxW3ee1ML9U5Of7KZXabgZWYfJXYPaXi2W9TuU0TDRBdGLwiXyxi1j9
         R0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=ZQJKsaY21XjjcT1M+qVN1VwATGUDt68e4WwQtZfPm0E=;
        b=qDl3wwTFsekFwoAjGcQkLF/+ELPhNujsIQREanc+pMr33tJEoyidBCOFkgChi371gm
         pQGWodQO6Gs56k5AAnQn0d+GMonLqn4L1/JhQnrIl3/77gBtqCpO1KGNvyzzNRqFpU9S
         pRYJGfc16h1S/ox700txsZTbw7EqKsPaoTbCCd6LE4aeyg5WT8ggO4wFopPeOOqtJteb
         yWyWxmlLH1mYxZ8Li+5/bytEqT16G/ELnSkRYzOHv3MvNLcKQizdFayNp3FNQdQ8a6vb
         61J9rrmNbbyrW0sRwMWuVZZt9HRKCj7RV14f4GWOQTPUvzXMNjkGLR/HPlmKIR3jpD9G
         O5zA==
X-Gm-Message-State: AOAM530ESVV5L1oiOKtxSYRUUmgH0GV52xGqndlJ8/Y+LiAb1wbrEb/Y
        Cj6iL2FmkvR24paXydKNayc=
X-Google-Smtp-Source: ABdhPJwBpEv0pTMBXffRL7705an0dyB9mIksTWZA/whPkMmA6NlvPDpbiHoMAWtuV3t9SShkk9fT5A==
X-Received: by 2002:a7b:c04c:: with SMTP id u12mr2362830wmc.9.1614151244257;
        Tue, 23 Feb 2021 23:20:44 -0800 (PST)
Received: from macbook-pro-alvaro.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id p13sm1872032wrj.52.2021.02.23.23.20.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2021 23:20:43 -0800 (PST)
From:   =?utf-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v3 2/3] dt-bindings: usb: generic-ehci: document
 spurious-oc flag
Date:   Wed, 24 Feb 2021 08:20:41 +0100
References: <20210223155005.21712-1-noltari@gmail.com>
 <20210223174455.1378-1-noltari@gmail.com>
 <20210223174455.1378-3-noltari@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20210223174455.1378-3-noltari@gmail.com>
Message-Id: <880F72F4-82DF-4738-A8F1-D5528AA3FC9E@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I didn=E2=80=99t change this, but I missed Alan=E2=80=99s Acked-by, so:
Acked-by: Alan Stern <stern@rowland.harvard.edu>

> El 23 feb 2021, a las 18:44, =C3=81lvaro Fern=C3=A1ndez Rojas =
<noltari@gmail.com> escribi=C3=B3:
>=20
> Over-current reporting isn't supported on some platforms such as =
bcm63xx.
> These devices will incorrectly report over-current if this flag isn't =
properly
> activated.
>=20
> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> ---
> v3: no changes.
> v2: change flag name and improve documentation as suggested by Alan =
Stern.
>=20
> Documentation/devicetree/bindings/usb/generic-ehci.yaml | 6 ++++++
> 1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml =
b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> index cf83f2d9afac..8089dc956ba3 100644
> --- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> +++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> @@ -122,6 +122,12 @@ properties:
>     description:
>       Set this flag to force EHCI reset after resume.
>=20
> +  spurious-oc:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Set this flag to indicate that the hardware sometimes turns on
> +      the OC bit when an over-current isn't actually present.
> +
>   companion:
>     $ref: /schemas/types.yaml#/definitions/phandle
>     description:
> --=20
> 2.20.1
>=20

