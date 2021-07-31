Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CD83DC524
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 10:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhGaIpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 04:45:40 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:46052
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232681AbhGaIpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 04:45:39 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id EB1F93F0AA
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 08:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627721132;
        bh=HpikimZJ3+N1KHx4n97v9ZY8Mpfh1GCJC1kFvVvcZrc=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=G+OORHGH2GRrD3kf7EHjalXbkr8W13MMljmZZjJ1xlE5/Dagw6/F0wVtFgYvshw0E
         bZRcc24vH9rF/qbtLynY6weUP3pq7X5KjVQy3j5RTsZmG2rRG5jKAAgM7Kc9HZOpco
         tNw+QmksmFr0k9Hvvh1ar2qLC0yOzyu0iNGNyQf1pPJnCRRFaMD6tTpi0vQvueEDc9
         2NlQK/3bzI4mIE0e0BM08ErdpTc+f3O/JTNYdo+gOJl1/300HAgozSDsHbDFDCgCQR
         jWX7FtGj/Fw3x82C75D+F//ckWel57qooDu4RJo08j7WTg9W0Kt5It9GyWpEvFT1nO
         AWljF/jdT8M+g==
Received: by mail-ed1-f69.google.com with SMTP id y39-20020a50bb2a0000b02903bc05daccbaso5841008ede.5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 01:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HpikimZJ3+N1KHx4n97v9ZY8Mpfh1GCJC1kFvVvcZrc=;
        b=SAa3fvbcfFsDKuvzIXImqW3GsWQ3N4QPEDVAZqbKFWJk4SvG+7USMPHblXe5HILLmR
         h6X93xehxI4a0lSSMAGSsh8vIGC9nvmc7+fCz/JPGsE3HX5QRjVLn5DDxRu1ZAUho4lv
         COry9qS81DOgWtroJyV5SDWUbJoTnml5hfFD87xFkO5B1eLeBGTUWTTHtrVeGV955R0X
         TynNorS+AY0CRxJcImtjrkmxvoZjvEyDfJrvkESHqu4ytcRRi1QNpdgdD2fvxeekGOTY
         qVkJJO3ky5MeNupLE5voWuZMTKK0xWDv1rnqxROVd/7V25Ipgn9auDqC56roiMtO9Iqu
         aTRQ==
X-Gm-Message-State: AOAM532ZXpJRxp/jD8qQdB2Q9I9KvY2yeux6ED0eLwAQfI36n1uU5ye6
        YVdBV3v1G4TKAuJIbJWQobUorJo93xvKMfs20Q+JB/5NqQhIIgMN7RLaGK9BgLA6iA/ILTYXNjH
        /8LnhhK0DGr9FpVHvxLRaLUlMluuPAUJHL14cef4Fpw==
X-Received: by 2002:a17:906:1f82:: with SMTP id t2mr6494558ejr.499.1627721132521;
        Sat, 31 Jul 2021 01:45:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhfyQHtQpkTYQbl8JV0BuJ0MetHqfQ6fFXdNuJCV2ubWaz/d0aGWkgl0x0n4Bo8PaJzjHcCQ==
X-Received: by 2002:a17:906:1f82:: with SMTP id t2mr6494542ejr.499.1627721132370;
        Sat, 31 Jul 2021 01:45:32 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id i10sm1888409edf.12.2021.07.31.01.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jul 2021 01:45:31 -0700 (PDT)
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
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
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
 <20210730144922.29111-12-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 11/12] dt-bindings: interrupt-controller: Add IRQ
 constants for Exynos850
Message-ID: <d603be80-4fb6-1bad-1963-c9fa7d1e63fb@canonical.com>
Date:   Sat, 31 Jul 2021 10:45:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730144922.29111-12-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2021 16:49, Sam Protsenko wrote:
> Add external GIC interrupt constants for SPI[479:0] for Exynos850 SoC.
> Interrupt names were taken from TRM without change, hence double
> underscore in const namings.

I am not sure what is the benefit of defining these in header. Unlike
other DT consts (e.g. clock IDs) drivers do not us them at all. Using
them in DT does not reduce chance of mistakes in numbers - instead of in
DTS you can make a mistake here in header file. In the same time, they
grow the interrupt property in DTS making it more difficult to read.

I also did not see anyone else using this approach, so it's not only me
(Marc also find it confusing).

If vendor kernel did similar, it's not an argument. Samsung LSI /.
vendor kernel has terrible code quality so usually it is not a good example.


Best regards,
Krzysztof
