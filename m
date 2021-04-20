Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A79365C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhDTP1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbhDTP1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:27:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6768AC06138A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:27:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id w186so15898128wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jM4HPTHVE1i18kTLntQk5Un7Ipi3bGzznJhmm/wqxNk=;
        b=XUM56xO6qMQN9Aa7DR7Un+8zyg+8IaYdGdCmXjgZpfZbi3UddQnQeZjEMSoWDLhD8x
         /7wVBMAVYolnfGTnRc/E92kJt/Twt8eOjN+iFLHzuiXVm2D7cc5wUoTPM2oyzQMQmN1Q
         6ArqIHP8rQSHLaZ+C1niXlw9P+Z+56mQfJOpu8Wxt2J7FcxIUcA/21RRoDSsiYF/bIdd
         P0imvAZ5VyuTbkBeRogLQxmR8IqF3+GeDU0ra7ybNefKGpkfNJ8qDpfhvDF+aSOqusdU
         cFzNq8Zu4n4IDXTLKfLU7phOgRazle5mit0FvE+dc/0OhoUmtmnigiG3Kc5UWStyPc5m
         fdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jM4HPTHVE1i18kTLntQk5Un7Ipi3bGzznJhmm/wqxNk=;
        b=VvWeHzOATAVCVZGz4SBsm8WiJ85ZYHHc3/8SGFmdEQZufPvnD6y0/5iHp5xLlOpdP/
         8u/U+ENLvKMWq1NndJbxB34X1FgK+5m1nMGXrxQ+36t2W059ahRLqtB2Xi6/+hED/P9z
         BpR/NvGW536rwv1kHoQt7R1m9rmMyPF61EEibeZWWL86tmAgSW6p4FHnIMRrReaS4scB
         h5ip5Mif5HZ3KWldkEiaQT+3wofpQfOFnOvH22nDPF/jOVhK8fzUnWo5zhe7POQNVmGj
         wXiQIKPykumcTKqxTvaSGistRdEI8wY177y8QDZfjpV+E4cSFUKlKpMkUGNS3JPUizF0
         Yv9Q==
X-Gm-Message-State: AOAM532BCq4GZQk37T+qy7JtE1+CPWP9tD9++VR2bWozNiMuM68+J219
        6ZlJxT8gbwXwTQ9pN8+wVXxd5S9MJ7GQb9vd
X-Google-Smtp-Source: ABdhPJzu6SnxVt8JGXQc7mXw2W9R2/li/7Lf5f27wuyubM/gpnqLy0ueNIR2ppNIhIgV3DFvHTAUbA==
X-Received: by 2002:a1c:80cd:: with SMTP id b196mr5109056wmd.30.1618932438646;
        Tue, 20 Apr 2021 08:27:18 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a079:f96:da87:2d00? ([2a01:e34:ed2f:f020:a079:f96:da87:2d00])
        by smtp.googlemail.com with ESMTPSA id o18sm3471746wmp.26.2021.04.20.08.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 08:27:17 -0700 (PDT)
Subject: Re: Aw: Re: [PATCH] thermal: mediatek: add sensors-support
To:     frank-w@public-files.de, linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <linux@fw-web.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210320080646.49615-1-linux@fw-web.de>
 <f4329b1a-02e0-aad5-55bd-82d30a38fc55@linaro.org>
 <trinity-4a3f024e-c01d-44e4-a884-530135853d33-1618930770250@3c-app-gmx-bs72>
 <b38c3539-c864-67b3-95e8-9b652cf6fcbf@linaro.org>
 <846366E9-5029-4C6A-B2EC-F70D901DC379@public-files.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <39eddcac-a86f-9259-6a1f-d3e39d872bb8@linaro.org>
Date:   Tue, 20 Apr 2021 17:27:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <846366E9-5029-4C6A-B2EC-F70D901DC379@public-files.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2021 17:24, Frank Wunderlich wrote:
> Am 20. April 2021 17:18:32 MESZ schrieb Daniel Lezcano <daniel.lezcano@linaro.org>:
>>
>> Hi Frank,
> 
>> The no_hwmon usage is a bit fuzzy in the thermal core code.
> 
> Maybe add depency in Kconfig? Else we can get undefined symbols on linking
> 
> regards Frank

Nope, there are the stubs in thermal_hwmon.h



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
