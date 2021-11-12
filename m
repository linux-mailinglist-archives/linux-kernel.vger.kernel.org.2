Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0560B44E7E2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 14:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbhKLNvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 08:51:51 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:39838 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbhKLNvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 08:51:42 -0500
Received: by mail-oi1-f172.google.com with SMTP id bf8so17961400oib.6;
        Fri, 12 Nov 2021 05:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=TC2M+mU+A5z9HrDX9S9GZXSmeMTv6gFjkiYKXqPqtKU=;
        b=PDf2hNDkay3S9sSRwW9ke8Cmov/20KXOJKW6m8MlVoa9RRJdt9/g6JQ6hOKfqXsH56
         aAAHfunu/0ygu4S6vavZqDfYldvGtl5xQZF2oiZWMmVg4c1r5oUGUsU8fkbCxWntFHEj
         j/nYARXMzlH20UIGpMQH2CQLlwdvlywOnxPDtz82iL2BooSYf9Q4a2JthrvBQSlEABK2
         pCDb/zp1/fOj+1hCpxuc2sk21y14ZRXtd7Kn0uWkEnQNTq8cVT8JZOL7VRW6Yt7qZLxR
         FT5Y+MMFZjJV0y3uEPeOUXSh60OT5+kHkYQas3hIg++JNAHFJLqdh/6Xshn5V897nf+J
         5Jvg==
X-Gm-Message-State: AOAM533OOsOGhdcx1VxlEIG6RD+FLvjTGkPKfHFLGjNosWGxF7B2GELa
        WkADSH8KMs4mgkoyarOWJA==
X-Google-Smtp-Source: ABdhPJyqLCyeEGS/my0wi5TWURD/69mMXlwnqhbDUdTjRdhY68jF3ugams1WHnb2/8Hlm26KL1Qd8w==
X-Received: by 2002:aca:5c82:: with SMTP id q124mr27682430oib.113.1636724930650;
        Fri, 12 Nov 2021 05:48:50 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q12sm1172983otl.66.2021.11.12.05.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 05:48:50 -0800 (PST)
Received: (nullmailer pid 2463371 invoked by uid 1000);
        Fri, 12 Nov 2021 13:48:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     James Lo <james.lo@mediatek.com>
Cc:     srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20211112055410.21418-2-james.lo@mediatek.com>
References: <20211112055410.21418-1-james.lo@mediatek.com> <20211112055410.21418-2-james.lo@mediatek.com>
Subject: Re: [RESEND, v14 1/3] dt-bindings: spmi: modify the constraint of reg property
Date:   Fri, 12 Nov 2021 07:48:37 -0600
Message-Id: <1636724917.135780.2463370.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 13:54:08 +0800, James Lo wrote:
> The constraint of reg may larger than 1, so we modify to
> 'minItem: 1' and 'maxItem: 2'.
> And adds documentation for the SPMI controller found on
> Mediatek SoCs.
> 
> Merge [RESEND,v13,2/4] into [RESEND,v13,1/4] for fix yaml
> error.
> [RESEND,v13,1/4] :
> dt-bindings: spmi: modify the constraint of reg property
> [RESEND,v13,2/4] :
> dt-bindings: spmi: document binding for the Mediatek SPMI
> controller
> 
> Signed-off-by: James Lo <james.lo@mediatek.com>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      | 76 +++++++++++++++++++
>  .../devicetree/bindings/spmi/spmi.yaml        |  3 +-
>  2 files changed, 78 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1554153


spmi@1c40000: reg: [[29622272, 4352], [31457280, 33554432], [65011712, 1048576], [66060288, 655360], [29401088, 155648]] is too long
	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dt.yaml

spmi@200f000: reg: [[33615872, 4096], [37748736, 4194304], [46137344, 4194304], [58720256, 2097152], [33595392, 8448]] is too long
	arch/arm64/boot/dts/qcom/apq8016-sbc.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dt.yaml
	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dt.yaml

spmi@200f000: reg: [[33615872, 4096], [37748736, 8388608], [46137344, 8388608], [58720256, 2097152], [33595392, 8448]] is too long
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dt.yaml
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dt.yaml

spmi@800f000: reg: [[134279168, 4096], [138412032, 16777216], [155189248, 16777216], [171966464, 2228224], [134258688, 12288]] is too long
	arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dt.yaml
	arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dt.yaml
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dt.yaml
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dt.yaml
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dt.yaml

spmi@c440000: #address-cells:0:0: 2 was expected
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml

spmi@c440000: reg: [[0, 205783040, 0, 4352], [0, 207618048, 0, 33554432], [0, 241172480, 0, 1048576], [0, 242221056, 0, 655360], [0, 205561856, 0, 155648]] is too long
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dt.yaml
	arch/arm64/boot/dts/qcom/sa8155p-adp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-db845c.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dt.yaml
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-hdk.dt.yaml
	arch/arm64/boot/dts/qcom/sm8350-mtp.dt.yaml

spmi@c440000: #size-cells:0:0: 0 was expected
	arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dt.yaml
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml

spmi@fc4c0000: reg: [[4232900608, 4096], [4232884224, 4096], [4232880128, 4096]] is too long
	arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy.dt.yaml
	arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dt.yaml
	arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dt.yaml
	arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dt.yaml
	arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dt.yaml
	arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dt.yaml
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dt.yaml
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dt.yaml
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dt.yaml
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dt.yaml

spmi@fc4cf000: reg: [[4232900608, 4096], [4232884224, 4096], [4232880128, 4096]] is too long
	arch/arm/boot/dts/qcom-apq8074-dragonboard.dt.yaml
	arch/arm/boot/dts/qcom-apq8084-ifc6540.dt.yaml
	arch/arm/boot/dts/qcom-apq8084-mtp.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dt.yaml

