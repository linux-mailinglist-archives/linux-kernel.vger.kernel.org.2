Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659A7315D83
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhBJCne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbhBJCkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:40:46 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA067C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 18:40:04 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id d2so297569pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 18:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=KYoGNRGF/cdkpxiZwkxLmpID3hvUKgr02FyNxvMiqMY=;
        b=FU8V4gNmji0oirWM4KYiPVoEsRH9R3pQqbnqd0xe/VOFXTQ1k8a9PQWCogZALTtWD7
         aMGJBaXd52nACLX8qIaYU1Z1ZiX1sRMaSRhOjwqgIIJ/C5h5y5ARxwjK1nZDvEXai8Xf
         yS+953pQhbWOcltZlfQruMNlHXAeo6pb9FOR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=KYoGNRGF/cdkpxiZwkxLmpID3hvUKgr02FyNxvMiqMY=;
        b=oD7sz5ADkGFc3RfwgZ63nfRVHKfHVf8as1FMEA+8u9PMZXxFg3y3E6PYvPjjcISRfE
         YBZa4D2JAvEnnImiytUsxLPv3JV+myT5XRHFBi9LeXtWfXsE2V29XE2C2VWoaXMA/3ay
         5iglSiR9zm/gEeFZWO0Bpk/S+Sg3jipIvZhlA/sqTPHS3XIjN1Yyz3d62pwiWdnKTaHS
         qVhDgbM1ID6vyhk45XjwUqeEFd3dcsipCRR2TGH5NlDNGN589acb0cJAuRC1jlEoSFK0
         GaJYwcCyPm0If4X+yDKjDTmtZuchkveDixCGAzkq0doE1cgYu7p7l42EjfCq+3B3rW1s
         eqaA==
X-Gm-Message-State: AOAM532e1f1ujigWAvpym3aF28b2Sr66NstcKRRDHQL0486ewpjiXtII
        JuxYKZjWyQUsiMhdRsDCOMlZGQ==
X-Google-Smtp-Source: ABdhPJzEdHI6yiEwrRmid6IO7ALuMxG9P7eQrE8UdkG9V8hp4DyEYFGZLJmMY9jteh4pQGZdT2hZig==
X-Received: by 2002:a17:902:ed8d:b029:e2:b3fb:ca95 with SMTP id e13-20020a170902ed8db02900e2b3fbca95mr803506plj.17.1612924804206;
        Tue, 09 Feb 2021 18:40:04 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:58e2:748e:a316:9823])
        by smtp.gmail.com with ESMTPSA id h70sm243660pfe.70.2021.02.09.18.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 18:40:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210209211347.GA183847@robh.at.kernel.org>
References: <20210202184434.42644-1-swboyd@chromium.org> <20210202184434.42644-3-swboyd@chromium.org> <20210209211347.GA183847@robh.at.kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: iio: Add cros ec proximity yaml doc
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Rob Herring <robh@kernel.org>
Date:   Tue, 09 Feb 2021 18:40:01 -0800
Message-ID: <161292480177.418021.6230224455352630951@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2021-02-09 13:13:47)
> On Tue, Feb 02, 2021 at 10:44:33AM -0800, Stephen Boyd wrote:
> > +    description: Name for proximity sensor
> > +
> > +required:
> > +  - compatible
> > +
> > +unevaluatedProperties: false
> > +additionalProperties: false
>=20
> Only need one. In this case 'additionalProperties'.

Got it.

>=20
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      ec@0 {
> > +        compatible =3D "google,cros-ec-spi";
> > +        reg =3D <0>;
> > +        proximity {
> > +          compatible =3D "google,cros-ec-mkbp-proximity";
> > +          label =3D "proximity-wifi-lte";
> > +        };
>=20
> The complete examples I prefer is 1 example for the whole MFD in the MFD =

> schema and no example here.

Alright. I can add it to the mfd binding instead.

>=20
> > +      };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml =
b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > index 76bf16ee27ec..479a9f15de32 100644
> > --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > @@ -94,6 +94,9 @@ properties:
> >    keyboard-controller:
> >      $ref: "/schemas/input/google,cros-ec-keyb.yaml#"
