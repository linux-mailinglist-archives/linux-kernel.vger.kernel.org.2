Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41C7333C81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 13:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhCJMTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 07:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhCJMTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 07:19:49 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA6C061762
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 04:19:48 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id 7so23109856wrz.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 04:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Thwrg3qqoUAhwxM+WcU2u+TiYXJHE8JDjJsGatqd/Y=;
        b=P9VknKEPcyVqWWZufkGPkL7KVSXa9RkQyQkPYODUoIxqRJr90IqY6fiSolH8U3aiWv
         93JrhtgP4aRcezHmCi/YEeCpNg/2qq8Htgn72XxVRzoQIuy5JLGiNLEpwbehqN5NtV9x
         8WEEvuVyRkSrBzZCRjPqwC4cCElK1sEkpwVGSKL6iszB+SvOHyLXRpvlPBg3flwuHEKu
         +fcDcHvQcHiVoPaQ8L4eQmbQ/XKi1bKnqV3jW/2gv0gXqjfEDOvYsJ55ihjlmIe+NQcF
         1bpbpL+j+mI1HQ9dQXY1/yUhJgeqaPgqIe+iC0EuBEqZ7SpCj1oFA0iSZQHwYQ/mj8/t
         4riA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Thwrg3qqoUAhwxM+WcU2u+TiYXJHE8JDjJsGatqd/Y=;
        b=qxrA4dVEjQUytqawC4/ZT+3QmNmaF+AyF6jXl1Le8wfDKDNzrUCjCgriKls7+HlhHt
         eqOwCUjuEMZaKiMqXjijdgBnnhWfkD5z90elQGJPUxL2AnAFZsN0IHPniui3agk5F03T
         PHkw/TItwGIHG37kbW1sN2tnSzUdkqqTxMQh/NEnmiJsqk969a0zsB1KLzwlHXl3cKiI
         WWS/VerHLi4xiqPYzQfwyBPX72c+au30KTlsAFgXIczLM4w64PPq+3V3U6uNmdxCwDbI
         DI+rz8zz1bKCCw9/kcvftq8Uf17WTF8uFsYk503T298NL56A+7wvBvnsGh8h7FG8RQ2o
         BCdg==
X-Gm-Message-State: AOAM533D8ciRibRvKq5qUgXUFMAfIB7IYjj2zT0X7jflqBD7sLkMXdaP
        ySckVibdmPZdy0NcH1Zn4RYurA==
X-Google-Smtp-Source: ABdhPJy2wS4+o8phanKVOn3lZq7ICLobsnju1ml3279qVLpDMTBVRF+ouyMr00zPdGc/SISKLUPpYA==
X-Received: by 2002:a5d:6d06:: with SMTP id e6mr3253733wrq.425.1615378787498;
        Wed, 10 Mar 2021 04:19:47 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8018:efa9:4421:9140? ([2a01:e34:ed2f:f020:8018:efa9:4421:9140])
        by smtp.googlemail.com with ESMTPSA id r11sm30479183wrm.26.2021.03.10.04.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 04:19:47 -0800 (PST)
Subject: Re: [PATCH v10 0/8] Add support for ipq8064 tsens
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>
References: <20210217194011.22649-1-ansuelsmth@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f0ab094e-440d-993c-6618-bf80fd05d484@linaro.org>
Date:   Wed, 10 Mar 2021 13:19:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210217194011.22649-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ansuel,

On 17/02/2021 20:40, Ansuel Smith wrote:
> This patchset convert msm8960 to reg_filed, use int_common instead 
> of a custom function and fix wrong tsens get_temp function for msm8960.
> Ipq8064 SoCs tsens driver is based on 8960 tsens driver. Ipq8064 needs
> to be registered as a gcc child as the tsens regs on this platform are
> shared with the controller.
> This is based on work and code here
> https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=wrk3/tsens-8960-breakage

I don't have major concerns with the series except there is no comment
from the maintainer / reviewer of the sensor.

Given it is based on Amit's work, I can assume they are correct.

I added Thara in Cc hoping she has time to review the changes. If nobody
complains with the series, I'll merge them in the next days

Thanks

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
