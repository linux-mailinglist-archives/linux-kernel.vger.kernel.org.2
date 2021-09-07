Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC254028BB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344068AbhIGM2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:28:48 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33974
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343992AbhIGM2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:28:46 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5D6534015D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017659;
        bh=VowlVOnHwTh6fwIAxHIe0aATqP59Ww2WwB63U4ZOWes=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=D5FVfmdHtePvR2eNtkX6bF6lhRGYh6r+BuM65toYLHgYo4EO1Mc08PW0rd6xbvh5t
         pnRBVKJlDjDOHra+6Ak6FHfY4GcIm1yMud+LNCu1SCGTEWZDXKDil9q95EnvrfpBIJ
         vvZzqIQnm2AWGsNEC2eObaAywLiLFradbWIPU1BaXthkXa6r9XQh+70cEgo09xYFkK
         QROKiWOEMMLPPNxC/LFYFi/UzrQv7+v/hssXn32VPXN+p6YIP9TGIYzHO+H9KRzM4j
         HHOXT/DYqHjUlCylUFteRqgS+EKqBFFtrZwvGqYXZeE5VUIKqFqbBNqLbydjUgPgi3
         YJQS+/ZQbq/YQ==
Received: by mail-wr1-f71.google.com with SMTP id z15-20020adff74f000000b001577d70c98dso2047867wrp.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 05:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VowlVOnHwTh6fwIAxHIe0aATqP59Ww2WwB63U4ZOWes=;
        b=CCO0aViDszeaAsShbEqAUgrLYKyd4vDhyJkep50U0baKRPhbmgzkICJuCO8CMnpFUo
         mRHmcA6M3AKnHgDERCQhznLAlP8BUtcMy3UWppcFTEHB4yY6jYW4gceie41t/1b2rJtd
         RH1+PdvjmpgVwfpdpdRZCKQ9LAzRAwuMSS/rIz7HO+YxE/cLADOQHgB28G8Q5dYUqlwE
         qV05j9fk/TggAxcoVd3XKkBHqJUBhBLXV0u0H9nKqhEC2MOb/6OjXUGNDb9VdRpIIZFw
         QQYVEHYxzWWIkFiLGJQkECpkEaD7SYNacTEZa8//EfbuGZzGakesXDT6DjemYIe5HepA
         Ro5A==
X-Gm-Message-State: AOAM533ov8J/tTCG2cMuC+m+mjjwbg/PQxTM1Wu5xJeu7wzOYt5KSGUl
        GenDstEFtCixhppmrSTETg0aJhCu6y13wd5F0E1tYZZ5Na6cFe03/aqS451grWxS6Mg9ZqioOUA
        bYkFSC+S+dr0sTQsf9r3zh+vF4Pe+C/rAGltKC4vvfg==
X-Received: by 2002:a05:600c:a44:: with SMTP id c4mr3731392wmq.83.1631017658784;
        Tue, 07 Sep 2021 05:27:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN3PfRE6+L1K67g6ewYU4vWSdNIvr1vNdsH6qFmi/JuqzzwcOU+VPDXX3AOLJKbFlugMmSHA==
X-Received: by 2002:a05:600c:a44:: with SMTP id c4mr3731373wmq.83.1631017658651;
        Tue, 07 Sep 2021 05:27:38 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.113.15])
        by smtp.gmail.com with ESMTPSA id r25sm10326524wrc.26.2021.09.07.05.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 05:27:38 -0700 (PDT)
Subject: Re: [PATCH] clk: samsung: exynos-audss: Make use of the helper
 function devm_platform_ioremap_resource()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210907085100.4152-1-caihuoqing@baidu.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <6e1b964b-0986-af51-b380-270aeb44e6bd@canonical.com>
Date:   Tue, 7 Sep 2021 14:27:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907085100.4152-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2021 10:50, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/clk/samsung/clk-exynos-audss.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Just send it as a series (git format-patch -4 HEAD), not one-by-one.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
