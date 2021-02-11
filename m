Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242DA31946F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhBKUZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:25:59 -0500
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:60879 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230039AbhBKUYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:24:09 -0500
X-Greylist: delayed 96500 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2021 15:24:08 EST
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 7ED4C5F9;
        Thu, 11 Feb 2021 15:23:17 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 11 Feb 2021 15:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=OoM33
        ZaM11xFA9cPWmaarY2HSn14dliF5OMriTeEoi8=; b=HKq2JjA9WKYxUfD2FuNzW
        vlH2KsQDy9hQODjhtYmVD3okGegwuGRZlGIOumL8MQEaWONSAa39PI5W/HZuj/mc
        UwF4ilQpyvoayjY9uKxhFaMhMLxcWbtHSWEMhc8xM84YHK8UuSU3MXL92W+oZwYk
        rplOnjH66oJvi6UDkYtYBoMO2ZzywmalC1/WRAIJWdDXm+LfU9B9gZ17lYQma6Og
        W9qjS9Scr8VK3h06TFSWQq0zu/Z8lRTEWjELYT3omuLflkgMK5n9C4+SFosxWXjZ
        AtTbQMp1dIyE9iwPehU9IAW9tENaGjYZqm5L94Y5xiEAouXwlKLvffQrJm4eTI62
        Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=OoM33ZaM11xFA9cPWmaarY2HSn14dliF5OMriTeEo
        i8=; b=ix16WujyMqSeZRW6QvPVtjJ+Jt6ZMAHWtDlOaHwReGpLYMPYL7l7uz/sL
        hJKDFkqfPirAoMla7cFJpR4uVzBIp2v9J91lqY8du2na4xri+9fatAp/68nYKUmn
        goqmuZXYBQWx2V5NlB6s6ueoJpE9hTIFNuCR8AHIwdQFL2mugnvoz9KDW3WWi/Ln
        b7TkFoCZ6nnzXT5VXkkLZfqSl4eQ25nVtecvZ73Y5pb5mIy+X2aDtUrUj7N3DLPO
        5nMZGCiGb0lRizkbaROOSuZvgwvxEVzW/Y1Nhim/Hct/u8qA725ggNiaNZrW0/ai
        nyh4/+xfZjT+0mESH0iiyTFFloXkQ==
X-ME-Sender: <xms:M5IlYJpqXy9CUYYNGLeARPhz_oOa0pQHFGG83w8K7P3mpF7oXSlSwQ>
    <xme:M5IlYLrbVP81-lbuDOMpb0U1LJ3srJbG__cdUUiNJWioRj4PiXkA1CqGKTQLIYFVK
    gG3rHsvtpMEJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheelgddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpehnnhgv
    thcuoehnnhgvthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepueegke
    dvheehveehteeiteduleejvddvtdeivedvueekjefgueehffeuleeugeeunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhnvghtsehfrghsth
    hmrghilhdrfhhm
X-ME-Proxy: <xmx:M5IlYGMCY8dM2OSSe3jPcvAtxfjbiUvw348Al_UcfxSh_ITHUwZbIg>
    <xmx:M5IlYE5idCuzdOFpX1_mH4Z0HsgjioxeK8_ZA1LRngdtscbJNykHXw>
    <xmx:M5IlYI6zC5FCR9WFQe2-ufqBt3gjUENtd-qVdEHAJ1d0rSRA_-FEXA>
    <xmx:NZIlYHRiwl_gLXUhJQeOOpjFN_frXOcLv0UsGXznH7fLKqS9KRezxDic6a0>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2F396A00060; Thu, 11 Feb 2021 15:23:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-141-gf094924a34-fm-20210210.001-gf094924a
Mime-Version: 1.0
Message-Id: <1ad78446-4a40-4c3e-8680-6dbf19616515@www.fastmail.com>
In-Reply-To: <20210211195559.n2j4jnchl2ho54mg@pali>
References: <20210209225630.mdwnzkvnaz3r4blt@pali>
 <a86c5069-d423-44db-92dd-b3e406b7ec91@www.fastmail.com>
 <20210210002619.43104a9b@kernel.org>
 <ac03801e-87e2-4e57-b131-bff52f03579d@www.fastmail.com>
 <1cd0c2ee-aa3a-4da2-9c0c-57cc5a1dad49@www.fastmail.com>
 <a1277b1f-f829-4d02-9e54-68ab4faaa047@www.fastmail.com>
 <20210210092339.qy6wwuq6qr5m2ozr@pali>
 <d6971325-af71-4f71-91c2-7b661804c022@www.fastmail.com>
 <20210210180322.rlfxdussqhejqpo6@pali>
 <966f50f2-68b2-4d4f-85f0-396df112c0f4@www.fastmail.com>
 <20210211195559.n2j4jnchl2ho54mg@pali>
Date:   Thu, 11 Feb 2021 12:22:52 -0800
From:   nnet <nnet@fastmail.fm>
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        a.heider@gmail.com, andrew@lunn.ch, gerald@gk2.net,
        gregory.clement@bootlin.com, kostap@marvell.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, luka.perkov@sartura.hr,
        miquel.raynal@bootlin.com, mturquette@baylibre.com,
        rmk+kernel@armlinux.org.uk, sboyd@kernel.org, tmn505@gmail.com,
        vladimir.vid@sartura.hr
Subject: =?UTF-8?Q?Re:_[PATCH_mvebu_v2_00/10]_Armada_37xx:_Fix_cpufreq_changing_b?=
 =?UTF-8?Q?ase_CPU_speed_to_800_MHz_from_1000_MHz?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021, at 11:55 AM, Pali Roh=C3=A1r wrote:
> On Wednesday 10 February 2021 11:08:59 nnet wrote:
> > On Wed, Feb 10, 2021, at 10:03 AM, Pali Roh=C3=A1r wrote:
> > > > > Hello! Could you please enable userspace governor during kerne=
l
> > > > > compilation?
> > > > >=20
> > > > >     CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
> > > > >=20
> > > > > It can be activated via command:
> > > > >=20
> > > > >     echo userspace > /sys/devices/system/cpu/cpufreq/policy0/s=
caling_governor
> > > > >=20
> > > > > After that you can "force" CPU frequency to specific value, e.=
g.:
> > > > >=20
> > > > >     echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/sca=
ling_setspeed
> > > > >=20
> > > > > I need to know which switch (from --> to freq) cause this syst=
em hang.
> > > > >=20
> > > > > This patch series (via MIN_VOLT_MV_FOR_L0_L1_1GHZ) is fixing o=
nly
> > > > > switching from 500 MHz to 1000 MHz on 1 GHz variant. As only t=
his switch
> > > > > is causing issue.
> > > > >=20
> > > > > I have used following simple bash script to check that switchi=
ng between
> > > > > 500 MHz and 1 GHz is stable:
> > > > >=20
> > > > >     while true; do
> > > > >         echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0=
/scaling_setspeed;
> > > > >         echo 500000 > /sys/devices/system/cpu/cpufreq/policy0/=
scaling_setspeed;
> > > > >         echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0=
/scaling_setspeed;
> > > > >         echo 500000 > /sys/devices/system/cpu/cpufreq/policy0/=
scaling_setspeed;
> > > > >     done
> > > >=20
> > > > echo userspace | tee /sys/devices/system/cpu/cpufreq/policy0/sca=
ling_governor
> > > > while true; do
> > > >   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0/sca=
ling_setspeed;
> > > >   echo 600000 | tee /sys/devices/system/cpu/cpufreq/policy0/scal=
ing_setspeed;
> > > > done
> > > >=20
> > > > >> +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108
> > > >=20
> > > > With 1108 I get a freeze within a minute. The last output to std=
out is 600000.
> > > >=20
> > > > With 1120 it takes a few minutes.
> > > >=20
> > > > With any of 1225, 1155, 1132 the device doesn't freeze over the =
full 5 minute load test.
> > > >=20
> > > > I'm using ondemand now with the above at 1132 without issue so f=
ar.
> > >=20
> > > Great, thank you for testing!
> > >=20
> > > Can you check if switching between any two lower frequencies 20000=
0
> > > 300000 600000 is stable?
> >=20
> > This is stable using 1132 mV for MIN_VOLT_MV_FOR_L0_L1_1GHZ:
> >=20
> > while true; do
> >   # down
> >   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling=
_setspeed;
> ...
>=20
> Hello!
>=20
> Could you please re-run test without tee, in form as I have shown abov=
e?
> UART is slow and printing something to console adds delay which decrea=
se
> probability that real issue is triggered as this is timing issue.

The test was done over SSH.

> Also please do tests just between two frequencies in loop as I observe=
d
> that switching between more decreased probability to hit issue.

> > > > echo userspace | tee /sys/devices/system/cpu/cpufreq/policy0/sca=
ling_governor
> > > > while true; do
> > > >   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0/sca=
ling_setspeed;
> > > >   echo 600000 | tee /sys/devices/system/cpu/cpufreq/policy0/scal=
ing_setspeed;
> > > > done

The first test ^ switched between 600 MHz and 1.2 GHz.

> The real issue for 1 GHz variant of A3720 is only when doing switch fr=
om
> 500 MHz to 1 GHz. So could you try to do some tests also without
> changing MIN_VOLT_MV_FOR_L0_L1_1GHZ and switching just between non-1.2=

> frequencies (to verify that on 1.2 GHz variant it is also from 600 MHz=

> to 1.2 GHz)?

With 1108 mV and switching between 600 MHz and 1.2GHz, I always saw a fr=
eeze within a minute.

