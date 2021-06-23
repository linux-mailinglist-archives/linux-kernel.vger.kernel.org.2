Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6842F3B1E2E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 17:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhFWQAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 12:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhFWQAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:00:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A521C061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 08:58:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b3so3223185wrm.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 08:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aWHjZHm3N3KTaeI1flHxO+u2O+0Wxl7tL3alYGtaqRE=;
        b=a6J6ljRuAIZkb+DVh8LoW7jj02m2amlvP37pUMNIC86PChD5zvYWSbh2ZPGuIxteun
         CxrJF0tvbIvfvj/x0Xh15YJyR3eEd7alhnBUiQfafOQENqPJrAnhOb07FAaltD3iRPJ0
         xiZnW98dRqX9F/1ss+6OxTkIwJOcNEgXMu1m+xQfHHCH/Lfw53oWHLY4Q/cUfXehz1Bz
         UHV3VjzMXqwFYdkBf6UMuRYKHap3m517Gu5B6RuzCUvw5aQLeyYBImR4Hl6R7NtHS2bB
         qlhH//kCrMoF7nN7WaOAKcluRgurO8Oo1ozvhsnjva9/o7Rdar18Ndu5a/Ex8yTkocnw
         qFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aWHjZHm3N3KTaeI1flHxO+u2O+0Wxl7tL3alYGtaqRE=;
        b=BWs604AV0gNc/Bk/9uOncqsY/QH4z+LhNfl8aBXiGKhHM9NkyclNV5Ye/qLMvu04A6
         dBvkuwyOMM20lDkzIpRUvJn59vplPK3l+Owj1oa0M2lQlZ6P28H4N2uQTB7bExMK9BiH
         4/pker895CLNkSaN9Z+wqjY3Piyc3e8Xxo23A886yZNcu9I+p9KgaG5h2+XskkF2qnlS
         23lnXG2DJdrT5ubk2STvesjj9pWDVTTGjo1MNpziZ7tYl6BeJ/MhdIXKT5nTbQ3M24e9
         UIWcPNjZrb1pecubIIvuO66YdwVIY+g4ygzvMe2Wlw/xcqeFbDBiK93FwA4lkVLxgV6u
         Q4Hg==
X-Gm-Message-State: AOAM5325rqKBGAbXd7cZr3Ee84p32lHavj5tc/uPjkTqfkJ5IsZtJ5eM
        +ZYcqI8C/Ge9alDjo6eSSUY8FedahgPkxVfz
X-Google-Smtp-Source: ABdhPJxWwEtc54/a6jHteiZGwnV6uZAjaFc7gseO7+hvrMbqZvGrAyvk5bMATLRniaJYmXd8+LDzzw==
X-Received: by 2002:adf:e48e:: with SMTP id i14mr880832wrm.64.1624463911596;
        Wed, 23 Jun 2021 08:58:31 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a562:3d0a:cd98:9ffd? ([2a01:e34:ed2f:f020:a562:3d0a:cd98:9ffd])
        by smtp.googlemail.com with ESMTPSA id l22sm493291wrz.54.2021.06.23.08.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 08:58:30 -0700 (PDT)
Subject: Re: [PATCH] Fix mt7622.dtsi thermal cpu
To:     Eric Woudstra <ericwouds@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210619121927.32699-1-ericwouds@gmail.com>
 <e30a2d01-a200-80cb-88d9-6aea62dd49f1@linaro.org>
 <56fb5540-fb86-4e6a-a596-1276026b37e5@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a4e41929-6ab4-fabb-741e-f25a5fd14e3b@linaro.org>
Date:   Wed, 23 Jun 2021 17:58:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <56fb5540-fb86-4e6a-a596-1276026b37e5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2021 17:35, Eric Woudstra wrote:
> It is only useful to set 1 map with the regulated temperature for cpu
> frequency throttling. Same as in the kernel document example.
> 
> 
> It has no use to set frequency scaling on 2 different temperature
> trip points, as the lowest one makes sure the higher one(s) are never
> reached.

I looked more closely the DT and there is a misunderstanding of the
thermal framework in the definition.

There is one trip point with the passive type and the cpu cooling
device, followed by a second trip point with the active type *but* the
same cpu cooling device. That is wrong.

And finally, there is the hot trip point as a third mapping and the same
cooling device.

The hot trip point is only there to notify userspace and let it take an
immediate action to prevent an emergency shutdown when reaching the
critical temperature.

> It can be applied only at 1 trip point. Multiple trip points
> is only usefully for fan control to make sure the fan is not too
> noisy when it is not necessary to be noisy.
> 
> 
> The CPU will almost come to a dead stop when it starts to pass the
> lowest thermal map with frequency throttling.
> 
> This is why it is a bug and needs a fix, not only adjustment.

Yes, you are right. It should be something like (verbatim copy):

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 890a942ec608..88c81d24f4ff 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -136,24 +136,18 @@ secmon_reserved: secmon@43000000 {

 	thermal-zones {
 		cpu_thermal: cpu-thermal {
-			polling-delay-passive = <1000>;
+			polling-delay-passive = <250>;
 			polling-delay = <1000>;

 			thermal-sensors = <&thermal 0>;

 			trips {
 				cpu_passive: cpu-passive {
-					temperature = <47000>;
+					temperature = <77000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};

-				cpu_active: cpu-active {
-					temperature = <67000>;
-					hysteresis = <2000>;
-					type = "active";
-				};
-
 				cpu_hot: cpu-hot {
 					temperature = <87000>;
 					hysteresis = <2000>;
@@ -173,18 +167,6 @@ map0 {
 					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
-
-				map1 {
-					trip = <&cpu_active>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-
-				map2 {
-					trip = <&cpu_hot>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
 			};
 		};
 	};


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
