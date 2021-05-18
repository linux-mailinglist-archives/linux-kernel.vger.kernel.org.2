Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC46F388121
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbhERUNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbhERUNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:13:18 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7538FC061573;
        Tue, 18 May 2021 13:11:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id q7so14423216lfr.6;
        Tue, 18 May 2021 13:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eqnKON75MC7wmOo09rQx8YXcKOuSxztzztMBXxXm75A=;
        b=q/4iatmrOgeg1PWQq7qdnEK93Mf5xlYSKZsJTH9Tv5UkG27MQ2EvSilQhDzJJGkfSi
         zPoez1JT5MkXAXfF0TdJOXl9jMMmFNB97v85pIW3kRiiRl4RNREjCBeEFUO9nJRxx+N4
         P8Ulebw30vk7rxv3h4sOPXKF0KbLZ95zWbbmwKTMouPL0dnM/QJ1IdbOC6U/fIfVv79m
         Of0LbTJI7C6ZeIEQRGejGtzZhBuc0nFI3f4ZJnGhm05EPZZ5aj8SaWGaQkCaSBTsVylx
         V+PAiPdj2EqK5ZnOuFa48ZTvVxCS93rB4vKwHpiYGWyhe/OaDNDiOvYxFSw8SRTXdQPG
         DF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eqnKON75MC7wmOo09rQx8YXcKOuSxztzztMBXxXm75A=;
        b=H76aDim1Rp1Qcm8oXHSCTzun+uCUeCSsrc4GhTIiASDcDeHMkPDR23qWRapOD3fkvJ
         sqT6d4sPeJ0FCqdjG4F541OsVhqcm+QuCEg9JTv8xF/Jc3iCdu9CPD4SfZXm6dxhBygV
         tjVxjCapUluvyJWcQI57A1yyxtkq2NZ+db1cCWrGwSl9yhDVIBqgnG33r58JQWvNroKs
         D993AaASqcc5W49zcGNMz0s6s9nNVrldY0iADaavK6oVq1XcdhUQ28WdE8mXsoGdh5Wc
         wTvEpgIIG1p3ROGAvNc0Lj9Xrs0tyMQ1intcVCEPD5KZA79yE/3//EudHyxMIpVng/9/
         rPwA==
X-Gm-Message-State: AOAM5336y+4R4LeBcr8cag2ZGhBcyO5JZuuFii6uaQoGzHkwGG3Cc3Ze
        2g7hoVpn7foWza+2sb9Jxol9z76Qvas=
X-Google-Smtp-Source: ABdhPJx6fBKAk+vMXzaeJUMIPe/E1mlIHljaim+HQDVwv3IcRiDuJXXqx9U0k27vviVxgdudscSDPw==
X-Received: by 2002:a05:6512:33c4:: with SMTP id d4mr5533905lfg.536.1621368717835;
        Tue, 18 May 2021 13:11:57 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.googlemail.com with ESMTPSA id r17sm3431037ljp.40.2021.05.18.13.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 13:11:57 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] ASoC: tegra: Unify ASoC machine drivers
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Ion Agorria <ion@agorria.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210518001356.19227-1-digetx@gmail.com>
 <20210518001356.19227-3-digetx@gmail.com>
 <20210518180949.GA949047@robh.at.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <95f62f68-b081-2f98-1f88-f39e52c49bfe@gmail.com>
Date:   Tue, 18 May 2021 23:11:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210518180949.GA949047@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.05.2021 21:09, Rob Herring пишет:
>> +static const char * const tegra_active_low_hp_compats[] = {
>> +	"ad,tegra-audio-plutux",
>> +	"ad,tegra-audio-wm8903-medcom-wide",
>> +	"ad,tegra-audio-wm8903-tec",
>> +	"nvidia,tegra-audio-wm8903-cardhu",
>> +	"nvidia,tegra-audio-wm8903-harmony",
>> +	"nvidia,tegra-audio-wm8903-picasso",
>> +	"nvidia,tegra-audio-wm8903-seaboard",
>> +	"nvidia,tegra-audio-wm8903-ventana",
>> +	NULL,
> I think this list should be added to the main match table below with 
> data having a flag for active low HP. Then you only match once, don't 
> need the exported function and the next difference is much easier to 
> add.
> 

Thank you for the suggestion. You're right that these compats will take
precedence.

I'm also now thinking that it should be okay to assume that the GPIO is
active-low by default. I haven't seen tegra boards with the active-high
configuration.

I'll remove the use of the exported function in v2.
