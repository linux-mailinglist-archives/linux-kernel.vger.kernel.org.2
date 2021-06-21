Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DD03AE821
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 13:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFUL2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 07:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhFUL2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 07:28:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A335C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 04:26:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m41-20020a05600c3b29b02901dcd3733f24so3129287wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 04:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VQIndBF+raV4yH/uAef42b9tgSUc/q1HIDoWGC5a4rI=;
        b=RTrAlXf9cKXMVWwPGTX1Kwgjh+eL5clejf7gh7Vjpa/nemnps6a40jTvvUVsfcT6HU
         UOzJzgyK9BDJKzXsF6CcygNTm7Unq1YvMT50PDBrYefsKVO2/anOsOfeDx03Xi5/WxGQ
         GhrK+l+kGMq/eeUNIMEu3tX4itq5fJbgbc9jF7BKYGFoVeBfZMen60pt0XxNCMLHFK4I
         lySoWPGXX3GwLDZuYgFrpa0qzqU0hixPCFJ32zDR3CAhZsY5mKrDXnko3xzXM2IZDgP/
         G/lBWjB5hIEDalX/aYWlHoajEdXb7vm8ziSv3a6/2ewgh/4YJibXy35JIRiBweMngetG
         zAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VQIndBF+raV4yH/uAef42b9tgSUc/q1HIDoWGC5a4rI=;
        b=Zpub4TykJwJnbwqBs7DnR5tLI69TRlzi/7+okXKCNBd8pmdMlmVfDJ/0NBPQljROJr
         T4B3tcVGx4J/y5gRQkXP+XYo1kx7TBymxurbIjKuTYjRdi0S1jpV5vydyimYe22Mu0hK
         c9cEBBD0yCzvJB8el2KS+EiApF37gPfsOJ3cbDE9au1R2/9/hTJFS2esjemnQtq6tTb8
         l0OIU+GITKcHViY57Tu+ef0Iq2CWoVvJ3WRNtVL632rvm3YiWbUkYT3y1Mv+ESbzr2Y7
         Wz+Ue+/qjexNI2hxQolaUYNyPNmNgarMLDjb72POEpoZUT+RrxMSdO5w/RX9FDAfKW/b
         0N9g==
X-Gm-Message-State: AOAM530eNCoR77wXVfi0JqVhqZPhtFPwN8F9dHswaAbxVXPAxpR/8bh+
        hetsY03ySJhah+kKeHoPdVuxe6jEh/BWL2aU
X-Google-Smtp-Source: ABdhPJzBf/rLzdPhlwdeWkxppRCDDwZPEvglk1oWay5c9Zwsnkp4D3mNVDvM1mQNffoDwpamZ2GZ+Q==
X-Received: by 2002:a05:600c:88a:: with SMTP id l10mr26901650wmp.7.1624274785928;
        Mon, 21 Jun 2021 04:26:25 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5ebd:8bd9:d549:4211? ([2a01:e34:ed2f:f020:5ebd:8bd9:d549:4211])
        by smtp.googlemail.com with ESMTPSA id s5sm18556352wrn.38.2021.06.21.04.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 04:26:25 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v5 2/3] thermal: mediatek: Add LVTS drivers for SoC
 theraml zones
To:     Ben Tseng <ben.tseng@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        srv_heupstream@mediatek.com
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Michael Kao <michael.kao@mediatek.com>,
        Yu-Chia Chang <ethan.chang@mediatek.com>
References: <20210617114707.10618-1-ben.tseng@mediatek.com>
 <20210617114707.10618-3-ben.tseng@mediatek.com>
Message-ID: <06b1804c-4675-2997-8c5c-bcdffbcfc4a1@linaro.org>
Date:   Mon, 21 Jun 2021 13:26:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210617114707.10618-3-ben.tseng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2021 13:47, Ben Tseng wrote:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> Add a LVTS (Low voltage thermal sensor) driver to report junction
> temperatures in Mediatek SoC and register the maximum temperature
> of sensors and each sensor as a thermal zone.

I think we already talked about that. We don't want a thermal sensor
driver to aggregate the temperatures but create some kindof virtual
sensor with a property (min, max, avg, ...) which is usable by anyone.

[ ... ]



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
