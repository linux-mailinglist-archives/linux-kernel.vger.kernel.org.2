Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3119D323A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 11:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhBXKbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 05:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhBXKbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 05:31:08 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D86C061574;
        Wed, 24 Feb 2021 02:30:27 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id s3so1681088otg.5;
        Wed, 24 Feb 2021 02:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LHRQW4ov53dg8KtZocnNCqA58r4Ul8zUg/imzVFJZFc=;
        b=EnkaliE1ciq3lJsaGMsd9guJwPz3qqBhkyv705iky4f2luq6423jNunBujtuRHTR63
         VcZ69LgprCzJdbV+BzZn/7s5p18kO+2bE1W64iC0Ax/MYg7z1/qVptQJi9tdY3IOtACk
         LGEtzSznv6EMxiji9FAo4IE/q5wAeMqisJj6M3RLFpFctazqBVjVhwky2Ro2f6izQ2ll
         lzhY6fFaRkgRdkZYy970aB+yBiUL9lJxmx8dv5fh0GEL9Pxes6eA9jrphM+V7fYnYy9Y
         dqCsdMdVH+WFx2k32wDd3VvcpO0bjpuVE9Z6DiBpFAyiMEcIXvwgcNmhbtaC6B9tZjOh
         uleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LHRQW4ov53dg8KtZocnNCqA58r4Ul8zUg/imzVFJZFc=;
        b=GYPoMgfkRBfnDxkNBq8jqy1cO6I97mlGTXpyl0Z5yqu04FX0cHxGadPqZ3CgBRRipd
         DpxmfSsdXKYdtsYpszVst4BiA3QVi7EZ5+m4ZJ0Ne6mavoG/jKiD0KsSE8jwBtlRX7QP
         Cns0Gav1H55Ywa75YXYoH6LYAeWNOCm4ykrY3i8AhbmI7N05ETma3boCD/NuCjYenOVa
         U1qa0XHE313Qg09oiR2TwzSqrSvCl+k1EVUq9mrjN8hi5XjoiaA9NyLRYHCmrKRPdbgm
         26CXhb0oS/nKMcmqz6oseZN8TPdFymx66wWPeMAdDlntYZUNz1eLigXkn4XC1Zi3bNcJ
         Qk/g==
X-Gm-Message-State: AOAM5306kUDcNuosnO2ClWKCYmwv23MELlNleZLslLKmgJ5S4VFMObda
        0kK5CKFbbQHPJLFpcV5rKx7fHioPzI3avxvA+ZI=
X-Google-Smtp-Source: ABdhPJxh5OIPDq2CBTjJ7ZNMjE/kYFTRuFbby9aNHs2PdkfliYoiudGLr9iuEZPgWbQ2v7uHDEcuPl+Kk1u1ifAaMeQ=
X-Received: by 2002:a9d:7f86:: with SMTP id t6mr23808369otp.362.1614162626506;
 Wed, 24 Feb 2021 02:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20210224091742.1060508-1-ikjn@chromium.org>
In-Reply-To: <20210224091742.1060508-1-ikjn@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 24 Feb 2021 11:30:14 +0100
Message-ID: <CAFqH_50BWF4sQnJAnVZDf3Dbuw+LaN67q39DvOh7ipzqNeNEMw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8183: Add power-domains properity to mfgcfg
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ikjoon,

Thank you for your patch.

Missatge de Ikjoon Jang <ikjn@chromium.org> del dia dc., 24 de febr.
2021 a les 10:21:
>
> mfgcfg clock is under MFG_ASYNC power domain
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---
>
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 5b782a4769e7..3384df5284c0 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -962,6 +962,7 @@ mfgcfg: syscon@13000000 {
>                         compatible = "mediatek,mt8183-mfgcfg", "syscon";
>                         reg = <0 0x13000000 0 0x1000>;
>                         #clock-cells = <1>;
> +                       power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_ASYNC>;

I don't think this will work in mainline, at least, the reference name
should be &spm

Thanks,
  Enric
>                 };
>
>                 mmsys: syscon@14000000 {
> --
> 2.30.0.617.g56c4b15f3c-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
