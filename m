Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCA8391A17
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhEZO0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbhEZO02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:26:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC06EC061574;
        Wed, 26 May 2021 07:24:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id e17so2253552lfb.2;
        Wed, 26 May 2021 07:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z4WMqlCaqWbEIAHnN6egjilVNRZEESDoadmQbpaoajE=;
        b=K/9SpcovoelFFzr0TPY28fCSQVmbxh38g7BBwjgWZ39vv+foIla4SnDJZCm9JGkccv
         5H2fjPYjD98P4za3oilxJpI0WXvWsDYZ5+xyCJ4Ogj6W9MhntxeR4lCO9i2hA+FPa/eH
         vsd6hH331vPY95swod1+7s/wLiN6nxGvf7nabdym1pN8zA98PHwVeWVHjT1aHXttoyeX
         GuBlxTgM3eFDT54GJoqf9gjsb6MwE1sTTsqPuSDLvcOBORuPgZqv+zsdphHV1kB3NAZt
         17xJRpuwpRWJ4GS7oIuOErOsAmMtv+bGQlmv1K5c/fraxanV8snpgUQA0z2U675R4Gqb
         gQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z4WMqlCaqWbEIAHnN6egjilVNRZEESDoadmQbpaoajE=;
        b=VeaWoPxlvqy83B9BH/uJjoccS7efH5CV2So58mo2B+FBlD8xQ8K9i4vvs5GXLL6AO2
         7OCNrpBxWO8UawzgCbF9cEfGT2Eb0rrW9x/TF05rdRf2ifWEaPiXsT6CoatvcWiqaAM3
         sapdJC2DQPzlElswQFjBOHWmSlFcwnyIIrvXwy+f/jmR+tt0YWE9SWOdPcUZvynE4Gfy
         XO4XWXjkWA0VuEGyhm7OWRMGIKiuaEVCc8q+xtqO73qVXkRaT7QIEprRuoTjLWEOa6cM
         vgdS0BuEgMkLUlELkIP82DuodJ9kXe8VmL6qtOUncM3Bffy3y9eDf4H9qLipbotzzVOq
         M4Yw==
X-Gm-Message-State: AOAM533o/AS2yuGqhKM1Ul3dzqHBZNLibW/H26YRkRQa25jZuYhoV04K
        hqk68FzMRFdBpNZ7q9XzYSybZYgeCw8=
X-Google-Smtp-Source: ABdhPJy1ol4BQtSOWjEpDvXMlDyrq+30W4jrVXfn1pVuparf3IB6gSCwGx7J5CgG9eg2OiX3c+QRXA==
X-Received: by 2002:a05:6512:1318:: with SMTP id x24mr2226384lfu.53.1622039093758;
        Wed, 26 May 2021 07:24:53 -0700 (PDT)
Received: from [192.168.1.102] ([178.176.73.49])
        by smtp.gmail.com with ESMTPSA id r17sm2433434ljp.40.2021.05.26.07.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 07:24:53 -0700 (PDT)
Subject: Re: [PATCH 13/24] usb: chipidea: core: Fix incorrectly documented
 function 'ci_usb_phy_exit()'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        David Lopo <dlopo@chipidea.mips.com>, linux-usb@vger.kernel.org
References: <20210526130037.856068-1-lee.jones@linaro.org>
 <20210526130037.856068-14-lee.jones@linaro.org>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <16614428-45c7-06af-547a-dba9c493de67@gmail.com>
Date:   Wed, 26 May 2021 17:24:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210526130037.856068-14-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 4:00 PM, Lee Jones wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/usb/chipidea/core.c:343: warning: expecting prototype for _ci_usb_phy_exit(). Prototype was for ci_usb_phy_exit() instead
> 
> Cc: Peter Chen <peter.chen@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: David Lopo <dlopo@chipidea.mips.com>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/usb/chipidea/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 3f6c21406dbd2..2b18f5088ae4a 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -335,7 +335,7 @@ static int _ci_usb_phy_init(struct ci_hdrc *ci)
>  }
>  
>  /**
> - * _ci_usb_phy_exit: deinitialize phy taking in account both phy and usb_phy
> + * ci_usb_phy_exit: deinitialize phy taking in account both phy and usb_phy

   I thought - shoiuld've been used as a separator. Is : good here as well?

>   * interfaces
>   * @ci: the controller
>   */

MBR, Sergei
