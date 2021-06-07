Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAD239D99E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFGK32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:29:28 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:34728 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhFGK3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:29:25 -0400
Received: by mail-ed1-f51.google.com with SMTP id cb9so19723036edb.1;
        Mon, 07 Jun 2021 03:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AGZ4t2IZtx3vp84RivJkuklm+6Eclk4GjnQsNM+4cwY=;
        b=IS3GHMuZYXL3+6Tp4HPoZ5enuZ34IX8rZx2bRRf3MRngY5SdMvqqyyTLauV6wTei4t
         C7JQ4cCpmCYUBwB2crFj3iMZiV8CRQbiecT5xc023UvriaSRz3G7D9oRBmxTGlF0nrK7
         JG5DHCRKB3qm+6bqzzyKdJ+YT62SfWJM6IYWs5IIi2c+K9aqKvJuz3AaxynldiALf9Za
         1htKh5RKL8eT1x7MQTi0kQZ2QscmWOS+y9Lcl8d8QANYTaUqp+xU4kOOj0wnqKnmQaCu
         9qdSCE+sC11TkIuoigCgaihtiYzOgFdPBe6hmIySmOGUQNJgDdI6j+VlSsE6P8pxSwNY
         4KKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AGZ4t2IZtx3vp84RivJkuklm+6Eclk4GjnQsNM+4cwY=;
        b=s5WXihdBx+hQhLaKEYsY8PP18mPQHziPaY51Et7CZ6em2A+WXhReMnMdU7fkTpzNFO
         MBZgviQSnP3NnyxPvG2a3PccfA4hzaPclrVriGJsn0nR2hAOvAESZzhl38x3ywP3jYI+
         Rg54sjTupjkmwz155wRXJekavc3uGLk/KyNJDCHxjsYoKQ50doMO18l0tjWe+kQrndPY
         a/4o2hB/whv6Hu0PAtRh1VxPxbIr9LSPmrEnBSn06zBJza3wE5/W515WJZ7TiLw+6est
         YRo5fpPAoztYzKClSH+RiWGKdaXdfDeIoyd9wLAjiKpGYc8kbKNXpsAq2gQ8vraZ4rHa
         umwQ==
X-Gm-Message-State: AOAM530it5SaxxMYguXkLhjWKAetcEbCZAeo8mmte7k7hmJZMl5snCVt
        P8ul/5+3wAsluP/POVz8Z4F8rVA3Ql3tlg==
X-Google-Smtp-Source: ABdhPJwt9PZQnrBzAZKmGKFQd+/M6Fgc5w5oXTXIOm+4MqVHgd1hcmvdZtyVj7q18+t6XZkD60piZA==
X-Received: by 2002:a50:9d8d:: with SMTP id w13mr19185406ede.94.1623061584372;
        Mon, 07 Jun 2021 03:26:24 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h6sm3973285edj.91.2021.06.07.03.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 03:26:24 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: add EEPROM node for NanoPi R4S
To:     wens@kernel.org
Cc:     Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Marty Jones <mj8263788@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210607081727.4723-1-cnsztl@gmail.com>
 <9258ab23-ef65-2c3d-f0d2-ca5f77d7c12a@gmail.com>
 <CAGb2v65ck=LV+UCdQoaUtEjFaTaHr9-wmGmpkCCkebUOuYtikw@mail.gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <f085da86-8b6d-ba99-2d0a-736ec02424db@gmail.com>
Date:   Mon, 7 Jun 2021 12:26:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v65ck=LV+UCdQoaUtEjFaTaHr9-wmGmpkCCkebUOuYtikw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

On 6/7/21 11:40 AM, Chen-Yu Tsai wrote:
> On Mon, Jun 7, 2021 at 5:31 PM Johan Jonker <jbx6244@gmail.com> wrote:
>>
>> Hi Tianling,
>>
>> On 6/7/21 10:17 AM, Tianling Shen wrote:
>>> NanoPi R4S has a EEPROM attached to the 2nd I2C bus (U92), which
>>> stores the MAC address.
>>>
>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>>> ---
>>>  arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
>>> index cef4d18b599d..4a82f50a07c5 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
>>> @@ -68,6 +68,15 @@
>>>       status = "disabled";
>>>  };
>>>
>>> +&i2c2 {
>>> +     eeprom@51 {
>>> +             compatible = "microchip,24c02", "atmel,24c02";
>>> +             reg = <0x51>;
>>> +             pagesize = <16>;
>>
>>> +             read-only; /* This holds our MAC */
>>
>> The mainline dts files should be generic I think.
>> Any comment about "use", partitions or write ability should be avoided.
>> It's up the user.
> 

> Per the datasheet for this specific EEPROM, the latter half (128 bytes)
> is read-only in hardware by design though.

The 24AA02XEXX is programmed at the factory with a
globally unique node address stored in the upper half
of the array and permanently write-protected. The
remaining 1,024 bits are available for application use.

Just a question...

    nvmem-cells = <&mac_address>;
    nvmem-cells-names = "mac-address";

Which part does this point to?

Can we use the lower part to store/rewrite this too?

===

From at24.yaml:

            items:
              - pattern:
"^(atmel|catalyst|microchip|nxp|ramtron|renesas|rohm|st),(24(c|cs|lc|mac)[0-9]+|spd)$"
              - pattern: "^atmel,(24(c|cs|mac)[0-9]+|spd)$"

How does Microchip 24AA025E48 fit the regex?
What compatible would you advise?

===

Johan

> 
> ChenYu
> 
