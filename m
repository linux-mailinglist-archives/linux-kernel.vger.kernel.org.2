Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5FD444646
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 17:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhKCQwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 12:52:15 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53534
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233005AbhKCQwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:52:14 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 90F163F1F8
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 16:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635958174;
        bh=izkpWJi/pLLJ98XZDF6SVK70Q4PiKzjW5l5a2WFdAgA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=PETWjrjzjs2gBgkFNJrkEhxccs+wq9JXdPx2prN7njJatX720biaXdgA2Q479z6z5
         2ZUy2BDNVCqKyNxZUytiBPR45DwBAYiceq8GcnNBBnz4tXfqrVTsvhGgCnQHB6b6BL
         X2Ej3i87rUifzRDnysi3Urwi8gMn+hAJr6H9ILNWSR9qlpfTvOECLi+aExbN53Zywy
         i3w/6S0gUdPiBFMUvAVG8CY5ivlV6LMBEAy0oYJev9HO87CISzT1RObZkmzgr/t1mD
         Zz3qs0+qSD3x7V4SGzHrWEbrKdw59ho/boj7gyflqkFj5DuWQbcmcb33Bgd2dMgr03
         lh0sbuaR+36GA==
Received: by mail-lf1-f71.google.com with SMTP id c13-20020a05651200cd00b004001aab328aso860847lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 09:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=izkpWJi/pLLJ98XZDF6SVK70Q4PiKzjW5l5a2WFdAgA=;
        b=BUhfs+0TAsYHTTdBkW0LQoLw8EgaZE5fPS3IZ+6kIyq3FBFJK2eEORMx7VKdrAxFum
         vACMpc45roL+pV3QvtS8IWJcdECovaGsiXqgRrQMMvpxj4YdotHfC/BgIAuu/Rs8A6z3
         zJnpDtcDjnGb/bIFVPL8m2xA7JEBAwnWBP7uu9mZ9cVU0Ey0F6qmd4ElNK4dWQsXJoKQ
         Shfs/P83onaAh6CNRTwfwDLyICV7AoAnoIXCImI6aPcqspSujNmSsQvaKuR2DhqkvTSa
         8B3bSvJu6UhLoB5M9C73mCY4M17s/uYp4hENeu89FF+xt4mAz9Yi+bLTjGzcVRrE0Q8O
         w5Lw==
X-Gm-Message-State: AOAM532elj/h1T0CF/3Em8Em4KNhoTDPuGO/TvMpaQ+FNQJkWnrvFgy3
        Sx+/QmuV3y4eW6DRkQW7d+IAevffhlGAl9tlLxHkoFhZryT886iAnhBL1/oHvC2+Jc0+4s2QRav
        3nSkb8trjIcrcxOUACpVMv//QumjgqQ+the8dr6WUWw==
X-Received: by 2002:a05:6512:3322:: with SMTP id l2mr21487122lfe.452.1635958173981;
        Wed, 03 Nov 2021 09:49:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFpmixwFB/chab3tgeDDfSF2Tcjfddj5PDK2pW7XS1eDafNy2LVdo+7GRNXinIuZNga1S/PQ==
X-Received: by 2002:a05:6512:3322:: with SMTP id l2mr21487093lfe.452.1635958173764;
        Wed, 03 Nov 2021 09:49:33 -0700 (PDT)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id r3sm222911lfc.114.2021.11.03.09.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 09:49:33 -0700 (PDT)
Message-ID: <c22e305e-cf28-9dfe-8354-9d71ee643faf@canonical.com>
Date:   Wed, 3 Nov 2021 17:49:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] clocksource/drivers/exynos_mct: Fix silly typo resulting
 in checkpatch warning
Content-Language: en-US
To:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20211103164804.30182-1-will@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211103164804.30182-1-will@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2021 17:48, Will Deacon wrote:
> Commit ae460fd9164b ("clocksource/drivers/exynos_mct: Prioritise Arm
> arch timer on arm64") changed the rating of the MCT clockevents device
> to be lower than the Arm architected timer and, in the process, replaced
> a semicolon with a comma thanks to a silly copy-paste error.
> 
> Put the semicolon back so that the code looks more idiomatic and resolve
> the SUSPECT_COMMA_SEMICOLON warning from checkpatch at the same time.
> 
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
> 
> Although this doesn't have a functional impact and I'd normally not pay
> too much attention to checkpatch warnings, the code is pretty weird as-is
> and I didn't intend for that comma to be there!
> 
>  drivers/clocksource/exynos_mct.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
