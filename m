Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98423B7308
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 15:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhF2NRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 09:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbhF2NRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:17:31 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA87C061760;
        Tue, 29 Jun 2021 06:15:03 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id m6-20020a9d1d060000b029044e2d8e855eso20635186otm.8;
        Tue, 29 Jun 2021 06:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cjpoeExDVoTQk33TVGG8V5XenOGECJoUHQ3xv8jXV0g=;
        b=Lduf+YRFSGDZRfa99b12nFYZp6MB40Cfj2CasYH9jDlr7Oj390Z81FUd97KiMfwVwq
         tRfpVbBXZcn9vdYT25uIWwo0zgZA5e0XCrhwQFX8I43IDNUUC0ijNl8ezZhwcsEw2lc1
         ygs4Xig3fPIfjtAjq1PlmEgrbity+55v6lLFSbwqS9T6HCRZktdPvXpp6+0dT2+cax2o
         ui90fHHVb86IZ+g2JIOljcQiX5VQV9+pYZPUPvuBU2+gAHXijE5Cro4iFZ+B1rxQQ6yR
         YjY1w6bVSfTF4JNqPgGrrFf+cJH/vhRYmYasxdh9JRNF8S/jN5U2RKxmLdnkf/SAxh4V
         Y+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cjpoeExDVoTQk33TVGG8V5XenOGECJoUHQ3xv8jXV0g=;
        b=Tq0PB+o/g13QusmzfLlAvO8JuHMvf/c+vDGzO2RI3FojcLRLJUh7TB1m6DMeDjngAF
         OkHtWX3cn9I/HznMkWafvZgx7u0iN2R++wxnqWwVBDLlvjW7VhRYuK90IcZ/gbyysIAZ
         l0xbevex1aknzi01uOYx8c4wr9+AhCLXQCDiL9xhNViAZujR3kW36rTQwn5WIsNGuFNI
         UrLXYLcgpmqJ/KuPU7KhWdd1t9oGDFynCgfgVC43KZfZ3iQ8t7bqYTBSgwEhaa/vwqw/
         oSUEuQihbuh0qx5G4ok8nwSZ1apeFjUFJh0uN8AQT1AwHquPG35aGaRhCRrDGfEKuRMg
         ITbw==
X-Gm-Message-State: AOAM5329gMnvHgja+jJ5gqfylYtsA0xxh9V6xJvpsPnkClfWk6fkRwEx
        Iv9xupaw53Muu0sPRHOKBA6ys+5mGOc=
X-Google-Smtp-Source: ABdhPJyRlNpLuQzVgJPWzuF5+Swtehe2Queq7hf5wR6XIiXzHXha2ry0XkD9BP4hjRW3rLAqNKkdQw==
X-Received: by 2002:a9d:57cc:: with SMTP id q12mr4695576oti.286.1624972502363;
        Tue, 29 Jun 2021 06:15:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o24sm4113745otp.13.2021.06.29.06.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 06:15:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: (aspeed-pwm-tacho) Using falling edge.
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
 <43b0c30c-949a-8a6f-268f-c2a550fca30d@roeck-us.net>
 <9CFDB695-1F7C-4B80-8AF9-A591C4D38813@aspeedtech.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d1b66816-b74b-a846-06e3-4f3720bcccec@roeck-us.net>
Date:   Tue, 29 Jun 2021 06:14:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9CFDB695-1F7C-4B80-8AF9-A591C4D38813@aspeedtech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/21 10:26 PM, Billy Tsai wrote:
> On 2021/6/28, 9:56 PM, "Guenter Roeck" <groeck7@gmail.com on behalf of linux@roeck-us.net> wrote:
> 
>      On 6/24/21 8:35 PM, Billy Tsai wrote:
>      >   > On 2021/6/24, 8:44 PM, "Guenter Roeck" <groeck7@gmail.com on behalf of linux@roeck-us.net> wrote:
>      >   >
>      >   >      On Thu, Jun 24, 2021 at 11:58:21AM +0800, Billy Tsai wrote:
>      >   >      >> The tach shouldn't use both edges to measure. When the tach input
>      >   >      >> duty cycle isn't 50% the return value will inaccurate.
>      >   >      >>
>      >   >      > A tachometer doesn't have a duty cycle. A pwm has a duty cycle, but that
>      >   >      > is completely independent of the pwm duty cycle used to set the fan speed.
>      >   >      > So this patch does not really make sense with the above explanation.
>      >   >
>      >   > The duty cycle means the waveform that reported from the fan tach pin not pwm signal.
>      >   >
>      >   >      > The impact of this patch is likely that the reported fan speed is reduced
>      >   >      > by 50%. It may well be that the driver currently reports twice the real fan
>      >   >      > speed. I have no idea if that is the case, but if it is it should not be
>      >   >      > conditional. The description above states "when the tach input cycle isn't
>      >   >      > 50%", suggesting that this is conditional on some other configuration.
>      >   >      > I don't know what that might be either.
>      >   >
>      >   > According to the tach mode, our tach controller will sample the time of once conditional meet and translate it to tach value.
>      >   > When the tach signal duty cycle isn't 50%, using both edges mode will get the tach value with error rate.
>      >   > In addition, the current report value of both edges will twice the result which will enlarge the error rate.
>      >   > Actually, the tach signal won't be a complete 50% duty cycle, so both edges mode isn't recommanded for the fan usage.
>      >   > With rising-to-rising mode the skew time of tach signal will also effect the accuracy.
>      >   > Thus, using the falling-to-falling mode is the better way for a fan tach monitor.
>      >   > But for flexibility, I think using dts property to control the tach mode is better the user can change the mode to adapter the monitor device.
>      >   >
> 
>      >   Trying again, using my own words.
> 
>      >   A fan normally provides two short pulses per revolution. Those are short
>      >   puleses, and one does not typically talk about "duty cycle" or "waveform"
>      >   in this context. The driver currently counts both edges of those pulses.
> 
> Our tach controller will count how many tach clocks in those shot pulses.
> In both edge mode the counting period only half of the pulse. Thus, it is more sensitive
> to the signal quality of the shot pulse when using both edges mode.
> 
>      >   Assuming that a fan reports, say, 1,000 pulses per minute, the hardware
>      >   would report a edle count of 2,000. This should translate into 500 RPM.
>      >   I don't know if this is currently the case in the driver; if not, it would
>      >   be a bug. Either case, the suggested change would reduce the pulse count
>      >   reported by the hardware to 1,000. If we assume that the driver currently
>      >   translates this correctly to 500 RPM, the suggested change would result
>      >   in the driver reporting 250 RPM, which would be wrong.
> 
>      >   So there are two possibilities:
>      >   1) The driver currently reports 1,000 RPM in this situation. This would be a bug
>      >       which needs to get fixed.
>      >   2) The driver currently correctly reports 500 RPM. In this case, the suggested
>      >       patch would introduce a bug because the code is not adjusted for the reduced
>      >       pulse count.
> 
>      >   The problem is that the patch does not address either of the situations above.
>      >   In case 1), it should state that the code currently reports twice the real
>      >   fan speed, and that the patch fixes that problem. In case 2), the patch should
>      >   also fix the arithmetic used to calculate RPM from the pulse count.
>      >   Either case, I disagree that this should be handled in devicetree. It has
>      >   nothing to do with hardware description or configuration but is in the
>      >   discretion of the driver author/implementer.
> 
> The driver doesn't have the two situations you describe, it already considers the different
> sampling modes at the arithmetic. The patch is used to make users have the option to select
> the mode not just fix it to the both edges mode.
> 

Thanks for the explanation. Please include that in the patch description, and please avoid
unusual terms such as "duty cycle" or "waveform".

Thanks,
Guenter


