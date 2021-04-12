Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5D635C607
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbhDLMST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbhDLMSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:18:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F200C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 05:18:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id 12so12712453wrz.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 05:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=mD2WCI7vh6febNnOcdykE7h73ToD187sENDF2eGoMmA=;
        b=CfxEjZWJUxvLwhhaaCuCP5Rm4NIpWDecw4S39zdkc7TruMwOO4Ve0TcplR5/cGlFnI
         wJPSiUZ/1ZkCNBuDDPNviLxmJ5CAIyBz0yvHtrMRbJSKQELt+on2UW6Id3ZAbzqIcbPk
         tkrtMYQTr31H3aQ+4g+qNsUib6gF/Q3r6A0DXv/7X5+fHpyn2fpwlFtE53RpE7hW5MM4
         gSUlWLt4uhvCVuPOsuLE2basyeVS7dYQMCiwMV/bpGnDS+tQHkac4tNUECkMWHWdpE94
         ZueDbngMvTdyQW00SPRhLsYlTnuyc5l70Lj0xvRJJ6BdgdxoGKVH4OttdelV21e9iHYm
         cYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=mD2WCI7vh6febNnOcdykE7h73ToD187sENDF2eGoMmA=;
        b=uI1nH9OsTjAtbLOIslio9OV89BJHn+oseGPo+7Ka64zln6tXKqt+kqWv1HN5oIbLH5
         bxsSA791ErIt0s3K9z6jVpNACya1Bsyq4x+jgGCDV+ksZOHrBZwy09oH81hcihf/s12m
         MTbX4IY0QExMnpSqsuiSbACpmFkjwjNRZIGpVEEceKGRFaak8s8emE8RE2SiYgOddwRU
         NV61sn9Rwl2cJLkDCqoS0uAuNd4TIt6hA0JnDGGAVSno6S2oUh3CHWzRoxxHgvfBdJnz
         zXBQ31yDcpbTeOsKsqulnKuUFPi2WrQ46sqTVeIhoPCUpXccv7H4WUWMzw36aRlLYjpf
         0v1Q==
X-Gm-Message-State: AOAM531aa4Sn1kVZ0a7uLbUdz1Hea1PhozQO0cAxZ3vqdNn4bjzyMp1v
        51A48KCTVMVJ54UpAedtbDBdSQ==
X-Google-Smtp-Source: ABdhPJwOJVOh8tgBiNxX6i8lAXohBmpkRch6okXtGKxI10P/KPtK3enB/wU+qF76pJm2M1i4jnJPoQ==
X-Received: by 2002:adf:ea83:: with SMTP id s3mr7899651wrm.39.1618229879061;
        Mon, 12 Apr 2021 05:17:59 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id s21sm14984525wmc.10.2021.04.12.05.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 05:17:58 -0700 (PDT)
References: <20210410111356.467340-1-jbrunet@baylibre.com>
 <20210410111356.467340-5-jbrunet@baylibre.com>
 <0c8c3b5d-891a-9bfa-3bbc-4982542df38a@linaro.org>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] ASoC: lpass: use the clock provider API
In-reply-to: <0c8c3b5d-891a-9bfa-3bbc-4982542df38a@linaro.org>
Message-ID: <1jmtu38znu.fsf@starbuckisacylon.baylibre.com>
Date:   Mon, 12 Apr 2021 14:17:57 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 12 Apr 2021 at 11:38, Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> Thanks Jerome for the patch,
>
>
> On 10/04/2021 12:13, Jerome Brunet wrote:
>> Clock providers should be registered using the clk_hw API.
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>   sound/soc/codecs/lpass-va-macro.c  | 2 +-
>>   sound/soc/codecs/lpass-wsa-macro.c | 9 +++------
>>   2 files changed, 4 insertions(+), 7 deletions(-)
>> diff --git a/sound/soc/codecs/lpass-va-macro.c
>> b/sound/soc/codecs/lpass-va-macro.c
>> index 5294c57b2cd4..56b887301172 100644
>> --- a/sound/soc/codecs/lpass-va-macro.c
>> +++ b/sound/soc/codecs/lpass-va-macro.c
>> @@ -1343,7 +1343,7 @@ static int va_macro_register_fsgen_output(struct va_macro *va)
>>   	if (ret)
>>   		return ret;
>>   -	return of_clk_add_provider(np, of_clk_src_simple_get, va->hw.clk);
>> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &va->hw);
>
> Now that we convert this to devm, You missed error path and driver remove
> where we delete clk provider. This should be removed as well as part of
> this patch.

Indeed. I should not have switched to devm here - It was not really the
purpose of the patch. Habits I guess.

Do you prefer I stick with devm (with the suggested fix) or revert to the
no-devm way for the v2 ? It makes no difference to me TBH.

>
>
> This applies to both wsa and va macro.
>
> Thanks,
> srini
>>   }
>>     static int va_macro_validate_dmic_sample_rate(u32 dmic_sample_rate,
>> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
>> index e79a70386b4b..acb95e83c788 100644
>> --- a/sound/soc/codecs/lpass-wsa-macro.c
>> +++ b/sound/soc/codecs/lpass-wsa-macro.c
>> @@ -2337,10 +2337,9 @@ static const struct clk_ops swclk_gate_ops = {
>>   	.recalc_rate = swclk_recalc_rate,
>>   };
>>   -static struct clk *wsa_macro_register_mclk_output(struct wsa_macro
>> *wsa)
>> +static int wsa_macro_register_mclk_output(struct wsa_macro *wsa)
>>   {
>>   	struct device *dev = wsa->dev;
>> -	struct device_node *np = dev->of_node;
>>   	const char *parent_clk_name;
>>   	const char *clk_name = "mclk";
>>   	struct clk_hw *hw;
>> @@ -2358,11 +2357,9 @@ static struct clk *wsa_macro_register_mclk_output(struct wsa_macro *wsa)
>>   	hw = &wsa->hw;
>>   	ret = clk_hw_register(wsa->dev, hw);
>>   	if (ret)
>> -		return ERR_PTR(ret);
>> -
>> -	of_clk_add_provider(np, of_clk_src_simple_get, hw->clk);
>> +		return ret;
>>   -	return NULL;
>> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
>>   }
>>     static const struct snd_soc_component_driver wsa_macro_component_drv
>> = {
>> 

