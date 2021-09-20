Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58ACA411067
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbhITHpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:45:02 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:52861 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhITHpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:45:01 -0400
Received: from [127.0.0.1] (ip-109-43-48-5.web.vodafone.de [109.43.48.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2536522205;
        Mon, 20 Sep 2021 09:43:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1632123810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jG+FiHLnsnQBouOgKZIw3mJf4cZfLDOlFHAh4FbgyyE=;
        b=oTr7dekHcylXJI3ctaSGGEIpcd+KbBzAu3ARkdt7wQG/GvZJ1N5wPBBQ3Ryklgg4KoDEwg
        eEpQwfiIIQ3AzjIPbXL4SPTFdYJmmM8/6j5oPhvHZDbR2WOYLo9Zz2qxeDFFcqYzvIelbr
        l/4gT0v9B1c9BzYsxl9v/5AAyup2k2s=
Date:   Mon, 20 Sep 2021 09:43:23 +0200
From:   Michael Walle <michael@walle.cc>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
CC:     devicetree@vger.kernel.org,
        =?ISO-8859-1?Q?Guido_G=FCnther?= <agx@sigxcpu.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_arm64=3A_dts=3A_imx8mm-kontron-n8?= =?US-ASCII?Q?01x-som=3A_do_not_allow_to_switch_off_buck2?=
User-Agent: K-9 Mail for Android
In-Reply-To: <d618c505-43e6-01a7-4d2a-847dad33b43e@kontron.de>
References: <20210915120325.20248-1-heiko.thiery@gmail.com> <7e7ee4244ababc0a46e0875222c7e37d@walle.cc> <898fd5e0-2073-3689-89b6-2c5071773786@kontron.de> <CAEyMn7ZbJr0_2Phc2rW7sDYQu4AABWPZ1F7xDgaS5U7ha7iqzA@mail.gmail.com> <9bcf7b749dca57d42aa2e7afd88b5a26f3eeff2a.camel@pengutronix.de> <CAEyMn7aa=-UKvUz4pWOWZJbPh7TTgzmDpmNKOTYM5g0G54xU2Q@mail.gmail.com> <d618c505-43e6-01a7-4d2a-847dad33b43e@kontron.de>
Message-ID: <447B96FA-2B75-4C72-A72B-1C1D29137B2C@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20=2E September 2021 09:31:20 MESZ schrieb Frieder Schrempf <frieder=2Es=
chrempf@kontron=2Ede>:
>On 17=2E09=2E21 18:10, Heiko Thiery wrote:
>> Hi Lucas,
>>=20
>> Am Fr=2E, 17=2E Sept=2E 2021 um 13:44 Uhr schrieb Lucas Stach
>> <l=2Estach@pengutronix=2Ede>:
>>>
>>> Am Freitag, dem 17=2E09=2E2021 um 09:28 +0200 schrieb Heiko Thiery:
>>>> Hi Frieder,
>>>>
>>>> Am Mi=2E, 15=2E Sept=2E 2021 um 14:09 Uhr schrieb Frieder Schrempf
>>>> <frieder=2Eschrempf@kontron=2Ede>:
>>>>>
>>>>> On 15=2E09=2E21 14:05, Michael Walle wrote:
>>>>>> Am 2021-09-15 14:03, schrieb Heiko Thiery:
>>>>>>> The buck2 output of the PMIC is the VDD core voltage of the cpu=2E
>>>>>>> Switching off this will poweroff the CPU=2E Add the 'regulator-alw=
ays-on'
>>>>>>> property to avoid this=2E
>>>>>>
>>>>>> Mh, have this ever worked? Is there a commit which introduced a reg=
ression?
>>>>>
>>>>> Yes, this did work before, even without 'regulator-always-on'=2E I
>>>>> currently don't understand why this is needed=2E The regulator is
>>>>> referenced in the CPU nodes as 'cpu-supply'=2E This should be enough=
 to
>>>>> not disable it as long as the CPU is up=2E
>>>>
>>>> I rechecked that with 5=2E11, 5=2E10 and 5=2E9 and I see on all of th=
em the
>>>> same issue:
>>>>
>>>> [ 31=2E716031] vdd-5v: disabling
>>>> [ 31=2E719032] rst-usb-eth2: disabling
>>>> [ 31=2E722553] buck2: disabling
>>>>
>>>> While on that I tried to compare with other boards and see that they
>>>> also have the cpu-voltage marked as "regulator-always-on"=2E The only
>>>> exception in dts/freescale is in imx8mq-librem5-devkit=2Edts [1] that
>>>> has not set this property=2E
>>>>
>>>> I agree with you and don't understand why this is happening=2E Has
>>>> anyone else an explanation?
>>>>
>>>> [1] https://eur04=2Esafelinks=2Eprotection=2Eoutlook=2Ecom/?url=3Dhtt=
ps%3A%2F%2Felixir=2Ebootlin=2Ecom%2Flinux%2Flatest%2Fsource%2Farch%2Farm64%=
2Fboot%2Fdts%2Ffreescale%2Fimx8mq-librem5-devkit=2Edts%23L319&amp;data=3D04=
%7C01%7Cfrieder=2Eschrempf%40kontron=2Ede%7Cce9d266ad78a4d06721008d979f5aee=
d%7C8c9d3c973fd941c8a2b1646f3942daf1%7C0%7C0%7C637674918380815550%7CUnknown=
%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6=
Mn0%3D%7C1000&amp;sdata=3DPsTKX4MXGwvvP6WxmQ1OWc8e32YI6Nsu%2FEkcNR4V8is%3D&=
amp;reserved=3D0
>>>>
>>> Maybe your kernel config is missing the cpufreq driver, so you don't
>>> have a consumer of the regulator?
>>>
>>> Marking the regulator as always-on seems like the right thing to do,
>>> you don't want to depend on a consumer showing up to make sure that
>>> your CPU voltage isn't cut=2E=2E=2E
>>=20
>> shouldn't it be that the node cpu-supply here is a consumer of the
>> referenced voltage?
>
>Yes, but as Michael and Lucas noted, the consumer is only active if the
>cpufreq driver is loaded and we don't want to depend on this=2E In my
>config I always had this compiled into the kernel so I didn't notice
>that the always-on property is missing=2E

Hm=2E So any cpu core voltage has to have the "always-on" property? On any=
 SoC? Shouldn't there be some code to prevent the disabling of the voltage =
if the cpu nodes have a cpu-supply phandle?

-michael

