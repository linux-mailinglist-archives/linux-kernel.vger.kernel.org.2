Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0F3430ACE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 18:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344242AbhJQQjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 12:39:53 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:48492
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230003AbhJQQjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 12:39:52 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 01CA34001A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 16:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634488659;
        bh=1RPm1/LKTSEH8C0YJx6dXoFgI89yVIC6crD5lgWAirc=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=GB/2jkttGiT2O3gSLZIsbwSllMctQKrSsyztzWsDbljlV5zNTSfTo35vCHi1wxUKR
         1bBlMY56nADKVeMt68W2CPN92cDamRoYIcOYm/I68xlenoO8tbWFW3Fg5u0CepcA2Q
         o2VUxAE4Xcf7IjayPdS+B/VtTVSjkZWLy9bkto7n3KyGKxN1mwMetIDefbDPC8bIlq
         XGM7hWB0xNa2J8d49mgDr9HW+VyfnHiasUDr3H98isGgsgEWF0vhNoBMy3Tjsp+keI
         p0bQORe73fZ8TR59UROSgM8qgfXvhU9qhqgig4fwkgPVkLlYvFj3vKhAGHHI+OENOi
         vGX1VAFqRmPqQ==
Received: by mail-lj1-f198.google.com with SMTP id a20-20020a2eb554000000b0020de66f70bcso550293ljn.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 09:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1RPm1/LKTSEH8C0YJx6dXoFgI89yVIC6crD5lgWAirc=;
        b=donA8VbHebWg7gMHfuj0m7wnjJVnz9D2GVOddKaQRUjBtMfQxPtXwrWo+7RSzilO8y
         627XhwnypZ/53iGw3dwj+GR9VRQf9xecUq2NSvC5W4J1mjYSg3RWXngoulM9y4E1z2kI
         ml9j7JFwrzQU7QLWcYF8URCPXTKCvU53CcxtMacsycdMtezb3hB3u5F2rvKiF54OEByu
         gvgfRWj1mqIJ4s/TyZofmduDs7IpyUp3MMzsN2vjV0udI+I//HFzaQuiRguTWaYagOiM
         GjHY2pNBWElmHGbTur2B6JY3EtEH7MZ/qdL8oMcp4iDmhX6X8ZyEHoHzFsgbe+c7e/Ge
         6Fhw==
X-Gm-Message-State: AOAM5339w1PHA9ya6rcWdxjVM8Iqwtp2qtymbht7K7D3B2C42lgMy9Z5
        bCoTgZ643p04MSDdUFz2xFDVI1viapXXPSG5jKhQbQ4oQlb5ibuTDvNejYSbSvQA+dvznJIRBgb
        Af+vROD1cVDIswnqCtjmoyvfvpnosQWaqmlRFP8CQEA==
X-Received: by 2002:a05:651c:204d:: with SMTP id t13mr23783985ljo.267.1634488658195;
        Sun, 17 Oct 2021 09:37:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/lqcEKlBCBJKXljOPkvtPOkonlr9+CwlLqnStL9xaA21H+RrX4917KV+h8+HiIpOwiDIgFg==
X-Received: by 2002:a05:651c:204d:: with SMTP id t13mr23783965ljo.267.1634488658014;
        Sun, 17 Oct 2021 09:37:38 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id k23sm46262ljm.29.2021.10.17.09.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 09:37:37 -0700 (PDT)
Subject: Re: [PATCH v4] dt-bindings: net: nfc: nxp,pn544: Convert txt bindings
 to yaml
To:     David Heidelberg <david@ixit.cz>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~okias/devicetree@lists.sr.ht
References: <20211017160210.85543-1-david@ixit.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <0937ddb4-7a5b-b6e0-d6b8-42a912744bd6@canonical.com>
Date:   Sun, 17 Oct 2021 18:37:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211017160210.85543-1-david@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2021 18:02, David Heidelberg wrote:
> Convert bindings for NXP PN544 NFC driver to YAML syntax.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2
>  - Krzysztof is a maintainer
>  - pintctrl dropped
>  - 4 space indent for example
>  - nfc node name
> v3
>  - remove whole pinctrl
> v4
>  - drop clock-frequency, which is inherited by i2c bus
> 
>  .../bindings/net/nfc/nxp,pn544.yaml           | 56 +++++++++++++++++++
>  .../devicetree/bindings/net/nfc/pn544.txt     | 33 -----------
>  2 files changed, 56 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/nfc/nxp,pn544.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/nfc/pn544.txt
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
