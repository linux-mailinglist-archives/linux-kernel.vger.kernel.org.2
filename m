Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB20A33A454
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 12:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbhCNLFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 07:05:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58784 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbhCNLEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 07:04:36 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lLOXx-0003NB-K2
        for linux-kernel@vger.kernel.org; Sun, 14 Mar 2021 11:04:33 +0000
Received: by mail-wr1-f72.google.com with SMTP id r12so13665825wro.15
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 04:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/4FZlK8TmHAjuapB8AlwDbpmIGJr32ZFSixHpqXZ9pg=;
        b=jQx3hEXbXNly/Qu7S8J0NV5hTsm+Eo9BLopCOfJBQWucC1g4g9Of8GsVBszjwGZ5v9
         MAoDzNeB134LW7ffBwAlMC922AJOa47dE+OmNbFrhdtoGa4vvCqr9J353eKqIGl+44Kg
         DJ2CWM5wxKvBOfLIKJqddJ+Vqq1kJszk004n8OaUVtsjSfcmw1TvobzeU8Rq3dcX+iqf
         Kuhem652JbrLiw7MORDZb/n/NGyFKgi7oFXEFbD667U4sTiYA+5yz6LPXFzD2r0iBzkS
         wKWnNjXKwbtZX+jKz+kEDOpxtrYk7cRdHPIk/0+evOQrr3z/13sSWTsyCO3I5aeT3BHu
         tx+Q==
X-Gm-Message-State: AOAM531c/t3wCrAGbCaYmHdKFzvJ40qDgppyevGj84RT5JFQ+d23Gnf9
        K6yrHWGVs+2EOz/E50JHCdolaAgPODk0Fx92adMW+5mKStL1Oz/DRSM/IQJA6SR7L5drl8B57ZL
        Fzd3hncV+8EJzplI6ufJSatbotMiPPNEsY6wg7KzogA==
X-Received: by 2002:a7b:cbc1:: with SMTP id n1mr21780643wmi.30.1615719873285;
        Sun, 14 Mar 2021 04:04:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjd1ztS9AgHaBu5UXec7saJLQB/ttHqHk3WZPTd6ZQaBlxShB38VGGEsz1DOst3D3NEHuVEQ==
X-Received: by 2002:a7b:cbc1:: with SMTP id n1mr21780629wmi.30.1615719873105;
        Sun, 14 Mar 2021 04:04:33 -0700 (PDT)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id v6sm14931080wrx.32.2021.03.14.04.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Mar 2021 04:04:32 -0700 (PDT)
Subject: Re: [PATCH] clk: socfpga: fix iomem pointer cast on 64-bit
To:     Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>
References: <20210311144833.1313387-1-krzysztof.kozlowski@canonical.com>
 <161566984049.1478170.1891806275092209249@swboyd.mtv.corp.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <7943a259-d40c-4191-1d0d-461edfc3a218@canonical.com>
Date:   Sun, 14 Mar 2021 12:04:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <161566984049.1478170.1891806275092209249@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2021 22:10, Stephen Boyd wrote:
> Quoting Krzysztof Kozlowski (2021-03-11 06:48:33)
>> Pointers should be cast to unsigned long instead of integer.  This fixes
>> warning when compile testing on ARM64:
>>
>>   drivers/clk/socfpga/clk-gate.c: In function ‘socfpga_clk_recalc_rate’:
>>   drivers/clk/socfpga/clk-gate.c:102:7: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> Any Fixes tag?

I'll add it.

> 
>> ---
>>  drivers/clk/socfpga/clk-gate.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
>> index 43ecd507bf83..c876523d5d51 100644
>> --- a/drivers/clk/socfpga/clk-gate.c
>> +++ b/drivers/clk/socfpga/clk-gate.c
>> @@ -99,7 +99,7 @@ static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
>>                 val = readl(socfpgaclk->div_reg) >> socfpgaclk->shift;
>>                 val &= GENMASK(socfpgaclk->width - 1, 0);
>>                 /* Check for GPIO_DB_CLK by its offset */
>> -               if ((int) socfpgaclk->div_reg & SOCFPGA_GPIO_DB_CLK_OFFSET)
>> +               if ((unsigned long) socfpgaclk->div_reg & SOCFPGA_GPIO_DB_CLK_OFFSET)
> 
> Should it be uintptr_t casted instead?

Good point, thanks!

> his isn't a very great code
> pattern given the way we store information in the iomem pointer about
> which clk type it is and then have to cast the pointer and assume
> alignment. Would be nice to get rid of it but I understand.

Best regards,
Krzysztof
