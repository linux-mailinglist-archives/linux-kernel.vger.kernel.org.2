Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DB83FDDE2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 16:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245303AbhIAOlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 10:41:22 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:40969 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbhIAOlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 10:41:18 -0400
Date:   Wed, 01 Sep 2021 14:39:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630507188;
        bh=GNaZ0XSxNT6YGfxq9tw2v+9H4+dnjpkUDJcg9FUrbAQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=dRYrBefGx9SXwXn8u7BFhiUtgh3E1gt8gM/4fpGtqbyS0wYB1I5//pGJRcFLua3R0
         dbnI8y9FjMDNTxXyI+Irnv3dwdImBtlUfDZh3EYvlcUMVyIOSYOqKuZ3ivc9RTVATn
         /Dn4syyOaT6zt5RsGeq5ZIL05yvuaNlDoHtCdjyo=
To:     Luke Jones <luke@ljones.dev>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v7] asus-wmi: Add support for custom fan curves
Message-ID: <Dv2UHejQ36ujT_nH9h_F1ZyUmd2_Oc3C9lZW1laK4tMQ6jambRzA7vvthMh_vWH-S9pwqGdJAbrkZJW9oK06Vz9nzyKBYu1r_vzlt7k-mgQ=@protonmail.com>
In-Reply-To: <1Y4PYQ.BFC57KCSOTUT1@ljones.dev>
References: <20210830113137.1338683-1-luke@ljones.dev> <20210830113137.1338683-2-luke@ljones.dev> <1o94oJFiia_xvrFrSPI_zG1Xfv4FAlJNY96x39rg-zX3-3N5Czw4KmTiJtzCy1So7kYXLu0FTkRkmwUUudeuTyLHSsx5sJGhfsZaYrXKEic=@protonmail.com> <1Y4PYQ.BFC57KCSOTUT1@ljones.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Barnab=C3=A1s,
>
> I did another refactor using hwmon_device_register_with_info() and
> HWMON_CHANNEL_INFO(). I'm unsure if this is what you were looking for
> so I'm going to attach the patch instead of submitting as a V8 for now.
>
> My main concern as that the use of the above removes the
> pwm1_auto_point1_pwm + pwm1_auto_point1_temp format and gives two
> hwmon<num>, one per cpu/gpu fan with:
>
> device power
> fan1_input subsystem
> fan2_input temp1_input
> fan3_input temp2_input
> fan4_input temp3_input
> fan5_input temp4_input
> fan6_input temp5_input
> fan7_input temp6_input
> fan8_input temp7_input
> in0_enable temp8_input
> name uevent
>
> cat -p /sys/devices/platform/asus-nb-wmi/hwmon/hwmon7/name
> asus_cpu_fan_custom_curve
>
> I've named the root name of each as descriptive as possible to convey
> exactly what each is
>
> Oh and `sensors` now shows:
>
> asus_cpu_fan_curve-isa-0000
> Adapter: ISA adapter
> fan1: 8 RPM
> fan2: 10 RPM
> fan3: 18 RPM
> fan4: 20 RPM
> fan5: 28 RPM
> fan6: 34 RPM
> fan7: 44 RPM
> fan8: 56 RPM
> temp1: +0.0=C2=B0C
> temp2: +0.1=C2=B0C
> temp3: +0.1=C2=B0C
> temp4: +0.1=C2=B0C
> temp5: +0.1=C2=B0C
> temp6: +0.1=C2=B0C
> temp7: +0.1=C2=B0C
> temp8: +0.1=C2=B0C
>
>
>  > FYI, the pwmX_enable attributes can be created by the hwmon
>  > subsystem itself if you use [devm_]hwmon_device_register_with_info()
>  > with appropriately populated `struct hwmon_chip_info`.
>
> So when you say this, did you mean *just* for the pwmX_enable
> attributes?
> [...]

Yes, that's right.


Best regards,
Barnab=C3=A1s P=C5=91cze
