Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E791A3A5603
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 04:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhFMCGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 22:06:41 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:39901 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhFMCGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 22:06:40 -0400
Received: by mail-pj1-f41.google.com with SMTP id w14-20020a17090aea0eb029016e9e0e7983so1483892pjy.4;
        Sat, 12 Jun 2021 19:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GXniuSw9ZMF00jtVBbwWdNTHC0JQ2hlRGU6EisXwcVc=;
        b=XtYIKlxgbuwqIrJ/SFXLecxdONWGKycr4SZNgxgEOfoVsTwcZATs5qOSeWb0ICjbrW
         0oFCIPP9x1a0Z0vTLis+8ojoMy1z7UkikPWNNrnavkV44YdqvGOLwAA+bIswzRHP1cTd
         goMPk+JGyp/pI+ycSs5Nhf41ex50VxmQOdUGOFwm4EVJ/BKnZ2RsETtcXM17LUKS+6zq
         CPO//54zmzJqjFg6i7Ni1EX+EB4HmvB1+ZX341+aC1S2u6exaWa4HbIMbeQxUqJwagGH
         Bm1L5L5fFdAoYpcXIgX19X6j5nRWPV3ZNKgGhPf8ehCkzu6UD+cC11yPAgIkuF/UznSh
         0TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GXniuSw9ZMF00jtVBbwWdNTHC0JQ2hlRGU6EisXwcVc=;
        b=h1yK7F3aKi8gPsgTERr17YjGHeDYZr2j9ilIGk4RDp4ep+W7cIT+lWsv1tc7yoq4cN
         bYV1bcnlPUDh649mlJ8nXSwpc7n2YW4FW8dnF+4YdYW02s0ni1/uUIqpp/XeD+pKUe1H
         TxawBPK4KOn8R44rAPaVRL9T5dmPElc4WvQjpCd99ybP94E3Q98CyRIZmd2subPSvB4p
         YNDRjRcEbj53OAvK3nu7Zq3TJmK28hn5FCil1YwqHuvBP6oi4J9rT97VyKL5ksSrXtX/
         0g2AjJOHDw97zu52gn5ggW5q7/B6hrvRtxsmp0irYOvMEy0KEQayscFmRv4Nwuh8xxJu
         Y3Fg==
X-Gm-Message-State: AOAM5304Af0JAl+uOPmjhdT6BverdWEqt7q+/ZT7JZYnv3oeojaPkIOp
        ofReiVD/Qd/bK5cqGpaoCDw=
X-Google-Smtp-Source: ABdhPJzZxqHRGgsczR/Ffu5hOfnCDw/t60KeaFg1sev/yKbBqB1gL39zuW+KBj84curnuugQKMeWKw==
X-Received: by 2002:a17:90a:b94c:: with SMTP id f12mr12110709pjw.32.1623549812731;
        Sat, 12 Jun 2021 19:03:32 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b23sm8444278pfi.34.2021.06.12.19.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jun 2021 19:03:31 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] ARM: dts: NSP: Add common bindings for MX64/MX65
To:     Matthew Hagan <mnhagan88@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210610232727.1383117-1-mnhagan88@gmail.com>
 <20210610232727.1383117-4-mnhagan88@gmail.com>
 <20210611203031.fj3g32o7kgupgzjy@skbuf>
 <0f3e81be-e99a-41fe-6898-42c4d25b21be@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <670e1397-1b90-ca8d-c161-6a4c48d6bff4@gmail.com>
Date:   Sat, 12 Jun 2021 19:03:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <0f3e81be-e99a-41fe-6898-42c4d25b21be@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/2021 4:14 PM, Matthew Hagan wrote:
[snip]
>>> +	pwm-leds {
>>> +		compatible = "pwm-leds";
>>> +
>>> +		red {
>>> +			label = "red:led";
>>> +			pwms = <&pwm 1 50000>;
>>> +		};
>>> +
>>> +		green {
>>> +			label = "green:led";
>>> +			pwms = <&pwm 2 50000>;
>>> +		};
>>> +
>>> +		blue {
>>> +			label = "blue:led";
>>> +			pwms = <&pwm 3 50000>;
>>> +		};
>>> +	};

[snip]

>> What is the reason for overriding this to 2?
> 
> I can't provide an explanation other than that it only works at 2.
> 
> When set to 3 I get the following:
> 
> [    0.784051] OF: /pwm-leds/red: #pwm-cells = 3 found -1
> [    0.789201] of_pwm_get(): can't parse "pwms" property
> [    0.794295] leds_pwm pwm-leds: error -EINVAL: unable to request PWM for red:led
> [    0.801628] leds_pwm: probe of pwm-leds failed with error -22

Strange because with a #pwm-cells value of 3, of_pwm_xlate_with_flags()
would treat the flags as optional so the way you have put it looks
correct to me. I am not sure what the channel sub-nodes are supposed to
do, they do not appear to be documented properties or parsed by the PWM
core?

Is your Device Tree possibly corrupted here?
-- 
Florian
