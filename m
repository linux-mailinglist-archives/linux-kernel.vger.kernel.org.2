Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700F34281F1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 16:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhJJOfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 10:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhJJOfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 10:35:06 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BB1C061570;
        Sun, 10 Oct 2021 07:33:08 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id k2-20020a056830168200b0054e523d242aso8710803otr.6;
        Sun, 10 Oct 2021 07:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2XmoqfFHJaqnS4tTFt5+VRSNF2yHJAScSduBsQ5OA5Q=;
        b=e+ld7uzGcc3eY0iVjdXwNeRggIQi8pN8frDT9tLgwzJwp6Jq1rARpTZbiprwNRCngS
         VrCUmvp6nKAzMh3XlCofzyNrDC6pnWW3SMeVI76ssdLplI28w9RBDd7Fv4yAtyQGofNA
         mzi5cgCslL1U6Y1bdpqBqHpk/ksI8qm5k0DvrAjAOMlOD0OWhpPppJHMwzs2K/NhbjU9
         +BJcxV/rP0VT4FQfq1WgebOGtnn2yKG5QxHftcdOGSw09TEjj3QALWsabyVjsdzwHpOA
         151XT9e9lAybXW0PvPuTRZO7F4UTwjj1kEBvueo3Ww566jcs2/ZublbHIlf7idH6rjtX
         F7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2XmoqfFHJaqnS4tTFt5+VRSNF2yHJAScSduBsQ5OA5Q=;
        b=4jzKHfc5oDuxDyvHfpBIUC5hxLyEpJsxlAeO1Ia/b7tDsvToYxzI0HGxsOpuUBB9Zc
         7HkbsjBOUYCCVQB/wu22JnoFRnKEalDvyKq3hd4NzVMZC52W4DwGTMc8XqvbcMGTuYr+
         h1bLVNarUX2KPzCK9AZ8njBk1Y70GHD+i3oHQr2P6BkeO6LNkJxpxpjmpHMx3U5GvfGw
         t6mml6l066o99u5fUY71cx3OLMBYpRNEA0TIclJxve7iWKDGYZ/Xj5KlzYrl0gKP1yOL
         v/labXuekglPAM0Xh0LTQaYdCSuO5pSzr1EMdMoLh+atiZFwfGpxnQ/cK7FXF8yozQpK
         4x6g==
X-Gm-Message-State: AOAM532O6r8UjFYrUMv2ZDBiV9t8aW9vAZoC3nh/T+0SoGuaKwO8wV4F
        5FOaoY46zrlEhDbA4ChgalLA9tfW/yU=
X-Google-Smtp-Source: ABdhPJxFBjKgo0gZHsXA7r+kx+kv2Qyd1QsDgfQKETLzvwG+NtM0fH6uH3Tocc6qanLMlOSD5sZvIA==
X-Received: by 2002:a05:6830:30a4:: with SMTP id g4mr7469319ots.312.1633876387255;
        Sun, 10 Oct 2021 07:33:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i25sm1171905oto.26.2021.10.10.07.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 07:33:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20211006222502.645003-1-pauk.denis@gmail.com>
 <20211006222502.645003-3-pauk.denis@gmail.com>
 <CAB95QARmjTBVRyru=ZDz9Wc5SX9EPFg7dg6vB+S8=pMtpg8FRw@mail.gmail.com>
 <20211007184644.1d042550@penguin.lxd>
 <CAB95QASYPRZSFnpE5u=SYJ49Hd+=BAZY==Ky8dzjL8h7YZj-CQ@mail.gmail.com>
 <CAB95QAQ+u4DmF0e9Zvy5hDV0mFQDEULtr-newtz5_6y=Bzp+ww@mail.gmail.com>
 <20211010133921.4277dc79@penguin.lxd>
 <CAB95QAQs_PUeTU7d9tg83a8hRepjLfLnxVykU2nvBv3Vn49HBQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/3] hwmon: (asus_wmi_ec_sensors) Support B550 Asus
 WMI.
Message-ID: <8527fb83-4b76-e3c4-85eb-542c1cee249a@roeck-us.net>
Date:   Sun, 10 Oct 2021 07:33:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAB95QAQs_PUeTU7d9tg83a8hRepjLfLnxVykU2nvBv3Vn49HBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/21 6:46 AM, Eugene Shalygin wrote:
> Hi Denis,
> 
> On Sun, 10 Oct 2021 at 12:39, Denis Pauk <pauk.denis@gmail.com> wrote:
>>
>> Hi Eugene,
>>
>> As for me, use WMI methods will be more reliable and cover more
>> motherboards.
> 
> Why do you believe they are more reliable? How does it cover more motherboards?
> 

You said yourself below: "I know the naive reading from the ACPI EC registers
leads to problems (fans get stuck, etc.)".

Something in the WMI code is obviously broken and, ultimately, will need
to get fixed. I don't know if that something is on the ASUS side or on the
kernel side, or on the interface between the two. A single WMI call taking
1 second is way too long and strongly suggests that some timeout is involved.
Not using WMI because of that just seems wrong.

Guenter

> Thanks,
> Eugene
> 
>>
>> Best regards,
>>              Denis.
>>
>> On Thu, 7 Oct 2021 20:11:33 +0200
>> Eugene Shalygin <eugene.shalygin@gmail.com> wrote:
>>
>>> Denis and All,
>>>
>>> regarding the asus-wmi-ec-sensors driver: it uses a WMI method to read
>>> EC registers, and this method is slow (requires almost a full second
>>> for a single call). Maybe I'm doing something wrong, but my impression
>>> is that the WMI calls themselves are that slow. I will try to
>>> reimplement this driver using direct EC operations and the global ACPI
>>> lock with a hope to make it read sensors quicker. If that works out,
>>> perhaps the nct6775 may go the same way, as it suffers too from the
>>> slow WMI calls. I know next to nothing about the ACPI system and learn
>>> from the beginning, so I'm not sure about the result. I know the naive
>>> reading from the ACPI EC registers leads to problems (fans get stuck,
>>> etc.), and if someone with knowledge can assure me that the idea with
>>> the ACPI global lock (as far as I understand it is even implemented in
>>> the ec kernel driver already) is correct, I would even request to stop
>>> accepting the EC WMI sensors driver, as it is so slow (albeit dead
>>> simple and small).
>>>
>>> Best regards,
>>> Eugen
>>>

