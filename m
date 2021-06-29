Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124F23B76C9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 19:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbhF2RCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 13:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234094AbhF2RCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 13:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624986006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lvbNyAaXNTQ5069fiqWmGdMCCDHTjfldNskdDQUflO8=;
        b=iMBPB+Rvw0vtMfq8hYDmCssyQYjQmzleJWcZTJ1SF/g9G6xLUODAqm8/lcT3hLY+9odKTN
        Ms+J5yTyPrgbid2PjEGDB6EjGDMIQ3BoiDC2yt0Zb9sJA8oC/WGJEejpIfu6yLydjZgeyc
        vQ5d0iz3rOenRFGd0VdpCNqQgoXD9iw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-rFQdyLYOPZes8KNAoA1VlA-1; Tue, 29 Jun 2021 13:00:04 -0400
X-MC-Unique: rFQdyLYOPZes8KNAoA1VlA-1
Received: by mail-ed1-f70.google.com with SMTP id d5-20020a0564020785b02903958939248aso373489edy.15
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 10:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lvbNyAaXNTQ5069fiqWmGdMCCDHTjfldNskdDQUflO8=;
        b=uXlXfbbaJyYWpadkY6lDO8bxQMNOTEZye2pkpyjYQB2sI6lsFtnzVbj27Wd+24Qul7
         K1cYnZZ2lZZp97q2rbNlH8apJjw+ztFrtQuvn2QeYWJsZUTfZFe/3KonVFJizVJ4MM+d
         BS5jgADrUZM5I00K7U9hgZr3Iipi/mhol4sFDdu6sjzDD2pGOV6cv1mChYJb/MaLO/qV
         qaHHdwA1Oap47C3GeAlhWug6CyA9HhK8OhA6Q99nMYyAFf3a9UHOr4kmUYqL+7RtxaU0
         OMZMJ0/TGAbW/nmJoG0AoKA+dV1NlkrwIR2DXZ3CKiSF6Tx0AzNpZFLHItsg+t+kF3vd
         vp7Q==
X-Gm-Message-State: AOAM5317y2yaDfAfUJmARvCJFNNzYwg4JlqXzDZHjQ6vtMAqIWgP5MlZ
        qlnpdBHNDQCdWHMtBS4vg28aMcQHllYfFMqEb2q0/gqBk50UJgsMCaYFtvmJ8WXbObreSaMs65t
        zFaoEy/olxatHBBvrSMtYzjcR
X-Received: by 2002:a17:906:d20b:: with SMTP id w11mr31393436ejz.242.1624986002980;
        Tue, 29 Jun 2021 10:00:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqRVaEdobduYFFV7UZZexaizEQ7YzvICKGT0JHpiGhiMaEkOSXzTmU+KuaIvfsal9TLSHd+A==
X-Received: by 2002:a17:906:d20b:: with SMTP id w11mr31393419ejz.242.1624986002720;
        Tue, 29 Jun 2021 10:00:02 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id i6sm8489096ejr.68.2021.06.29.10.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 10:00:02 -0700 (PDT)
Subject: Re: [PATCH] mfd: axp20x: Update AXP288 volatile ranges
To:     wens@csie.org
Cc:     Lee Jones <lee.jones@linaro.org>, linux-acpi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Clamshell <clamfly@163.com>
References: <20210626132732.40063-1-hdegoede@redhat.com>
 <CAGb2v64O3w6AGH4V-r6D_Zni-pCW2g7BTTceb4CoeAdowR2KNw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e6bffdd7-20f8-f04c-0c27-09223ce963a0@redhat.com>
Date:   Tue, 29 Jun 2021 19:00:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v64O3w6AGH4V-r6D_Zni-pCW2g7BTTceb4CoeAdowR2KNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the review.

On 6/29/21 4:19 AM, Chen-Yu Tsai wrote:
> Hi,
> 
> On Sat, Jun 26, 2021 at 9:29 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> On Cherry Trail devices with an AXP288 PMIC the external SD-card slot
>> used the AXP's DLDO2 as card-voltage and either DLDO3 or GPIO1LDO
>> (GPIO1 pin in low noise LDO mode) as signal-voltage.
>>
>> These regulators are turned on/off and in case of the signal-voltage
>> also have their output-voltage changed by the _PS0 and _PS3 power-
>> management ACPI methods on the MMC-controllers ACPI fwnode as well as
>> by the _DSM ACPI method for changing the signal voltage.
>>
>> The AML code implementing these methods is directly accessing the
>> PMIC through ACPI I2C OpRegion accesses, instead of using the special
>> PMIC OpRegion handled by drivers/acpi/pmic/intel_pmic_xpower.c .
>>
>> This means that the contents of the involved PMIC registers can change
>> without the change being made through the regmap interface, so regmap
>> should not cache the contents of these registers.
>>
>> Mark the LDO power on/off, the LDO voltage control and the GPIO1 control
>> register as volatile, to avoid regmap caching their contents.
>>
>> Specifically this fixes an issue on some models where the i915 driver
>> toggles another LDO using the same on/off register on/off through
>> MIPI sequences (through intel_soc_pmic_exec_mipi_pmic_seq_element())
>> which then writes back a cached on/off register-value where the
>> card-voltage is off causing the external sdcard slot to stop working
>> when the screen goes blank, or comes back on again.
>>
>> Note the AXP288 PMIC is only used on Bay- and Cherry-Trail platforms,
>> so even though this is an ACPI specific problem there is no need to
>> make the new volatile ranges conditional since these platforms always
>> use ACPI.
>>
>> Fixes: dc91c3b6fe66 ("mfd: axp20x: Mark AXP20X_VBUS_IPSOUT_MGMT as volatile")
> 
> Maybe you want
> 
> Fixes: cd53216625a0 ("mfd: axp20x: Fix axp288 volatile ranges")
> 
> and then list the other one as a prerequisite? Or just list both tags.

I've just listed both for v2 of this patch.

> Should we CC stable on this?

That is not necessary, the fix will automatically get picked up in
the relevant stable series based on the Fixes tag (in my experience).

>> Reported-and-tested-by: Clamshell <clamfly@163.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/mfd/axp20x.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index 3eae04e24ac8..db6a21465594 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -125,12 +125,13 @@ static const struct regmap_range axp288_writeable_ranges[] = {
>>
>>  static const struct regmap_range axp288_volatile_ranges[] = {
>>         regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP288_POWER_REASON),
>> +       regmap_reg_range(AXP22X_PWR_OUT_CTRL1, AXP22X_ALDO3_V_OUT),
> 
> This region also covers the voltage and on/off controls for the buck
> regulators. Maybe include that in your commit message if that was the
> intent, or skip over them if not?

This was intentional I've added the following comment to the commit
msg for v2:

"The regulator register-range now marked volatile also includes the
buck regulator control registers. This is done on purpose these are
normally not touched by the AML code, but they are updated directly
by the SoC's PUNIT which means that they may also change without going
through regmap."

Regards,

Hans




> 
> 
> Thanks
> ChenYu
> 
>>         regmap_reg_range(AXP288_BC_GLOBAL, AXP288_BC_GLOBAL),
>>         regmap_reg_range(AXP288_BC_DET_STAT, AXP20X_VBUS_IPSOUT_MGMT),
>>         regmap_reg_range(AXP20X_CHRG_BAK_CTRL, AXP20X_CHRG_BAK_CTRL),
>>         regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IPSOUT_V_HIGH_L),
>>         regmap_reg_range(AXP20X_TIMER_CTRL, AXP20X_TIMER_CTRL),
>> -       regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
>> +       regmap_reg_range(AXP20X_GPIO1_CTRL, AXP22X_GPIO_STATE),
>>         regmap_reg_range(AXP288_RT_BATT_V_H, AXP288_RT_BATT_V_L),
>>         regmap_reg_range(AXP20X_FG_RES, AXP288_FG_CC_CAP_REG),
>>  };
>> --
>> 2.31.1
>>
> 

