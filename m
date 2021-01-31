Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE092309CC5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhAaOSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbhAaN36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 08:29:58 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A168AC0613D6;
        Sun, 31 Jan 2021 05:15:56 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v15so13669759wrx.4;
        Sun, 31 Jan 2021 05:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z96GBUCs0M5u1QWQOLFBuEN34fEFOJsks2+1bXtFwB8=;
        b=cJz8+N367PNdVSLb39XzmLY/GhXLdCl6o857tgtkGnssNbT35c8Ej/tJPaEUPp87Fh
         nEiH2ap/4tavdV1M3Qkmlpo8uhB7lSyVQMPrZ+jUKu/hgCTC0KuK9zL3pm4vSxae/uDu
         Q1JqLaIqRo5tCHUIWUOCFATNMFZJ41EMu8hw6kSQKnviGB4XTR74dhK1jXjeF9DCyv11
         BJZxXBsYpEJYfaVdFxm3X6iyntL/FYqaoTklGPoRjgDxN/WC5HgVW2weBS6hm2jAeLRu
         6SWxjKkg/7JaBR/FKWOOzVzHy68fdcQeX5ZzW+paTZSZb/Re96hl5UuYXPdlHDmkl6Ke
         Y5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z96GBUCs0M5u1QWQOLFBuEN34fEFOJsks2+1bXtFwB8=;
        b=a/5D/Ysh+54K7ss12sXZGMfGpweZkVa4psJmNmzZBUnQgLmcX9i7U4s9a7AoiPj7sU
         oAGc0nwKQAGKi2KTMxZUptbPf0rZ3IQ1fJlj2C4n+rN0++Z0N9Y86gQg/YrAd00rt90c
         B3IiaCkjIIYO9fCpx63rtxSqbDfZr5xPvc9Un1ZxhmbZyaOHL4PR0slUDxEEMLRoZwoN
         MYVbsY/ZXRTHyQzSYTPVHB7Rl8B5mJrmb3Qm+OpyGx/PjJF8yMyy2rsECzqrubuwuiBn
         gcercR8LAH//XonHdcHKt+JrmOBZCv0Yl8UKB7TTOhje/DvaDVPGmek5tpoPmtdiTeJ2
         SToA==
X-Gm-Message-State: AOAM531eZajUhpqFwWHqnA82FcyLOtyyMkXzf8U7oLSMo5De7xdSRiwE
        fibMc7G+rUODrx6oNZyGlIs=
X-Google-Smtp-Source: ABdhPJygmlyoGE8kXJ+MPqHsL7t2Uo5PpDqMOOp+jvdNwCfwSH7MHwOuhSMTjefcOD+R+Fo/NDM8cA==
X-Received: by 2002:a5d:58c2:: with SMTP id o2mr13561306wrf.31.1612098955213;
        Sun, 31 Jan 2021 05:15:55 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id h14sm5506478wmq.39.2021.01.31.05.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 05:15:54 -0800 (PST)
Subject: Re: [PATCH v4 2/5] soc: mediatek: pwrap: add arbiter capability
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Fei Shao <fshao@chromium.org>,
        Argus Lin <argus.lin@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
References: <1605700894-32699-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1605700894-32699-3-git-send-email-hsin-hsiung.wang@mediatek.com>
 <CANMq1KDsNRk0FWDO3bnbhLrXPhW7O_OVD_a7Q01+ZvuGWL3dhA@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <79cc3385-ad65-db14-124d-53cd69c979be@gmail.com>
Date:   Sun, 31 Jan 2021 14:15:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CANMq1KDsNRk0FWDO3bnbhLrXPhW7O_OVD_a7Q01+ZvuGWL3dhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/12/2020 03:33, Nicolas Boichat wrote:
> On Wed, Nov 18, 2020 at 8:08 PM Hsin-Hsiung Wang
> <hsin-hsiung.wang@mediatek.com> wrote:
>>
>> Add arbiter capability for pwrap driver.
>> The arbiter capability uses new design to judge the priority and latency
>> for multi-channel.
>> This patch is preparing for adding mt6873/8192 pwrap support.
>>
>> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
>> ---
>>  drivers/soc/mediatek/mtk-pmic-wrap.c | 57 ++++++++++++++++++++++++++++++------
>>  1 file changed, 48 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> index c897205..5678f46 100644
>> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
>> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> @@ -25,10 +25,12 @@
>>
>>  /* macro for wrapper status */
>>  #define PWRAP_GET_WACS_RDATA(x)                (((x) >> 0) & 0x0000ffff)
>> +#define PWRAP_GET_WACS_ARB_FSM(x)      (((x) >> 1) & 0x00000007)
>>  #define PWRAP_GET_WACS_FSM(x)          (((x) >> 16) & 0x00000007)
>>  #define PWRAP_GET_WACS_REQ(x)          (((x) >> 19) & 0x00000001)
>>  #define PWRAP_STATE_SYNC_IDLE0         BIT(20)
>>  #define PWRAP_STATE_INIT_DONE0         BIT(21)
>> +#define PWRAP_STATE_INIT_DONE1         BIT(15)
>>
>>  /* macro for WACS FSM */
>>  #define PWRAP_WACS_FSM_IDLE            0x00
>> @@ -74,6 +76,7 @@
>>  #define PWRAP_CAP_DCM          BIT(2)
>>  #define PWRAP_CAP_INT1_EN      BIT(3)
>>  #define PWRAP_CAP_WDT_SRC1     BIT(4)
>> +#define PWRAP_CAP_ARB          BIT(5)
>>
>>  /* defines for slave device wrapper registers */
>>  enum dew_regs {
>> @@ -340,6 +343,8 @@ enum pwrap_regs {
>>         PWRAP_DCM_DBC_PRD,
>>         PWRAP_EINT_STA0_ADR,
>>         PWRAP_EINT_STA1_ADR,
>> +       PWRAP_SWINF_2_WDATA_31_0,
>> +       PWRAP_SWINF_2_RDATA_31_0,
>>
>>         /* MT2701 only regs */
>>         PWRAP_ADC_CMD_ADDR,
>> @@ -1108,14 +1113,22 @@ static void pwrap_writel(struct pmic_wrapper *wrp, u32 val, enum pwrap_regs reg)
>>
>>  static bool pwrap_is_fsm_idle(struct pmic_wrapper *wrp)
>>  {
>> -       u32 val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
>> +       u32 val;
>> +
>> +       val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
>> +       if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
>> +               return PWRAP_GET_WACS_ARB_FSM(val) == PWRAP_WACS_FSM_IDLE;
>>
>>         return PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_IDLE;
>>  }
>>
>>  static bool pwrap_is_fsm_vldclr(struct pmic_wrapper *wrp)
>>  {
>> -       u32 val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
>> +       u32 val;
>> +
>> +       val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
>> +       if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
>> +               return PWRAP_GET_WACS_ARB_FSM(val) == PWRAP_WACS_FSM_WFVLDCLR;
> 
> This code is now copied twice. Do you think it'd be better to create a
> new function?
> 
> static u32 pwrap_get_fsm_state(struct pmic_wrapper *wrp) {
>    if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
>       return PWRAP_GET_WACS_ARB_FSM(val);
>    else
>       return PWRAP_GET_WACS_FSM(val);
> }
> 
>>
>>         return PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_WFVLDCLR;
>>  }
>> @@ -1165,6 +1178,7 @@ static int pwrap_wait_for_state(struct pmic_wrapper *wrp,
>>  static int pwrap_read16(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
>>  {
>>         int ret;
>> +       u32 val;
>>
>>         ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
>>         if (ret) {
>> @@ -1172,13 +1186,21 @@ static int pwrap_read16(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
>>                 return ret;
>>         }
>>
>> -       pwrap_writel(wrp, (adr >> 1) << 16, PWRAP_WACS2_CMD);
>> +       if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
>> +               val = adr;
>> +       else
>> +               val = (adr >> 1) << 16;
>> +       pwrap_writel(wrp, val, PWRAP_WACS2_CMD);
>>
>>         ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_vldclr);
>>         if (ret)
>>                 return ret;
>>
>> -       *rdata = PWRAP_GET_WACS_RDATA(pwrap_readl(wrp, PWRAP_WACS2_RDATA));
>> +       if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
>> +               val = pwrap_readl(wrp, PWRAP_SWINF_2_RDATA_31_0);
>> +       else
>> +               val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
>> +       *rdata = PWRAP_GET_WACS_RDATA(val);
>>
>>         pwrap_writel(wrp, 1, PWRAP_WACS2_VLDCLR);
>>
>> @@ -1228,8 +1250,13 @@ static int pwrap_write16(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
>>                 return ret;
>>         }
>>
>> -       pwrap_writel(wrp, (1 << 31) | ((adr >> 1) << 16) | wdata,
>> -                    PWRAP_WACS2_CMD);
>> +       if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB)) {
>> +               pwrap_writel(wrp, wdata, PWRAP_SWINF_2_WDATA_31_0);
>> +               pwrap_writel(wrp, BIT(29) | adr, PWRAP_WACS2_CMD);
>> +       } else {
>> +               pwrap_writel(wrp, BIT(31) | ((adr >> 1) << 16) | wdata,
>> +                            PWRAP_WACS2_CMD);
>> +       }
>>
>>         return 0;
>>  }
>> @@ -2022,6 +2049,7 @@ MODULE_DEVICE_TABLE(of, of_pwrap_match_tbl);
>>  static int pwrap_probe(struct platform_device *pdev)
>>  {
>>         int ret, irq;
>> +       u32 mask_done;
>>         struct pmic_wrapper *wrp;
>>         struct device_node *np = pdev->dev.of_node;
>>         const struct of_device_id *of_slave_id = NULL;
>> @@ -2116,14 +2144,21 @@ static int pwrap_probe(struct platform_device *pdev)
>>                 }
>>         }
>>
>> -       if (!(pwrap_readl(wrp, PWRAP_WACS2_RDATA) & PWRAP_STATE_INIT_DONE0)) {
>> +       if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
>> +               mask_done = PWRAP_STATE_INIT_DONE1;
>> +       else
>> +               mask_done = PWRAP_STATE_INIT_DONE0;
>> +
>> +       if (!(pwrap_readl(wrp, PWRAP_WACS2_RDATA) & mask_done)) {
>>                 dev_dbg(wrp->dev, "initialization isn't finished\n");
>>                 ret = -ENODEV;
>>                 goto err_out2;
>>         }
>>
>>         /* Initialize watchdog, may not be done by the bootloader */
>> -       pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
>> +       if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
>> +               pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
>> +
> 
> To expand on Matthias' question on v3
> (https://patchwork.kernel.org/project/linux-mediatek/patch/1600686235-27979-3-git-send-email-hsin-hsiung.wang@mediatek.com/):
> is there any PWRAP implementation where a design with an arbiter is
> still able to control the watchdog?
> 
> If not, at the very least, it'd be good to expand the comment above
> (e.g. "designs with arbiter support cannot change the watchdog
> timer").
> 
>>         /*
>>          * Since STAUPD was not used on mt8173 platform,
>>          * so STAUPD of WDT_SRC which should be turned off
>> @@ -2132,7 +2167,11 @@ static int pwrap_probe(struct platform_device *pdev)
>>         if (HAS_CAP(wrp->master->caps, PWRAP_CAP_WDT_SRC1))
>>                 pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN_1);
>>
>> -       pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
>> +       if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> 
> Please invert this if test:
> 
> if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
>    ... 0x3 ...
> else
>    ... 0x1 ...
> 
>> +               pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
>> +       else
>> +               pwrap_writel(wrp, 0x3, PWRAP_TIMER_EN);
>> +

Thanks for the review Nicolas, I think with these two comments addressed the
patch is ready for mainline. Given of course that 4/5 isn't a hack with all the
registers being not defined.

Regards,
Matthias

>>         pwrap_writel(wrp, wrp->master->int_en_all, PWRAP_INT_EN);
>>         /*
>>          * We add INT1 interrupt to handle starvation and request exception
>> --
>> 2.6.4
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
