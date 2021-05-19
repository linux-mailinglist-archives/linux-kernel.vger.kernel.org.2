Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2A83891D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354622AbhESOs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:48:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:32958 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbhESOs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:48:57 -0400
Received: from mail-qv1-f72.google.com ([209.85.219.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1ljNU1-0001PJ-46
        for linux-kernel@vger.kernel.org; Wed, 19 May 2021 14:47:37 +0000
Received: by mail-qv1-f72.google.com with SMTP id f17-20020a0cf3d10000b02901eda24e6b92so10532112qvm.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jlsUdvAi6guPhxb/KDLB35/MQXQ9ef80K6DmXkPtEJY=;
        b=KN5NVA/3lg4H6AEwYpH7XR8UvNXlkhKLnFthjnyGrO0njzSGluava450JOOs3ZkuDZ
         ZGa6lfRRYWiX6vfvO41qoBqw//tdJrnE11NaUcoEL9DRqIuCK8fvm+v6EcogGAu0y7dL
         fGJTupD+AMf1CHWKHjaGCuBlLW14k9BBOm+yiHM+Bk9diaeo0xlZarCBcyyXNvMTtIp2
         AwMsrstTSVZ5FpZJxYnq0IYkb111dif4Dh1AxLcgqLCsw4MgHYQl8swYxP3bUaPy8yfk
         QXGwCRbfPVpgQ2oiwq9QdUSORVkgNS+EXyslgYVO5+Q7R2R+sySIaU2FMhTiNhXiayqG
         Rx9A==
X-Gm-Message-State: AOAM533zT+lu3zWuwVcRcx1EuLscAGywaPiTB72TYurgFuuLkZxlWecE
        cU9IfAY/8WrkRKjA3jE3MHUegFHm2aiNDG9oTOhaJYtL7Db6w7Eaa2aXcf3PA6tmFlCqCfrN8kL
        I5F6PNEC4t6juSTFeZWjavpeUNfuhCs7/W+BrbOA78w==
X-Received: by 2002:ae9:e70c:: with SMTP id m12mr4511958qka.414.1621435656336;
        Wed, 19 May 2021 07:47:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQnyqJ3uV7od4UNk33JSm3yvXvFib0hw6K0hCjkV16Dui0sb3gcPAR3H/GJ1RFmug5AkAs6A==
X-Received: by 2002:ae9:e70c:: with SMTP id m12mr4511940qka.414.1621435656170;
        Wed, 19 May 2021 07:47:36 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.1])
        by smtp.gmail.com with ESMTPSA id x27sm9461224qkj.133.2021.05.19.07.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 07:47:35 -0700 (PDT)
Subject: Re: [PATCH] soc: samsung: pmu: fix BUT->BIT macro typo
To:     Alim Akhtar <alim.akhtar@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
References: <20210517141250.55655-1-krzysztof.kozlowski@canonical.com>
 <CAGOxZ524m0tYy2Y8xnkfoSg9PQj7uA6PohYC9u23Je3F+gHjDA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <6c7fda4b-7f0c-242e-21c2-eb6c003d6d05@canonical.com>
Date:   Wed, 19 May 2021 10:47:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAGOxZ524m0tYy2Y8xnkfoSg9PQj7uA6PohYC9u23Je3F+gHjDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2021 10:36, Alim Akhtar wrote:
> Hello Krzysztof
> 
> On Mon, May 17, 2021 at 7:59 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> The macro EXYNOS5_USE_STANDBYWFI_ARM_CORE1 should use BIT, not BUT.  Fix
>> does not have real effect as the macro is not used in the code.
>>
> Can we consider removing this? As this is not used in code.

Sure, I guess, if someone needs this bit, can always check in the
documentation :)

Best regards,
Krzysztof
