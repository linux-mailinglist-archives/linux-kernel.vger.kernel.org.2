Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E7C309CE8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhAaO2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhAaOGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 09:06:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3923BC061573;
        Sun, 31 Jan 2021 06:05:42 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d16so13691102wro.11;
        Sun, 31 Jan 2021 06:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gFx/tVQHtxgCPh4i1/Qzd/o3NQjbvg90eZx0ANkD1ok=;
        b=Mc/BXBnam+6D3Q1EIbkSs20p+TfdamlDzRm1mKEd0wwL7QoAph+p+ncpKbNUjXnLQM
         Ku98p7qv6fBXHhUpWT0o4TCePql5h5HYWlfzg8opwp+5RTGw6TcUIaSKRaxk+eomK7ya
         0H2Nu+0FgSV0OFIslc1UMORvr0EeFutMueXDK7gwN92hYYnlSVZ8EP1QPzJJzqm+llHI
         fVjWqKpenJNXhBpsTjDHUFZ2P5vn9+YIBPtlUeS10gP5I2oq3ank/M1tfAURa+otoVDb
         J1k4n7BrJnsUAclr3RVztAb5gMriR3J89tJRZmBKUGqYtz176CZgWFlxcrvA0YancK/j
         yKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gFx/tVQHtxgCPh4i1/Qzd/o3NQjbvg90eZx0ANkD1ok=;
        b=uHVS2zd3tOT24JeWTIrnC+tm6LtfOpfWHIjojP8qCO4KEkNA/Ho99yHzTZpnJqm9sx
         86l3pTwLMIWu6df5J+CQDoitDvXrnUZygO+5mSoCPCPNPzg/K/FN04W3soqeZSSKNORk
         dBXPxEsKMXn8dsdtzAoXfMya473NLyWBTdlmZC0czO4fOkgm9M24khIeTFZ414wBrHXa
         YzOx/M1bECaWskAttWrUdwZAhw+/KNIuoWoZk4q4HSBFfr7NrhQHC7J7qs69X45SlZZO
         Eq7jwaA8z7+t3VlJUh3+SSoevdqH7DroPior2VPqtt0eJ95jmIy1OUxgishELnIEONyZ
         MK9g==
X-Gm-Message-State: AOAM533/2e+JbNb8f2H+moHahKbIYXyk733wRux6Cp1Q1V9cPA5pGJuv
        AlQi4yjfd2hEyKR49xvFnW8=
X-Google-Smtp-Source: ABdhPJx+1XxLkxZy7ZG2gL6Lij7vZ8DkospleDPpQ854Dkbmhs5pTan1QNTUJMbA7j0X2//OkeK2kg==
X-Received: by 2002:a05:6000:104f:: with SMTP id c15mr13555983wrx.239.1612101940878;
        Sun, 31 Jan 2021 06:05:40 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id y18sm22498726wrt.19.2021.01.31.06.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 06:05:40 -0800 (PST)
Subject: Re: [PATCH v1 1/2] arm64: dts: mt6779: Support devapc
To:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SGFua3MgQ2hlbiAo6Zmz5b2l5bu3KQ==?= 
        <Hanks.Chen@mediatek.com>,
        =?UTF-8?B?SmFja3Nvbi1rdCBDaGFuZyAo5by15ZyL5r6kKQ==?= 
        <Jackson-kt.Chang@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>
References: <1608713092-26952-1-git-send-email-neal.liu@mediatek.com>
 <1608713092-26952-2-git-send-email-neal.liu@mediatek.com>
 <1608717152.29691.1.camel@mtkswgap22>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <c7d6e41f-33ba-065a-4d83-ab61323faeac@gmail.com>
Date:   Sun, 31 Jan 2021 15:05:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1608717152.29691.1.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/12/2020 10:52, Neal Liu wrote:
> +add comments & reviewed-by Hanks
> 
> On Wed, 2020-12-23 at 16:44 +0800, Neal Liu wrote:
> 
> Support DEVAPC on MT6779 platforms by adding device node.
> 
> Reviewed-by: Hanks Chen <hanks.chen@mediatek.com>

Apllied with the description and Reviewed-by to v5.11-next/dts64

Thanks a lot!

>> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
>> ---
>>  arch/arm64/boot/dts/mediatek/mt6779.dtsi |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt6779.dtsi b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
>> index 370f309..52ecfc7 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt6779.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
>> @@ -189,6 +189,14 @@
>>  			#clock-cells = <1>;
>>  		};
>>  
>> +		devapc: devapc@10207000 {
>> +			compatible = "mediatek,mt6779-devapc";
>> +			reg = <0 0x10207000 0 0x1000>;
>> +			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_LOW>;
>> +			clocks = <&infracfg_ao CLK_INFRA_DEVICE_APC>;
>> +			clock-names = "devapc-infra-clock";
>> +		};
>> +
>>  		uart0: serial@11002000 {
>>  			compatible = "mediatek,mt6779-uart",
>>  				     "mediatek,mt6577-uart";
> 
