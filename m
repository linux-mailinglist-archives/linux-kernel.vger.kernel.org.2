Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380F83B5F73
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhF1N6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhF1N6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:58:52 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8130C061574;
        Mon, 28 Jun 2021 06:56:26 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id o13-20020a9d404d0000b0290466630039caso3625974oti.6;
        Mon, 28 Jun 2021 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MlExkp7hP/ylcrzSxL7T+dFTODfyxl0iT59Y7w//6AI=;
        b=PNCFkZdjcjZ3XtS8w2YFVrtLgcKI/EFdDyvCxgjOS+ctap0ccxNMlhF4Cy+YRzm+GX
         qApU/qgxnokyePZEhsKCUuRjwXPD0gmHmh5l3v/OJVoUNEbr7n4Ufn001SgBJl7TVw2z
         1/29AAY/A29+WhFvFeX1biGb71YYdwq412ZJB+/dNGIT6+Zey5l4ecqrezi3JNQ6xOwe
         nlMdcqlmoWobYRas1Ge1zr9V/GIymXSB9yQ9aJI0xC1XOl8O4Z+KzZuwvZ7lBYQIyslh
         wAOWmTnAPpevqNBHw1tPfDXyiqPDIA2ekQJlAnLkQ3DT/YsH5SryerD7phAX9DZGSo0m
         kt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MlExkp7hP/ylcrzSxL7T+dFTODfyxl0iT59Y7w//6AI=;
        b=eW/Kbt5u23uPzTC79xA2RU7E76d5JNZxkbMEoEBsMSLFRnNj9guWTRzlr/2caCIQji
         kudcWDlWKJ070pUlVOXWIw96iQgSxWzjunSgGzUlGOMC+NSVuTDcdF184crS1HcKRfpw
         OjWx265BjNin8bLYSEfoGKvDtgmlZM/hbsVAWP18jLCsoSv/TBgdKnGFzhUmJZM2QCCj
         Uc64uMDAn1clp37/T5bCkcnGapN3j3PbKzAMwfEZYDJxd+Vytaw2idJqc6oYNBCpwluP
         tWHPH5akZZWPExzfEF57JvFtbTUQJvuzkTOjNE8jfg+EDgvm4i5oJ9EXjdDvyPXrtl6C
         Xcuw==
X-Gm-Message-State: AOAM532C6UdPB1BQInwlFn0oLZDKRXgpK2fhkHvjZ/gKExtNqi6cfJ62
        l5KjvzG1099Iu542n8XNzk8=
X-Google-Smtp-Source: ABdhPJz7CrhyeVBx+daUx8mvU1U+EBy6hdRC8vefO5jyXcZa8GFDHCgAnMmsF0F6kyEPv3CbPjFwjA==
X-Received: by 2002:a9d:6545:: with SMTP id q5mr22048969otl.268.1624888586144;
        Mon, 28 Jun 2021 06:56:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j14sm3447071otn.18.2021.06.28.06.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 06:56:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
References: <20210624035821.25375-1-billy_tsai@aspeedtech.com>
 <20210624124428.GB1670703@roeck-us.net>
 <51093C5F-61E2-4155-9C9A-035E330AEA1E@aspeedtech.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (aspeed-pwm-tacho) Using falling edge.
Message-ID: <43b0c30c-949a-8a6f-268f-c2a550fca30d@roeck-us.net>
Date:   Mon, 28 Jun 2021 06:56:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <51093C5F-61E2-4155-9C9A-035E330AEA1E@aspeedtech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/21 8:35 PM, Billy Tsai wrote:
> On 2021/6/24, 8:44 PM, "Guenter Roeck" <groeck7@gmail.com on behalf of linux@roeck-us.net> wrote:
> 
>      On Thu, Jun 24, 2021 at 11:58:21AM +0800, Billy Tsai wrote:
>      >> The tach shouldn't use both edges to measure. When the tach input
>      >> duty cycle isn't 50% the return value will inaccurate.
>      >>
>      > A tachometer doesn't have a duty cycle. A pwm has a duty cycle, but that
>      > is completely independent of the pwm duty cycle used to set the fan speed.
>      > So this patch does not really make sense with the above explanation.
> 
> The duty cycle means the waveform that reported from the fan tach pin not pwm signal.
> 
>      > The impact of this patch is likely that the reported fan speed is reduced
>      > by 50%. It may well be that the driver currently reports twice the real fan
>      > speed. I have no idea if that is the case, but if it is it should not be
>      > conditional. The description above states "when the tach input cycle isn't
>      > 50%", suggesting that this is conditional on some other configuration.
>      > I don't know what that might be either.
> 
> According to the tach mode, our tach controller will sample the time of once conditional meet and translate it to tach value.
> When the tach signal duty cycle isn't 50%, using both edges mode will get the tach value with error rate.
> In addition, the current report value of both edges will twice the result which will enlarge the error rate.
> Actually, the tach signal won't be a complete 50% duty cycle, so both edges mode isn't recommanded for the fan usage.
> With rising-to-rising mode the skew time of tach signal will also effect the accuracy.
> Thus, using the falling-to-falling mode is the better way for a fan tach monitor.
> But for flexibility, I think using dts property to control the tach mode is better the user can change the mode to adapter the monitor device.
> 

Trying again, using my own words.

A fan normally provides two short pulses per revolution. Those are short
puleses, and one does not typically talk about "duty cycle" or "waveform"
in this context. The driver currently counts both edges of those pulses.
Assuming that a fan reports, say, 1,000 pulses per minute, the hardware
would report a edle count of 2,000. This should translate into 500 RPM.
I don't know if this is currently the case in the driver; if not, it would
be a bug. Either case, the suggested change would reduce the pulse count
reported by the hardware to 1,000. If we assume that the driver currently
translates this correctly to 500 RPM, the suggested change would result
in the driver reporting 250 RPM, which would be wrong.

So there are two possibilities:
1) The driver currently reports 1,000 RPM in this situation. This would be a bug
    which needs to get fixed.
2) The driver currently correctly reports 500 RPM. In this case, the suggested
    patch would introduce a bug because the code is not adjusted for the reduced
    pulse count.

The problem is that the patch does not address either of the situations above.
In case 1), it should state that the code currently reports twice the real
fan speed, and that the patch fixes that problem. In case 2), the patch should
also fix the arithmetic used to calculate RPM from the pulse count.

Either case, I disagree that this should be handled in devicetree. It has
nothing to do with hardware description or configuration but is in the
discretion of the driver author/implementer.

Guenter
