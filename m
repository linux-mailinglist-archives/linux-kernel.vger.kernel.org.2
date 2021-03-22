Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33D0343DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCVK0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhCVK0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:26:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C84AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 03:26:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e18so16080880wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 03:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OSkS8klzMM+4/NTgGz09ceK75610Ius88Sv2HzyZb5o=;
        b=qidjlqXaQCI2EWyfh0TVmaLz9gqEHLl/iklW8EIbKVTuXg+vOJHtobt/ZmjyzMmark
         92I4FNxkZ+jpfHMtD9K7u8Q/XJfoMtPjEq99A73jO4pIkGD96K6JUWLY8RFygUTuhZUd
         3Rwg0HTV8CbPMECJseV3LDUnfNmBeAqxg4qx/N9V2zXU8WyQOJ2yPhUOEeAcMITnRUqP
         zEaAi0GS8gXGI3JxvoLDIkOoGPa5iTrBpaBHwAZu1wIvfH3D/vKxKmTWt9lYkM5raRDK
         6BK2/grg/Qw5Z0AjLOZXuK9hPcqtGfeDCgv1pmQw8hTyn1EDMP9gAGsb1IGOwxMB38gs
         oPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OSkS8klzMM+4/NTgGz09ceK75610Ius88Sv2HzyZb5o=;
        b=eWln//kY0b89fAr6VKQR3n2AFgWQWE6/9knYKLi8M1kxEPv6WD3zaXa3Ez8C2Kd3pD
         rtVKp+ra2Ouy9c3Quv4jJtUlLFv7ftjUDieN7X78QHnyn88eZvq34g24GQ+4QFhYODdI
         b8TQZ72jjfPSq/Ga5+HAFSZsIr88vjH2EnvXGvGeiRTi3/MMBpxyGhIV9Pp7Y5zjGObh
         4uDxYN7porI0u4B43PiOvbVpDgC18yqEIFjjuhYDWS1WbaL4Luqx6zSkr4TPpUBknjNt
         VOrxIKf7fLs8ANd5XDeiOXFBB/Aq3l8e0WIevbMM27QpNoT6AB0+K78pSqubr8auLFPN
         Dy8g==
X-Gm-Message-State: AOAM530nh7+DRF/4oVYinM8pG6DAuLlp6WhQ9JGndVNnSghmjZj7Hg8x
        N/J4Oji3N450zul9xplm4E/UeQ==
X-Google-Smtp-Source: ABdhPJxKLdTlVU+Al3YSaiI/ZgS4AoFun1Gz+b2uECwV24sFgpR6uQTG69gnEy3luXXRJxoXiyO0GA==
X-Received: by 2002:a5d:5088:: with SMTP id a8mr17620390wrt.294.1616408782813;
        Mon, 22 Mar 2021 03:26:22 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id w131sm16544911wmb.8.2021.03.22.03.26.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Mar 2021 03:26:22 -0700 (PDT)
Subject: Re: [PATCH v3 2/7] ASoC: codecs: wcd-clsh: add new version support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     robh@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
References: <20210319092919.21218-1-srinivas.kandagatla@linaro.org>
 <20210319092919.21218-3-srinivas.kandagatla@linaro.org>
 <26038ba1-e8f6-08e3-bee5-673d69d7decd@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <585401cc-4248-7769-4d9a-84553b2d0ea6@linaro.org>
Date:   Mon, 22 Mar 2021 10:26:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <26038ba1-e8f6-08e3-bee5-673d69d7decd@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/03/2021 15:23, Pierre-Louis Bossart wrote:
> 
>> +static void wcd_clsh_v3_set_hph_mode(struct snd_soc_component 
>> *component,
>> +                  int mode)
>> +{
>> +    u8 val = 0;
> 
> initialization not needed.
> 
I agree, will remove this in next spin.

>> +
>> +    switch (mode) {
>> +    case CLS_H_NORMAL:
>> +        val = 0x00;
>> +        break;
>> +    case CLS_AB:
>> +    case CLS_H_ULP:
>> +        val = 0x0C;
>> +        break;
>> +    case CLS_AB_HIFI:
>> +    case CLS_H_HIFI:
>> +        val = 0x08;
>> +        break;
>> +    case CLS_H_LP:
>> +    case CLS_H_LOHIFI:
>> +    case CLS_AB_LP:
>> +    case CLS_AB_LOHIFI:
>> +        val = 0x04;
>> +        break;
>> +    default:
>> +        dev_err(component->dev, "%s:Invalid mode %d\n", __func__, mode);
>> +        return;
>> +    };
>> +
>> +    snd_soc_component_update_bits(component, WCD9XXX_ANA_HPH, 0x0C, 
>> val);
>> +}
>> +
>> +
> 
> extra line
> 
will remove this in next spin.

>> +void wcd_clsh_set_hph_mode(struct wcd_clsh_ctrl *ctrl, int mode)
>> +{
>> +    struct snd_soc_component *comp = ctrl->comp;
>> +
>> +    if (ctrl->codec_version >= WCD937X)
>> +        wcd_clsh_v3_set_hph_mode(comp, mode);
>> +    else
>> +        wcd_clsh_v2_set_hph_mode(comp, mode);
>> +
>> +}
>> +
>>   static void wcd_clsh_set_flyback_current(struct snd_soc_component 
>> *comp,
>>                        int mode)
>>   {
>> @@ -289,6 +388,130 @@ static void 
>> wcd_clsh_set_buck_regulator_mode(struct snd_soc_component *comp,
>>                       WCD9XXX_A_ANA_RX_REGULATOR_MODE_CLS_H);
>>   }
>> +static void wcd_clsh_v3_set_buck_regulator_mode(struct 
>> snd_soc_component *component,
>> +                        int mode)
>> +{
>> +    snd_soc_component_update_bits(component, WCD9XXX_ANA_RX_SUPPLIES,
>> +                0x02, 0x00);
>> +}
>> +
>> +static inline void wcd_clsh_v3_set_flyback_mode(struct 
>> snd_soc_component *component,
>> +                        int mode)
>> +{
>> +    if (mode == CLS_H_HIFI || mode == CLS_H_LOHIFI ||
>> +        mode == CLS_AB_HIFI || mode == CLS_AB_LOHIFI) {
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_ANA_RX_SUPPLIES,
>> +                0x04, 0x04);
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_FLYBACK_VNEG_CTRL_4,
>> +                0xF0, 0x80);
>> +    } else {
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_ANA_RX_SUPPLIES,
>> +                0x04, 0x00); /* set to Default */
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_FLYBACK_VNEG_CTRL_4,
>> +                0xF0, 0x70);
>> +    }
>> +}
>> +
>> +static inline void wcd_clsh_v3_force_iq_ctl(struct snd_soc_component 
>> *component,
>> +                     int mode, bool enable)
>> +{
>> +    if (enable) {
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_FLYBACK_VNEGDAC_CTRL_2,
>> +                0xE0, 0xA0);
>> +        /* 100usec delay is needed as per HW requirement */
>> +        usleep_range(100, 110);
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_CLASSH_MODE_3,
>> +                0x02, 0x02);
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_CLASSH_MODE_2,
>> +                0xFF, 0x1C);
>> +        if (mode == CLS_H_LOHIFI || mode == CLS_AB_LOHIFI) {
>> +            snd_soc_component_update_bits(component,
>> +                    WCD9XXX_HPH_NEW_INT_PA_MISC2,
>> +                    0x20, 0x20);
>> +            snd_soc_component_update_bits(component,
>> +                    WCD9XXX_RX_BIAS_HPH_LOWPOWER,
>> +                    0xF0, 0xC0);
>> +            snd_soc_component_update_bits(component,
>> +                    WCD9XXX_HPH_PA_CTL1,
>> +                    0x0E, 0x02);
>> +        }
>> +    } else {
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_HPH_NEW_INT_PA_MISC2,
>> +                0x20, 0x00);
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_RX_BIAS_HPH_LOWPOWER,
>> +                0xF0, 0x80);
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_HPH_PA_CTL1,
>> +                0x0E, 0x06);
>> +    }
>> +}
> 
> do you need the inline for the two functions above?
yes, these are totally unnecessary.

--srini
> 
> 
