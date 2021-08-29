Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2214F3FA933
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 07:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhH2FKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 01:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhH2FKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 01:10:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C9C460C3E;
        Sun, 29 Aug 2021 05:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630213795;
        bh=FEeBfZ+6U5xnJrFKkCKAsByOUDTYILMyvL1+UQZIOLQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qiufa6f/TQZetxczkGDsHCFAhcCsKA0LIJNrJCJrbI9PJ3RvGq0rZ9yfLpMSnWt6x
         X0Imn6l5gb6aQiYg4K4bjN/lfEcGBmpX1AhvdjH9JVhiL/ZSC7NQ2w0oS88Ku0s212
         GZhA+VxxUwjc44YTdO55/F4EUmZdqgpVuMrkaNu8RxBtYcOcgjRkXzRIMws6LpmJr+
         Bo9XAWRSUGOrbvF8a50GG5i+ROrYrL0I0o1hQZKfzHf7B6Ou8/+UNvzAyqvDPQ6sv3
         HwGpzyfmqkA5pDMxiIw3e7qiEhCZ6bFaS0IyoTdi4D0dhsSC6bAy6QDJw+ICcxaJwg
         aTu384gcZ8tlA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210804092244.390376-2-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210804092244.390376-1-nobuhiro1.iwamatsu@toshiba.co.jp> <20210804092244.390376-2-nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH v4 1/4] dt-bindings: clock: Add DT bindings for PLL of Toshiba Visconti TMPV770x SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh+dt@kernel.org>
Date:   Sat, 28 Aug 2021 22:09:54 -0700
Message-ID: <163021379431.2676726.15668763072935534900@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nobuhiro Iwamatsu (2021-08-04 02:22:41)
> Add device tree bindings for PLL of Toshiba Visconti TMPV770x SoC series.
>=20
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .../clock/toshiba,tmpv770x-pipllct.yaml       | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv7=
70x-pipllct.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pip=
llct.yaml b/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllc=
t.yaml
> new file mode 100644
> index 000000000000..7b7300ce96d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.ya=
ml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/toshiba,tmpv770x-pipllct.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba Visconti5 TMPV770X PLL Controller Device Tree Bindings
> +
> +maintainers:
> +  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +
> +description:
> +  Toshia Visconti5 PLL controller which supports the PLLs on TMPV770X.
> +
> +properties:
> +  compatible:
> +    const: toshiba,tmpv7708-pipllct
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  clocks:
> +    description: External reference clock (OSC2)
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    osc2_clk: osc2-clk {
> +      compatible =3D "fixed-clock";
> +      clock-frequency =3D <20000000>;
> +      #clock-cells =3D <0>;
> +    };
> +
> +    soc {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        pipllct: clock-controller@24220000 {
> +            compatible =3D "toshiba,tmpv7708-pipllct";

The driver makes it look like this is actually part of a syscon node. Is
that right? It's not clear to me that this is a syscon. But then looking
at the binding it seems that one device has been split up into PLL and
"not PLL" parts sort of arbitrarily.

> +            reg =3D <0 0x24220000 0 0x820>;
> +            #clock-cells =3D <1>;
> +            clocks =3D <&osc2_clk>;
> +        };
> +    };
> +...
