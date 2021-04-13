Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1197935D8E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbhDMHcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbhDMHcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:32:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875C6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:31:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id w186so3617669wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=I0tKIcGAnmGzt7gEhrs4pRS1r2Q74lYwZyR49l7q3W4=;
        b=s9WMcgFohkgE20WsAj9CXlV7WD1zYY9OWiuDjIFtC6KA4jVR76cLXh09qK5IL7ZoG+
         Yue22tCXfmjieQ3qMNvUV4GBD0bRFkH6fVyEcqaS5jtOBfUi2+WfQzHRhwrp36hZstv7
         ZhudGEdVmABoHwZw5ag0jfU7Is3+wiBpwOq0MPGaemjfShNUaHZJr68vMjgp31dqYDNR
         Tr2/z1+BZY7d45OCTzmM6Z0CwwmlAkhCaLl9yqzmqvB+YMrCSvevAfLrL5bA7oL7I3dn
         qt5EEpbJdh9h6ml4uoCl5+GpaeBD2/pOGuNi9oADeL2P2apsVffNnBrcx/8gdM687olG
         dxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=I0tKIcGAnmGzt7gEhrs4pRS1r2Q74lYwZyR49l7q3W4=;
        b=e4LuLd8JC/z64x9GoJg1VzkM4GW/jI2I2Ow8DEEfcTiMHKE9E/2ldFXqDsoTLWg0g5
         22krq/ugsNkXN/LCbF3BL4WIlmrXSyopcecwVOzgGSieWZ0gCMfM+4j2YxGUA8GKqzMs
         LPaZdFGojN7n2Aezxa1LWGixyhoKTmJRVrcH+0A2grRg17+CEZNoECBZTV4i20uuEjL3
         NAdKPthDrn8gCya3d889NdFiBS4taSttLk58Smkmhak1sOHxj+qOoRIIMZWb4o0MHH1X
         OQpAgKuykV5r6HYr+eSleTr0AlXASRW7aE6jwN/pxVMDOdMWxtqpwNa6JJRlb7ajcU0W
         SC1Q==
X-Gm-Message-State: AOAM5307IL1RyTX+2eH0yMMitksBQ0g1jQYaQW6XZeEqdBATcaXOokww
        gGRNEZT82gXoR9tUSKhuUzONlg==
X-Google-Smtp-Source: ABdhPJyVk1h6gk/4Qj2FC3S5U0X0xGwrQZewBKjbRr9KD4g/hHEh1n+0fYFf1yNyALe2v30aVv5MgQ==
X-Received: by 2002:a05:600c:4f14:: with SMTP id l20mr2689930wmq.71.1618299118162;
        Tue, 13 Apr 2021 00:31:58 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id z17sm7197599wro.1.2021.04.13.00.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 00:31:57 -0700 (PDT)
References: <20210410111356.467340-1-jbrunet@baylibre.com>
 <20210410111356.467340-4-jbrunet@baylibre.com>
 <161825923642.3764895.16526540466177115640@swboyd.mtv.corp.google.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] ASoC: rt5682: clock driver must use the clock
 provider API
In-reply-to: <161825923642.3764895.16526540466177115640@swboyd.mtv.corp.google.com>
Message-ID: <1jlf9m63o3.fsf@starbuckisacylon.baylibre.com>
Date:   Tue, 13 Apr 2021 09:31:56 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 12 Apr 2021 at 22:27, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Jerome Brunet (2021-04-10 04:13:54)
>> Clock drivers ops should not the clk API but the clock provider (clk_hw)
>> instead.
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  sound/soc/codecs/rt5682.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
>> index 0e2a10ed11da..2eee02ac8d49 100644
>> --- a/sound/soc/codecs/rt5682.c
>> +++ b/sound/soc/codecs/rt5682.c
>> @@ -2634,7 +2634,7 @@ static int rt5682_wclk_set_rate(struct clk_hw *hw, unsigned long rate,
>>                 container_of(hw, struct rt5682_priv,
>>                              dai_clks_hw[RT5682_DAI_WCLK_IDX]);
>>         struct snd_soc_component *component = rt5682->component;
>> -       struct clk *parent_clk;
>> +       struct clk_hw *parent_hw;
>>         const char * const clk_name = clk_hw_get_name(hw);
>>         int pre_div;
>>         unsigned int clk_pll2_out;
>> @@ -2649,8 +2649,8 @@ static int rt5682_wclk_set_rate(struct clk_hw *hw, unsigned long rate,
>>          *
>>          * It will set the codec anyway by assuming mclk is 48MHz.
>>          */
>> -       parent_clk = clk_get_parent(hw->clk);
>> -       if (!parent_clk)
>> +       parent_hw = clk_hw_get_parent(hw);
>> +       if (!parent_hw)
>>                 dev_warn(component->dev,
>>                         "Parent mclk of wclk not acquired in driver. Please ensure mclk was provided as %d Hz.\n",
>>                         CLK_PLL2_FIN);
>
> Can this code be removed? I don't know why we care to check if the clk
> has a parent or not.

I'm focusing on removing "hw->clk" where they are - w/o changing too
much what the driver does. I don't have the HW nor the story behind it
and there is about 50 more drivers to be fixed ... thankfully, most are
in drivers/clk/ ;)

Here, at least the clock consummer API is not longer used within a clock
ops, which is not great considering the locking scheme (among other things)
