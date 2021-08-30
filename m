Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396703FB246
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 10:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbhH3IOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 04:14:41 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:52594
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234529AbhH3IOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 04:14:40 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A046F407A1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630311226;
        bh=eSx3NUMPq83UK+z5+YBa3OObfzdkGkOX4S8bufFEz/Y=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=uEs3c3XaIrWd7WC+tPWJ45z5sYhMy6uLbBtZDqircY0A8aflGyqix0UpTy55CNbpj
         45aX2Ss+RfrlYxXgnNQbrZ1Kn0QFcD74PwEQ10iuFkhD7b8p131hd2pDTeYF42+n2r
         rZ4m3SCR+pn362X/UCMAyPOzTslhAWtLSkbu0WE64R9Dmk5JJPCZBherh2an5phK0+
         FJg4cEwsQ6cyI2bUpczr3/RIO+5LrHvcTjPYYB2ZeHuBS8NikYUFA9/zWeyqQ/Eii9
         Ym6wl+FmlHwKQuksD39x/M2nx1poWX8kqxR7ECN5kzGeMSUBpj/BRDlRqgoYRgqktj
         Q5lgI9kV8NGwQ==
Received: by mail-wm1-f72.google.com with SMTP id s197-20020a1ca9ce000000b002e72ba822dcso2778913wme.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 01:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eSx3NUMPq83UK+z5+YBa3OObfzdkGkOX4S8bufFEz/Y=;
        b=gSMISIgeODlCMHArED/NlOGSrAfGgtZwBwX5dOxxgYihThYXAe8EhqY2RAoJPEQM2F
         prz//9FgbHZ61nuo+DfVN435kQJ6jGYS9/TZlBu2LdX5ZtcjrJTdWMmXi8xUfxRq+lWW
         BzmW0Zkf/HpCd+RUzPzsC0KCLNi4mNcFRDdb4+6BMXVz+yMye/HwRW6fTlowpOv0v/+4
         Y0RfgQcjngwId1QyaYXm6TJx+O3vNXqQGH/n2FEBig2CoW7n9bK7lcmv7BMBp3Y6UT90
         UKRiBjlFYMc94nZdbf3Bn3hFgGCZ8zQ+/f/glRtkJ/GxX1ynIUpIuq3ytWj1psSwzwY3
         zPUQ==
X-Gm-Message-State: AOAM5319uxj2Q67QDXC9WJKw9DaCg3znA532alziOeObxCY6OHyEplWm
        LO+Q74J/DnGj2jagFagPbfYwyo0mCvnaJsr8pRQz6cBf51qOrDZjb1TabaqAVDnAfIfZpSmKlAJ
        OqvVEwtWc/i0AhLS2vXsX/GjVUz0ATsdvtvWPQdPWoA==
X-Received: by 2002:a05:600c:428a:: with SMTP id v10mr31271909wmc.25.1630311223590;
        Mon, 30 Aug 2021 01:13:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6olxhDfz1lLDwfzLkp8OUNUr1AoxOLKW23LNJzBGbO3TIlKX5j+QsdumWOsvWLwaJ3ofS5Q==
X-Received: by 2002:a05:600c:428a:: with SMTP id v10mr31271886wmc.25.1630311223430;
        Mon, 30 Aug 2021 01:13:43 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.112.211])
        by smtp.gmail.com with ESMTPSA id l1sm12582917wrb.15.2021.08.30.01.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 01:13:43 -0700 (PDT)
Subject: Re: [PATCH] ASoC: samsung: s3c24xx_simtec: fix spelling mistake
 "devicec" -> "device"
To:     Colin King <colin.king@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210827185003.507006-1-colin.king@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <db203d28-5a90-401a-962a-aaebae5b6cb2@canonical.com>
Date:   Mon, 30 Aug 2021 10:13:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210827185003.507006-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/2021 20:50, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/soc/samsung/s3c24xx_simtec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
