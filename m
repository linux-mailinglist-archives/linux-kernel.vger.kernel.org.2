Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B634E456C58
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 10:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbhKSJbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 04:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhKSJbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 04:31:08 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C18CC06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 01:28:06 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 133so7902189wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 01:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r+D+/iFxQeUaSzIHOYEY7gTB4ZlTunAChJBw4Vx/h3o=;
        b=MsCrfqF2G/HWApoSW+yGY/CahQ5E1rwVg/Q5wRILPSt5NZhRikHb3/etvMUgNfeg3e
         VtGfkURG+2dfbHYb1f03OdWBVitnDMMMxXweRgp3mtN9tn+sZdv9Dqst1IZYhnm4hs8O
         tKx9v/HO8f7nzmhso1cgimMBQgH68+m9FAapBKewFehMpiMP1G6bcYc/5zWFQHUs1xDN
         zOg0bIhlkNH6aBNwFI1lj65gSlZa5ZmZ82KeIB/MhYbtV7iAGKC9Kx0joIQOK2dcddb/
         VwD1CrNAG8RRRZ/U9UsHYR1Sw8MlYqNE/A9QiTPqcMHuj9wIh9/Gbf/tHokSprrZ4Ms1
         KHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r+D+/iFxQeUaSzIHOYEY7gTB4ZlTunAChJBw4Vx/h3o=;
        b=HlTHn1ednN5ZiJsdFG/YEw1QxwNkt4ourYripi4LXzQ9dg/yu8DCIMUJvBL4DpnDsN
         oZFXPqbwb+xyekcLFzZpAN4ecGTf2RySCs3N9l6xsVoTkABeO44pz0ziv+kivEA1IU1a
         rFB1pKP+ehldPkYRd+O5jRLCiQDyBTeisHP4NbXFn9ZOT9aKlPvYZAnpxYGFImsyKgj9
         iFfWk0Q1EaQ7Mye7aNCIhMiFnYl1b1nRdniNDN81AmHNC96qs8mWRskBrr6wSQ4oqhge
         9WhMSfRawA6bg73xHhGMjuI/mO9ptMP8h1GF0NXMpNPxEGxm8OwQ987u8V3FCvYwkAhA
         Q+jA==
X-Gm-Message-State: AOAM530gEts9i1W6uBsq1nzm6Gt3pPXK6sz3NngnhosenIyPFauqXy6m
        EMb6520tXPh3EiroqndnVZxB4w==
X-Google-Smtp-Source: ABdhPJySuFqUtzPgUUjMSITVM6BpN5ur/JS/Xzbc1VOcd0/Y0kjbMZ6qRNVEUg4ADrOIAHNulb/dgQ==
X-Received: by 2002:a05:600c:b43:: with SMTP id k3mr4912735wmr.159.1637314084575;
        Fri, 19 Nov 2021 01:28:04 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:dbf8:821:b43e:3a83? ([2a01:e34:ed2f:f020:dbf8:821:b43e:3a83])
        by smtp.googlemail.com with ESMTPSA id t1sm2750773wre.32.2021.11.19.01.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 01:28:04 -0800 (PST)
Subject: Re: [PATCH v3] thermal: imx: implement runtime PM support
To:     Petr Benes <petrben@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Zhang Rui <rui.zhang@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20211117103426.81813-1-o.rempel@pengutronix.de>
 <20211117103719.GA4250@pengutronix.de>
 <CAPwXO5a+EEWzUm=Kgda8Dr5xmUBhmHMr5dNnFrw2wrjfEmDs0Q@mail.gmail.com>
 <CAPwXO5bHG7WmPLFFN429VGV7ra4V9ZvT5WfDMwdXOCvS3_x9jA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1a9c6e6c-2b0f-1e27-4f9f-ae065631006e@linaro.org>
Date:   Fri, 19 Nov 2021 10:28:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPwXO5bHG7WmPLFFN429VGV7ra4V9ZvT5WfDMwdXOCvS3_x9jA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2021 10:18, Petr Benes wrote:
> Hello everybody,
> 
> If this issue is about to close. Appending my tag.
> 
> Fixes: d92ed2c9d3ff ("thermal: imx: Use driver's local data to decide
> whether to run a measurement")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> Tested-by: Petr Beneš <petr.benes@ysoft.com>

Applied, thanks for testing.

In the future, please just add your tag, not the other ones otherwise
that puzzle the tools collecting them.

  -- D.

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
