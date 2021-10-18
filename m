Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6ACF431EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 16:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhJROGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 10:06:22 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49098
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233152AbhJRODD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:03:03 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 832C23FFFE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 14:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634565646;
        bh=hOmDJ63rwjyLjUsGk3cIxatC7VRnjyU/42JZ0Lta5uc=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=HbO9LcBJTuNwrv8yrh7idxR1sNlM8wbU/8ucNuiJ7bg/kdUJl2QeoufD15u8ypcuR
         LAvDA6BZBP1Ncz6rWrrnCUuAGXx49JH3JhY8IC3afc094eT1FMjDAvJfODCtFBTk2Y
         cSzPPYd0BtwKeOYng1/1QzpEgcCi+fsp2E9mKuzpSgMPrviEC6eGN3Nt9BZvNWRQMP
         7GkfPn65u85a+AeDgdS6KyFRjmTTSafFGyuQ1kb4La5/UgYjcqAurnE3bGdb/AcpRT
         GwoTSd2jTQ9WZidWZnYGD6R9NDDuGlIVWWJL0trAbPIpmxUd946/buXYoD0S/vyWdD
         VNTNgSc9pl3zQ==
Received: by mail-lj1-f198.google.com with SMTP id t7-20020a2e7807000000b00210dad8b167so1624766ljc.22
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 07:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hOmDJ63rwjyLjUsGk3cIxatC7VRnjyU/42JZ0Lta5uc=;
        b=rt1fUfuiEP33qjq+NwWib8HQ9+2xl+oWE1FpltNxTZBp2MrCiFzk9TwgptiYFKdCeu
         JKF3upSs+eHswgKDoKPhHwPl7KaUDheC+S16GLBaxXOEeDu1W8FKRqTdWpKWzwboMQcD
         GuHC2T2G8ienjHW29J7HioMFimeWw9+1IMFA/C7EM4n7496yu6rCBUf4mPVMU6+3yuKm
         H3kcJKtizkq8BlDhZ2JrqN8csjd4PHECHvS9NdVZywaEWKeoUIbIE+e6Cry981oT6Lnq
         CUpAV0ASNO/Mh/85qBueFVDfkaUr7Gvb4iuHCu01A9gRbi3EiTlRD+u6zE1xbx5/Na92
         s/8g==
X-Gm-Message-State: AOAM532tvJBELjqqO9OlTg0VK3t4aRsAnf1rXACF6DXiSWpEAOvKcD4b
        7GUhqmS8gHvdYnR04H3viZ/dV2luGgHbIeXcTCeu6yuPlBG1Kp0huPMlzZtL4va8ZVKlKuw98Lw
        SloMHw0X6crgQISGoFxkQ+qCIAR++WCK4znK52u0R5w==
X-Received: by 2002:a05:651c:1589:: with SMTP id h9mr34118284ljq.151.1634565645350;
        Mon, 18 Oct 2021 07:00:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGdsMC2+F7dPtQ5pAWFxgiy/MsdPyqcyjp+s7nAs9s60aNFddvh5hV8IScSftVcxS6IHnyDg==
X-Received: by 2002:a05:651c:1589:: with SMTP id h9mr34118264ljq.151.1634565645191;
        Mon, 18 Oct 2021 07:00:45 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id h6sm232919ljh.67.2021.10.18.07.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 07:00:44 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 1/5] riscv: dts: sifive: use only generic JEDEC
 SPI NOR flash compatible
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210920130248.145058-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <2b5cacd3-811e-fc4a-2257-19d968331825@canonical.com>
Date:   Mon, 18 Oct 2021 16:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210920130248.145058-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2021 15:02, Krzysztof Kozlowski wrote:
> The compatible "issi,is25wp256" is undocumented and instead only a
> generic jedec,spi-nor should be used (if appropriate).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Changes since v1:
> 1. New patch
> ---
>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 2 +-
>  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Hi Paul and Palmer,

This set is waiting for quite a long. Do you pick DTS patches for Risc-v
or shall I send it to Arnd/Olof directly? I can do it, but it would be
great to have a confirmation of such merging path.

Best regards,
Krzysztof
