Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017E23DBD20
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 18:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhG3Qe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 12:34:59 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:52810
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229682AbhG3Qe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 12:34:58 -0400
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id EE69E3F23B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 16:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627662892;
        bh=LOZkX2Gn1AlaUpgTb3/KKeIofvF4AshHz3LJwLGMhDk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=JD1ZfK8pFVkvqaRDgdGpfCk4kRfcHvJQHV4EDZ+7HFrcoOJuysVUz0uno45kNj/KT
         heLXZu9M8FYd/ehc2t7b3nUpMrP3zRQSUrVx1SNmksADwNVh2LVJ4hNWGm8KwHnSB6
         flrq99BOGH+AB76P0OQ5pSdjb8BhR9vdn5dZoyO7H33GXywHilNl4IvZstmqBC6k/J
         ChfqpgC6TawPTCQdJXj5FLa0GZrz2zwjjct0o9RBNrShPX1fIqYtZ+3tn2bkSN5x81
         mzc+fFei5bQBEsrwVG2habPRQGBoA53JpxuaFoVA2Emzq4x6jrLKV/fth4kjPu8qQ/
         i6lKZ4J8kKTAw==
Received: by mail-ej1-f69.google.com with SMTP id q19-20020a170906b293b029058a1e75c819so3267686ejz.16
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 09:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LOZkX2Gn1AlaUpgTb3/KKeIofvF4AshHz3LJwLGMhDk=;
        b=kp1CNmBym8xuuDeKESsajDWit8+agzgpejZclrjHeYw/9FtAism+ARdl/YmEY2EZSE
         g9ynv7V9nM1LnFXlSILKADkJGCrcjn0vrVEpO8+cdRXxiO4clFiHZ5/s6YZ8egG0+VRA
         wY1DUX6PjqWJP2KJVZmiDFyv7S5lzPSwCIzbt5zTApBwdg3ZUZFQXEj3BnujPcDwUNVJ
         Cmp5HhdE7iDWWTKsfjJQVzEb+ZzLieqjOdHb4f+zxr7pQVov049jBJ/HrVynXEAAgOp4
         6vtANw5yTQGSOlpKYDr5VDjChkZwCPX5EFAiJIYXnq5outFJY6MpvF7NO9Th92Ztl5n/
         InRQ==
X-Gm-Message-State: AOAM531yoPuTbmJxuMUNPdCx4BAY5qHim6WfHPD0HKdv/o3EHkRyGfA2
        6cPqc1jDPUcT2dkZJGD9SsDWCE+M16DVUa0HHPiEgaAGlpz1HhaUZKdEhwUa+7iPyDNg0hwjnuF
        liIFJPfVMPRpyeUf0EXaid7RcYzNvx3ihUdr3YSwuhw==
X-Received: by 2002:a17:906:c0d1:: with SMTP id bn17mr3262437ejb.511.1627662892675;
        Fri, 30 Jul 2021 09:34:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAQ3oDEvssRhYOquKsKs0awtj++lTiixkq4+khiYVFew5afUiOqz586WxPl24Q2+jJCRUS5Q==
X-Received: by 2002:a17:906:c0d1:: with SMTP id bn17mr3262411ejb.511.1627662892551;
        Fri, 30 Jul 2021 09:34:52 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id b25sm928440edv.9.2021.07.30.09.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 09:34:51 -0700 (PDT)
Subject: Re: [PATCH 05/12] tty: serial: samsung: Fix driver data macros style
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
 <20210730144922.29111-6-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e11d0e60-9bbc-16d2-c8ea-42d3d93e97d1@canonical.com>
Date:   Fri, 30 Jul 2021 18:34:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730144922.29111-6-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2021 16:49, Sam Protsenko wrote:
> Make checkpatch happy by fixing this error:
> 
>     ERROR: Macros with complex values should be enclosed in parentheses
> 
> Although this change is made to keep macros consistent with consequent
> patches (adding driver data for new SoC), it's intentionally added as a
> separate patch to ease possible porting efforts in future.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
