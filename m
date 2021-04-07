Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17453567BD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349994AbhDGJKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbhDGJKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:10:22 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3C6C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 02:10:11 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o20-20020a05600c4fd4b0290114265518afso769802wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 02:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E701SlcCrVz67XXmWrxLLXJUKWXi3hhGVBswQflcfKc=;
        b=rcq+BxD8v9tMgxLwmSDs2SRxC0bboNhEvY6zfzGzUrzUNmiMb4dDVpB2lqfaoUQmZi
         2SdoDnDkrFXaX335+nCRrv7x0QTWIm6Zv5shcl1AskSULGdM/Ch9sKjSsI7FN7pnORE3
         +Rj0f3HsLOZpjmJjsWm0bz2S3MDaSZqSLL7IMlAjUALM7M2goYB1ZwWULnfki3Z2cqeS
         axJKtsm2AdexUF/R1H+xA5OxzJEhsUhiRL4Nzpq1Arz5GYgS7g3EcBVPuAB6CA3l/crY
         x4kD8ZQzJZDnqRUKUUyaB9w4/xPSi2i9MpyIOzz6+azi96xa/NtCZ6Z9Q/xUpfEerYOk
         56lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E701SlcCrVz67XXmWrxLLXJUKWXi3hhGVBswQflcfKc=;
        b=bNzImqIWXP5/b/JFEOMWI64oy3i13yHbHp4Fu61rb3ItHUx8IMCQc4mscDsqrijybN
         14Cv2Vt+P9KqRmE8zTYeLlT1guljAlxbrTOA4PP2c4sPkIkpKt7OKEaenc9LWyFzZD4y
         HDZrqmy5OfM32Bb+4EwDkQ66VBL0Ecw4nepkzOvotfeIqrBnuQJ2oHzn2CUU6BU7emBJ
         7G7g9BmpTh5NQ4mZGDoAzXQwMf9U54108Si0UKbR2Cy1qeT2Au4wJ8zGIRerHGckweix
         eCHu0XjaKW7OBqEMOO8oj3V8Lz6b0yPgQV/v/K8coL76ZPgipnpfn0efrZm/f4QucfYm
         SYYg==
X-Gm-Message-State: AOAM530Gggucz0Bqqe1IhG5YEFnFDCuVWK6b5L15djRzgQC6/pEkE8lP
        hlNJyMqdQNo2CC1fbocNaOb6Bg==
X-Google-Smtp-Source: ABdhPJzcgQhp66xKNb9OEInGvyad2APPTICANv9uTgAdL/J/3NtVusZS+eiTi1UhQBfdtgyn2rSb3Q==
X-Received: by 2002:a1c:4e07:: with SMTP id g7mr2112103wmh.29.1617786609946;
        Wed, 07 Apr 2021 02:10:09 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:90c5:36a9:5586:99b9? ([2a01:e34:ed2f:f020:90c5:36a9:5586:99b9])
        by smtp.googlemail.com with ESMTPSA id s83sm7418759wms.16.2021.04.07.02.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 02:10:09 -0700 (PDT)
Subject: Re: [v3,1/3] thermal: mediatek: Relocate driver to mediatek folder
To:     Michael Kao <michael.kao@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, srv_heupstream@mediatek.com,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20210312034018.17437-1-michael.kao@mediatek.com>
 <20210312034018.17437-2-michael.kao@mediatek.com>
 <1617786505.12846.1.camel@mtksdccf07>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <848df858-1f8d-bcf1-f885-546b70c37b9e@linaro.org>
Date:   Wed, 7 Apr 2021 11:10:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617786505.12846.1.camel@mtksdccf07>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2021 11:08, Michael Kao wrote:
> Hi Maintainers,
>  
> Gentle pin for this patch.
>  
> Thanks

ack, pong



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
