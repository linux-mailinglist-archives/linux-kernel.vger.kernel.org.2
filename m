Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CF133AF8B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhCOKFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhCOKE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:04:59 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA40C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:04:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l11so8349135wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5sZ5UpjkgNLtW67WrWBw/5iK//Kn0zjBWk0o6baJMew=;
        b=mpOuv4hx22qNNNdhDjQDFf+0BsGXZDaApfx09MfV79qdf8GqjmIUfn2rNGBOeeDJvM
         qqdJS0vPUCO44UfilSun63fjQEZ7m5P00wHXBcnoM93hXXEYoaiuNsM79wqpZ/qXdWcz
         sZ4hLJenc0Gyj9bcRhey2smGfJdVKfEWPmXoBt9pQBAyDPZISlZcJksI+Z45fxXy30tj
         n2PhG1YW4lwg683e06T5eRbZ6XkCGEAWKwSMbmk8q7s9uex07KPzfMqbKCowRtkBgnDN
         Wnbh3O9+ekCoXRi6l3YWMjDCV2gIkjhYhIPhkOJ4S/e7FwQDrLzRyvVZC4KEot/d8w8M
         GiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5sZ5UpjkgNLtW67WrWBw/5iK//Kn0zjBWk0o6baJMew=;
        b=oRlveCRenKZ+M7eCVMqdg17fQemk3aUoyDzJcEWL1cTQFP20F+av5jKRvDKGdz3Iaj
         MqBGcYzJy4KCR6i/rnv8qfEf3XIWFTWwIZpVfOYh+B0jVHj3cIJuPFrTxgXZBrMt0/nq
         dex0dt3r4g9xsfUVZlW4oB3Th8khyzJ5/6OI4WiiUeoaaqfeDNISAqFe041lxC5Zt/4P
         lfX/ABjoh4uz7SZ94epjgTyL92pTPm+6+9jhfkDPlB5url24SVJDabRY9Bz9GBnOhsZt
         QQ2/fpDBVsEgJ//Dd8vXFYlkVbCGwUQi5CbdLX5OlwGMpEyGt52qF/gmv3MRoQ3q/NlJ
         ehjg==
X-Gm-Message-State: AOAM532aviVsoeP43AuHz2t00ovqV9c2Lb4xBMOgdZF2NNBDVkbnE0UJ
        QwviUDR2TeySR3UIwNiFfqf5mQ==
X-Google-Smtp-Source: ABdhPJzFkwZDY5ukBN4jHfebVQYaV+QuTKS2OCkFuPV3HA3Jyvm1CPVExhoEUKVtGDxyOIQEbIlb1w==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr26282581wrn.59.1615802697501;
        Mon, 15 Mar 2021 03:04:57 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id s9sm12119272wmh.31.2021.03.15.03.04.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 03:04:56 -0700 (PDT)
Subject: Re: [PATCH 3/7] ASoC: codecs: wcd938x: add basic driver
To:     Mark Brown <broonie@kernel.org>
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com
References: <20210311173416.25219-1-srinivas.kandagatla@linaro.org>
 <20210311173416.25219-4-srinivas.kandagatla@linaro.org>
 <20210312153443.GI5348@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9e112ca1-f618-6a6c-fc1e-854de3c8acfe@linaro.org>
Date:   Mon, 15 Mar 2021 10:04:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210312153443.GI5348@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/03/2021 15:34, Mark Brown wrote:
> On Thu, Mar 11, 2021 at 05:34:12PM +0000, Srinivas Kandagatla wrote:
> 
>> +static int wcd9380_update_status(struct sdw_slave *slave,
>> +				 enum sdw_slave_status status)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int wcd9380_port_prep(struct sdw_slave *slave,
>> +			     struct sdw_prepare_ch *prepare_ch,
>> +			     enum sdw_port_prep_ops state)
>> +{
>> +	return 0;
>> +}
> 
> If these can legitimately be empty I'd expect the framework to support
> them being omitted.

One of them is not mandatory, I will revisit this before sending out 
next version.

thanks,
srini
> 
