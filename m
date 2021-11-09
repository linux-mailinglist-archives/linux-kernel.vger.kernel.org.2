Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0350B44AD80
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 13:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242080AbhKIMbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 07:31:40 -0500
Received: from ixit.cz ([94.230.151.217]:54452 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231250AbhKIMbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 07:31:39 -0500
Received: from [127.0.0.1] (37-48-50-181.nat.epc.tmcz.cz [37.48.50.181])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id BE6E520064;
        Tue,  9 Nov 2021 13:28:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1636460931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/KTxYwpPq7QKcYnuyQGk0KK0u6IPgYbFhdr9d5r8Aqc=;
        b=QhK8ZufLm8qirdnmNWtHrkyJM9HQwJgcPOQdznKkQ6ITURh3M4mHt2v/X067xI6NKrCepB
        8FvB4Ves1xltpqQdHOymcejNB/GwxBZNfH9jilgKMygPVM+pPoIRicTlm0B+PCOL5Bp2wj
        i54Q7l9/cGzMpEJFRzkYWyudv+KqHng=
Date:   Tue, 09 Nov 2021 12:24:36 +0000
From:   David Heidelberg <david@ixit.cz>
To:     Rob Herring <robh@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, - <kernel@puri.sm>,
        ~okias/devicetree@lists.sr.ht, phone-devel@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: sound: gtm601: convert to YAML
In-Reply-To: <YYmQ7OCIIb2AbnjY@robh.at.kernel.org>
References: <20211030121753.50191-1-david@ixit.cz> <YYmQ7OCIIb2AbnjY@robh.at.kernel.org>
Message-ID: <A1DBDD90-C79D-4455-9AC7-92C9DFB0F298@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I agree, I'll adapt Librem 5 dts to follow original convention and resend=
=2E


-------- P=C5=AFvodn=C3=AD zpr=C3=A1va --------
Odes=C3=ADlatel: Rob Herring <robh@kernel=2Eorg>
Odesl=C3=A1no: 8=2E listopadu 2021 21:04:44 UTC
Komu: David Heidelberg <david@ixit=2Ecz>
Kopie: Liam Girdwood <lgirdwood@gmail=2Ecom>, Mark Brown <broonie@kernel=
=2Eorg>, - <kernel@puri=2Esm>, ~okias/devicetree@lists=2Esr=2Eht, phone-dev=
el@vger=2Ekernel=2Eorg, alsa-devel@alsa-project=2Eorg, devicetree@vger=2Eke=
rnel=2Eorg, linux-kernel@vger=2Ekernel=2Eorg
P=C5=99edm=C4=9Bt: Re: [PATCH v2] dt-bindings: sound: gtm601: convert to Y=
AML

On Sat, Oct 30, 2021 at 02:17:52PM +0200, David Heidelberg wrote:
> Convert GTM601 binding to the YAML format=2E
>=20
> Signed-off-by: David Heidelberg <david@ixit=2Ecz>
> ---
> v2:
>  - add #sound-dai-cells
>  - put kernel@puri=2Esm into maintainers
>=20
>  =2E=2E=2E/devicetree/bindings/sound/gtm601=2Etxt      | 19 ----------
>  =2E=2E=2E/devicetree/bindings/sound/gtm601=2Eyaml     | 36 ++++++++++++=
+++++++
>  2 files changed, 36 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/gtm601=2Etxt
>  create mode 100644 Documentation/devicetree/bindings/sound/gtm601=2Eyam=
l
>=20
> diff --git a/Documentation/devicetree/bindings/sound/gtm601=2Etxt b/Docu=
mentation/devicetree/bindings/sound/gtm601=2Etxt
> deleted file mode 100644
> index efa32a486c4a=2E=2E000000000000
> --- a/Documentation/devicetree/bindings/sound/gtm601=2Etxt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -GTM601 UMTS modem audio interface CODEC
> -
> -This device has no configuration interface=2E The sample rate and chann=
els are
> -based on the compatible string
> -	"option,gtm601" =3D 8kHz mono
> -	"broadmobi,bm818" =3D 48KHz stereo
> -
> -Required properties:
> -
> -  - compatible : one of
> -	"option,gtm601"
> -	"broadmobi,bm818"
> -
> -
> -Example:
> -
> -codec: gtm601_codec {
> -	compatible =3D "option,gtm601";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/gtm601=2Eyaml b/Doc=
umentation/devicetree/bindings/sound/gtm601=2Eyaml
> new file mode 100644
> index 000000000000=2E=2Ee81a6aa75522
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/gtm601=2Eyaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2=2E0-only OR BSD-2-Clause
> +%YAML 1=2E2
> +---
> +$id: http://devicetree=2Eorg/schemas/sound/gtm601=2Eyaml#
> +$schema: http://devicetree=2Eorg/meta-schemas/core=2Eyaml#
> +
> +title: GTM601 UMTS modem audio interface CODEC
> +
> +maintainers:
> +  - kernel@puri=2Esm
> +
> +description: >
> +  This device has no configuration interface=2E The sample rate and cha=
nnels are
> +  based on the compatible string
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: broadmobi,bm818
> +          - const: option,gtm601

This does not match what the binding originally said=2E And generally this=
=20
combined with the one below should never be valid=2E

> +      - items:
> +          - enum:
> +              - broadmobi,bm818  # 48 kHz stereo
> +              - option,gtm601  # 8 kHz mono
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gtm601_codec {
> +        compatible =3D "option,gtm601";
> +    };
> --=20
> 2=2E33=2E0
>=20
>=20
