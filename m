Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9AE40EB5E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 22:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhIPUJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 16:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbhIPUJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:09:03 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC475C061574;
        Thu, 16 Sep 2021 13:07:42 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id r26so10712757oij.2;
        Thu, 16 Sep 2021 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n3oUbPRJpWQiVkwSvD4XP51mLLt5jJ8ezEdpZRzBKoU=;
        b=m43f4ZIBhiDKo4McVMnu4UXAFaAYo9cBRh84VTYahUgu9PgQCagH0qWuDOWa6JLXUr
         p3KhAvvN/dla8XukXAjucYD1Xmiaa8fGIH1RULHJdoGkRNN5mGjYz3i43uqL0cJBfz1j
         pKz7CvG8rVe7nQxcIdBAmV80Lz1ukWSb258v4QRU3Ls6ohYsiZgvUEOgAenN2CiE9PPs
         t2Yym9ytPXgK4cMf96yFen2TQ8fxSwDGJqVqBjUaVuJ60mNSxqpIt7dP5DrHG9GZnve4
         2oYfp7k5IE4GouYOPOy3pGthWjPpapMtXSlYyb/acFio4nfO6xBWHrlfCJIIpO4O7Uih
         wN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n3oUbPRJpWQiVkwSvD4XP51mLLt5jJ8ezEdpZRzBKoU=;
        b=fIZEU3UqnBRoHt1ZWcAcJMi7U4NKsz5R+BguEr39hrgK97nBYIjHCXWJ5OT1/a09Ml
         22Ud7hWC/hH6K08Ss2IZ4cEztTMcqNwUwKrYkTv7VGBrK6/Bfbj5jzaoZqkyCbLSSLT+
         5ubVFZda3Dt3KZhsaz3dk0EM9KdLgcZ73uFBTpCiK0Kmd9i7WBWgvHiVKAaCliLM1KSM
         MA1P1hJjfELSH3njfctfsquNe9NCaap96wdfP7e8mZj7d8VVUgVFEq0t8pCM9nPX4L+t
         rvqHH4tTbuIwgtGWj0ggJRuFp7XjHHJtkpYD+CHGdStVioxEPQ1WinTFMEZUA7IBsOgz
         H70w==
X-Gm-Message-State: AOAM530F+hxaqicJ0BFy7Bm1/sa1/mqfZepbA7fMu8oxaUun6aq0zKnc
        LMEtDG3EDlWbMFrh00WEaIg=
X-Google-Smtp-Source: ABdhPJwX1OBbhXmLMqqZwNCwkUgIyEiz5ug1sETP3rnj3BOem+2YZBfyamhYS2yCLi9ioCv6uHq7Ig==
X-Received: by 2002:a54:4e84:: with SMTP id c4mr6661752oiy.106.1631822862066;
        Thu, 16 Sep 2021 13:07:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g16sm971206otr.20.2021.09.16.13.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 13:07:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Oskar Senft <osk@google.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20210910130337.2025426-1-osk@google.com>
 <71c17c47-ca9e-e9d2-7b89-cc25b512c06a@roeck-us.net>
 <CABoTLcRZ43EUVzbqWniu64PkB7Yx4RMYKjaBxaSihk+k0Ca-gA@mail.gmail.com>
 <722b27f6-4390-9b5b-f6f2-75ce9e967d12@roeck-us.net>
 <CABoTLcSdkmuBxd5Yh6z2Oqm1-_Vd4J5Ni1i1qq5s07mWu7Ndew@mail.gmail.com>
 <20210914150859.GB3457579@roeck-us.net>
 <CABoTLcQfS5-UL92NR9vbc2YrGJv3oQPYCqAm-diNoq-tkHP_hQ@mail.gmail.com>
 <c410eba9-f6cf-4dbf-797f-48afde9c1898@roeck-us.net>
 <CABoTLcQWXerMWPvWUqjykiNcx9oGoP8aEcuDwcQ36yu-CBc0pA@mail.gmail.com>
 <382858f5-e833-d4b9-f189-449671992ba5@roeck-us.net>
 <CABoTLcST=74wRbtMA2SdmeHd0WmU7id05ouSfw4PFw2nJt_gLw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] dt-bindings: hwmon: Add nct7802 bindings
Message-ID: <9869ed19-b8ab-d9e5-e791-a02eeb2c5eed@roeck-us.net>
Date:   Thu, 16 Sep 2021 13:07:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABoTLcST=74wRbtMA2SdmeHd0WmU7id05ouSfw4PFw2nJt_gLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 12:53 PM, Oskar Senft wrote:
>> Ah, using the node name as indication for both sensor type and
>> index ? SGTM, though we'd really need input from Rob.
>> I guess one could also consider something more generic like
>> "temperature-sensor@0", "voltage-sensor@0", and so on (instead
>> of [mis-]using reg and a sensor-type field).
> 
> Hmm, in that case, maybe we should just remove the "sensors" section.
> 
> i2c {
>      #address-cells = <1>;
>      #size-cells = <0>;
> 
>      nct7802@28 {
>          compatible = "nuvoton,nct7802";
>          reg = <0x28>;
>          #address-cells = <1>;
>          #size-cells = <0>;
> 
>          temperature-sensor@0 { /* LTD */
>              status = "okay";
>              label = "my local temperature";
>          };
> 
>          temperature-sensor@1 { /* RTD1 */
>              status = "okay";
>              mode = <0x2>; /* 3904 transistor */
>              label = "other temperature";
>          };
> 
>          temperature-sensor@3 { */ RTD3 */
>              status = "okay";
>              mode = <0x3>; /* thermal diode */
>              label = "3rd temperature";
>         };
>     };
> };
> 

I think there was a reason for "sensors", because there can be other
bindings on the same level. Documentation/devicetree/bindings/hwmon/ltc2978.txt
lists "regulators", for example.

Where did you find the "sensors" example for ltc2978 ? I don't see it
in the upstream kernel. Or was that derived from the official "regulators"
bindings ?

> Now, with "sensors" removed and everything at "top-level", we'll need
> to decide what to do if individual sensors are missing. I guess in
> that case I would just leave the affected sensors alone, i.e. neither
> configure nor disable them and instead read their status from HW. That
> way prior uses of the nct7802 in device trees will continue to behave
> as before as does the EEPROM-style configuration.
> 
> I would like to focus on the implementation of the temperature-sensor
> entries for now (i.e. LTD, RTD1, RTD2, RTD3). Support for other sensor
> types could be added in a separate change. Would that be acceptable?
> 

Yes, let's do that. I'd like us to keep the "sensors" subnode to have a clear
association and differentiator to other sub-nodes such as "regulators".
Open is if we can use "temperature-sensor@0" or if it would have to be
a chip specific "ltd", but I think we can sort that out after suggesting
an initial set of bindings to Rob.

Thanks,
Guenter
