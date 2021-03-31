Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4386634FDDB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhCaKOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbhCaKN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:13:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CC7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 03:13:55 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso868873wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 03:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c4/jb/onpfRSCNwhLaXR762taSPSqHcBp79M2N1xunQ=;
        b=Lcry5IJiXguBsfACvMyWHzG123ZxOoCByNzxSLk1knbWacziXY0gJi7W5ClFZGM5lO
         VqnxbqBOc8M+mJGPJBWfcVI16e/+nhiXMyiZvYDtft3SEVcqofw4qWvLS4Dzbd7lGO3e
         Vm0CJFY11UAKaGNWVWgNws/PW8+Y1Svqjx024d1cFpskjiCOhRBWSEKJ0zXaQc7DFDXk
         q7xqTfX99kYiMga6OTpMwXYAvrWKURmhd1TwSnp18gr/4JV7+pKELYmKhcJt5nN8Csn1
         CCqbuw5vN+abcxr94yeNaDb8oJ740jgZhEKeiKQ+Ffk8ct3/RgGuWsrCDjA9RfSCp46C
         jk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c4/jb/onpfRSCNwhLaXR762taSPSqHcBp79M2N1xunQ=;
        b=SgUcJK8FFDWx9UYxUNPlQmwQ9MYAnkwlzt0QAwc5/yHoTeXt/rbVRVlhxCkv5tvO/1
         CRMSIYgM5FcjSbnaYQDbLVnHOD34pZuL5oi6tLzwgqxq49lBh1SINgLqYrCHzg+DBZCC
         nKUKZJnnxPtPk9nxUhoUJ4dqtV7/wuriRFrBMqJgb0NqKVijMm3ysgjjipFCo71vE/nA
         qAx7wLayBCFsYw8dVC+psYg0U06dsCzSLLGETtncWjO8qSYU7+WzYuV+aR3gCqyZfbP/
         R4xPkzYq0MtTyPfQSuj+Wv3yfSKEmQmrJpVLgzxtgW9E+oo+wcpHD3xln1u62q+N9hry
         HzLg==
X-Gm-Message-State: AOAM530ChrEcnG5Z7/yKxICja4HgxLqdUdlFptIrV/pBHRMyi1Kb4Vb6
        v7zj9hEf89Szw+yiIHkp59M=
X-Google-Smtp-Source: ABdhPJz/IVtF4RqfrQ3TZNSfCTUyxAjCrenQbl5KbDNp6EBM3919C7exvv1X8ZngNe2ulOqjcn0I8g==
X-Received: by 2002:a05:600c:4f4f:: with SMTP id m15mr2454196wmq.29.1617185634230;
        Wed, 31 Mar 2021 03:13:54 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id k4sm5483000wrd.9.2021.03.31.03.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 03:13:53 -0700 (PDT)
Subject: Re: [RESEND PATCH 1/2] arm64: defconfig: Allow mt8173-based boards to
 boot from usb
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Michael Walle <michael@walle.cc>, Nishanth Menon <nm@ti.com>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20210331090659.4169966-1-enric.balletbo@collabora.com>
 <CAJMQK-jO=yfXDa4t1WzNVmyoQnaBkQP1t1G3HgThWCRAseWk3g@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <a36f2b08-5e23-271f-f894-911ebdd85c5a@gmail.com>
Date:   Wed, 31 Mar 2021 12:13:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJMQK-jO=yfXDa4t1WzNVmyoQnaBkQP1t1G3HgThWCRAseWk3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/03/2021 11:15, Hsin-Yi Wang wrote:
> On Wed, Mar 31, 2021 at 5:07 PM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> Enable the option necessary to boot mt8173-based boards to boot from
>> usb devices, like its phy and the regulators needed to have proper
>> support.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

Both patches applied to v5.12-next/defconfig

Thanks!

> 
>> This is only a resend rebased on top of mainline to fix some trivial
>> conflicts.
>>
>>  arch/arm64/configs/defconfig | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index d612f633b771..7b4be3807b6d 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -448,6 +448,7 @@ CONFIG_I2C_GPIO=m
>>  CONFIG_I2C_IMX=y
>>  CONFIG_I2C_IMX_LPI2C=y
>>  CONFIG_I2C_MESON=y
>> +CONFIG_I2C_MT65XX=y
>>  CONFIG_I2C_MV64XXX=y
>>  CONFIG_I2C_OMAP=y
>>  CONFIG_I2C_OWL=y
>> @@ -594,6 +595,7 @@ CONFIG_MFD_EXYNOS_LPASS=m
>>  CONFIG_MFD_HI6421_PMIC=y
>>  CONFIG_MFD_HI655X_PMIC=y
>>  CONFIG_MFD_MAX77620=y
>> +CONFIG_MFD_MT6397=y
>>  CONFIG_MFD_SPMI_PMIC=y
>>  CONFIG_MFD_RK808=y
>>  CONFIG_MFD_SEC_CORE=y
>> @@ -611,6 +613,8 @@ CONFIG_REGULATOR_HI655X=y
>>  CONFIG_REGULATOR_MAX77620=y
>>  CONFIG_REGULATOR_MAX8973=y
>>  CONFIG_REGULATOR_MP8859=y
>> +CONFIG_REGULATOR_MT6358=y
>> +CONFIG_REGULATOR_MT6397=y
>>  CONFIG_REGULATOR_PCA9450=y
>>  CONFIG_REGULATOR_PF8X00=y
>>  CONFIG_REGULATOR_PFUZE100=y
>> @@ -787,6 +791,7 @@ CONFIG_USB_RENESAS_USBHS_HCD=m
>>  CONFIG_USB_RENESAS_USBHS=m
>>  CONFIG_USB_ACM=m
>>  CONFIG_USB_STORAGE=y
>> +CONFIG_USB_MTU3=y
>>  CONFIG_USB_MUSB_HDRC=y
>>  CONFIG_USB_MUSB_SUNXI=y
>>  CONFIG_USB_DWC3=y
>> @@ -988,6 +993,7 @@ CONFIG_OWL_PM_DOMAINS=y
>>  CONFIG_RASPBERRYPI_POWER=y
>>  CONFIG_FSL_DPAA=y
>>  CONFIG_FSL_MC_DPIO=y
>> +CONFIG_MTK_PMIC_WRAP=y
>>  CONFIG_QCOM_AOSS_QMP=y
>>  CONFIG_QCOM_COMMAND_DB=y
>>  CONFIG_QCOM_GENI_SE=y
>> @@ -1064,6 +1070,7 @@ CONFIG_PHY_HI6220_USB=y
>>  CONFIG_PHY_HISTB_COMBPHY=y
>>  CONFIG_PHY_HISI_INNO_USB2=y
>>  CONFIG_PHY_MVEBU_CP110_COMPHY=y
>> +CONFIG_PHY_MTK_TPHY=y
>>  CONFIG_PHY_QCOM_QMP=m
>>  CONFIG_PHY_QCOM_QUSB2=m
>>  CONFIG_PHY_QCOM_USB_HS=y
>> --
>> 2.30.2
>>
