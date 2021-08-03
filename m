Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D08F3DE7C7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhHCIA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbhHCIAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:00:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDDDC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 01:00:42 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so1521064wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xQ4m8nY0R0gdaQ2/t/epPl2Yst37jmddCHkepiSD0C4=;
        b=Bw+xkG5sbehOUYrGhW3vuHjC0TodTkMZrfcQqx90U7cza0bBBP+1vYns95ZaSdpsaW
         0ZejcJ4Vl0vp8xDbgM1uk3tTQkuD460xHm+MTBNVbOZuHGVyBCs0HFLhFINqMWGLY9sZ
         SuEMjTiYAkai4RKewsDrHd/xSHe5J+lQ8yvBTh5H+nE7akdFJjAkbHi7B16zwMAeN7nP
         it2zDi+0Jk2xm2q0urRgOdPZvXffKHfpiR2EPrBLK4pGR0givWjer6Bn3dI4vIi/DPQy
         4ZDz/FGRU0R2IAyPvMMKAPoruwFrejYoxePAxZzNVUQDAvVgohV1+P4U56gUqpqZV7me
         FB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xQ4m8nY0R0gdaQ2/t/epPl2Yst37jmddCHkepiSD0C4=;
        b=XYRKjtyyaN833xsMDV1sshTswy9pSSKUyssJk/dHYmALEr8WVgRQKGmHN5cs42ssKD
         PoBcmGcLUKqZu+KfCa6skIgDjs33fC05R1nimojiZEHnmIaIJad3ImWKTfJtvZH+hZ9T
         8IMHNZ3O0MBd2d4v7H6IBl8CE9HRpKYJ5/YjlPQb0YmQ4vESnTq0NvaE6udnLK/LaHrt
         7rr9SFU/jTEJPpsfSNqt+HL5t+NJHLLshRzXafqcn+yILegXQ7tT4cWUeJL3jYLuI/Sq
         +cZ6/22PMVz/rL9Q0TF9w8E8xeDsezp37sLJY87dggDHiz11AfDaNYb32xPrdsJJZBoH
         Ffbg==
X-Gm-Message-State: AOAM531KpUSNrrB0jbldi7XnV0zkSJcmxIUACBmctd53sgCpSjExc72v
        1HwOT3hyd4GxXMOMal4srPaVvg==
X-Google-Smtp-Source: ABdhPJwel4nkglJAenKOcjYpcxSacPWxMq2xkHmEmS8ycsumGKjElVh8s/Y1jXHSsXVTWplDeiJwSA==
X-Received: by 2002:a1c:2314:: with SMTP id j20mr2951400wmj.30.1627977636036;
        Tue, 03 Aug 2021 01:00:36 -0700 (PDT)
Received: from [192.168.1.11] (hst-221-68.medicom.bg. [84.238.221.68])
        by smtp.googlemail.com with ESMTPSA id m9sm13534055wrz.75.2021.08.03.01.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 01:00:34 -0700 (PDT)
Subject: Re: [PATCH v3 7/7] media: venus: Set buffer to FW based on FW min
 count requirement.
To:     dikshita@codeaurora.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org
References: <1626246068-21023-1-git-send-email-dikshita@codeaurora.org>
 <1626246068-21023-8-git-send-email-dikshita@codeaurora.org>
 <e85515cc-6213-cdc3-dab8-46ea5eb58011@linaro.org>
 <6c8f0d013be8ba6d276afe04d6e0c840@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <253417f1-579a-0a57-388b-7fb07fd83d9c@linaro.org>
Date:   Tue, 3 Aug 2021 11:00:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6c8f0d013be8ba6d276afe04d6e0c840@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/21 10:50 AM, dikshita@codeaurora.org wrote:
>>> req->count_min = inst->fw_min_cnt;
>>> +
>>> +    ret = hfi_plat->bufreq(&params, inst->session_type, buftype, req);
>>> +    if (buftype == HFI_BUFFER_OUTPUT || buftype == HFI_BUFFER_OUTPUT2)
>>
>> ^^^^
>>
>>> +        if (inst->fw_min_cnt != req->count_min)
>>> +            inst->fw_min_cnt = req->count_min;
>>> +    return ret;
>>>  }
>>
>> Also in regards to inst->fw_min_cnt, can we pass fw_min_cnt as input to
>> get_bufreq via 'req' structure, i.e.
>>
>> req.count_min = inst->fw_min_cnt;
>>
>> ret = venus_helper_get_bufreq(inst, type, &req);
>>
>> inst->fw_min_cnt = req.count_min
>>
>> ?
>>
> Sorry, I didn't get it, How is this different from the current
> implementation?

The difference is that platform_get_bufreq() will not modify any of
'struct venus_inst' members, i.e. platform_get_bufreq() is not supposed
to change anything from input 'inst' argument.

-- 
regards,
Stan
