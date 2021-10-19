Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FECA433532
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbhJSL5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 07:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbhJSL5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:57:48 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A80C061745
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 04:55:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k7so47068890wrd.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 04:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OfgRavpjdaRnyZMZtHAxS1ESnmxDtwV/YQMRVX1HiTg=;
        b=shhQdElF6ju41sYLL53sgrDU3KlOu00x4bItb6g0DDp0EcCi2e6P+L+6RbQxOsuldn
         YjWitlBL9d3RknRslgWM8WK8J5FA28B6XTQUyPmcxLhV1zydcZxFGVpH4huyOPAgjDL+
         g64Z3BW+20bn/uVXGhDtKuuqs6fxO7M8O7wt700S3lnZa+YPBb0NsSAPC8VIlFRR90Li
         usfQD9JfzNX4sZua+JM3bx00Y1FfsXfWO70txY/dUJUwXd7X3ReKLUCLdKr4LWBEHiQn
         aGTq1j1HyRtTZfTTda7fnVwbdTBc/1CLPTIdplUmKkRnGFOnTnZ1HG4LSgruv/BNAzl0
         T0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OfgRavpjdaRnyZMZtHAxS1ESnmxDtwV/YQMRVX1HiTg=;
        b=nKJN8ClfnAAipsRANkSvg0G9CEGv+cIBS4RSDP4vO2kB8bDgPa0ZcTGaHU1V2pZGlF
         3vqm0VoY3UmSUHoLOmv7sc06cMlkwAX29XYkUsz846de6IcG6EXefSIxEjhoOnGAE5DB
         6qzZnuA4NWOIGkAxy46mB1Ml5L2MkBrSbnfti9AgnFmQBHR2h3xgP8KrgRU3UDqn3jJz
         MzlnxXmdX45VbY+HhVAvZ7x4QN4VCXh821drlP5XD/r0+sWM+1cdxkoHERTbySGfT35t
         6KkJms1Kr5gAG3VU4uqWUOrCoFFE2EKwNvoS3eSN7UDlIyeNBY05j2dMMabyR6qfaEsr
         qDWQ==
X-Gm-Message-State: AOAM5316Q2K7Lz6WnYDgTHXB4IY2weLkvfTQ6ysioD4npjapE4iaTy8t
        pka2c7GrUA+EW61v52JDW3SKbA==
X-Google-Smtp-Source: ABdhPJwdnQGuYukHN+2a6QkyEQRU9mh3j3XSKlSZAo+R/J8UIiCSg79kX4Xbl1jZ/rqWSu35mgEDUA==
X-Received: by 2002:adf:e292:: with SMTP id v18mr41642658wri.369.1634644534174;
        Tue, 19 Oct 2021 04:55:34 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c590:9206:d20a:23bd? ([2a01:e34:ed2f:f020:c590:9206:d20a:23bd])
        by smtp.googlemail.com with ESMTPSA id 10sm2381798wme.27.2021.10.19.04.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 04:55:33 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] thermal: imx: implement runtime PM support
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-pm@vger.kernel.org, Petr Benes <petrben@gmail.com>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Zhang Rui <rui.zhang@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20210924115032.29684-1-o.rempel@pengutronix.de>
 <19b2ab33-aa56-75fb-f6ef-3c928be9c50c@linaro.org>
 <20211019115151.GC16320@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <df3f527d-22f3-b58d-a546-bdd8d312505c@linaro.org>
Date:   Tue, 19 Oct 2021 13:55:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019115151.GC16320@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2021 13:51, Oleksij Rempel wrote:
> Hi Daniel,
> 
> On Tue, Oct 19, 2021 at 01:04:46PM +0200, Daniel Lezcano wrote:
>> On 24/09/2021 13:50, Oleksij Rempel wrote:
>>> Starting with commit d92ed2c9d3ff ("thermal: imx: Use driver's local
>>> data to decide whether to run a measurement") this driver stared using
>>> irq_enabled flag to make decision to power on/off the thermal core. This
>>> triggered a regression, where after reaching critical temperature, alarm
>>> IRQ handler set irq_enabled to false,  disabled thermal core and was not
>>> able read temperature and disable cooling sequence.
>>>
>>> In case the cooling device is "CPU/GPU freq", the system will run with
>>> reduce performance until next reboot.
>>>
>>> To solve this issue, we need to move all parts implementing hand made
>>> runtime power management and let it handle actual runtime PM framework.
>>>
>>> Fixes: d92ed2c9d3ff ("thermal: imx: Use driver's local data to decide whether to run a measurement")
>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>
>> Thanks for this fix.
>>
>> Petr or Oleksij,
>>
>> could you confirm it is tested and working without CONFIG_PM ?
> 
> Petr was right, no it is not working without PM.
Ok, thanks.

I suppose the fix is related to the initialization of the sensor which
should be enabled with/out pm_runtime, right ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
