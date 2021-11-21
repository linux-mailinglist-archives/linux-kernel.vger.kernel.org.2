Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8722E458566
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 18:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbhKUR0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 12:26:47 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49708
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233693AbhKUR0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 12:26:46 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A4D843F177
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 17:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637515420;
        bh=8EKhvAzuNETIXPZvBdvtzzbJxkmJKv3T8xcGJE2o9zc=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=Vcq5ocBFePw1joK3tninNkDLh7L4qkTioKUzYWhvcBRKQhTSqwFc5KUbYrbMtdjVa
         8Ba58iEGUsziz6d2KxMiE9yLepucEtumHSTopd+Ex9mZrgf0j7QfdugLLCEthnTODh
         mhNhNq6EyZnlx+PqXn7Vfq2XZjOmBP9STfssmPVkMiaJn+SfGc8PHmkNkJTdS4zUgE
         osy00h2UR+g2YgVeUInvGr0auuzd+lRyZhQ8h0VpA8TajFIbOsw+az+6I9OoRIy/BL
         rleVXLjXQ0REQPkEI1qPDtj1OwvgiibBhjuyqDjU/oAdfg5giVHZWljX58ykSxAFGP
         /9f0bq+eTzSIQ==
Received: by mail-lf1-f71.google.com with SMTP id n18-20020a0565120ad200b004036c43a0ddso10300862lfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 09:23:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8EKhvAzuNETIXPZvBdvtzzbJxkmJKv3T8xcGJE2o9zc=;
        b=2SrTj2DQpO5OHq/Ts0tq9OAHho8QW3vutOcaY900Nb6bLqP0YvPLBm0lLkPIz+o4MH
         qKpjbSWbgf5TKRFGeUvJZ2fQDPDAJyMRKqGbnbQaehm17uq/wkRjmfKgQciTag2B13kq
         cvt39GbXg3NrAs7OAtWft/skuHluajP6D4k2g07HgRpzfD49JMKznspzBlpGexqhbpRb
         iDRiM9+oB4/o3sEd3hHThn1/He7s23Mv6SUbFbDOKoJUZBoD1r7D6c6+pl0w5UaKBMls
         UAtQIdbDkb/CV60ByGCa8FSmIRyhEhWj89j3n7Bi7kQNlPRS4XU8jR3b3EhjPzVPgzlg
         hwFw==
X-Gm-Message-State: AOAM532DhrHjcbsTkE0ELaorPZaZ/RkLGXAmI+yCItLdgNP8Ce0bzEK1
        +c/604pF11KbqsP79Ss2Kt7xsCQRKdCoKeWisk2H0STOPd8CPmZ3SAxp4l1py8dGGZ8TJ3FjL/N
        1vFJPJnJw1HZkxcSa86+N/SS3lbtPyGwq7GYUBCYk/Q==
X-Received: by 2002:a05:6512:104f:: with SMTP id c15mr51372076lfb.256.1637515419964;
        Sun, 21 Nov 2021 09:23:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1jPqSJFTGZGAENICSqrdk2/BOSkXQMTiiA8ICivNbDKs03/7WG+pTjnVWK2WHcqcaxqwhpA==
X-Received: by 2002:a05:6512:104f:: with SMTP id c15mr51372056lfb.256.1637515419800;
        Sun, 21 Nov 2021 09:23:39 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id u23sm701037lfo.35.2021.11.21.09.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Nov 2021 09:23:38 -0800 (PST)
Message-ID: <a6111407-c0a4-0c35-dc26-f30022df775b@canonical.com>
Date:   Sun, 21 Nov 2021 18:23:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 2/6] riscv: dts: sifive unmatched: Expose the board ID
 eeprom
Content-Language: en-US
To:     Vincent Pelletier <plr.vincent@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
References: <378c64fb868b595430b0068a9af10fdbeceb8e12.1637362542.git.plr.vincent@gmail.com>
 <589539cd08e35c35b269a769caeac40b85ffd01c.1637362542.git.plr.vincent@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <589539cd08e35c35b269a769caeac40b85ffd01c.1637362542.git.plr.vincent@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2021 23:55, Vincent Pelletier wrote:
> Mark it as read-only as it is factory-programmed with identifying
> information, and no executable nor configuration:
> - eth MAC address
> - board model (PCB version, BoM version)
> - board serial number
> Accidental modification would cause misidentification which could brick
> the board, so marking read-only seem like both a safe and non-constraining
> choice.
> 
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> 
> ---
> Changes since v2:
> - Fix end-of-commit-message separator so change lists do not end up in them.
> Changes since v1:
> - Remove trailing "." on subject line.
> ---
>  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
