Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EA0440DA5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 10:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhJaJh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 05:37:59 -0400
Received: from ip-15.mailobj.net ([213.182.54.15]:39994 "EHLO msg-4.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230289AbhJaJhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 05:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1635672917; bh=vJl6wad1L8/qQsHFiM4x6jV7Ba+rQVM5va0SBcOMf20=;
        h=X-EA-Auth:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:MIME-Version:Content-Transfer-Encoding;
        b=LzxmPc/r6zetKg6txq7wv8VVsphGY7Op2zZIYzlWtTyAHkyvmx+4XEhbEKwB71+IY
         xoavisHzSRMTP8qxoYTgfYN24arihCi/PgkKLzudF2DyGzWZxk/ZYE0yo5wwpIJJtm
         0EfvpdBGGmlBkLQEFR5XELFZgErhUsazWaW94gCQ=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Sun, 31 Oct 2021 10:35:17 +0100 (CET)
X-EA-Auth: G/xCF6IFwpi4luFdXUamameEVAkt81gKAIbtu5Egt8p0gvNt1SPUyLj91+xiitzXK6u5pr4rxNuIK+Zi5dCB7bwmSewjjv/Bi+qA5GH7yRo=
Message-ID: <a2f4bcd22b896f05ec3f33809f577cf9e889f270.camel@mailoo.org>
Subject: Re: [PATCH v1 3/4] ASoC: dt-bindings: nxp, tfa989x: Add rcv-gpios
 property for tfa9897
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        stephan@gerhold.net, linux-kernel@vger.kernel.org, tiwai@suse.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Date:   Sun, 31 Oct 2021 10:35:15 +0100
In-Reply-To: <YXtYtsPCeh937oF6@robh.at.kernel.org>
References: <20211024085840.1536438-1-vincent.knecht@mailoo.org>
         <20211024085840.1536438-4-vincent.knecht@mailoo.org>
         <YXtYtsPCeh937oF6@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 28 octobre 2021 =C3=A0 21:13 -0500, Rob Herring a =C3=A9crit=C2=A0=
:
> On Sun, Oct 24, 2021 at 10:58:39AM +0200, Vincent Knecht wrote:
> > Add optional rcv-gpios property specific to tfa9897 receiver mode.
> >=20
> > Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> > ---
> > =C2=A0.../devicetree/bindings/sound/nxp,tfa989x.yaml=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++++++++
> > =C2=A01 file changed, 10 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> > b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> > index 7667471be1e4..a9e15baedafd 100644
> > --- a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> > +++ b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> > @@ -12,6 +12,16 @@ maintainers:
> > =C2=A0allOf:
> > =C2=A0=C2=A0 - $ref: name-prefix.yaml#
> > =C2=A0
> > +=C2=A0 - if:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
st: nxp,tfa9897
> > +=C2=A0=C2=A0=C2=A0 then:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcv-gpios:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: op=
tional GPIO to be asserted when receiver mode is enabled.
>=20
> Did you test this works?=20
>=20
> You have to define the property outside the if/then schema at the top=20
> level. Then use an if/then schema to restrict it (rcv-gpios: false).

Sorry, I only tested validation with dt_binding_check.

I'll send another version later today with
if:
  not:
    properties:
      compatible:
        const: nxp,tfa9897
then:
  properties:
    rcv-gpios: false
and a tfa9897 example section, which passes the check and fails
if rcv-gpio is added to tfa9895.

Thank you



