Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E1B429F47
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbhJLIGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:06:04 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:52624
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234829AbhJLIEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:04:02 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6494C3F338
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 08:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634025685;
        bh=JHyKbjTift426wz+CkjwB4QsgP3nBOzBlm+zKKFBLrQ=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=nTdGrWM1g/ojwN4hcsHoB/xz8suphpUtgdoLWpb6ACX89k1iw/hNOZECaaVsscP6F
         4ihu31EiTHH3eHw46k5cg8KdjOUxDkCBTYeHfcnmPJnX7WRGxQlbBAMo6pyrTGvRi7
         C6nlNw8YRi2S54sCz7gzALyYxuxwKFb86si371qGUVcoLjYGrq+2mRRJvexAG0/Rdh
         6ixPx/Bk0CmLHyJGf7Fcxmm823kYFO0BH7xO9ftOXMLKl8jD8v4a0axo6S7pgf4i1F
         eG37edxwOtafFL+mc2N1TSCKBrczUfgk35Anbm/KpjNAjBXtMc3yNyjW1gkgjZOk6E
         zVyp/W4yzbH6Q==
Received: by mail-lf1-f72.google.com with SMTP id br42-20020a056512402a00b003fd94a74905so3019098lfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JHyKbjTift426wz+CkjwB4QsgP3nBOzBlm+zKKFBLrQ=;
        b=aNig0lgyJalDPA8hZfzyWpTbKWvLhbtKQw6N079Rnr8ZxsWE0Q6praoylR3ycw49hj
         XCYoQt+js31HRBYruavoHXKf+XtSLaYOegrbenmDeW7adQgmmIfN/MMnsdkdTrGk2Q65
         +AdeQ5dd36710+ielf+UkAVMJi2nMUVnt51lAOqvLk7Fq4vTyeCd8y0sVPFy7Q3LodVq
         vkJY3lGBwxF67aQQ4twm0Gbf4+4wNwq4a9EjqGCGOZr9BrzUol7mmm2s/B/+pb8knX0f
         lVQ1ql1TICRA25Yec2FkOn5RLXJrj6/ZdvOW+h0nSgF/FY3f0dlQiAHjAZXu3qUm5N4w
         lSYg==
X-Gm-Message-State: AOAM533h15SZIIWlP10jyl+iZtD0lObRyk2UrGsAPo96Usp2+BusZCYF
        /wWbHb3Rnyz0GzuMhTexge7WJreUTf40QdG4AjeN7NbgQDfUVmOwiZV+vfVchHn0ayLUp82KmaV
        tDCo55ouGYrk69DnL4oDy8RnOanvGxxlJD8NpOII5yw==
X-Received: by 2002:a05:6512:12d3:: with SMTP id p19mr33215023lfg.280.1634025684650;
        Tue, 12 Oct 2021 01:01:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNBcrjWlAgA0DVgCpnAIyjVoJ0m61P7YwAe3a19d6w8XjZGCQJ4xECpD5up8MG19txYXE2gw==
X-Received: by 2002:a05:6512:12d3:: with SMTP id p19mr33214997lfg.280.1634025684383;
        Tue, 12 Oct 2021 01:01:24 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u27sm956373lfm.275.2021.10.12.01.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 01:01:23 -0700 (PDT)
Subject: Re: [PATCH 4/8] rtc: max77686: remove useless variable
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
References: <20211011155615.257529-1-luca@lucaceresoli.net>
 <20211011155615.257529-5-luca@lucaceresoli.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <43b0cc1e-8b65-0322-d8ee-a8e45f1aa8fe@canonical.com>
Date:   Tue, 12 Oct 2021 10:01:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011155615.257529-5-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2021 17:56, Luca Ceresoli wrote:
> rtc_24hr_mode is set to 1 in max77686_rtc_probe()->max77686_rtc_init_reg()
> before being read and is never set back to 0 again. As such, it is de facto
> a constant.
> 
> Remove the variable and the unreachable code.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  drivers/rtc/rtc-max77686.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
