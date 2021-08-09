Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1CC3E4427
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 12:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhHIKrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 06:47:35 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:40370
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234738AbhHIKqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 06:46:45 -0400
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 5EF6A3F34E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 10:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628505983;
        bh=yt7czbeHRo3zFzMadQuUQl5b/q3O9yrC7ug3tMqy3VU=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=NVArT16GalAihELtXdtq9GDh1w1YvayhWRnEGJUxReMr6kYARwUFQDffcXOGkHkyd
         7HvpkmOjm3X92OIbZX9WOSYX9NZ5uB4RY1QdoQV3gACmhsXeGq2wgThzP0P0CxE/Yg
         lmP0205ZNpuDPYfYrqPfgqRlD8Ly0JTvm1qquowqZmgf0ItadXr3zAtpTbbRzlVHsz
         fJ9s4ibKdedgowu0Iv1n+hgDYheked6sY7yZpARrtVc799JIvcgyMUU7lLHymsCRTm
         y91N+xmdXUIRRd2c1L9/CEjh974JqpwFmTiGRZ5BVwGrQHQqSnjSnVLAsFDTU3JPot
         D3jiZ7WELkD4g==
Received: by mail-ej1-f69.google.com with SMTP id gg1-20020a170906e281b029053d0856c4cdso4362417ejb.15
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 03:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yt7czbeHRo3zFzMadQuUQl5b/q3O9yrC7ug3tMqy3VU=;
        b=Cnh2E+eK6LLdwHS75H3YV6v3v1wXqi//1jeW84KPsoP1iPT4KBJeDtiMe5Y1NOYVhJ
         tLl5BXc6PO2CqttV8Hz7Bsf6hEYtIoFlS/AHS3ZRtHdIoF0R3tBgBHz+T80NhDNjtNJH
         eWV2fQU5xrXLgpeud9ak04IOSfKz5cxRj4JWw4d31wYyM9NoO7XXu014rjJ3lbIST/c6
         jpxvakxGBsh3OLLAaMFh1nzlysXUkTG4IyGf4s9NuG3zF8IsqtqissF+9MRceZd+JZau
         UBdwK5FrA4soRnJKjJ+oKfP2tdi+QLSIuCUPCTuejgMln0U0jDd6DwEPAxsFaQRgKEqe
         gA7A==
X-Gm-Message-State: AOAM531Jj1xIeC7FOEGbRrpmSQr+y1PVArlddXKkl7b7bs6RAX3x/9/8
        jyeM060VlGB+fy6A0FlMh+s5CkgDbF9hX67dk3hTIHYL+EErRhrU0ik4Vh2VIKzQfw8TdRhTxSy
        4b6avAGsOWOAQDZ7+IuJeCupcHj4Mr17sfwY1/TKsag==
X-Received: by 2002:a17:906:4346:: with SMTP id z6mr2946650ejm.403.1628505982425;
        Mon, 09 Aug 2021 03:46:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwilRElb69ECVZp5XBCmIh/rGOdeWiuwyHyABm9gfRG9GvWksDs334T+DetejTgQ1+PQ9rACw==
X-Received: by 2002:a17:906:4346:: with SMTP id z6mr2946634ejm.403.1628505982295;
        Mon, 09 Aug 2021 03:46:22 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id f5sm5733019ejj.45.2021.08.09.03.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 03:46:21 -0700 (PDT)
Subject: Re: [PATCH v2 6/8] tty: serial: samsung: Add Exynos850 SoC data
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20210806152146.16107-1-semen.protsenko@linaro.org>
 <20210806152146.16107-7-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <6169e25b-2829-628a-f910-348ddd4b3030@canonical.com>
Date:   Mon, 9 Aug 2021 12:46:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806152146.16107-7-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2021 17:21, Sam Protsenko wrote:
> Add serial driver data for Exynos850 SoC. This driver data is basically
> reusing EXYNOS_COMMON_SERIAL_DRV_DATA, which is common for all Exynos
> chips, but also enables USI init, which was added in previous commit:
> "tty: serial: samsung: Init USI to keep clocks running".
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Fixed default fifo sizes
> 
>  drivers/tty/serial/samsung_tty.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
