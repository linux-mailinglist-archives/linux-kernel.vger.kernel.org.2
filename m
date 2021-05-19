Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA56E388A66
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343616AbhESJVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344889AbhESJV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:21:27 -0400
X-Greylist: delayed 593 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 May 2021 02:20:07 PDT
Received: from office2.cesnet.cz (office2.cesnet.cz [IPv6:2001:718:1:101::144:244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9082C061761;
        Wed, 19 May 2021 02:20:07 -0700 (PDT)
Received: from localhost (ip-78-45-210-72.net.upcbroadband.cz [78.45.210.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 0494340006B;
        Wed, 19 May 2021 11:10:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1621415411;
        bh=9rJ9Z+mUNNZ52JFny7dcqpzdc+w+PhUPqEWe2Fkq+q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kF8lDyIUmSNtkj7mUmPHN3fqM9GHcen9DMX0qrvhbixtFGhX9k0ZJlbdJrLedA94E
         kJSV7U1lRgRItH5F5cmgo/wtIIbR6fWiVP+ZXPfgku8CZBB5r6udXk4m6OmUGV1Ov8
         0KZm1im+4Xb9P0xPgET7uojaDP/fLMtkIrdctHFOvVYRqe3shpyCEkxaEI0vOmHYuC
         vOBoQPiLTtSHLZhqGvCWIsJLO8tPgpmGzqlpsaKJdGQRli0mja7CwaE5yuY8p/7Wma
         Xj6Amx86ZWHZhm4500rBqHIE4gkUyB9+uvC3fSGn0gebsLu0nHHWL12Oeeg3pyXtdH
         vHFaRE7ftWlOw==
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     =?iso-8859-1?Q?V=E1clav_Kubern=E1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/5] hwmon: (max31790) Fix and split =?iso-8859-1?Q?pwm*=5Fenable?=
Date:   Wed, 19 May 2021 11:10:10 +0200
MIME-Version: 1.0
Message-ID: <6f256c72-df4d-4f9a-ba5f-eabfd9f2365f@cesnet.cz>
In-Reply-To: <20210518211609.GA3532746@roeck-us.net>
References: <20210518211609.GA3532746@roeck-us.net>
Organization: CESNET
User-Agent: Trojita/unstable-2020-07-06; Qt/5.15.2; xcb; Linux; 
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> As it turns out, even the current code doesn't really work for fans 7..12.
> =09=09sr =3D get_tach_period(data->fan_dynamics[channel]);
> However, the data->fan_dynamics array has only 6 entries, not 12, so
> reading fan[7-12]_input will result in bad/random values.

Hi Guenter, I'm Vaclav's colleague. The chip can indeed reconfigure each=20
PWMOUT pin either as a PWM output or as a TACH input, but that's not=20
something that's correctly implemented in the current code, and we have no=20=

use for that either (and we cannot test that on our PCBs easily, we do not=20=

have the manufacturer's eval kit).

It looks to me that the original bug is that the current docs mention 12=20
fan inputs. Would you be OK with a patch series which fixes the docs so=20
that the chip always exports 6 TACH inputs and 6 PWMOUT channels?

Cheers,
Jan
