Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D333C9CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 12:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241370AbhGOKfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 06:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241364AbhGOKfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:35:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46302C061764
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:32:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r11so7075866wro.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gsV66XE0EGcG7u2wmOs4QFlA/ant67YwT3lAEx/PPF4=;
        b=wIkAKP4/H87UVy9+HYifgqffQYx1gkM/H7YB35NOf1+wZqfqPl2CQZaaA0WzIULntf
         2b8QS9GaXQe1+ZRPYGAK667GQv3VOahDiFPceqU72tBooi5//iUK5GQH2GfOvinBM/Oc
         4ZcKgePDycMWsVfjGYF8ql+vaQsxokOJtuQu5EO5D5p+RNjcfvdd0JhVKLlYA3qAB9NG
         nc8LM4g2EwRMpD+QSHKSeYoD8+Z0XKZ8pXpERuPc3VnDRsulTuu9lzepsCKAnkjogK0+
         4mXKMlkGpKSBy4qe1byqMF0C72mBXof5dTQTw50C7uA747tO6XvysXLtB+Tu9mSgroVZ
         6fZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gsV66XE0EGcG7u2wmOs4QFlA/ant67YwT3lAEx/PPF4=;
        b=lg7QMkCqMfH6L7DdZkPbjRvFg5gDQvPG4SXadl2WZaLU2Va9J/Q621+LIRc/+0Rf2T
         q0n1o5rUspsRL/jCKSAQQf0MiH0tqj2FHBP4JaeOwqA+rBT3HaNdGIyq7IhVAyr/zgvo
         DlDKVCGscVUvyHsXmpD0jeLIRMK1I4T4XlGJbIpSV3RcTz2NJC/p4CQTzdap/Pz6HQuG
         vUqTFxHglZnmafRJ2XF7FphNpiUf6QUnAKhTYlIT7lk25GnZunvrsK4CPCKbazGX5QUj
         Z7mOUhMEhs7MjMBTAeb/NHRJPaRyxwBsHn1J42VxJ+gnraF7PBuV2OgvwKtks+Be9Q3e
         weLA==
X-Gm-Message-State: AOAM532yHyTCn4iAifuqsRcQZiV8g7Ob4udM+XQMqSixJ4eI2Th8qgGg
        QD0how/6Tcnc2NkD8jnitX4gkYv5Dz06rw==
X-Google-Smtp-Source: ABdhPJxD8Iw7gZcKuTN5IAoaPBQmG7KeAJdm6gsWH8Icp8kvCAmMon/G5b+fpC4BZY28Mlrn/Lx3pg==
X-Received: by 2002:adf:a1c2:: with SMTP id v2mr4609978wrv.155.1626345131549;
        Thu, 15 Jul 2021 03:32:11 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id o3sm6086193wrm.5.2021.07.15.03.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 03:32:11 -0700 (PDT)
Subject: Re: [PATCH v2 10/16] ASoC: qcom: audioreach: add bedai support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.de,
        plai@codeaurora.org, linux-kernel@vger.kernel.org
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
 <20210714153039.28373-11-srinivas.kandagatla@linaro.org>
 <cb2636b9-e88f-76c3-129a-5cbb2cd017b2@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <cb3a2cd6-b8f2-bdf0-91fc-c19e3e98c053@linaro.org>
Date:   Thu, 15 Jul 2021 11:32:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cb2636b9-e88f-76c3-129a-5cbb2cd017b2@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/07/2021 18:03, Pierre-Louis Bossart wrote:
>> +	rc = q6apm_graph_media_format_pcm(dai_data->graph[dai->id],
>> +					  substream->stream, cfg->sample_rate,
>> +					  cfg->num_channels, NULL, cfg->bit_width);
>> +
>> +	rc = q6apm_graph_prepare(dai_data->graph[dai->id]);
> any good static analyzer would tell you you didn't test rc before overriding it..

yes you are correct, I did forgot to do cppcheck after make W=1 C=1

These are now fixed in new version.

--srini
