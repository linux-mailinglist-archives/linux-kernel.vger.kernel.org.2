Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE1F35676D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349797AbhDGI7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:59:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33871 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349793AbhDGI7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:59:53 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lU42J-0007zI-U0
        for linux-kernel@vger.kernel.org; Wed, 07 Apr 2021 08:59:43 +0000
Received: by mail-wr1-f70.google.com with SMTP id s10so11435437wre.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 01:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HrFQR6kSfLloLNA/dDhXdVEPAqQMePY3u8T0+ZWdumA=;
        b=RLqmBOjKv13ZIRhRd+Yg0a3ZXmtTn5KGPedN2EpwlEQGUMyTLSnwZiWnWphnwuWqac
         2qyvKMsINmXHEBLLcgFz6pVLfTyAj+7at9CvP/DGhwN2a/zoSA4Lf51fe73eQfRfO9NM
         UNsfC0it+QKJy4neTlU+Gag9b5/CDHZEw+2u7zMkoezecrVfjx4ma9wTanpK45eb417f
         xlTUbQqIsHH0cXQPg80IXAHfHF13lif6L86Snf1RUpBBgenD8zOCrYqftO0rDXL8HqO+
         N1nDc2mCc6KS9J7Gphfoo+d4FOGVl1/G7H7eK8J3nOsjD/TOy7NJ7aMYLfn+y5agAI4X
         dZog==
X-Gm-Message-State: AOAM531XJuu5SkVwJOngvZnIWub9uWWjCGh/ypCpJR7YmffeIGMh7Xz8
        AOtCHYnPCPdURVAXnzXT4+aa98Oc3NGC/WlX37mVyKqrD9UT47ibWUrSLlnl9GHGQwy8oPX+NxK
        tzH0Xi42jY3dWS0IH5iiOXPWRWFyTcpIf5w0uws/btw==
X-Received: by 2002:adf:8b4e:: with SMTP id v14mr2989612wra.103.1617785983371;
        Wed, 07 Apr 2021 01:59:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmwG7oM+/Ygyr/WFee4xU5I6OhgemgdCLxHNjNxLusiIVwYFW8pje8fMFnJpExj31WAIghpg==
X-Received: by 2002:adf:8b4e:: with SMTP id v14mr2989606wra.103.1617785983256;
        Wed, 07 Apr 2021 01:59:43 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id e9sm22844623wrv.92.2021.04.07.01.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 01:59:42 -0700 (PDT)
Subject: Re: [PATCH] clk: socfpga: arria10: Fix memory leak of socfpga_clk on
 error return
To:     Colin King <colin.king@canonical.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210406170115.430990-1-colin.king@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <450a3b07-044d-602d-f1a0-f0748bbc5bc5@canonical.com>
Date:   Wed, 7 Apr 2021 10:59:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210406170115.430990-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2021 19:01, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is an error return path that is not kfree'ing socfpga_clk leading
> to a memory leak. Fix this by adding in the missing kfree call.
> 
> Addresses-Coverity: ("Resource leak")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/clk/socfpga/clk-gate-a10.c | 1 +
>  1 file changed, 1 insertion(+)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
