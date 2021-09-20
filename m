Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825994110F2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 10:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbhITIaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 04:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbhITIa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 04:30:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44CDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 01:29:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d6so27309272wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 01:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NmwufkRm5QXP0RAh9pBbo8ktk5iDLTsqfPbzEqZPusQ=;
        b=ASztJaW6JLqDSrnzAc8sDk8rdLwza8sZQRFbsVufD7S6x99Hhl7BGV5YzttOZprJPR
         A6TbTopEIqMinlR87Ykkzakz5iZ/O/5AuzDw4YkrqTEzes8j1K5NNjA2QOw3sTxJDGo1
         XfwHT0hIyrbhKwUogGCw6ZC/OLu1RprMonZ9Yj7TzNFrcOJTTC+hFsqWWqbusTZVIns3
         HIrSkjQ1/g2BaOGHXjp7iU8kmma/vSYLuYp3Ba7eGXib4bCsmpcwJYXGuSMU8W/KojWX
         ehFVT2F7wWBmutG0rItwEPu77rY+Gr2IPyptA1Iz0a49hWLhllx3WS+WWU82s7eXfgZ+
         197Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NmwufkRm5QXP0RAh9pBbo8ktk5iDLTsqfPbzEqZPusQ=;
        b=iNq95YN/R8S2FoS7u1wHCEcepAxp0o5C3L5OohNrPnyubDKi7t5oc70KAaSCD0ncvG
         35tM/zjDbOr8ABXCZztpgeIThYLTp+LSvTidz4S0X2kcX6Kudh4ucbQkvzCRM+u2Pk1c
         l1covbg1/E8MaLcI8hj1XK6XbVnHGdTMfjnDp6/S0EgcRBtQf85d7zKg24Vi2PtGAGjP
         AKXFkMJMDqYgCZU4p5yROMLqIIJJYlklD9Q2NxSW+3Gzj9y2ne50+EHpvyJkDGJAiWWt
         PDRVAZLxYhswyrvO7av3HGKHXCR3LbG8kJyK3AjBtD7d+I22IqgBVknAuzdnwI8RsuR6
         SOqA==
X-Gm-Message-State: AOAM533ov9WXbK742GP0boh5TMp5ntZ77FqmKXv1Y+20U1pgV5HDyqxM
        eCpFLnJoZWqtQWC1KPv0g/2KyA==
X-Google-Smtp-Source: ABdhPJzuxaefHZvd38Fmw8Tt/MDEALuJp9Z/DsWNUXhTEtV7qyVR7JWj5ElkPT5QmeIyOw9MdlrDLw==
X-Received: by 2002:adf:d1cf:: with SMTP id b15mr803908wrd.181.1632126541068;
        Mon, 20 Sep 2021 01:29:01 -0700 (PDT)
Received: from [172.20.10.7] ([37.169.24.17])
        by smtp.gmail.com with ESMTPSA id b16sm15249049wrp.82.2021.09.20.01.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 01:29:00 -0700 (PDT)
Subject: Re: [PATCHv2 0/3] Fix the pwm regulator supply properties
To:     Anand Moon <linux.amoon@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        devicetree@vger.kernel.org
References: <20210919202918.3556-1-linux.amoon@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <9d759c05-c67f-1230-7f58-562dc9bb1224@baylibre.com>
Date:   Mon, 20 Sep 2021 10:28:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210919202918.3556-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 19/09/2021 22:29, Anand Moon wrote:
> Changes PWM supply properties help fix internal link of PWM to
> main 12V supply as per the shematics.
> 
> V1: https://lkml.org/lkml/2021/6/29/288
> 
> Thanks
> -Anand
> 
> Anand Moon (3):
>   arm64: dts: meson-g12a: Fix the pwm regulator supply properties
>   arm64: dts: meson-g12b: Fix the pwm regulator supply properties
>   arm64: dts: meson-sm1: Fix the pwm regulator supply properties
> 
>  arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts       | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts         | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts      | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi | 4 ++--
>  arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi   | 4 ++--
>  arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi        | 4 ++--
>  arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts   | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts  | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi       | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts        | 2 +-
>  10 files changed, 13 insertions(+), 13 deletions(-)

Thanks for fixing all the other boards !

I'll let a few days for Martin to review, but it's ok for me.

Neil


> 
> --
> 2.33.0
> 

