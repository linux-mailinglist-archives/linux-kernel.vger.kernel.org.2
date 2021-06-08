Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B5939FA41
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhFHPXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:23:34 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:40857 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhFHPXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:23:33 -0400
Received: by mail-wm1-f49.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so2222903wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 08:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9hSTH6iFfhk4YNZO/PD9dC5EfuAvuq3JWTMQoezRpa4=;
        b=rVbGga0YMt9v4RX5dgluDTeRiWVagmxiI0r5XffEEGtnBUTGgfpdr8TilsetE54+aG
         W+49JL8h9wKLOfe2XEo8MUlmzM5apk577/ud4NiVAdwH7A60G3aHuxZGXSoBUHf2D496
         glgWg5l6oifVXTG1gPto4Qv820VWcm3Lzpb8VutkEgH3k31hrPNLcFzbkdaYh2JdgPtw
         6s41/4/GuEVBDCpHCFDTk7MgZUXOyg1ldFA0euDOCnUtKrdGK/JbAZCssNpZ29sePJzm
         t2X3aymp+IbTcoOYt7eJV/cXyLo24gbfnedJf01l5+H4fXemCe9VDCIlVEYmF5SmBo4H
         O3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9hSTH6iFfhk4YNZO/PD9dC5EfuAvuq3JWTMQoezRpa4=;
        b=p2pOQzD9dbP5Nx8ZGBGAhpuBPML2sBFmzGdL9b/L++LIGAiRm2Zd54Tfzg7rodXbyE
         CBFUvi7wwuJ1tNggwalQyOJCc84BS0cRoQLFgc7hI7QalXxcIoiKegn7VmCEoqMJcNX8
         MANYy1LHNTTsFtuLzrOt/9pD8yqOlatZMYVMiVn3NKYx5vopENQvHZVc7IWCYmW7TFC1
         +kYVNZRi+h5sTNFxjrg/2Iawy8421eADY5AUPTnQs9WcXuHZGEIy7Fr8WfZuaZyx/Srg
         Eol/QY5Bm+V98c9APjPQMBDGMuWKKQ4W2KAhmnYhbulfRcEbTNJ6epnumfJVOspv1DYF
         OZ/w==
X-Gm-Message-State: AOAM5337xIqT3bzLg5G8Arft3GG/LCUh93EFly32tSYUgC21gWGw7QsX
        zPPoW7tSTqPU0lleWsJIRMMZ+g==
X-Google-Smtp-Source: ABdhPJyxapM48QVF45aLpo2H+FUZRplP63/n5liTflATtO1NCzwg7X8/1DrHPmn3DkqJrHfE7tmETA==
X-Received: by 2002:a7b:c44f:: with SMTP id l15mr4870340wmi.151.1623165632463;
        Tue, 08 Jun 2021 08:20:32 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id b26sm3123109wmj.25.2021.06.08.08.20.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 08:20:32 -0700 (PDT)
Subject: Re: [PATCH v8 6/9] ASoC: codecs: wcd938x: add basic controls
To:     Mark Brown <broonie@kernel.org>
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
References: <20210601113158.16085-1-srinivas.kandagatla@linaro.org>
 <20210601113158.16085-7-srinivas.kandagatla@linaro.org>
 <20210608135933.GE4200@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e8ca16d9-f179-c6de-d683-21180ea4ed1b@linaro.org>
Date:   Tue, 8 Jun 2021 16:20:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210608135933.GE4200@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/06/2021 14:59, Mark Brown wrote:
> On Tue, Jun 01, 2021 at 12:31:55PM +0100, Srinivas Kandagatla wrote:
> 
>> +static int wcd938x_rx_hph_mode_put(struct snd_kcontrol *kcontrol,
>> +				   struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
>> +	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
>> +
>> +	wcd938x->hph_mode = ucontrol->value.enumerated.item[0];
>> +
>> +	return 0;
>> +}
> 
> _put() should return true if it made a change, the same bug is present
> in a lot of other drivers too.
> 
Sure will fix this in next spin

>> +static const struct snd_kcontrol_new wcd9380_snd_controls[] = {
>> +	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum_wcd9380,
>> +		     wcd938x_rx_hph_mode_get, wcd938x_rx_hph_mode_put),
>> +	SOC_ENUM_EXT("TX0 MODE", tx_mode_mux_enum_wcd9380[0],
>> +		     wcd938x_tx_mode_get, wcd938x_tx_mode_put),
>> +	SOC_ENUM_EXT("TX1 MODE", tx_mode_mux_enum_wcd9380[1],
>> +		     wcd938x_tx_mode_get, wcd938x_tx_mode_put),
>> +	SOC_ENUM_EXT("TX2 MODE", tx_mode_mux_enum_wcd9380[2],
>> +		     wcd938x_tx_mode_get, wcd938x_tx_mode_put),
>> +	SOC_ENUM_EXT("TX3 MODE", tx_mode_mux_enum_wcd9380[3],
>> +		     wcd938x_tx_mode_get, wcd938x_tx_mode_put),
>> +};
> 
> Please don't use this pattern of indexing into arrays by absolute
> number, it's error prone and hard to read.  Just declare static
> variables for the enums and reference them individually.

I agree, will clean these instances in next version.

--srini
> 
