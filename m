Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CDE32E7C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 13:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhCEMSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 07:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCEMSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 07:18:36 -0500
X-Greylist: delayed 605 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Mar 2021 04:18:36 PST
Received: from office2.cesnet.cz (office2.cesnet.cz [IPv6:2001:718:1:101::144:244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD1EC061574;
        Fri,  5 Mar 2021 04:18:36 -0800 (PST)
Received: from localhost (ip-94-112-197-160.net.upcbroadband.cz [94.112.197.160])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id A7734400064;
        Fri,  5 Mar 2021 13:08:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1614946108;
        bh=PrDtuf4GNCuIf4buOVLl6wJYuOH+X5xKlXypeeu9GN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jgMNm3hO/+H22rHcWQrHZDE5HcGXkdemAE/4whSzhI9xjMwYTSkINWYN89nyItky4
         OzxeArZsGPHPWOg/XhpUtCsHX4Vy7uPsLVANoUwsmtoRbdBhgU8xp766Kj8387QpVo
         gKvKYTNpYTT+uuhECJuAjZYZMoAJ3dyhvgjiR1hcO18yTQ10mmqJfKjMZij/iyMhPx
         roMUNtx5JCMcmsV3SyMYi2ChexAPKT6PilPTXQTkDASgAHH98p1ecD1YSHZqwgCbQ/
         JqDZPGNN2A/R7UEAJuJuRf9q914i1Lf740OWM1D7z9jZ5EcYM8H5qxhKxQ63XKKCmk
         rEZV7l2wo6gdQ==
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     =?iso-8859-1?Q?V=E1clav_Kubern=E1t?= <kubernat@cesnet.cz>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] hwmon: (max31790) Allow setting pulses
Date:   Fri, 05 Mar 2021 13:08:26 +0100
MIME-Version: 1.0
Message-ID: <ad1c3054-e9a2-4299-aeed-94e36d6d3d12@cesnet.cz>
In-Reply-To: <20210304105830.507176-3-kubernat@cesnet.cz>
References: <20210304105830.507176-1-kubernat@cesnet.cz>
 <20210304105830.507176-3-kubernat@cesnet.cz>
Organization: CESNET
User-Agent: Trojita/unstable-2020-07-06; Qt/5.15.2; xcb; Linux; 
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -285,6 +295,9 @@ static int max31790_write_fan(struct device=20
> *dev, u32 attr, int channel,
>  =09=09=09=09   MAX31790_REG_FAN_CONFIG(channel),
>  =09=09=09=09   data->fan_config[channel]);
>  =09=09break;
> +=09case hwmon_fan_pulses:
> +=09=09data->pulses[channel] =3D val;
> +=09=09break;

This needs input validation, otherwise it's possible to write 0 in there=20
and you get a division-by-zero in the kernel context:

[102109.999968] Division by zero in kernel.
[102110.003917] CPU: 1 PID: 27590 Comm: cat Not tainted 5.9.3-cla-cfb #42
[102110.010462] Hardware name: Marvell Armada 380/385 (Device Tree)
[102110.016497] [<c010f16c>] (unwind_backtrace) from [<c010ae40>]=20
(show_stack+0x10/0x14)
[102110.024355] [<c010ae40>] (show_stack) from [<c083ba30>]=20
(dump_stack+0x94/0xa8)
[102110.031689] [<c083ba30>] (dump_stack) from [<c083a3fc>]=20
(Ldiv0+0x8/0x2c)
[102110.038499] [<c083a3fc>] (Ldiv0) from [<c064c1ac>]=20
(max31790_read+0x174/0x204)
[102110.045836] [<c064c1ac>] (max31790_read) from [<c0646fdc>]=20
(hwmon_attr_show+0x44/0x138)
...

A similar error can also happen when setting the fan speed to 0 RPM.=20
That's, however, not an error caused by this patch series AFAIK. I *think*=20=

that RPM_TO_REG should be changed to check if `rpm` is 0, and if so, set=20
the register directly to the maximal value of 0x7ff (in another patch).

With kind regards,
Jan
