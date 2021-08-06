Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005DF3E2EFD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 19:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241858AbhHFRti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 13:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231776AbhHFRtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 13:49:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A8F1610E7;
        Fri,  6 Aug 2021 17:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628272160;
        bh=T7XbKNjz6J9bdpleiSzEHZfZGDNL3V/Rt8lKFm7vdVI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qehl2nYGu56NQ47YvZFb3tco6q5uF6+RgLz1Kn3KSngor7+15bJVjupCtFsHtlJm5
         Jgniw7UjdxMvraFBDsq0orNLK92elvMPSHcGjXwkvMA+6fiVbHRqoYqwjc21b+awvV
         /pbrbeMp6W1j4eN3+GBjqMpOTRhW0DFMkiPReSNTSxyBEuKYi/CC0Jacy6WEGThrdH
         tPl/XiPEJxNKmoHE2GN/ndBSeBB64dLJsSgWzq5M4odHaFpnZK9wddB5lxSV552tt4
         k3pGnMXJs13mqRPLQvDtprHOE5jMpGMNF4US0eUt02ghnSVyTw8g+2++lz3J2LXC4L
         mpkbSXSuftc0g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1627972461-2627-5-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1627972461-2627-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1627972461-2627-5-git-send-email-hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH v10 4/5] spmi: mediatek: Add support for MT8195
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Henry Chen <henryc.chen@mediatek.com>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 06 Aug 2021 10:49:19 -0700
Message-ID: <162827215909.1975443.852277412377742323@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hsin-Hsiung Wang (2021-08-02 23:34:20)
> From: Henry Chen <henryc.chen@mediatek.com>
>=20
> Add spmi support for MT8195.
>=20
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>

Missing Signed-off-by from hsin-hsiung.wang here

> ---
> changes since v9:
> - No change.
> ---
>  drivers/spmi/spmi-mtk-pmif.c | 90 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>=20
> diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
> index 94c45d46ab0c..0c320801c9d5 100644
> --- a/drivers/spmi/spmi-mtk-pmif.c
> +++ b/drivers/spmi/spmi-mtk-pmif.c
> @@ -348,6 +427,14 @@ static const struct pmif_data mt6873_pmif_arb =3D {
>         .soc_chan =3D 2,
>  };
> =20
> +static const struct pmif_data mt8195_pmif_arb[] =3D {

This is an array of type pmif_data.

> +       {
> +               .regs =3D mt8195_regs,
> +               .spmimst_regs =3D mt8195_spmi_regs,
> +               .soc_chan =3D 2,
> +       },
> +};
> +
>  static int mtk_spmi_probe(struct platform_device *pdev)
>  {
>         struct pmif *arb;
> @@ -444,6 +531,9 @@ static const struct of_device_id mtk_spmi_match_table=
[] =3D {
>         {
>                 .compatible =3D "mediatek,mt6873-spmi",
>                 .data =3D &mt6873_pmif_arb,

mt6873_pmif_arb is not an array, see the context header above.

How does this work? Has this been tested?

> +       }, {
> +               .compatible =3D "mediatek,mt8195-spmi",
> +               .data =3D &mt8195_pmif_arb,
>         }, {
>                 /* sentinel */
>         },
> --=20
> 2.18.0
>
