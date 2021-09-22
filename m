Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E120E414345
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 10:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhIVIMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 04:12:36 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50442
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233349AbhIVIMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:12:31 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0854A3F337
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632298259;
        bh=P8Qe07F/xjMQdNLxVav+Rfl78SB2e9oBWelI8/7HSJc=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=CsM4WOF81WV4yB0lm/EC63pq6fB0GK4NL8c4/F5T2//WbLnIeKe42j/bP2oUKxitz
         mp++AyRgVe+N2l+uOArLWutgo28uA/ASj36UsuqtSCR04x2f1T7isAgNOMJWQqTnWA
         hHd/GuvSPETJY1/RCKnDOWpkxc1QpD0rdvcaRPEb1GwulU+FTifRo1HEKbP7oUCsXb
         p3RUIxB6z7fpCPQTs/3Sf6PS75AbjV/t3Y3F6hWjCbUXfab2Ksjbe6izEZS50oAPUd
         /bbWz9RmziME4Vpy2yoOTK6wEg8J0hXIjYP+LeuyGlC910r6cm0paI/xa/bQqT6GTe
         71ZFoYf/zeKJQ==
Received: by mail-wr1-f72.google.com with SMTP id l9-20020adfc789000000b00160111fd4e8so1361622wrg.17
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 01:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P8Qe07F/xjMQdNLxVav+Rfl78SB2e9oBWelI8/7HSJc=;
        b=Tw/7pwPWPP97wrKBcvEOSNaSmmLYSGXLnGFn4fVdlrF2toVrNhay0L4Q/9h9orA01p
         zZ+/7xJ8xdF+naokDo5+6AMg58rxjuA641Cd/LJfMPxeAqI8NBYYdcg6DQNg95fL1uhk
         o7EQvumjdzqwTvUaDQc6N3DnViTMOz32gwlUKquoq1KtjG4lE8vAjY3SNHWxUG8DBFcL
         GO/B2hqqQ9IHcq/8BlN4iNhcYbJA9APc02ldlD9xOhrsC8tHxTYpLLo3s97wQJhSN5aX
         2AnYycm/FvCzxd2Y/nZt53PjgUVPx7vKH1ua7LXX5FZJcYGeoXDUGYcqjVjTTQQ9j7e0
         uTRg==
X-Gm-Message-State: AOAM532uAtEBNKw9DOthS8e3cDb4lTm10wRLfqG4CXZ5SkHiSUEGkovT
        pjobf/lWLaKpbSg0GiM8nGAeXlz3L8VVMrsX1cDMU9JCxjXyfysk7Cd4R7c+PAeVZ4e0LWahvOd
        IfFVXpBizKAKceBU9PvNaf+D095HcgAxXIlxW0cc1eA==
X-Received: by 2002:a05:600c:3b89:: with SMTP id n9mr9113904wms.186.1632298258647;
        Wed, 22 Sep 2021 01:10:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb3Ljj7oUI5lHEYQz4nwFDjBGGdyp2FKjKpmWPv5gSTXpVI7LSRlWIyJA3WG9xT/pBfVR0VA==
X-Received: by 2002:a05:600c:3b89:: with SMTP id n9mr9113885wms.186.1632298258458;
        Wed, 22 Sep 2021 01:10:58 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id d24sm1174219wmb.35.2021.09.22.01.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 01:10:58 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 1/4] mfd: sec-irq: Do not enforce (incorrect)
 interrupt trigger type
To:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20210602110445.33536-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <7ac677f1-2928-21de-a226-449e72b1bd10@canonical.com>
Date:   Wed, 22 Sep 2021 10:10:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210602110445.33536-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2021 13:04, Krzysztof Kozlowski wrote:
> From: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Interrupt line can be configured on different hardware in different way,
> even inverted.  Therefore driver should not enforce specific trigger
> type - edge falling - but instead rely on Devicetree to configure it.
> 
> The Samsung PMIC drivers are used only on Devicetree boards.
> 
> Additionally, the PMIC datasheets describe the interrupt line as active
> low with a requirement of acknowledge from the CPU therefore the edge
> falling is not correct.
> 
> Marek Szyprowski reports that together with DTS change (proper level in
> DTS) it fixes RTC alarm failure that he observed from time to time on
> TM2e board.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> ---
> 
> Rebased on https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=for-mfd-next
> 
> Changes since v1:
> 1. Mention in commit msg that this fixes TM2e RTC alarm.
> 2. Add Marek's tested-by.
> ---
>  drivers/mfd/sec-irq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Dear Lee,

This was already a resend. Any comments from your side?

Best regards,
Krzysztof
