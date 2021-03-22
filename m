Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E779343E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhCVKrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhCVKqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:46:49 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C9DC061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 03:46:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so10956999wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 03:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p4Z+wpe/vlKTP8y/0b+d0+U+PvDT/FlgjYt5lTllbW4=;
        b=eYfP90bCndlRF+00r9IZJOiHhMudTRzbsxstg4t3X6AzYHN9oYXfW3RwSYOUneya5j
         JT3/5iPETN2qrtY5SNH59Ebc8DISrjoiSfanSQdXOYn+1xOBNVURx0xQ9mc8N6hX8TKG
         IIQuWx86G/vRLw7L3nyWTv+GyIn7X/M6vNrJv1vLeMjNiSgRbqmuZdI3FnBEFFuYIUnJ
         ZTb68qljpYnOA5BaPnEHIkA/VK9n+DZ1KP0D9PQKgfwvr3e0gQgCJDdhOuBwH2jxZyIi
         mFVsjZuVzxa20YvtuaBbepuQ2o6Y9L3GjtXsi0/VGDS1Fzc2XtHXw8Lsgqo8+jBYlJpQ
         FIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p4Z+wpe/vlKTP8y/0b+d0+U+PvDT/FlgjYt5lTllbW4=;
        b=gX19iBZo9XCJL8EFt+m1pwUmGJptK691pfwnutWP30UHNAi1vzvp/zn1PRyF0szu8x
         Uu5MVvGZRKgD6+SL41Az4gzec27b6uuyIj+dTNK2NoCbe+3qtDt8LOACLPFEWr3vDgEU
         B9ZDofkMonepQZz5+ZcRz17o8N4bc/kKlolG5Q0lORr9PsPWOAD4jYBG8kLJulEwSYnj
         Nyk9CPDhWUku3vsKKtt9WTgGp2fl89eTie71YYjZfOGmfQEoIj3Gjgzi07mdV9Jcigvx
         +UupDIVMsF0KBEYV2/u+WZ/nzA1/fFF/idK/3ijwx1v0lPtTCrmswcGOpyY703UVYF0Y
         Ipbg==
X-Gm-Message-State: AOAM53265SmmJGO03unpw+0hTX64RcrzFvmyLkT2ey1LYP0VgKSrfEr1
        YLKZZO1qY3xiEng0ksVzCARs9A==
X-Google-Smtp-Source: ABdhPJxTICOn4dREAmCJlaSoXT3/chc3t/SLyvSy99RFM/zEpURlFKD2twjaC7AN+aVj3xlziA5Nig==
X-Received: by 2002:a1c:bdc2:: with SMTP id n185mr15561214wmf.128.1616410006852;
        Mon, 22 Mar 2021 03:46:46 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d8b:d5f9:2138:169c? ([2a01:e34:ed2f:f020:d8b:d5f9:2138:169c])
        by smtp.googlemail.com with ESMTPSA id 18sm16024198wmj.21.2021.03.22.03.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 03:46:46 -0700 (PDT)
Subject: Re: [PATCH 10/14] clocksource/drivers/npcm: Add support for WPCM450
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210320181610.680870-1-j.neuschaefer@gmx.net>
 <20210320181610.680870-11-j.neuschaefer@gmx.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a0ddef86-c94b-f474-df0a-38ea3f66ad80@linaro.org>
Date:   Mon, 22 Mar 2021 11:46:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210320181610.680870-11-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2021 19:16, Jonathan Neuschäfer wrote:
> Add a compatible string for WPCM450, which has essentially the same
> timer controller.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
