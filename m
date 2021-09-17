Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B24540F3FD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbhIQIW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbhIQIW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:22:56 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7583EC061574;
        Fri, 17 Sep 2021 01:21:34 -0700 (PDT)
Received: from [IPv6:::1] (unknown [IPv6:2a02:810c:c200:2e91:60e0:68ce:cb75:b798])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 12A8C221E6;
        Fri, 17 Sep 2021 10:21:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1631866889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nnc+HY8a4/een0W4N4RVJwoWUUFXT3UU5FvOqYxu5fo=;
        b=Fpb0gnQGHSui0beRgFelwfi/m11KMrP+aRet+Ieb6etkH55CoVi7tlIx1ZbjU6QlsOXA42
        P+AuYmrQAMnoX/JVanUgphU351p/SM8PdmAdJjmh8JZ9TKrC3zAsD1w5yqfWBWO3N9CoDk
        e2S8NAz0DVLJbILfpEYwxOSZJJ0GItE=
Date:   Fri, 17 Sep 2021 10:21:25 +0200
From:   Michael Walle <michael@walle.cc>
To:     Heiko Thiery <heiko.thiery@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
CC:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?ISO-8859-1?Q?Guido_G=FCnther?= <agx@sigxcpu.org>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_arm64=3A_dts=3A_imx8mm-kontron-n8?= =?US-ASCII?Q?01x-som=3A_do_not_allow_to_switch_off_buck2?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAEyMn7ZbJr0_2Phc2rW7sDYQu4AABWPZ1F7xDgaS5U7ha7iqzA@mail.gmail.com>
References: <20210915120325.20248-1-heiko.thiery@gmail.com> <7e7ee4244ababc0a46e0875222c7e37d@walle.cc> <898fd5e0-2073-3689-89b6-2c5071773786@kontron.de> <CAEyMn7ZbJr0_2Phc2rW7sDYQu4AABWPZ1F7xDgaS5U7ha7iqzA@mail.gmail.com>
Message-ID: <3EDFF987-82C2-4B0A-9488-037D1BD4CA48@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 17=2E September 2021 09:28:51 MESZ schrieb Heiko Thiery <heiko=2Ethiery@=
gmail=2Ecom>:
>Hi Frieder,
>
>Am Mi=2E, 15=2E Sept=2E 2021 um 14:09 Uhr schrieb Frieder Schrempf
><frieder=2Eschrempf@kontron=2Ede>:
>>
>> On 15=2E09=2E21 14:05, Michael Walle wrote:
>> > Am 2021-09-15 14:03, schrieb Heiko Thiery:
>> >> The buck2 output of the PMIC is the VDD core voltage of the cpu=2E
>> >> Switching off this will poweroff the CPU=2E Add the 'regulator-alway=
s-on'
>> >> property to avoid this=2E
>> >
>> > Mh, have this ever worked? Is there a commit which introduced a regre=
ssion?
>>
>> Yes, this did work before, even without 'regulator-always-on'=2E I
>> currently don't understand why this is needed=2E The regulator is
>> referenced in the CPU nodes as 'cpu-supply'=2E This should be enough to
>> not disable it as long as the CPU is up=2E
>
>I rechecked that with 5=2E11, 5=2E10 and 5=2E9 and I see on all of them t=
he
>same issue:
>
>[ 31=2E716031] vdd-5v: disabling
>[ 31=2E719032] rst-usb-eth2: disabling
>[ 31=2E722553] buck2: disabling
>
>While on that I tried to compare with other boards and see that they
>also have the cpu-voltage marked as "regulator-always-on"=2E The only
>exception in dts/freescale is in imx8mq-librem5-devkit=2Edts [1] that
>has not set this property=2E
>
>I agree with you and don't understand why this is happening=2E Has
>anyone else an explanation?

Do you have the CPU frequency scaling driver enabled?=20

-michael

