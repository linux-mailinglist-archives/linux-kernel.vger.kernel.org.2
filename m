Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33D4433C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhJSQ1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:27:00 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45542
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230168AbhJSQ07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:26:59 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8F20D40750
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634660685;
        bh=498IUqh7qiqUKcZ9Q0qZOmmm/FH00+0dL2t8BJdk6fA=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=apnn2sB5st76EtsitHaukDhDJOObRvaO+OWhM/gtXGB6nbTm9zZMvpAER6CpOdxUO
         Mqi5l5vrbipouLmP+RWop4ljgdceT+52lQUGdsemC2xFBSawiVS19hCmEsYrkqAwod
         oD+IX/S30pRyI8y1id5Up1zELEoBpng9QWrAuryGR+yu/PzSkHYR9jO3HuiU49Z6l1
         Fgv/ejqrxxoj00JxGli/azcfak1l8swCqCc6vBndOrvKTg246qBvuQRPbxud/TBWPE
         plNOxHfkPABtb4QSeYELIxzUDKik7QsRBWtHB19DGkElsb1JcmwJbeq8svbQ34vlzr
         guueitUlLcT/A==
Received: by mail-lf1-f71.google.com with SMTP id m16-20020a056512115000b003fdb79f743fso1633616lfg.16
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 09:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=498IUqh7qiqUKcZ9Q0qZOmmm/FH00+0dL2t8BJdk6fA=;
        b=sJl1poPQ0Q9HUIttVwF8f53WOtcwp+jIdP3DxTDpKnNu7KCkatRgOh1oZK12GH95bf
         bcnsTh5u4+WJwFusoYxHBVxd4i0Bn742dEzCxeLT6CxSzuk5N6LgsdPBnmt/7G7sXOcb
         ifbCkRtgu9UAJ+i/x5W/hFkMhgJPRHfNVZ3A23wTZ5vvLtGURIpqX/XRqpkPxk6ZiRWQ
         X/zmBPpVSPTjc8HS22vPWyw5o+1AAxFvsjqPQGRXVv67mQlnr34odRcnIA/NJdFxPBVJ
         MKHWSpir9j1Aju1e5njejThCgqhYRgp6X+VSVxGfgNkGAnjK6S+8HgOKeelGAAXotJp9
         ZHWg==
X-Gm-Message-State: AOAM533Gtk3zvILAHd2JMNXnVEhjYx69J/i9l160f9efU4oOrdssppaO
        Nlo496x104vh9lfSciFoM+jHoTHUVLOdDsckRDkIWKB0Ev9uPdzNk155opfjN5hBBa7jgSdetjm
        vwanlemMBbzpkEQGTIrqXReM7wRvXO0MocibXamyAUA==
X-Received: by 2002:a2e:9d2:: with SMTP id 201mr7553969ljj.163.1634660684608;
        Tue, 19 Oct 2021 09:24:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykGa5sogCFDqH8jTBbw0yAdFSWHwImCp941pYeQoMrhNAOHaCU1EWke4ktmA/lwSiGuenk1A==
X-Received: by 2002:a2e:9d2:: with SMTP id 201mr7553945ljj.163.1634660684344;
        Tue, 19 Oct 2021 09:24:44 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id f6sm2115939ljo.36.2021.10.19.09.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 09:24:43 -0700 (PDT)
Subject: Re: [PATCH 3/4] rtc: s3c: Extract read/write IO into separate
 functions
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211019131724.3109-1-semen.protsenko@linaro.org>
 <20211019131724.3109-4-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <1a71e63d-0586-2208-bd84-6bc2d15147e4@canonical.com>
Date:   Tue, 19 Oct 2021 18:24:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019131724.3109-4-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2021 15:17, Sam Protsenko wrote:
> Create dedicated functions for I/O operations and BCD conversion. It can
> be useful to separete those from representation conversion and other
> stuff found in RTC callbacks, e.g. for initializing RTC registers.
> This patch does not introduce any functional changes, it's merely
> refactoring change.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/rtc/rtc-s3c.c | 98 +++++++++++++++++++++++++++----------------
>  1 file changed, 61 insertions(+), 37 deletions(-)
> 

Looks correct:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
