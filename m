Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E8135BC14
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbhDLI0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbhDLI0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:26:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A6FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 01:26:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id w186so1744520wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 01:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UaKmap8VBg3qA/HYVgj8+5VJG7Je5+TY240hCc5hhQU=;
        b=D9bGG0D89YcdKYQVNMxqqEfkh5jnzAnYR+Z6iaiehla9H3/mJR7c0nc7W7/eAvgyum
         kRailtqXCfNQ85Q3Eb0gydmc0l+jUk4bujbqief4/2iss6t+H3yH1oR8OSj9Cgy+L2hv
         lXZHSsQGs71LQ4pU5ngrTQNTUmSIAaAHrTfgtNHcu4osdU0UFQBFfRDaNV/er6qwFjDY
         AGh8F6MyNG9DcSHPMH0q44SlYTFU7zLdKQAyiwLRoYgIxpZ6gg9UsCLqhqjwDBx20N2S
         boUYhk2Ybuy9TRkOE/X1wJGKMxWutsHaJvr30jjeTmKHh+K8exEx9l/3yks4rBBGn4N+
         /BVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UaKmap8VBg3qA/HYVgj8+5VJG7Je5+TY240hCc5hhQU=;
        b=hx/26zCF+HgQj2fJ/qgcztio6m9dVTPwcOhaO2gcYiKJ1QcU7VIv136k3n3jYforrn
         iJ38llBuywvi4RN8wmt6ze8ccDxENeUsqKwYZgIlPU4FBVGm16e4visw45LPKIWCpgia
         IkydCeG4nulScBoUQy+HhfCH71ahRDA/Jt+4lsHS1EvICDYda/JDUOuuCzmm2vSUYGFn
         teqs8VPeORc+YR2EFpFh3qgJyAa741quQor5N8Uar1jFeqDlmt7Mf8s2oCmvnZMHaVI1
         nJ2H4ohFxClxgBhsFaD6F8ceoHIlL/UFxxiZUNXmPW33KzNJY96NkuY+nsdk8B1HeCyB
         0JcA==
X-Gm-Message-State: AOAM530/zSEs1Z4ju826RzRcQyCEqePvPMHZhrdD54FomqA+IBnKyvwZ
        E+iItkl9mUePV8+IBUSK5tLm4A==
X-Google-Smtp-Source: ABdhPJwsfDxCETIVflyHJroKHGN4n7AsriRCdtoYopc7TlOeEXwsW8tArL9wGxUxG0peFRZCfJVPqA==
X-Received: by 2002:a1c:7ed3:: with SMTP id z202mr18155336wmc.136.1618215992476;
        Mon, 12 Apr 2021 01:26:32 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:4c21:b00e:ff79:bf20? ([2a01:e0a:90c:e290:4c21:b00e:ff79:bf20])
        by smtp.gmail.com with ESMTPSA id x25sm3642204wmj.34.2021.04.12.01.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 01:26:32 -0700 (PDT)
Subject: Re: [PATCH] gpu/drm: mediatek: hdmi: check for valid modes on MT8167
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabien Parent <fparent@baylibre.com>
References: <20210409084308.481185-1-narmstrong@baylibre.com>
 <CAAOTY_-gqN2HCLg6AABsXYzJoBxpN8FkMfjqWFu2q=6noiY1qg@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <e3bd95df-f5c9-2791-8112-348592b7a513@baylibre.com>
Date:   Mon, 12 Apr 2021 10:26:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAAOTY_-gqN2HCLg6AABsXYzJoBxpN8FkMfjqWFu2q=6noiY1qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2021 00:41, Chun-Kuang Hu wrote:
> Hi, Neil:
> 
> Neil Armstrong <narmstrong@baylibre.com> 於 2021年4月9日 週五 下午4:43寫道：
>>
>> On MT8167, only CEA modes and anything using a clock below 148500 is
>> supported for HDMI. This change adds some checks to make sure the
>> video format is OK for MT8167.
> 
> I think this patch should be separated to 3 patches. check CEA mode,
> check clock, add mt8167 hdmi support.

Ok

> 
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
>> index 8ee55f9e2954..991e2e935b93 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
>> @@ -148,6 +148,8 @@ struct hdmi_audio_param {
>>
>>  struct mtk_hdmi_conf {
>>         bool tz_disabled;
>> +       unsigned long max_mode_clock;
>> +       bool cea_modes_only;
>>  };
>>
>>  struct mtk_hdmi {
>> @@ -1259,6 +1261,13 @@ static int mtk_hdmi_conn_mode_valid(struct drm_connector *conn,
>>                         return MODE_BAD;
>>         }
>>
>> +       if (hdmi->conf->cea_modes_only && !drm_match_cea_mode(mode))
>> +               return MODE_BAD;
>> +
>> +       if (hdmi->conf->max_mode_clock &&
>> +           mode->clock > hdmi->conf->max_mode_clock)
>> +               return MODE_CLOCK_HIGH;
>> +
>>         if (mode->clock < 27000)
>>                 return MODE_CLOCK_LOW;
>>         if (mode->clock > 297000)
>> @@ -1810,10 +1819,18 @@ static const struct mtk_hdmi_conf mtk_hdmi_conf_mt2701 = {
>>         .tz_disabled = true,
>>  };
>>
>> +static const struct mtk_hdmi_conf mtk_hdmi_conf_mt8167 = {
>> +       .max_mode_clock = 148500,
>> +       .cea_modes_only = true,
>> +};
>> +
>>  static const struct of_device_id mtk_drm_hdmi_of_ids[] = {
>>         { .compatible = "mediatek,mt2701-hdmi",
>>           .data = &mtk_hdmi_conf_mt2701,
>>         },
>> +       { .compatible = "mediatek,mt8167-hdmi",
> 
> "mediatek,mt8167-hdmi" does not exist in binding document, so add this
> to binding document first.
> In addition, could you also transfer mediatek,hdmi.txt to yaml format?

Sure

Thanks,
Neil

> 
> Regards,
> Chun-Kuang.
> 
>> +         .data = &mtk_hdmi_conf_mt8167,
>> +       },
>>         { .compatible = "mediatek,mt8173-hdmi",
>>         },
>>         {}
>> --
>> 2.25.1
>>

