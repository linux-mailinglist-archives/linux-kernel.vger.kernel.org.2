Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3586438ACDC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243613AbhETLuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:50:22 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:40924 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241101AbhETLbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:31:05 -0400
X-Greylist: delayed 94763 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 May 2021 07:31:00 EDT
Received: from localhost (ip-78-45-210-72.net.upcbroadband.cz [78.45.210.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 6BE9D40006B;
        Thu, 20 May 2021 13:29:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1621510164;
        bh=hlH5MiV+pHvEjTzZVRlEtFB7ucGjCHd76P6F/bq75QQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Y499jaLrNQDvGYFs6T1IcIQh63oVg1U0GvxX99UTXLVXpA11kxXA0hp6+oqn4+zi1
         jl4blfDxEiANWLJwJr7nuzIpmsestbwKmXCSPgfwEIyDt7cvb2gDniOQkhTuBI2av3
         6evzJb1+GJTmSneRbst0CNovvWl0LT+w0nFm6OQul6381rNvJuRWODCiM2RmNJlaUA
         IQlCtDSPsCNxywRrrjbBpWWnKg+bXdVSsP9LBeEvJTNaafkZGvNSXKNS1I2atSUs+x
         fkPyOw0wWSizodMaTJ/y4bmGNZV8fTNOR7nA7EXaDDyJQ+VadzelaBzue6GlDhHmxn
         vYIxWZBZdpepw==
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Guenter Roeck <linux@roeck-us.net>,
        =?iso-8859-1?Q?V=E1clav_Kubern=E1t?= <kubernat@cesnet.cz>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/5] hwmon: (max31790) Fix and split =?iso-8859-1?Q?pwm*=5Fenable?=
Date:   Thu, 20 May 2021 13:29:24 +0200
MIME-Version: 1.0
Message-ID: <9bbdc7a7-f34d-4e3a-8e64-c20810456d11@cesnet.cz>
In-Reply-To: <76619e11-3999-1e89-de93-fb5942970844@roeck-us.net>
References: <20210518211609.GA3532746@roeck-us.net>
 <6f256c72-df4d-4f9a-ba5f-eabfd9f2365f@cesnet.cz>
 <76619e11-3999-1e89-de93-fb5942970844@roeck-us.net>
Organization: CESNET
User-Agent: Trojita/unstable-2020-07-06; Qt/5.15.2; xcb; Linux; 
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> As for fan[7-12]_enable, I don't even know if those can be enabled
> separately. I see two options: Drop those attributes entirely (
> assuming that those fan inputs are always enabled if the associated
> pins are configured as inputs), or align them with fan[1-6]_enable.

I think we need to decide first who provides the initial configuration for=20=

this chip. There's always at least six TACH inputs, and then there's six=20
more pins where each can be either a PWM output or a TACH input. Who=20
decides that? Is the kernel supposed to export six knobs to the userspace?=20=

So far, I've assumed that this should be driven via sysfs. But perhaps you=20=

would you like to rely on the FW (?) to set this up properly? (On our=20
board, that would be a few random calls to `i2cset` from a U-Boot boot=20
script. Not pretty, but doable. Just one more place to keep track of.)

It's proabably "tricky" to do this at runtime -- and I don't expect to see=20=

many boards where you have such a big freedom of reconnecting the actual=20
fans once manufactured, anyway. So, either some DT parameters, or an=20
autodetection based on whatever is in the registers at power up, which=20
would make an explicit assumption that "something" has set up the nPWM/TACH=20=

bits properly in the Fan Configuration Register. OK, that might work, but=20
the kernel must not ever reset that chip afterwards.

There's also the Fan Fault Mask register, which controls which fans=20
propagate their failures to the nFAN_FAIL output pin. This one requires a=20
semi-independent control than the nPWM/TACH bit above. It's feasible that=20
not all TACH inputs have an actual fan connected, and this can well vary=20
between products. For example, ours has just four fan connectors, so we=20
don't want "failures" of fans 5 and 6 to assert the nFAN_FAIL pin. Also,=20
there should be a check which prevents unmasking these failures for those=20
TACH channels which are configured as PWM outputs. Or we can once again=20
ignore this one and rely on the FW.

The current kernel code in max31790_read_fan() reads beyond the end of=20
data->fan_dynamics, hitting the content of `fault_status` or `tach` fields=20=

instead, and therefore returning garbage. Not a big deal, just a missing %=20=

operator I guess, but to me, that's a pretty strong suggestion that nobody=20=

has used or even tested monitoring more than six fans on this chip, ever.=20
(And yeah, the datasheet is not clear on how it's supposed to work anyway.=20=

Using a modulo is just a guess.)

Neither Vaclav nor me have any way of testing this feature -- hence my=20
proposal to only improve what we need, and ignore TACH channels 7-12. But I=20=

guess it's not OK from your point of view?

With kind regards,
Jan
