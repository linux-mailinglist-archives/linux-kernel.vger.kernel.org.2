Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C592435A488
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 19:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhDIRTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 13:19:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53843 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDIRTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:19:40 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lUun0-00088R-Qp
        for linux-kernel@vger.kernel.org; Fri, 09 Apr 2021 17:19:26 +0000
Received: by mail-wr1-f69.google.com with SMTP id a15so2546248wrf.19
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 10:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MF7ir3WvrSx3fVs+kwq9HlQIkfNHtZbHStyjJVEI674=;
        b=aP8OpBuGr+Br5/cuESqaZdd6xCu7kIjAfeclDrxnl9cJ2bUFgOnWPUtXAVEkfrDjjG
         TglDmBnt49rtflL/2hRVFs3H/ePnkD0cU2AvDYHK22Gq9QRsl3fwRzWwsPZAncTMSUus
         W8TN0SZAcfvRW3kTnJ9Kp+h4u9r30soiQ7eOOkbijRQMDkj3mPS7su6MLsqFaizHf3wl
         s2MLxiYzqUuc4qdYhwYgsMtQP4ImrBhJp5Trew+VNHJfGHExI8rGo/9Vq/hw0JXEkN6Q
         1HMb1WBn0dXamZCaqYb4YxxW+Y6DUoNzw9H0EX/BJSvMdiMWc+TF+FYgTmNMJhta5z/C
         oSrQ==
X-Gm-Message-State: AOAM531wW95mApBdlqyhAWHUufTFbx+3RjBhkcqTeArYP/W20WBdNDAr
        5svYEiG8UllwFg56NTQ5uT5G2cpBUercgOenSAcn4Xhtymhb44s+2E+4Ku8koLqOvPYtGMXX5PO
        BTyR+gM0kFKis76ufrwZXC4d7izot/Fsk0qgG1TiSYA==
X-Received: by 2002:a5d:6ad1:: with SMTP id u17mr18632733wrw.214.1617988766176;
        Fri, 09 Apr 2021 10:19:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoHmJCq+boBnAlfaIBVP5XJAn1stsfy3E4Yg3rVDRyUJcFf9LW6ZyaB9V9QoKKEjW3PrCWwQ==
X-Received: by 2002:a5d:6ad1:: with SMTP id u17mr18632724wrw.214.1617988766071;
        Fri, 09 Apr 2021 10:19:26 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id s83sm4841985wms.16.2021.04.09.10.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 10:19:25 -0700 (PDT)
Subject: Re: [PATCH v2] dt-bindings: serial: samsung: include generic dtschema
 to match bluetooth child
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210405172119.7484-1-krzysztof.kozlowski@canonical.com>
 <20210409160952.GA3737690@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d4d90a42-8c18-2f5e-d77d-da006f9b108f@canonical.com>
Date:   Fri, 9 Apr 2021 19:19:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210409160952.GA3737690@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2021 18:09, Rob Herring wrote:
> On Mon, Apr 05, 2021 at 07:21:19PM +0200, Krzysztof Kozlowski wrote:
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> Include the generic serial.yaml dtschema so the child node like
>> "bluetooh" will be properly matched:
> 
> typo
> 
>>
>>   arch/arm/boot/dts/exynos4210-universal_c210.dt.yaml:
>>     serial@13800000: 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> ---
>>
>> Changes since v1:
>> 1. Drop the new example, as Rob suggested.
>> ---
>>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks, I'll send with fixed typo.

Best regards,
Krzysztof
