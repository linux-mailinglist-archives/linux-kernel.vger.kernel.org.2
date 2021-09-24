Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E465417153
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 13:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245673AbhIXLx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 07:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244430AbhIXLx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 07:53:27 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBBEC061574;
        Fri, 24 Sep 2021 04:51:54 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso12715124otb.11;
        Fri, 24 Sep 2021 04:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fUTn9iZOV2L7vaasO2TvIVEOR1E4a/e8kh4KjyXUp8Q=;
        b=KHgReeP8DTmsfqxZB+2xN2OSSDzFTr/hPrH70aVjESNdaOJDqhPIGxTHydzwmg10D5
         mmdZtEf0DqZsGTm0h1DgDKztBE1YYbmU1HIyQUNXB88R7Ix6VG3Z1kaTueRCAKoZm87W
         DvlNwllul5Ck6d5R71ZLz5BiG1zajCyOqto6Qw2qWJXFkhHli3M9Cqtl9b7HZU8UlPs0
         Pq5y3UUkJ3W2qR+KPNexQaAy5AGytf4G/5RPXJl0aUR93+kyDMIbny2kt7AzDdDiw0aA
         CdAjJhzyqgg/5+zaJdPczsJDHU4YwtdfXwKyh3knxhcPoACCYvKrvnL7pfVjnukMMGle
         r8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fUTn9iZOV2L7vaasO2TvIVEOR1E4a/e8kh4KjyXUp8Q=;
        b=Lsrgki8p8oh27U2VeB07q5IeB7tsInEaYzmSNAfvO7HF4o5P/c6kxQuHT4dwHdYm+G
         qzdWIeJrzRxUDnJnYGxYYmvZ6ceA55Pyobk/JzAX/XDmfrVs2zyq8kS0Va1HIPr4pXey
         gmIwIEcAdfp59UydBiIHr+rZbE/rihzNrSWZoFAbZHy+8BJEIKglfR1ql5z/HMUfAyqC
         WRgfnA8NJIuhp3blPaIs96KarpH5t78gDy5Ad3+cmKOWsLUPgtTYhdK5RmM6+WhWO6IZ
         iCE3iT+kgzMaOt5n/p8He6eF5kzdwMKwQGybwAcrlzJYxr1mUWlE8XoGsNq9YUEd1881
         Su2w==
X-Gm-Message-State: AOAM532B/N+D/BzIb/F9iBbJnz7H7oJwFcu6RB8oOD4wE2Q+kWWK5R01
        +4Bd3JIODdZHhdl8nTOViFA=
X-Google-Smtp-Source: ABdhPJwg0PQxk/rq5OHl8Gjab/6RaZbWE/kpE/Meh+vlmmbJG3C/ofPfu1vkjUNij6g29RdZePGIFw==
X-Received: by 2002:a9d:7019:: with SMTP id k25mr3609123otj.350.1632484313698;
        Fri, 24 Sep 2021 04:51:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d26sm2006568oij.49.2021.09.24.04.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 04:51:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 24 Sep 2021 04:51:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] dt-bindings: hwmon: jedec,jc42: add nxp,se97b
Message-ID: <20210924115152.GC2694238@roeck-us.net>
References: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
 <20210920182114.339419-6-krzysztof.kozlowski@canonical.com>
 <YUzuyG3e7sHlMHAJ@robh.at.kernel.org>
 <8871dd77-f9f1-bf25-78ad-48f97efcf7d9@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8871dd77-f9f1-bf25-78ad-48f97efcf7d9@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 08:57:44AM +0200, Krzysztof Kozlowski wrote:
> On 23/09/2021 23:16, Rob Herring wrote:
> > On Mon, Sep 20, 2021 at 08:21:14PM +0200, Krzysztof Kozlowski wrote:
> >> Document bindings for NXP SE97B, a DDR memory module temperature sensor
> >> with integrated SPD and EEPROM via Atmel's AT24 interface.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >> ---
> >>  Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml b/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
> >> index a7bb4e3a1c46..0e49b3901161 100644
> >> --- a/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
> >> +++ b/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
> >> @@ -10,6 +10,14 @@ maintainers:
> >>    - Jean Delvare <jdelvare@suse.com>
> >>    - Guenter Roeck <linux@roeck-us.net>
> >>  
> >> +select:
> >> +  properties:
> >> +    compatible:
> >> +      const: jedec,jc-42.4-temp
> >> +
> >> +  required:
> >> +    - compatible
> >> +
> > 
> > Is this supposed to be in the last patch? And why is it needed?
> 
> Yes, this is here on purpose because of nxp,se97b which is sensor with
> at24-compatible EEPROM.
> 
> arch/arm/boot/dts/at91-nattis-2-natte-2.dts:
> 169         temp@18 {
> 170                 compatible = "nxp,se97b", "jedec,jc-42.4-temp";
> 
> 171                 reg = <0x18>;
> 172                 smbus-timeout-disable;
> 173         };
> 174
> 175         eeprom@50 {
> 176                 compatible = "nxp,se97b", "atmel,24c02";

How would that be handled anyway ? Yes, the chip includes both a temperature
sensor and an eeprom, but this node should most definitely not instantiate as
temperature sensor.

Guenter

> 177                 reg = <0x50>;
> 178                 pagesize = <16>;
> 
> Without the select, dtbs_check was complaining about the second node:
> 
> eeprom@50: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['nxp,se97b', 'atmel,24c02'] is too long
> 	Additional items are not allowed ('atmel,24c02' was unexpected)
> 	'jedec,jc-42.4-temp' was expected
> 	From schema:
> /home/dev/linux/linux/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
> 
> eeprom@50: 'pagesize' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	From schema:
> /home/dev/linux/linux/Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
> 
> 
> >>  properties:
> >>    compatible:
> >>      oneOf:
> >> @@ -31,6 +39,7 @@ properties:
> >>                - microchip,mcp98244
> >>                - microchip,mcp9843
> >>                - nxp,se97
> >> +              - nxp,se97b
> >>                - nxp,se98
> >>                - onnn,cat6095
> >>                - onnn,cat34ts02
> >> -- 
> >> 2.30.2
> >>
> >>
> 
> 
> Best regards,
> Krzysztof
