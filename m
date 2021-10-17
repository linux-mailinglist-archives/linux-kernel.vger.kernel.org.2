Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EC743088D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245519AbhJQMCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbhJQMCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:02:44 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F17C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 05:00:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id y3so35830139wrl.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 05:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DCYEqb1k49K3imC4oVzyozxFv8GwGv/4wZN3QkeC/aQ=;
        b=QUdiOZ3XvYh028+yHdid/bcKSiTvGrrv+Jm9rHxgaGiHEpAocg2fZvYvnqHGacBSkN
         G441PhRV06MbBkIQvQn01qxWaWL0Gzxsty7Boz0MkFflbT1AHj0CtIAUb/hhAgJSJBHg
         1Re8Jyv7IkuZNVl8zNsl0J7x4tgdiKXBYUR0Nz2j0SopECqXWXBH2jNlnyppFrFuUMB7
         VQI0gvJSaLp3o9YwvTjjb/q0M86C2ZR1nuidDUisLmOF8vMpuGUCQ4QtE069o0OxNEJu
         8buM0/RJZyEOrVa7dIAbP04bALnc6xRLDyUYTHmx7Y8FVgBS97+BFepWpsnam2fN7Ypr
         noOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DCYEqb1k49K3imC4oVzyozxFv8GwGv/4wZN3QkeC/aQ=;
        b=Fj13ipKm30/wMObeSRB1xKnOv+60Ode9p4qiFFA+6e4B/t9wv+9qENiMHlBIHdmkSK
         KHkZO6AZf8807v0963aB+LRdnsTDDBC54ZOGuH/tKdX0klgGyouhVz6/uOMKRtGGPvlh
         meQOGH2jMwqE7P9sIsBb53KQno8UZv4b6trDMs5rJAnrX5HgDynu1Gzc7DDoXl8UDVm3
         ZRNmUsPYgaFzBDand29fbfeQE4BovhMWdnC3nS/c4YVNeHw7bwhJWRY8wTIfJHgttAEu
         aQKTYzrH7UBSXo3QEZP2fuegR2yU8RnCPD09fzNsyV0SUjAR2I7++7yjuG7J9xUAU2Xn
         zuAA==
X-Gm-Message-State: AOAM533HUgHzD6tL0K9J/YPR1SqClAk6G+f21wQjSpoxYC0seLLyVgp6
        vhW4DPVbxa7Z9ckda3H3vNr6c1jztZg=
X-Google-Smtp-Source: ABdhPJwBq7o9ILnHKu0aj4XpjCulBCrGLlcyOXP9feDonAPpRRg9N0T1eNJ/BYAIqvbJTkQRfNzeYg==
X-Received: by 2002:adf:c00a:: with SMTP id z10mr27618558wre.315.1634472033580;
        Sun, 17 Oct 2021 05:00:33 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::d7f0? ([2a02:8108:96c0:3b88::d7f0])
        by smtp.gmail.com with ESMTPSA id k13sm15603173wmj.41.2021.10.17.05.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 05:00:33 -0700 (PDT)
Message-ID: <5318cdca-6200-c966-0f87-74e0e79d27ee@gmail.com>
Date:   Sun, 17 Oct 2021 14:00:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/2] staging: r8188eu: remove CONFIG_BT_COEXIST
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211016172345.23114-1-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211016172345.23114-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/21 19:23, Martin Kaiser wrote:
> Remove the remaining code for CONFIG_BT_COEXIST, which is not used for
> this driver.
> 
> This series should be applied on top of "staging: r8188eu: another round
> of removals".
> 
> Martin Kaiser (2):
>    staging: r8188eu: remove unused components in pwrctrl_priv
>    staging: r8188eu: remove BT_COEXIST settings from Makefile
> 
>   drivers/staging/r8188eu/Makefile              | 5 -----
>   drivers/staging/r8188eu/include/rtw_pwrctrl.h | 4 ----
>   2 files changed, 9 deletions(-)
> 

For both patches.

Acked-by: Michael Straube <straube.linux@gmail.com>
