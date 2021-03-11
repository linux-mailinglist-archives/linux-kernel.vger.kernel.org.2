Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA9C337201
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhCKMFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbhCKMFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:05:08 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E7FC061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:05:07 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso13027737wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aMz02Pw/MDl0mrQwKqYDtH71nVS5Z34c9wdMRV1lOr0=;
        b=aVrMdt8T8/22diTp99YzVzKObN++3fBBNcFoCKDLcHbKPjlu2RlTSq3KZOHMDaTg36
         CHJCYlRl2Fw+L2GAynR9pSnImyRYMJgIUANmZn5OfC9l6ocb6zfv9FFLrF2Jm19Xp5z0
         TyvHKIJJ/ySTAdnkr7ks3OFvI/IRhxHyKuHiRAuEM1xZWTRWV1i3ksIhcKEJvSup6tPl
         BmHCoem893e/iZSd8QV8kU/Ie3Et4yXDfBmC+dAml5FV+uq7CJFRZpjVl2TLvdkg6LaY
         1JfxVfUa/3foEvpug8MaBgaa+rnbD8I4jtF/p+GnbI8eafOdORQcqhCdf5tTGPAMMx22
         W6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aMz02Pw/MDl0mrQwKqYDtH71nVS5Z34c9wdMRV1lOr0=;
        b=ApDGIp9bXVG5eJ362OGFX3O8+S7HnTCvhrrT/Mhco9xGmo+t+UMYbyI9RhMJGmElsF
         guS1K2S7Tjsow5IBsDFGfVptiIsoy7/wAy+m7VEZtfEcgXfsawH1g3fadjyo/NwmqVLf
         Xk4TernDqKXj+2A4aTGvh6zYM8q3ts4b4i6Hecjpp5zPHg33l1exoEauIVSJ3ICxXBqF
         px6rX08/5eAcFgnM13DJV3Cocy03To2RWPf2fzaVqUVXm2rKiIZ38uDhfeMOvMVg9Txa
         sa0j83359zOg8kVJhWawF/RNkVubo3oy3B79e88Fwri8eTrBYfwL+rWIQEP1Um2mFjJq
         el5A==
X-Gm-Message-State: AOAM530GQD5fkll7AgoBFEfbwq/6v9UVjnv1BLaQXhZWum0aYWeiuej5
        2JArN14/09p+Q5tGFIJ4V3y6Xxtq9WFdJQ==
X-Google-Smtp-Source: ABdhPJy6rICxcQ9Lhw2Aw4PIYEzaZG0Ub83ywDHcSjrrLcV7UYTGYnhSG+DcKXgHOaT1D38zVLyo/A==
X-Received: by 2002:a1c:9d85:: with SMTP id g127mr7881382wme.161.1615464306057;
        Thu, 11 Mar 2021 04:05:06 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:84cf:7f4d:d470:dfd4? ([2a01:e34:ed2f:f020:84cf:7f4d:d470:dfd4])
        by smtp.googlemail.com with ESMTPSA id c9sm3516205wrr.78.2021.03.11.04.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 04:05:05 -0800 (PST)
Subject: Re: [RESEND PATCH v5 2/4] arm64: dts: rk3399: Add dfi and dmc nodes.
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Lin Huang <hl@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?Ga=c3=abl_PORTAY?= <gael.portay@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210308233858.24741-1-daniel.lezcano@linaro.org>
 <20210308233858.24741-2-daniel.lezcano@linaro.org>
 <9c36893a-6ca8-dade-e203-890a4071bf50@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <01efe343-673a-6f4f-13e7-cbf2a7254b6b@linaro.org>
Date:   Thu, 11 Mar 2021 13:05:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9c36893a-6ca8-dade-e203-890a4071bf50@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2021 12:42, Johan Jonker wrote:
> Hi Daniel,

> 
> (This is a generic dtsi. How about cooling and dmc ??)
Yeah, I will add it after. I need to figure out the right dynamic power
coefficient from the different places around (android / chromeos /
etc...). Any help for that is welcome.


[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
