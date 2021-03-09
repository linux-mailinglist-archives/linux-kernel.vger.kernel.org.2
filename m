Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16553331B13
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 00:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhCHXmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 18:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCHXmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 18:42:25 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF1FC061760
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 15:42:14 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so4831636wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 15:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hwc6ioSeyDLj2VeBA1I8VhaON0iiYWH5K/33t+nVEd4=;
        b=fG2Rf1CFFFJOBspVUlpQ58aCn5uGaTWTG5S2k7Kybh/91K2GAbdqKd08CvgyEghb/v
         Wcyt4s3jj1DrxGQNenrDByBqIO2oVEcoemDa+Z8QSM0Tae7LoJCm73rMhwLvzOt7soLa
         O1bd+/urR20jWf6kPZXJSWTCNFsP98AoQJbxzbaiYnVNySdgYmVucLU6umzI2ksECekN
         6KQdPPMQqFmlmyurT0EpFOZeR4cJCwf8Z5Q6X7yw2qEHPaNKKzTJM4Gws9qW/1J9i+a9
         sqlQMuSttREb5QD9bFj9Vt/URjmssrlxCyMVJ6R7alQYqUDoGchRWXyph6/7AnC5Ay0L
         amHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hwc6ioSeyDLj2VeBA1I8VhaON0iiYWH5K/33t+nVEd4=;
        b=uUwFb1UdxYOJLsANJKXHq0xqFTmC2iKQhT/0IJUPSsv4U0+ArzIgC5KwKzNF5kyiOm
         gYLPsOgesoK9Nq/s6VnyRJI7LD6HvOkhdAujUTSQc9l2DqAnYoSSB8dg2NetfOgo8+FF
         6fqyF8RYvjxlkUa3zxJZ5UzBrQGRw52Bus6ynQ0zZqTFXoGoD33kwJI2lLA5/m2fwmHk
         +0OcShafdD1PJ2O8An/dzwR+IWVHvos/+ZsYKO3tBpmQXTGXqguONfS6snA0aeW3xYJ6
         ibJAxsxLhiOF+4qd7l3BwKbiNHuUnF4BC8M7DklYodyGpa9r9jdhJoLYZT7FXb/J2Yvd
         Ezcw==
X-Gm-Message-State: AOAM531RUF5yp6GMTf11RFq+rLbb4NcZ/b0zeUG3zYcHlhmmEKrFnQSN
        KP9fpwPvuX71UXxCywLFdJjyRI/xPgR4Sw==
X-Google-Smtp-Source: ABdhPJwxqDuF6ZBG+tpLP00v/+QBSkSxlsTwFBddThHUrkPRzL59fLYqHDncktr+qz2xfyOcvqL48A==
X-Received: by 2002:a05:600c:220d:: with SMTP id z13mr1053866wml.1.1615246932725;
        Mon, 08 Mar 2021 15:42:12 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8499:4f69:106b:da0? ([2a01:e34:ed2f:f020:8499:4f69:106b:da0])
        by smtp.googlemail.com with ESMTPSA id j16sm1684956wmi.2.2021.03.08.15.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 15:42:12 -0800 (PST)
Subject: Re: [RESEND PATCH v5 1/4] dt-bindings: devfreq: rk3399_dmc: Add
 rockchip,pmu phandle.
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?Ga=c3=abl_PORTAY?= <gael.portay@collabora.com>,
        Rob Herring <robh@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210308233858.24741-1-daniel.lezcano@linaro.org>
Message-ID: <0771841f-9227-1c6a-2dc2-366511bcc926@linaro.org>
Date:   Tue, 9 Mar 2021 00:42:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210308233858.24741-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2021 00:38, Daniel Lezcano wrote:
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> The Rockchip DMC (Dynamic Memory Interface) needs to access to the PMU
> general register files to know the DRAM type, so add a phandle to the
> syscon that manages these registers.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> index a10d1f6d85c6..a41bcfef95c8 100644
> --- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> @@ -12,6 +12,8 @@ Required properties:
>  			 for details.
>  - center-supply:	 DMC supply node.
>  - status:		 Marks the node enabled/disabled.
> +- rockchip,pmu:		 Phandle to the syscon managing the "PMU general register
> +			 files".

For the record, https://lkml.org/lkml/2020/6/30/367



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
