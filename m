Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085C83A0E7F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbhFIIJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:09:40 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:41929 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbhFIIJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:09:35 -0400
Received: by mail-wr1-f53.google.com with SMTP id o3so6019981wri.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 01:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kFAOmJ8pJ4xgYGxPRlgaz8KsSajsnGo3Wjp6nlmAIho=;
        b=JQl1iTsPpKJgzW8kORR5X8+lCPr9bhpq/DZ86sXj6+s5jNdyGNIKIAVRMLyobxWgSY
         PCZJtVSIwyxkfJ/gQCKW6TGqbmBhTA/DBys2WIlKUgRa6NuWbTGyjJEgtioAQ+zq/Dul
         E0Q17XklnYgZuVsICX+fm1IlAEIF3qfnoAAS9r/MeTBHacY4C7mcLiddYncakgCWKOWH
         1L1JjRnRvMlXjluHnN8hcPHP48+hKYMXIAt3n1pOzWNIUF38ehnB8xZZQZzFOGz2ncAJ
         VBPPSv0JFCLzbB1tLmuPzrvEHkRnbyNc1VYzz4E3FCCdwFiG28ako+tjSTfKYOCPa68e
         7qTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kFAOmJ8pJ4xgYGxPRlgaz8KsSajsnGo3Wjp6nlmAIho=;
        b=YMDwCczRT4Lia/gtGUEGZF6/u8bd7yBmbuAR1L65IKNu0X/YtmLtMFvZi53yNhmwct
         f+nnqPqBvFPRU1qZXgHxxgd718uHR7U1uEXK7U3NZT/bqqwq6bnLiIAUMiX56CIW4OBW
         zavenzA+fd2XTTZ4LSuGRKhBvnkveUSdwes+knhLpLdza9pYA1As7Y+grV1gFfcgDGLV
         rrSBMHrd/3AyKlp3Xp7YAYlA4IRUYkPZu7KEQDiulgQJ8i04YwbBRDllPyYg6by8n7p0
         y/6+ig6zqJZCQ9VhhPtxvYchX74OyIba4PqXzgtNb6VFKZFS1KSuv8yg5a4UKf3u5toR
         53pw==
X-Gm-Message-State: AOAM533aLhW3Jq3ySGKwzGgy+lg4CagluadwVoljVPCgH6OV7D0vQmuQ
        MvjOeDWNQrO+T3CyEBrzNanvhwY9ySI=
X-Google-Smtp-Source: ABdhPJxRNr/D5jm2CzvTjkv/w83K9RYOChZVLyEVg5XG0Pd0GbC+Ehf93KQqDRoe9MGQAyK2g1F9Mg==
X-Received: by 2002:adf:b648:: with SMTP id i8mr20585813wre.425.1623225989103;
        Wed, 09 Jun 2021 01:06:29 -0700 (PDT)
Received: from ziggy.stardust (81.172.61.185.dyn.user.ono.com. [81.172.61.185])
        by smtp.gmail.com with ESMTPSA id k12sm5328590wmr.2.2021.06.09.01.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 01:06:28 -0700 (PDT)
Subject: Re: [PATCH 2/2] soc: mediatek: pwrap: add pwrap driver for MT8195 SoC
To:     Fei Shao <fshao@chromium.org>, James Lo <james.lo@mediatek.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Henry Chen <henryc.chen@mediatek.com>
References: <20210602112050.12338-1-james.lo@mediatek.com>
 <20210602112050.12338-3-james.lo@mediatek.com>
 <CAC=S1nhUB=6y1SXUvAuhdj69S36FQnp9nr9V65TtS72pxuoRTg@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <87ab50ff-bae3-b2a3-1e54-642cdce3600d@gmail.com>
Date:   Wed, 9 Jun 2021 10:06:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAC=S1nhUB=6y1SXUvAuhdj69S36FQnp9nr9V65TtS72pxuoRTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2021 09:51, Fei Shao wrote:
> On Wed, Jun 2, 2021 at 7:21 PM James Lo <james.lo@mediatek.com> wrote:
>>
>> From: Henry Chen <henryc.chen@mediatek.com>
>>
>> MT8195 are highly integrated SoC and use PMIC_MT6359 for
>> power management. This patch adds pwrap master driver to
>> access PMIC_MT6359.
>>
>> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
>> ---
>>  drivers/soc/mediatek/mtk-pmic-wrap.c | 35 ++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> index e4de75f35c33..952bc554f443 100644
>> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
>> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> @@ -961,6 +961,23 @@ static int mt8183_regs[] = {
>>         [PWRAP_WACS2_VLDCLR] =                  0xC28,
>>  };
>>
>> +static int mt8195_regs[] = {
>> +       [PWRAP_INIT_DONE2] =            0x0,
>> +       [PWRAP_STAUPD_CTRL] =           0x4C,
>> +       [PWRAP_TIMER_EN] =              0x3E4,
>> +       [PWRAP_INT_EN] =                0x420,
>> +       [PWRAP_INT_FLG] =               0x428,
>> +       [PWRAP_INT_CLR] =               0x42C,
>> +       [PWRAP_INT1_EN] =               0x450,
>> +       [PWRAP_INT1_FLG] =              0x458,
>> +       [PWRAP_INT1_CLR] =              0x45C,
>> +       [PWRAP_WACS2_CMD] =             0x880,
>> +       [PWRAP_SWINF_2_WDATA_31_0] =    0x884,
>> +       [PWRAP_SWINF_2_RDATA_31_0] =    0x894,
>> +       [PWRAP_WACS2_VLDCLR] =          0x8A4,
>> +       [PWRAP_WACS2_RDATA] =           0x8A8,
>> +};
>> +
>>  static int mt8516_regs[] = {
>>         [PWRAP_MUX_SEL] =               0x0,
>>         [PWRAP_WRAP_EN] =               0x4,
>> @@ -1066,6 +1083,7 @@ enum pwrap_type {
>>         PWRAP_MT8135,
>>         PWRAP_MT8173,
>>         PWRAP_MT8183,
>> +       PWRAP_MT8195,
>>         PWRAP_MT8516,
>>  };
>>
>> @@ -1525,6 +1543,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>>                 break;
>>         case PWRAP_MT6873:
>>         case PWRAP_MT8183:
>> +       case PWRAP_MT8195:
>>                 break;
>>         }
>>
>> @@ -2025,6 +2044,19 @@ static const struct pmic_wrapper_type pwrap_mt8183 = {
>>         .init_soc_specific = pwrap_mt8183_init_soc_specific,
>>  };
>>
>> +static struct pmic_wrapper_type pwrap_mt8195 = {
>> +       .regs = mt8195_regs,
>> +       .type = PWRAP_MT8195,
>> +       .arb_en_all = 0x777f, /* NEED CONFIRM */
>> +       .int_en_all = 0x180000, /* NEED CONFIRM */
> 
> Please get the confirmative values here then send the next patch, thanks.
> 

Yes please. You can send this as a follow-up patch, otherwise I'd need to remove
this from my queue, as I have overseen the fact that not all values are confirmed.

Regards,
Matthias
