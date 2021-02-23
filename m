Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D446322E54
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhBWQF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbhBWQFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:05:42 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08C7C06174A;
        Tue, 23 Feb 2021 08:05:00 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w11so442635wrr.10;
        Tue, 23 Feb 2021 08:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gqqpVSIfzMUpEjdo3rT3BHRB1xjS3NCoeNfVT3jZ/3k=;
        b=srIK3J2VaZWAPEZ5x2atrT0bobMk18EaEV0jlmo7YNv6JR2qZM0AMo+Jx9jrAJTYxQ
         vbnnc/2Rt+3vy3M2RR2skZCei+Wq3vy+Il7K19MRbL7oyKfUtXn7XV6Ik8XYzvzJFkr3
         H9M7FfuglsBPd+xCGUkgjeKuZ93eJ+T9bM4mea4SPebbRrMPF76u2/nuLXDZnHvv5soJ
         Cthl48RL17hvPGQKNpZKLuaSo/kZv0to+EnTLnb/ZP+IcUYfA8MjtgxFbslR2rAFiALW
         UUIBup1WG54gfwf223mXE0twz/8a84WanG7pNYMWK5WR4JT5DFapLTAONa2/gtYCiZxV
         GmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gqqpVSIfzMUpEjdo3rT3BHRB1xjS3NCoeNfVT3jZ/3k=;
        b=ucldUkLny3ovG6W2s/KP9l3v52RfUPdxxfbjjLUx1oMPDy3O4n66BbatCoRgSx94vZ
         64sSJjxFDvF48nH/6u3jk42W7C0YCl4NVjJRmZdDa0F45iBsUmEhCqIyhZwmy8vlZIdG
         LvmKibJ9gHqniRIPaM/VJgBdPjr9ugXkaa8zIF3sbyipoIvpQ4xrb1PGoX0zoyXvcB5J
         un1vOy0dM1t/zlZb8K2C+6cdH2ijdY6mHUnMhf1UeTKlTBWW4+RuVNfXTnIOlWglLdtI
         UBvsYrDxPLvT07tUtq2r4gIdQoA6iL6dk9onKv8qbCmUk9nmvlGQW5bkxj1AsbS+iQf/
         P80w==
X-Gm-Message-State: AOAM5312JcuXs2IqpjO01Wg/ysKF53PcmBGGsemq5hnqwxX0nSOWRwKj
        MszQwURf61PF/WO8mktalv4=
X-Google-Smtp-Source: ABdhPJy+VT6aKJoDs2liqCvfi0G35SBrbSbkQVM3FqvqO4h+wbaZ6m1kEsxdK+8O6XLX55k4J4Ns1g==
X-Received: by 2002:adf:b313:: with SMTP id j19mr3837144wrd.188.1614096299576;
        Tue, 23 Feb 2021 08:04:59 -0800 (PST)
Received: from macbook-pro-alvaro.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id r17sm33312349wrx.82.2021.02.23.08.04.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2021 08:04:58 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH 1/2] dt-bindings: usb: generic-ehci: document ignore-oc
 flag
From:   =?utf-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <20210223155443.GB1261797@rowland.harvard.edu>
Date:   Tue, 23 Feb 2021 17:04:57 +0100
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <54E1894F-C8D8-4E2F-92DF-DC891153BAAB@gmail.com>
References: <20210223155005.21712-1-noltari@gmail.com>
 <20210223155005.21712-2-noltari@gmail.com>
 <20210223155443.GB1261797@rowland.harvard.edu>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> El 23 feb 2021, a las 16:54, Alan Stern <stern@rowland.harvard.edu> =
escribi=C3=B3:
>=20
> On Tue, Feb 23, 2021 at 04:50:04PM +0100, =C3=81lvaro Fern=C3=A1ndez =
Rojas wrote:
>> Over-current reporting isn't supported on some platforms such as =
bcm63xx.
>> These devices will incorrectly report over-current if this flag isn't =
properly
>> activated.
>>=20
>> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
>> ---
>> Documentation/devicetree/bindings/usb/generic-ehci.yaml | 5 +++++
>> 1 file changed, 5 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml =
b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
>> index cf83f2d9afac..294bbf02399e 100644
>> --- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
>> +++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
>> @@ -117,6 +117,11 @@ properties:
>>       Set this flag if EHCI has a Transaction Translator built into
>>       the root hub.
>>=20
>> +  ignore-oc:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description:
>> +      Set this flag for HCDs without over-current reporting support.
>=20
> This is not a good description of a device property.  DT entries are=20=

> supposed to described the hardware, not talk about how to use it.

Any suggestions on a proper description?

>=20
> When you say that the bcm63xx doesn't support over-current reporting,=20=

> what exactly do you mean?  Do you mean that sometimes the hardware =
turns=20
> on the over-current bit when an over-current isn't actually present?  =
Or=20
> do you mean something else?

Yes, the hardware turns on the over-current bit with no over-current =
present.

>=20
> Alan Stern
>=20
>> +
>>   needs-reset-on-resume:
>>     $ref: /schemas/types.yaml#/definitions/flag
>>     description:
>> --=20
>> 2.20.1

Best regards,
=C3=81lvaro.

