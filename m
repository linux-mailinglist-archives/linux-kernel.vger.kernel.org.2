Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C808421235
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbhJDPDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:03:18 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59312
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235502AbhJDPBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:01:23 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1BD9C402CF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 14:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633359574;
        bh=mjXPISoqrzvv6T8eWckfoa+w/l3lHuMX4ztP7/j2C4I=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=krgPwlUMcgSwGlUiB12Zp99l3ylJhBuPOZcXfKGJhKv6FBX0T5wsQj03FXeMydFfG
         fU0Ap4Cxz1/qbtKp6qAMAF2AdYS/USKX/yH39XNGXfdim+Ro9l2Vboni/KrCh+kfVe
         dFbsCn7EwOQb+tr0mi0PiansBje8fuel8+dej03lOHu6yeE/A8MU2j9Dx9vp81wUx4
         SgcBWX8FyyTK+6ku9XV8HO2nWZikf1YvnoXP0VEsVoQD/+ODsXfGsbkMK989wQwGkh
         GtDVaoiDnc40pKhaBHNnF6IsEaASWF5Br72GqxKRDdI5VWP8A1cX3OS8qwRwN0udnO
         G7rfvMGdkq3BA==
Received: by mail-lf1-f70.google.com with SMTP id v2-20020ac25582000000b003fd1c161a31so8475577lfg.15
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 07:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mjXPISoqrzvv6T8eWckfoa+w/l3lHuMX4ztP7/j2C4I=;
        b=W9Fbj6N0F8GCo5hkSVHSdnsXGByHTUCGKpOuzgT5hWV93371XpyXRYymeRhf2A8j6c
         g+v+PyQ6XM56eT2Wei20h3cj5qAEQuvktn98Bd41IX35RupbgeGk9NFpJUkb+3OXHoHN
         zK0p0VrkRM1BL/gnDEOC5vGsK2urBL83MafWAfEVjoszZKylPXBxLiBOMCfnO0nwUzGH
         Vq+SZh7OWeuDLVFqvlicyYiKd5J6nOBzD9aiM/+DJNtYiCX4z6botozxl2XR4VDIpHXn
         4Yb6lUPisY5P2txMuFmwTueGiqp+toofOZKb9cM0xtP8C8iN6oHJEcTmVx8wnlttcUir
         pqzQ==
X-Gm-Message-State: AOAM532suPn6JoIAwdorPo7jU6srSdwduIyVgQZzo3FygVf6feAYcRRy
        vgLzTZgkeMb7C3y/ttTWDTyCjPd2wdut961nJyfd0qZId1w+db7SYh5diqIgR3v4NYW5xu+m0/d
        +JhiGhBb5Wyf1pCWugEYLp9bFEJpvJOJkzqhS5d2Txg==
X-Received: by 2002:a2e:575d:: with SMTP id r29mr16342112ljd.284.1633359573250;
        Mon, 04 Oct 2021 07:59:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOo+lB6RcMLwBXgkySBQ4vL0Yv8gDCQD9CBhd0v3DB/P0euRpRs8FczKlBWRUn5Il77PI8dQ==
X-Received: by 2002:a2e:575d:: with SMTP id r29mr16342096ljd.284.1633359573085;
        Mon, 04 Oct 2021 07:59:33 -0700 (PDT)
Received: from [192.168.0.197] ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id h21sm817340lfc.30.2021.10.04.07.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 07:59:32 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: mmc: arasan,sdci: drop unneeded clock-cells
 dependency
To:     Rob Herring <robh@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210928082346.22398-1-krzysztof.kozlowski@canonical.com>
 <YVsWDaC0TOSOrrxW@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ba5cfb69-1d79-d1cf-5f15-46b4dca2fa9f@canonical.com>
Date:   Mon, 4 Oct 2021 16:59:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVsWDaC0TOSOrrxW@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2021 16:56, Rob Herring wrote:
> On Tue, Sep 28, 2021 at 10:23:46AM +0200, Krzysztof Kozlowski wrote:
>> The meta-schema already defines dependency between clock-cells and
> 
> You mean the schema already does.

Yes.

> 
>> clock-output-names.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>> index 23abb7e8b9d8..dd70431df0b7 100644
>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>> @@ -158,10 +158,6 @@ properties:
>>      description:
>>        The MIO bank number in which the command and data lines are configured.
>>  
>> -dependencies:
>> -  clock-output-names: [ '#clock-cells' ]
> 
> The schema defines this.
> 
>> -  '#clock-cells': [ clock-output-names ]
> 
> But not this. That's because in the common case, clock-output-names is 
> optional. But here it is required when '#clock-cells' is present.

You are right, somehow I missed that part...


Best regards,
Krzysztof
