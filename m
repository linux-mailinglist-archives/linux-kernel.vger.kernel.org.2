Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BF8427EAF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 06:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhJJEMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 00:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhJJEMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 00:12:17 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9A4C061762;
        Sat,  9 Oct 2021 21:10:19 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so16986914otj.2;
        Sat, 09 Oct 2021 21:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6E4858d2orjdrSQiha5Y3WBgnHennset4GT8xzXd6F8=;
        b=QDFPaASct9RptqvmaxtqeORNuBq/B0TTdo6SMEM1eYka9w1/KUFx8yqgxMEEc6TSA9
         GWPe+u/xWkftGocQvC2j4ew2w2Gvvf1XaS0DcIkoK4zEcfXp5jXZR6e9FlcDa8pNPD6j
         /wXClERGRWopPDjJ+KW4oPXVr8OM6lkhfChadatqKulinA93CujlAztkm+o4fseaNdbi
         uM7l6ta6mExd0ibc98g99Yvc7K9Kq6svc7ZG8BoqpIFj0CdN9JNykyt1EOvaXgpqJ3hG
         rfEAmHw3G5g3cvoErt0w47BcMn7NbBtL3zIOxubd+xBockfoSrD7g/hb10pqi4/AIAa5
         TEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6E4858d2orjdrSQiha5Y3WBgnHennset4GT8xzXd6F8=;
        b=7Q7qdjwzz91Q6eQsBUzfgMw7PboT65D+CO65v6572mMsQ3So1B57z04uRJoiUHvBlU
         nIA/nhbeIt/hRM14GS+799JYyRY9OUduRNh+gOYb8VxYSgYRd3f9D2Xi42M3EbQbM9Z8
         wRS8lJKGxsQZBq/HV9kG6f9ZTzlgJTY4D/2ut1wBYe5G4cdmf/AZUiz3qiq0D+aqOCKT
         vbbWZjnttKMghTUiDptJx4AB+oTV3D9l0JuPSVi34x0aminD5AbAPRcXTnFwFiW6iuhX
         1KDlGEnZNy342gC5HyXtThW+l5fPANuxil+fiqnO99jAAkOiZDPC0YCDEKUbZ8ZBmHtf
         z+Zw==
X-Gm-Message-State: AOAM530/C1xsHSn+nhDvaNcNqyH3hnjpF91FO+n1rwK++LgkeAab25nh
        bAFIuWiQGDdrVHeqrJqfvFMZNtb0sm0=
X-Google-Smtp-Source: ABdhPJy98qKWYaqED9GpozG805AplEwqWwALxIxtl0yXi9XZd6rEm5RQhWAm2ikMO7o5pyQwoFUJrA==
X-Received: by 2002:a05:6830:922:: with SMTP id v34mr15639087ott.240.1633839018963;
        Sat, 09 Oct 2021 21:10:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l7sm804328oog.22.2021.10.09.21.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 21:10:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add nct7802 bindings
To:     Oskar Senft <osk@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211009185257.2230013-1-osk@google.com>
 <b73b638e-5a24-4960-354d-c8ab5d61c387@roeck-us.net>
 <CABoTLcQBjbW_wtQUo9jdbPbcJJcLaHEA+Oe17bWSCy+_GqOeLg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <bb62fdc5-fea0-333c-3b46-e52cce2fc0c2@roeck-us.net>
Date:   Sat, 9 Oct 2021 21:10:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABoTLcQBjbW_wtQUo9jdbPbcJJcLaHEA+Oe17bWSCy+_GqOeLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/21 8:06 PM, Oskar Senft wrote:
> Hi Guenter
> 
> Thanks again for your review!
> 
>>> Signed-off-by: Oskar Senft <osk@google.com>
>>> ---
>>
>> change log goes here.
> This might be a silly question: I'm using "git send-email", but I
> don't think there's a way to edit the e-mail before it goes out. Do I
> just add "---\n[Change log]" manually in the commit description?
> 

When you use git send-email, you usually have a patch file to send.
I use git format-patch to create that patch file, add the change
log using an editor, and then send it with git send-email.

>>> +description: |
>>> +  The NCT7802Y is a hardware monitor IC which supports one on-die and up to
>>> +  5 remote temperature sensors with SMBus interface.
>>> +
>>
>> Just noticed: 5 remote temperature sensors ? Shouldn't that be 3 ?
> This includes 2 temperature sensors that are queried via PECI (i.e.
> SMBus). I generated the description from the "general description"
> section in the datasheet. I think the driver doesn't implement the 2
> PECI sensors at this time, but the statement about the HW is still
> true.
> 

Ok, make sense.

Thanks,
Guenter

>>> +      sensor-type:
>>> +        items:
>>> +          - enum:
>>> +              - temperature
>>> +              - voltage
>>> +      temperature-mode:
>>> +        items:
>>> +          - enum:
>>> +              - thermistor
>>> +              - thermal-diode
>>> +    required:
>>> +      - reg
>>> +      - sensor-type
>>
>> If I understand correctly, "temperature-mode" is implemented as mandatory
>> for channels 1 and 2 if sensor-type is "temperature" (which makes sense).
>> No idea though if it is possible to express that in yaml.
>> If not, can it be mentioned as comment ?
> 
> After doing a bit more searching, I found the amazing "if: then:
> else:" construct that allows to express this properly and eliminates
> the code duplication. I'll follow up in PATCH v6.
> 
> Thanks
> Oskar.
> 
> 
> 
>>
>>> +
>>> +  channel@2:
>>> +    type: object
>>> +    description: Remote Temperature Sensor or Voltage Sensor ("RTD2")
>>> +    properties:
>>> +      reg:
>>> +        const: 2
>>> +      sensor-type:
>>> +        items:
>>> +          - enum:
>>> +              - temperature
>>> +              - voltage
>>> +      temperature-mode:
>>> +        items:
>>> +          - enum:
>>> +              - thermistor
>>> +              - thermal-diode
>>> +    required:
>>> +      - reg
>>> +      - sensor-type
>>> +
>>> +  channel@3:
>>> +    type: object
>>> +    description: Remote Temperature Sensor or Voltage Sensor ("RTD3")
>>> +    properties:
>>> +      reg:
>>> +        const: 3
>>> +      sensor-type:
>>> +        items:
>>> +          - enum:
>>> +              - temperature
>>> +              - voltage
>>> +    required:
>>> +      - reg
>>> +      - sensor-type
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    i2c {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        nct7802@28 {
>>> +            compatible = "nuvoton,nct7802";
>>> +            reg = <0x28>;
>>> +
>>> +            #address-cells = <1>;
>>> +            #size-cells = <0>;
>>> +
>>> +            channel@0 { /* LTD */
>>> +              reg = <0>;
>>> +              status = "okay";
>>> +            };
>>> +
>>> +            channel@1 { /* RTD1 */
>>> +              reg = <1>;
>>> +              status = "okay";
>>> +              sensor-type = "temperature";
>>> +              temperature-mode = "thermistor";
>>> +            };
>>> +
>>> +            channel@2 { /* RTD2 */
>>> +              reg = <2>;
>>> +              status = "okay";
>>> +              sensor-type = "temperature";
>>> +              temperature-mode = "thermal-diode";
>>> +            };
>>> +
>>> +            channel@3 { /* RTD3 */
>>> +              reg = <3>;
>>> +              status = "okay";
>>> +              sensor-type = "voltage";
>>> +            };
>>> +        };
>>> +    };
>>>
>>

