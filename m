Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9363340F81F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhIQMms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbhIQMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:42:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5659C061764
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 05:41:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 70so4294295wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8L9xblep16e49FpEMcjJPX36O9S5sP+1ZMCJZZAcM1A=;
        b=Zlg0RMyIUnruJRCSbzsnLq+eMG0/29T8sAkvtM0RTiVz7OXX6hiuq45yVy/ffP9kAG
         fK/F+rRdLOXORF6WTah3UjmgLA4hI4yiHlaZcpYoUgKSchd0v3IAzqkDZT6tqTBnYM3M
         AD/j+mLGwzIn6TANVTYoDeOXh74nmXJzhF1BZxy4l2FIrj6DSnb4MpBjZCzjCPHapXLo
         f0fLGvHJ5OoERVjXJ5w2uVlIfm+p9efPfiCg7p0sAvpyKEmgduFHA//+XnOBsL2E+EyN
         CbSMN+cBxx1HRHywTA7g09A0LeoiWuLy/aCNh78rknd+vZBNqHXjX/TZ0YmHH5ZHc35S
         nPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8L9xblep16e49FpEMcjJPX36O9S5sP+1ZMCJZZAcM1A=;
        b=5Qvmz/95VfqJHY+9uHLBh/Vk7ldqRNscPLwuq4YLh+oXomOoebdr8WwLf6JERzJXaV
         k5z0onoPFWwKmV0kZJ9nIvEjMsYSVUzncJ+wjyl/SgJatvWvsmXBxRbYu6vNtlic6q7F
         qPdXYdoAu9LzJuuH3WHPiQWvLl8Xz48VoShN5e7I2EGkm2h46B9DHt7KDT19ORkbKI+m
         nkBK9peV4CiOd5GFZc3PGt5HmwpV+U+M9v6izsp1t3BoenCNdmYaSdDRcgwHNsF45mun
         e+u/5rCly48y8L24du/ObpkjnUsUjsTMt1yK1oPQOxpYq0Gz+Dy1Tg7kCfdNA2n1KyyK
         Os6Q==
X-Gm-Message-State: AOAM531blqC3tzGypIivIHG6pRf09SlWl6OHdQheYoivRn0zUqGObU8U
        XSG1556xsC2NtKSlCWKNC+NRjA==
X-Google-Smtp-Source: ABdhPJzzgR/rHp5puKqSVZrzAs1oIA3JRcqHIp0G7enBP9XWkQb3cpkstNanbqrUyOKT1qlRTkZAtQ==
X-Received: by 2002:a05:600c:414d:: with SMTP id h13mr14924930wmm.121.1631882483259;
        Fri, 17 Sep 2021 05:41:23 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6b11:6374:882d:42a0? ([2a01:e34:ed2f:f020:6b11:6374:882d:42a0])
        by smtp.googlemail.com with ESMTPSA id l26sm10532391wmi.25.2021.09.17.05.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 05:41:22 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Add a generic virtual thermal sensor
To:     Alexandre Bailon <abailon@baylibre.com>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org
References: <20210917072732.611140-1-abailon@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bd347d14-0b42-f9ed-bf15-080c929e1cb7@linaro.org>
Date:   Fri, 17 Sep 2021 14:41:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210917072732.611140-1-abailon@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2021 09:27, Alexandre Bailon wrote:
> This series add a virtual thermal sensor.
> It could be used to get a temperature using some thermal sensors.
> Currently, the supported operations are max, min and avg.
> The virtual sensor could be easily extended to support others operations.
> 
> Note:
> Currently, thermal drivers must explicitly register their sensors to make them
> available to the virtual sensor.
> This doesn't seem a good solution to me and I think it would be preferable to
> update the framework to register the list of each available sensors.

Why must the drivers do that ?

> Changes in v2:
> - Fix some warnings / errors reported by kernel test robot
> - rename some struct and functions with a more accurate name
> - update the dt bindings: rename type attribute to aggregation-function
> - factorize a little bit the aggregation functions
> 
> Alexandre Bailon (2):
>   dt-bindings: Add bindings for the virtual thermal sensor
>   thermal: add a virtual sensor to aggregate temperatures
> 
>  .../thermal/virtual,thermal-sensor.yaml       |  67 +++
>  drivers/thermal/Kconfig                       |   8 +
>  drivers/thermal/Makefile                      |   1 +
>  drivers/thermal/virtual-sensor.h              |  51 +++
>  drivers/thermal/virtual_sensor.c              | 400 ++++++++++++++++++
>  include/dt-bindings/thermal/virtual-sensor.h  |  15 +
>  6 files changed, 542 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
>  create mode 100644 drivers/thermal/virtual-sensor.h
>  create mode 100644 drivers/thermal/virtual_sensor.c
>  create mode 100644 include/dt-bindings/thermal/virtual-sensor.h
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
