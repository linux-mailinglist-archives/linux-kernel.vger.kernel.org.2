Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7641C3A4DE1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 11:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhFLJYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 05:24:35 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:44615 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLJYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 05:24:34 -0400
Received: by mail-wr1-f47.google.com with SMTP id f2so8543459wri.11;
        Sat, 12 Jun 2021 02:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VPyfpqUMlxaWdAzLxId3Zh5R6JorORKQlcjlpTdHelo=;
        b=WBu1HCdi/S31eLGZ4097FPwjEU+DY8GX9ch7FcVF2Pku3eCw7UKY2MgUUFvTO0Hj9X
         894JgYQx//cwhbtezHsqIc1BJGPSTQrtn2+Yhg+wxoaKClgGrAMDpAHmMwRgFw9Trjdr
         HPy/wMVkrzY604BmPMAU7OFsHXEPHKBB8xAuckjfNdDfwFXhyMZJjwWdTaGNSL6MCbrI
         PP6dlsn+/rfnyp6jBmillGqFo7DLgFxG2CrH1eSCiXQyoGiuwd5kxuibpMdpLblENOef
         V6Ao2+gcqT+1ZSv475obc0Fxso5cIxHVidPjwFnahKQedOMhCsTQUG43c9OD6rwZjE+f
         JWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VPyfpqUMlxaWdAzLxId3Zh5R6JorORKQlcjlpTdHelo=;
        b=HCQ7HWwsa+VlUBZ9tzFDSHyOJNyZV/swU/89r7zfn2bwA4x/fnVpWuI+gihUaCVfLm
         /D9VUeGfvGp0nkWTtvqejeex9QZ44Si/kYqtIF6Q7qobLptL+7NqAAMHGgjW01TwWpvU
         9pVxQCpqaVaJzRg2h5flpYCwLFJGqHeeCDEaIuz6+b/D+RDoY8cEnZGXeohfAjUQoEud
         yQhnZt3+Y5xr8veugE3yLm87zIyh2z4nRUKwfdVJ1PidlUKYHgyf7WlQCDYWNiOQGugj
         23ZOenV3j00GrD7D79nhvh4xQ3OPBvkmkSl0Di91DRU2ZMccd16xpuWlLm1Zq+9GDOJv
         NsVg==
X-Gm-Message-State: AOAM5324gJzYhl4cnkdR0ZfY3YggsLIRvReauWQlldf05BBSCpqrR/Oq
        7YYyOpl2Y7pGNFQwsb9o/65bQaNWq46kZQ==
X-Google-Smtp-Source: ABdhPJx1SmIKt8DQjEBrnkm86h9UTaK5hGf5oK2W6pHvVhU3I/3Rp6viczcAtjNXXOl91Mjt/XRPZQ==
X-Received: by 2002:a5d:64c7:: with SMTP id f7mr8237318wri.36.1623489694024;
        Sat, 12 Jun 2021 02:21:34 -0700 (PDT)
Received: from localhost.localdomain (haganm.plus.com. [212.159.108.31])
        by smtp.gmail.com with ESMTPSA id l10sm9562095wrs.11.2021.06.12.02.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jun 2021 02:21:33 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: bcm: NSP: add Meraki MX64/MX65
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210610232727.1383117-1-mnhagan88@gmail.com>
 <20210610232727.1383117-2-mnhagan88@gmail.com>
 <20210611194644.64lvhvp76wy6guqp@skbuf>
From:   Matthew Hagan <mnhagan88@gmail.com>
Message-ID: <f0af3f0a-ab13-ecdc-d834-c95ddcb52866@gmail.com>
Date:   Sat, 12 Jun 2021 10:21:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210611194644.64lvhvp76wy6guqp@skbuf>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

Many thanks for taking the time to review the submission.

On 11/06/2021 20:46, Vladimir Oltean wrote:

> On Fri, Jun 11, 2021 at 12:27:13AM +0100, Matthew Hagan wrote:
>> Add bindings for the Meraki MX64/MX65 series. Note this patch should be
>> applied on top of "dt-bindings: arm: bcm: add NSP devices to SoCs".
>>
>> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
>> index 78dfa315f3d0..7d184ba7d180 100644
>> --- a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
>> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
>> @@ -62,6 +62,12 @@ properties:
>>            - enum:
>>                - brcm,bcm958625hr
>>                - brcm,bcm958625k
>> +              - meraki,mx64
>> +              - meraki,mx64-a0
>> +              - meraki,mx64w
>> +              - meraki,mx64w-a0
>> +              - meraki,mx65
>> +              - meraki,mx65w
>>            - const: brcm,bcm58625
>>            - const: brcm,nsp
>>  
>> -- 
>> 2.26.3
>>
> I think these compatibles describe SoCs, whereas Meraki MX64/MX65 are
> boards, so this is a miscategorization. Can you not just describe the
> Northstar Plus SoC that you are using in your compatible string?

My understanding is that the bcm958625hr and bcm958625k are dev boards
using the BCM58625 SoC variant of NSP. For reference, a close example
can be found in brcm,bcm4708.yaml in the same directory:

      - description: BCM53012 based boards
        items:
          - enum:
              - brcm,bcm953012er
              - brcm,bcm953012hr
              - brcm,bcm953012k
              - meraki,mr32
          - const: brcm,brcm53012
          - const: brcm,brcm53016
          - const: brcm,bcm4708

For the compatible string we would definitely need to specify a unique
device name for identification by the OS, rather than just the SoC.

Of course I could be mistaken. Will await confirmation on this.

Matthew

