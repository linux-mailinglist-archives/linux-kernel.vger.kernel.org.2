Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2E9460B30
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 00:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359755AbhK1Xhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 18:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241451AbhK1Xfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 18:35:38 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E8CC0613F7;
        Sun, 28 Nov 2021 15:32:08 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z5so64319793edd.3;
        Sun, 28 Nov 2021 15:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nKEIfrJKPGEz8pFXZhstnqQjRimIfAQvEIfn2EHeg1U=;
        b=p0SR2HFVjtCbpiS8okyS7UQGw9U0lId9npeIs1IriZ8vs/8kqxFivjp0Stj6ySHa90
         TxciHhHDUdWrr+HaPujcTIDOkLg/uDaijmeBjhrsLoPFZO6JWPkx2Urgz6ZJNmdEnPji
         73QrrWYdwzhoAQrc+dW2TFgTsr2XXxu3PmzVWfCx62kbnrubL+l7FoqBNF2Lz6jGFcnY
         kPV0UpeGElMK/X4g6bo0c7A1PH9BM5EvyCGWN4djhK9TA4PPPr/15TdePBp2kDcGRiYg
         W9pC7hemiAwaYyL8JI3uLPCAxV4e4eZYcqQhJ+/rYXqNBpARvWd3Pf2tBihRvcwrCr7P
         204A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nKEIfrJKPGEz8pFXZhstnqQjRimIfAQvEIfn2EHeg1U=;
        b=LFK+n3ZOTkvojHXK2hyHYm6lBs3zsM+27iQCnDfo3TDKxkoWyj7VzoOJ6KRCSZJ9hV
         vGk7exDrbqQItCZcygSOeq0a0FOgQa7/gPX1TLOdXlIbH6P/GHx4ASY8FNEvQULEtd3C
         zhNMzIEtlQ8JKtSU55POYvIQJutq75YbB2GSHcuuajPkJvozattdRqhsjHmAuDp8am5S
         Nt+s0MWM4RAbm6+uW8tEgNdUYlJX+XJamJ6VvhDMQixmmHhvA+vF5uigINvnfPRGfGi9
         T09tbc2iYsseh4ciQMmMSQslv1cfht7QvU/Cj2WukUP8AQqX538Bjq+J6jiEer+UUIvq
         IBXA==
X-Gm-Message-State: AOAM533497XOR9y9xmnov5ALwLea+VdBqh4njyeyZ5bNbKdmIpxGIHCs
        g7WQ5QZGO0dlEFkhowXpLvqRDXkMrqsu0Vhk91A=
X-Google-Smtp-Source: ABdhPJwNVRff5EnA98Bxi8W/rhhTmGvicKlDkMN9fEFFqsudF49/ErSr6f2B6r6USnT+ZWOQ6gsezlAFDRZBItcPCLs=
X-Received: by 2002:a17:907:94c2:: with SMTP id dn2mr55373070ejc.325.1638142326561;
 Sun, 28 Nov 2021 15:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20211120122022.1052768-1-aford173@gmail.com> <1637685269.730771.3442927.nullmailer@robh.at.kernel.org>
 <YaQN6EFpmYxvLJwo@robh.at.kernel.org>
In-Reply-To: <YaQN6EFpmYxvLJwo@robh.at.kernel.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 28 Nov 2021 17:31:55 -0600
Message-ID: <CAHCN7x+Fj3iVFrV08FY4zzGhNA8tKEFmHvG=ukYfHRnGp4cTvA@mail.gmail.com>
Subject: Re: [RESEND PATCH V5] dt-bindings: soc: imx: Add binding doc for spba bus
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 5:17 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Nov 23, 2021 at 09:34:29AM -0700, Rob Herring wrote:
> > On Sat, 20 Nov 2021 06:20:22 -0600, Adam Ford wrote:
> > > Add binding doc for fsl,spba-bus.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > >
> >
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
>
> Do you intend to fix all the node names or perhaps also allow for
> 'spba-bus' at least.

My intent is to allow for spba-bus, but I am still learning the yaml.

I assume pattern: "^bus(@[0-9a-f]+)?$" needs to change, but I am not
sure of the syntax to make it support spba-bus.  Can you give me a
pointer?

thanks

adam
>
> >
> > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > This will change in the future.
> >
> > Full log is available here: https://patchwork.ozlabs.org/patch/1557604
> >
> >
> > spba@50000000: $nodename:0: 'spba@50000000' does not match '^bus(@[0-9a-f]+)?$'
> >       arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dt.yaml
> >       arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dt.yaml
> >       arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dt.yaml
> >       arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dt.yaml
> >       arch/arm/boot/dts/imx25-karo-tx25.dt.yaml
> >       arch/arm/boot/dts/imx25-pdk.dt.yaml
> >       arch/arm/boot/dts/imx31-bug.dt.yaml
> >       arch/arm/boot/dts/imx31-lite.dt.yaml
> >       arch/arm/boot/dts/imx50-evk.dt.yaml
> >       arch/arm/boot/dts/imx50-kobo-aura.dt.yaml
> >       arch/arm/boot/dts/imx53-ard.dt.yaml
> >       arch/arm/boot/dts/imx53-cx9020.dt.yaml
> >       arch/arm/boot/dts/imx53-kp-ddc.dt.yaml
> >       arch/arm/boot/dts/imx53-kp-hsc.dt.yaml
> >       arch/arm/boot/dts/imx53-m53evk.dt.yaml
> >       arch/arm/boot/dts/imx53-m53menlo.dt.yaml
> >       arch/arm/boot/dts/imx53-mba53.dt.yaml
> >       arch/arm/boot/dts/imx53-ppd.dt.yaml
> >       arch/arm/boot/dts/imx53-qsb.dt.yaml
> >       arch/arm/boot/dts/imx53-qsrb.dt.yaml
> >       arch/arm/boot/dts/imx53-smd.dt.yaml
> >       arch/arm/boot/dts/imx53-tx53-x03x.dt.yaml
> >       arch/arm/boot/dts/imx53-tx53-x13x.dt.yaml
> >       arch/arm/boot/dts/imx53-usbarmory.dt.yaml
> >       arch/arm/boot/dts/imx53-voipac-bsb.dt.yaml
> >
> > spba@70000000: $nodename:0: 'spba@70000000' does not match '^bus(@[0-9a-f]+)?$'
> >       arch/arm/boot/dts/imx51-apf51dev.dt.yaml
> >       arch/arm/boot/dts/imx51-apf51.dt.yaml
> >       arch/arm/boot/dts/imx51-babbage.dt.yaml
> >       arch/arm/boot/dts/imx51-digi-connectcore-jsk.dt.yaml
> >       arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dt.yaml
> >       arch/arm/boot/dts/imx51-ts4800.dt.yaml
> >       arch/arm/boot/dts/imx51-zii-rdu1.dt.yaml
> >       arch/arm/boot/dts/imx51-zii-scu2-mezz.dt.yaml
> >       arch/arm/boot/dts/imx51-zii-scu3-esb.dt.yaml
> >
> > spba-bus@2000000: $nodename:0: 'spba-bus@2000000' does not match '^bus(@[0-9a-f]+)?$'
> >       arch/arm/boot/dts/imx6dl-alti6p.dt.yaml
> >       arch/arm/boot/dts/imx6dl-apf6dev.dt.yaml
> >       arch/arm/boot/dts/imx6dl-aristainetos2_4.dt.yaml
> >       arch/arm/boot/dts/imx6dl-aristainetos2_7.dt.yaml
> >       arch/arm/boot/dts/imx6dl-aristainetos_4.dt.yaml
> >       arch/arm/boot/dts/imx6dl-aristainetos_7.dt.yaml
> >       arch/arm/boot/dts/imx6dl-b105pv2.dt.yaml
> >       arch/arm/boot/dts/imx6dl-b105v2.dt.yaml
> >       arch/arm/boot/dts/imx6dl-b125pv2.dt.yaml
> >       arch/arm/boot/dts/imx6dl-b125v2.dt.yaml
> >       arch/arm/boot/dts/imx6dl-b155v2.dt.yaml
> >       arch/arm/boot/dts/imx6dl-colibri-eval-v3.dt.yaml
> >       arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dt.yaml
> >       arch/arm/boot/dts/imx6dl-cubox-i.dt.yaml
> >       arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dt.yaml
> >       arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dt.yaml
> >       arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dt.yaml
> >       arch/arm/boot/dts/imx6dl-dhcom-picoitx.dt.yaml
> >       arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dt.yaml
> >       arch/arm/boot/dts/imx6dl-emcon-avari.dt.yaml
> >       arch/arm/boot/dts/imx6dl-gw51xx.dt.yaml
> >       arch/arm/boot/dts/imx6dl-gw52xx.dt.yaml
> >       arch/arm/boot/dts/imx6dl-gw53xx.dt.yaml
> >       arch/arm/boot/dts/imx6dl-gw54xx.dt.yaml
> >       arch/arm/boot/dts/imx6dl-gw551x.dt.yaml
> >       arch/arm/boot/dts/imx6dl-gw552x.dt.yaml
> >       arch/arm/boot/dts/imx6dl-gw553x.dt.yaml
> >       arch/arm/boot/dts/imx6dl-gw560x.dt.yaml
> >       arch/arm/boot/dts/imx6dl-gw5903.dt.yaml
> >       arch/arm/boot/dts/imx6dl-gw5904.dt.yaml
> >       arch/arm/boot/dts/imx6dl-gw5907.dt.yaml
> >       arch/arm/boot/dts/imx6dl-gw5910.dt.yaml
> >       arch/arm/boot/dts/imx6dl-gw5912.dt.yaml
> >       arch/arm/boot/dts/imx6dl-gw5913.dt.yaml
> >       arch/arm/boot/dts/imx6dl-hummingboard2.dt.yaml
> >       arch/arm/boot/dts/imx6dl-hummingboard2-emmc-som-v15.dt.yaml
> >       arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dt.yaml
> >       arch/arm/boot/dts/imx6dl-hummingboard.dt.yaml
> >       arch/arm/boot/dts/imx6dl-hummingboard-emmc-som-v15.dt.yaml
> >       arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dt.yaml
> >       arch/arm/boot/dts/imx6dl-icore.dt.yaml
> >       arch/arm/boot/dts/imx6dl-icore-mipi.dt.yaml
> >       arch/arm/boot/dts/imx6dl-icore-rqs.dt.yaml
> >       arch/arm/boot/dts/imx6dl-lanmcu.dt.yaml
> >       arch/arm/boot/dts/imx6dl-mamoj.dt.yaml
> >       arch/arm/boot/dts/imx6dl-nit6xlite.dt.yaml
> >       arch/arm/boot/dts/imx6dl-nitrogen6x.dt.yaml
> >       arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dt.yaml
> >       arch/arm/boot/dts/imx6dl-phytec-pbab01.dt.yaml
> >       arch/arm/boot/dts/imx6dl-pico-dwarf.dt.yaml
> >       arch/arm/boot/dts/imx6dl-pico-hobbit.dt.yaml
> >       arch/arm/boot/dts/imx6dl-pico-nymph.dt.yaml
> >       arch/arm/boot/dts/imx6dl-pico-pi.dt.yaml
> >       arch/arm/boot/dts/imx6dl-plybas.dt.yaml
> >       arch/arm/boot/dts/imx6dl-plym2m.dt.yaml
> >       arch/arm/boot/dts/imx6dl-prtmvt.dt.yaml
> >       arch/arm/boot/dts/imx6dl-prtrvt.dt.yaml
> >       arch/arm/boot/dts/imx6dl-prtvt7.dt.yaml
> >       arch/arm/boot/dts/imx6dl-rex-basic.dt.yaml
> >       arch/arm/boot/dts/imx6dl-riotboard.dt.yaml
> >       arch/arm/boot/dts/imx6dl-sabreauto.dt.yaml
> >       arch/arm/boot/dts/imx6dl-sabrelite.dt.yaml
> >       arch/arm/boot/dts/imx6dl-sabresd.dt.yaml
> >       arch/arm/boot/dts/imx6dl-savageboard.dt.yaml
> >       arch/arm/boot/dts/imx6dl-skov-revc-lt2.dt.yaml
> >       arch/arm/boot/dts/imx6dl-skov-revc-lt6.dt.yaml
> >       arch/arm/boot/dts/imx6dl-solidsense.dt.yaml
> >       arch/arm/boot/dts/imx6dl-ts4900.dt.yaml
> >       arch/arm/boot/dts/imx6dl-ts7970.dt.yaml
> >       arch/arm/boot/dts/imx6dl-tx6dl-comtft.dt.yaml
> >       arch/arm/boot/dts/imx6dl-tx6s-8034.dt.yaml
> >       arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dt.yaml
> >       arch/arm/boot/dts/imx6dl-tx6s-8035.dt.yaml
> >       arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dt.yaml
> >       arch/arm/boot/dts/imx6dl-tx6u-801x.dt.yaml
> >       arch/arm/boot/dts/imx6dl-tx6u-8033.dt.yaml
> >       arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dt.yaml
> >       arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dt.yaml
> >       arch/arm/boot/dts/imx6dl-tx6u-811x.dt.yaml
> >       arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dt.yaml
> >       arch/arm/boot/dts/imx6dl-udoo.dt.yaml
> >       arch/arm/boot/dts/imx6dl-victgo.dt.yaml
> >       arch/arm/boot/dts/imx6dl-vicut1.dt.yaml
> >       arch/arm/boot/dts/imx6dl-wandboard.dt.yaml
> >       arch/arm/boot/dts/imx6dl-wandboard-revb1.dt.yaml
> >       arch/arm/boot/dts/imx6dl-wandboard-revd1.dt.yaml
> >       arch/arm/boot/dts/imx6dl-yapp4-draco.dt.yaml
> >       arch/arm/boot/dts/imx6dl-yapp4-hydra.dt.yaml
> >       arch/arm/boot/dts/imx6dl-yapp4-orion.dt.yaml
> >       arch/arm/boot/dts/imx6dl-yapp4-ursa.dt.yaml
> >       arch/arm/boot/dts/imx6q-apalis-eval.dt.yaml
> >       arch/arm/boot/dts/imx6q-apalis-ixora.dt.yaml
> >       arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dt.yaml
> >       arch/arm/boot/dts/imx6q-apf6dev.dt.yaml
> >       arch/arm/boot/dts/imx6q-arm2.dt.yaml
> >       arch/arm/boot/dts/imx6q-b450v3.dt.yaml
> >       arch/arm/boot/dts/imx6q-b650v3.dt.yaml
> >       arch/arm/boot/dts/imx6q-b850v3.dt.yaml
> >       arch/arm/boot/dts/imx6q-cm-fx6.dt.yaml
> >       arch/arm/boot/dts/imx6q-cubox-i.dt.yaml
> >       arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dt.yaml
> >       arch/arm/boot/dts/imx6q-cubox-i-som-v15.dt.yaml
> >       arch/arm/boot/dts/imx6q-dfi-fs700-m60.dt.yaml
> >       arch/arm/boot/dts/imx6q-dhcom-pdk2.dt.yaml
> >       arch/arm/boot/dts/imx6q-display5-tianma-tm070-1280x768.dt.yaml
> >       arch/arm/boot/dts/imx6q-dmo-edmqmx6.dt.yaml
> >       arch/arm/boot/dts/imx6q-dms-ba16.dt.yaml
> >       arch/arm/boot/dts/imx6q-ds.dt.yaml
> >       arch/arm/boot/dts/imx6q-emcon-avari.dt.yaml
> >       arch/arm/boot/dts/imx6q-evi.dt.yaml
> >       arch/arm/boot/dts/imx6q-gk802.dt.yaml
> >       arch/arm/boot/dts/imx6q-gw51xx.dt.yaml
> >       arch/arm/boot/dts/imx6q-gw52xx.dt.yaml
> >       arch/arm/boot/dts/imx6q-gw53xx.dt.yaml
> >       arch/arm/boot/dts/imx6q-gw5400-a.dt.yaml
> >       arch/arm/boot/dts/imx6q-gw54xx.dt.yaml
> >       arch/arm/boot/dts/imx6q-gw551x.dt.yaml
> >       arch/arm/boot/dts/imx6q-gw552x.dt.yaml
> >       arch/arm/boot/dts/imx6q-gw553x.dt.yaml
> >       arch/arm/boot/dts/imx6q-gw560x.dt.yaml
> >       arch/arm/boot/dts/imx6q-gw5903.dt.yaml
> >       arch/arm/boot/dts/imx6q-gw5904.dt.yaml
> >       arch/arm/boot/dts/imx6q-gw5907.dt.yaml
> >       arch/arm/boot/dts/imx6q-gw5910.dt.yaml
> >       arch/arm/boot/dts/imx6q-gw5912.dt.yaml
> >       arch/arm/boot/dts/imx6q-gw5913.dt.yaml
> >       arch/arm/boot/dts/imx6q-h100.dt.yaml
> >       arch/arm/boot/dts/imx6q-hummingboard2.dt.yaml
> >       arch/arm/boot/dts/imx6q-hummingboard2-emmc-som-v15.dt.yaml
> >       arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dt.yaml
> >       arch/arm/boot/dts/imx6q-hummingboard.dt.yaml
> >       arch/arm/boot/dts/imx6q-hummingboard-emmc-som-v15.dt.yaml
> >       arch/arm/boot/dts/imx6q-hummingboard-som-v15.dt.yaml
> >       arch/arm/boot/dts/imx6q-icore.dt.yaml
> >       arch/arm/boot/dts/imx6q-icore-mipi.dt.yaml
> >       arch/arm/boot/dts/imx6q-icore-ofcap10.dt.yaml
> >       arch/arm/boot/dts/imx6q-icore-ofcap12.dt.yaml
> >       arch/arm/boot/dts/imx6q-icore-rqs.dt.yaml
> >       arch/arm/boot/dts/imx6q-kp-tpc.dt.yaml
> >       arch/arm/boot/dts/imx6q-logicpd.dt.yaml
> >       arch/arm/boot/dts/imx6q-marsboard.dt.yaml
> >       arch/arm/boot/dts/imx6q-mccmon6.dt.yaml
> >       arch/arm/boot/dts/imx6q-nitrogen6_max.dt.yaml
> >       arch/arm/boot/dts/imx6q-nitrogen6_som2.dt.yaml
> >       arch/arm/boot/dts/imx6q-nitrogen6x.dt.yaml
> >       arch/arm/boot/dts/imx6q-novena.dt.yaml
> >       arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dt.yaml
> >       arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dt.yaml
> >       arch/arm/boot/dts/imx6q-phytec-pbab01.dt.yaml
> >       arch/arm/boot/dts/imx6q-pico-dwarf.dt.yaml
> >       arch/arm/boot/dts/imx6q-pico-hobbit.dt.yaml
> >       arch/arm/boot/dts/imx6q-pico-nymph.dt.yaml
> >       arch/arm/boot/dts/imx6q-pico-pi.dt.yaml
> >       arch/arm/boot/dts/imx6q-pistachio.dt.yaml
> >       arch/arm/boot/dts/imx6qp-nitrogen6_max.dt.yaml
> >       arch/arm/boot/dts/imx6qp-nitrogen6_som2.dt.yaml
> >       arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dt.yaml
> >       arch/arm/boot/dts/imx6qp-prtwd3.dt.yaml
> >       arch/arm/boot/dts/imx6q-prti6q.dt.yaml
> >       arch/arm/boot/dts/imx6q-prtwd2.dt.yaml
> >       arch/arm/boot/dts/imx6qp-sabreauto.dt.yaml
> >       arch/arm/boot/dts/imx6qp-sabresd.dt.yaml
> >       arch/arm/boot/dts/imx6qp-tx6qp-8037.dt.yaml
> >       arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dt.yaml
> >       arch/arm/boot/dts/imx6qp-tx6qp-8137.dt.yaml
> >       arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dt.yaml
> >       arch/arm/boot/dts/imx6qp-vicutp.dt.yaml
> >       arch/arm/boot/dts/imx6qp-wandboard-revd1.dt.yaml
> >       arch/arm/boot/dts/imx6qp-zii-rdu2.dt.yaml
> >       arch/arm/boot/dts/imx6q-rex-pro.dt.yaml
> >       arch/arm/boot/dts/imx6q-sabreauto.dt.yaml
> >       arch/arm/boot/dts/imx6q-sabrelite.dt.yaml
> >       arch/arm/boot/dts/imx6q-sabresd.dt.yaml
> >       arch/arm/boot/dts/imx6q-savageboard.dt.yaml
> >       arch/arm/boot/dts/imx6q-sbc6x.dt.yaml
> >       arch/arm/boot/dts/imx6q-skov-revc-lt2.dt.yaml
> >       arch/arm/boot/dts/imx6q-skov-revc-lt6.dt.yaml
> >       arch/arm/boot/dts/imx6q-skov-reve-mi1010ait-1cp1.dt.yaml
> >       arch/arm/boot/dts/imx6q-solidsense.dt.yaml
> >       arch/arm/boot/dts/imx6q-tbs2910.dt.yaml
> >       arch/arm/boot/dts/imx6q-ts4900.dt.yaml
> >       arch/arm/boot/dts/imx6q-ts7970.dt.yaml
> >       arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dt.yaml
> >       arch/arm/boot/dts/imx6q-tx6q-1010.dt.yaml
> >       arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dt.yaml
> >       arch/arm/boot/dts/imx6q-tx6q-1020.dt.yaml
> >       arch/arm/boot/dts/imx6q-tx6q-1036.dt.yaml
> >       arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dt.yaml
> >       arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dt.yaml
> >       arch/arm/boot/dts/imx6q-tx6q-1110.dt.yaml
> >       arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dt.yaml
> >       arch/arm/boot/dts/imx6q-udoo.dt.yaml
> >       arch/arm/boot/dts/imx6q-utilite-pro.dt.yaml
> >       arch/arm/boot/dts/imx6q-var-dt6customboard.dt.yaml
> >       arch/arm/boot/dts/imx6q-vicut1.dt.yaml
> >       arch/arm/boot/dts/imx6q-wandboard.dt.yaml
> >       arch/arm/boot/dts/imx6q-wandboard-revb1.dt.yaml
> >       arch/arm/boot/dts/imx6q-wandboard-revd1.dt.yaml
> >       arch/arm/boot/dts/imx6q-zii-rdu2.dt.yaml
> >       arch/arm/boot/dts/imx6s-dhcom-drc02.dt.yaml
> >       arch/arm/boot/dts/imx6sl-evk.dt.yaml
> >       arch/arm/boot/dts/imx6sll-evk.dt.yaml
> >       arch/arm/boot/dts/imx6sll-kobo-clarahd.dt.yaml
> >       arch/arm/boot/dts/imx6sll-kobo-librah2o.dt.yaml
> >       arch/arm/boot/dts/imx6sl-tolino-shine2hd.dt.yaml
> >       arch/arm/boot/dts/imx6sl-tolino-shine3.dt.yaml
> >       arch/arm/boot/dts/imx6sl-tolino-vision5.dt.yaml
> >       arch/arm/boot/dts/imx6sl-warp.dt.yaml
> >       arch/arm/boot/dts/imx6sx-nitrogen6sx.dt.yaml
> >       arch/arm/boot/dts/imx6sx-sabreauto.dt.yaml
> >       arch/arm/boot/dts/imx6sx-sdb.dt.yaml
> >       arch/arm/boot/dts/imx6sx-sdb-mqs.dt.yaml
> >       arch/arm/boot/dts/imx6sx-sdb-reva.dt.yaml
> >       arch/arm/boot/dts/imx6sx-sdb-sai.dt.yaml
> >       arch/arm/boot/dts/imx6sx-softing-vining-2000.dt.yaml
> >       arch/arm/boot/dts/imx6sx-udoo-neo-basic.dt.yaml
> >       arch/arm/boot/dts/imx6sx-udoo-neo-extended.dt.yaml
> >       arch/arm/boot/dts/imx6sx-udoo-neo-full.dt.yaml
> >       arch/arm/boot/dts/imx6ul-14x14-evk.dt.yaml
> >       arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dt.yaml
> >       arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dt.yaml
> >       arch/arm/boot/dts/imx6ul-geam.dt.yaml
> >       arch/arm/boot/dts/imx6ul-isiot-emmc.dt.yaml
> >       arch/arm/boot/dts/imx6ul-isiot-nand.dt.yaml
> >       arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dt.yaml
> >       arch/arm/boot/dts/imx6ul-kontron-n6310-s.dt.yaml
> >       arch/arm/boot/dts/imx6ull-14x14-evk.dt.yaml
> >       arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dt.yaml
> >       arch/arm/boot/dts/imx6ull-colibri-eval-v3.dt.yaml
> >       arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dt.yaml
> >       arch/arm/boot/dts/imx6ul-liteboard.dt.yaml
> >       arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dt.yaml
> >       arch/arm/boot/dts/imx6ull-opos6uldev.dt.yaml
> >       arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dt.yaml
> >       arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dt.yaml
> >       arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dt.yaml
> >       arch/arm/boot/dts/imx6ul-opos6uldev.dt.yaml
> >       arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dt.yaml
> >       arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dt.yaml
> >       arch/arm/boot/dts/imx6ul-pico-dwarf.dt.yaml
> >       arch/arm/boot/dts/imx6ul-pico-hobbit.dt.yaml
> >       arch/arm/boot/dts/imx6ul-pico-pi.dt.yaml
> >       arch/arm/boot/dts/imx6ul-prti6g.dt.yaml
> >       arch/arm/boot/dts/imx6ul-tx6ul-0010.dt.yaml
> >       arch/arm/boot/dts/imx6ul-tx6ul-0011.dt.yaml
> >       arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dt.yaml
> >       arch/arm/boot/dts/imx6ulz-14x14-evk.dt.yaml
> >
> > spba-bus@2240000: $nodename:0: 'spba-bus@2240000' does not match '^bus(@[0-9a-f]+)?$'
> >       arch/arm/boot/dts/imx6sx-nitrogen6sx.dt.yaml
> >       arch/arm/boot/dts/imx6sx-sabreauto.dt.yaml
> >       arch/arm/boot/dts/imx6sx-sdb.dt.yaml
> >       arch/arm/boot/dts/imx6sx-sdb-mqs.dt.yaml
> >       arch/arm/boot/dts/imx6sx-sdb-reva.dt.yaml
> >       arch/arm/boot/dts/imx6sx-sdb-sai.dt.yaml
> >       arch/arm/boot/dts/imx6sx-softing-vining-2000.dt.yaml
> >       arch/arm/boot/dts/imx6sx-udoo-neo-basic.dt.yaml
> >       arch/arm/boot/dts/imx6sx-udoo-neo-extended.dt.yaml
> >       arch/arm/boot/dts/imx6sx-udoo-neo-full.dt.yaml
> >
> > spba-bus@30000000: $nodename:0: 'spba-bus@30000000' does not match '^bus(@[0-9a-f]+)?$'
> >       arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dt.yaml
> >
> > spba-bus@30800000: $nodename:0: 'spba-bus@30800000' does not match '^bus(@[0-9a-f]+)?$'
> >       arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dt.yaml
> >       arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dt.yaml
> >       arch/arm/boot/dts/imx7d-cl-som-imx7.dt.yaml
> >       arch/arm/boot/dts/imx7d-colibri-aster.dt.yaml
> >       arch/arm/boot/dts/imx7d-colibri-emmc-aster.dt.yaml
> >       arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dt.yaml
> >       arch/arm/boot/dts/imx7d-colibri-eval-v3.dt.yaml
> >       arch/arm/boot/dts/imx7d-flex-concentrator.dt.yaml
> >       arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dt.yaml
> >       arch/arm/boot/dts/imx7d-mba7.dt.yaml
> >       arch/arm/boot/dts/imx7d-meerkat96.dt.yaml
> >       arch/arm/boot/dts/imx7d-nitrogen7.dt.yaml
> >       arch/arm/boot/dts/imx7d-pico-dwarf.dt.yaml
> >       arch/arm/boot/dts/imx7d-pico-hobbit.dt.yaml
> >       arch/arm/boot/dts/imx7d-pico-nymph.dt.yaml
> >       arch/arm/boot/dts/imx7d-pico-pi.dt.yaml
> >       arch/arm/boot/dts/imx7d-remarkable2.dt.yaml
> >       arch/arm/boot/dts/imx7d-sbc-imx7.dt.yaml
> >       arch/arm/boot/dts/imx7d-sdb.dt.yaml
> >       arch/arm/boot/dts/imx7d-sdb-reva.dt.yaml
> >       arch/arm/boot/dts/imx7d-sdb-sht11.dt.yaml
> >       arch/arm/boot/dts/imx7d-zii-rmu2.dt.yaml
> >       arch/arm/boot/dts/imx7d-zii-rpu2.dt.yaml
> >       arch/arm/boot/dts/imx7s-colibri-aster.dt.yaml
> >       arch/arm/boot/dts/imx7s-colibri-eval-v3.dt.yaml
> >       arch/arm/boot/dts/imx7s-mba7.dt.yaml
> >       arch/arm/boot/dts/imx7s-warp.dt.yaml
> >
> > spba-bus@50000000: $nodename:0: 'spba-bus@50000000' does not match '^bus(@[0-9a-f]+)?$'
> >       arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dt.yaml
> >       arch/arm/boot/dts/imx35-pdk.dt.yaml
> >
> >
