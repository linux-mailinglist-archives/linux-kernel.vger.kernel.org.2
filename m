Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC9C31AD91
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 19:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhBMSbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 13:31:51 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:37507 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229574AbhBMSbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 13:31:49 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 4128AC61;
        Sat, 13 Feb 2021 13:30:42 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Sat, 13 Feb 2021 13:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=QZEIT
        s9Ss68RIAo4FdUn2+jTSj5L+y5IituaMoLm3eI=; b=WIbLXiFWD5RARYjeVZx9X
        21t8JPpGrYsgXQ54q3iXW8yGhUUu48YiI19HcWQPVEsE5rBxMWS+v+1j2Zdv84pk
        oI7t8zzZwEsrW9SOapoO0PIi2pvx0uTYw3oryZITHvBcWtgBtG0KotN4wDljMI9W
        /uCYiuaT7eeD6whM4TLvcgNNudW3zwB50wRg3fhKEQ+K8FhEQVGDrR6zDcDu7cIA
        v2FM6010/qtXDxLD3HLjhbQCKscjvcWVx8As/4lKJ/kotlqpjlrN0XQGxlpReMBz
        5BZIl20eTxsChaJBrd4r76aPAs79SXfWMa4icas2sThOTE2G8xaCTDucg2uEw9g/
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=QZEITs9Ss68RIAo4FdUn2+jTSj5L+y5IituaMoLm3
        eI=; b=mpCjNBK3/gf3/LTTemmUDqxTndccHpEDTQ1+aOfcDUu+zGZWy61HsjEbE
        3e2yzETL+kvleKaytk9k+K7/7CQ73T8dRsDNSEuG5EO8d615Ie3WDshzYFNDQev2
        LdklbUj4OaS4xvItnE8ZJ5CVPUSlEoPu86oOUJSIeP9oZsx/86FUZLEHgQbgfi01
        V4lBaPk36A+9ygA93CWALkptrxxlrQYAZWnC4ikA+R3q+duUYB4ecSaHpH0tYL04
        kapu/mHO7W31eoizrafKIS/ZtDf64X2wlcFTiIKmuC19TJg/+5+URxD7AtGNno0Z
        KhTQsVNxndl/A0LcAYG9Qn2vjaJvg==
X-ME-Sender: <xms:zxooYO96HC99FkFkbGQo55QR4nBuKDVHvaHkV9jnUZmFIR2EP57Jkw>
    <xme:zxooYOst3YOGU8fW3qa6k6oKkTgSY2MsT9IDUiW1HHdPzT3ck0md-O-3lPEANxdIO
    TC6KKP_QwViuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrieefgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpehnnhgv
    thcuoehnnhgvthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepueegke
    dvheehveehteeiteduleejvddvtdeivedvueekjefgueehffeuleeugeeunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhnvghtsehfrghsth
    hmrghilhdrfhhm
X-ME-Proxy: <xmx:zxooYEAHcvLDYeRsmJq6Si2WMylyXfVhUMEFFk0TsblBfxPmZakhiw>
    <xmx:zxooYGcC9CCIIU6QY4qFnjgBpOw-EUTbsxBSedCZX8qAOzcM8gqrhQ>
    <xmx:zxooYDNURQf90lQ1QBYAvT4XsRCYUSyDd2IR6ea3YEUkijFJkxBpYA>
    <xmx:0RooYKmvmIs__MHT6CDzH2tHXuXlWTsRObQT3AzbttqpOM9SMVZZ0rIkSXA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9EB65A00060; Sat, 13 Feb 2021 13:30:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-141-gf094924a34-fm-20210210.001-gf094924a
Mime-Version: 1.0
Message-Id: <c0b02aa0-1789-43a3-8d73-057890f703f1@www.fastmail.com>
In-Reply-To: <20210213100139.ckrscepg72zjkj4f@pali>
References: <1cd0c2ee-aa3a-4da2-9c0c-57cc5a1dad49@www.fastmail.com>
 <a1277b1f-f829-4d02-9e54-68ab4faaa047@www.fastmail.com>
 <20210210092339.qy6wwuq6qr5m2ozr@pali>
 <d6971325-af71-4f71-91c2-7b661804c022@www.fastmail.com>
 <20210210180322.rlfxdussqhejqpo6@pali>
 <966f50f2-68b2-4d4f-85f0-396df112c0f4@www.fastmail.com>
 <20210211195559.n2j4jnchl2ho54mg@pali>
 <1ad78446-4a40-4c3e-8680-6dbf19616515@www.fastmail.com>
 <20210211234445.hbv2diphmgbir76u@pali>
 <000b92cc-9b54-4af9-b95c-d1317fb6f97f@www.fastmail.com>
 <20210213100139.ckrscepg72zjkj4f@pali>
Date:   Sat, 13 Feb 2021 10:30:19 -0800
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



On Sat, Feb 13, 2021, at 2:01 AM, Pali Roh=C3=A1r wrote:
> On Thursday 11 February 2021 16:41:13 nnet wrote:
> > On Thu, Feb 11, 2021, at 3:44 PM, Pali Roh=C3=A1r wrote:
> > > On Thursday 11 February 2021 12:22:52 nnet wrote:
> > > > On Thu, Feb 11, 2021, at 11:55 AM, Pali Roh=C3=A1r wrote:
> > > > > On Wednesday 10 February 2021 11:08:59 nnet wrote:
> > > > > > On Wed, Feb 10, 2021, at 10:03 AM, Pali Roh=C3=A1r wrote:
> > > > > > > > > Hello! Could you please enable userspace governor duri=
ng kernel
> > > > > > > > > compilation?
> > > > > > > > >=20
> > > > > > > > >     CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
> > > > > > > > >=20
> > > > > > > > > It can be activated via command:
> > > > > > > > >=20
> > > > > > > > >     echo userspace > /sys/devices/system/cpu/cpufreq/p=
olicy0/scaling_governor
> > > > > > > > >=20
> > > > > > > > > After that you can "force" CPU frequency to specific v=
alue, e.g.:
> > > > > > > > >=20
> > > > > > > > >     echo 1000000 > /sys/devices/system/cpu/cpufreq/pol=
icy0/scaling_setspeed
> > > > > > > > >=20
> > > > > > > > > I need to know which switch (from --> to freq) cause t=
his system hang.
> > > > > > > > >=20
> > > > > > > > > This patch series (via MIN_VOLT_MV_FOR_L0_L1_1GHZ) is =
fixing only
> > > > > > > > > switching from 500 MHz to 1000 MHz on 1 GHz variant. A=
s only this switch
> > > > > > > > > is causing issue.
> > > > > > > > >=20
> > > > > > > > > I have used following simple bash script to check that=
 switching between
> > > > > > > > > 500 MHz and 1 GHz is stable:
> > > > > > > > >=20
> > > > > > > > >     while true; do
> > > > > > > > >         echo 1000000 > /sys/devices/system/cpu/cpufreq=
/policy0/scaling_setspeed;
> > > > > > > > >         echo 500000 > /sys/devices/system/cpu/cpufreq/=
policy0/scaling_setspeed;
> > > > > > > > >         echo 1000000 > /sys/devices/system/cpu/cpufreq=
/policy0/scaling_setspeed;
> > > > > > > > >         echo 500000 > /sys/devices/system/cpu/cpufreq/=
policy0/scaling_setspeed;
> > > > > > > > >     done
> > > > > > > >=20
> > > > > > > > echo userspace | tee /sys/devices/system/cpu/cpufreq/pol=
icy0/scaling_governor
> > > > > > > > while true; do
> > > > > > > >   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/pol=
icy0/scaling_setspeed;
> > > > > > > >   echo 600000 | tee /sys/devices/system/cpu/cpufreq/poli=
cy0/scaling_setspeed;
> > > > > > > > done
> > > > > > > >=20
> > > > > > > > >> +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108
> > > > > > > >=20
> > > > > > > > With 1108 I get a freeze within a minute. The last outpu=
t to stdout is 600000.
> > > > > > > >=20
> > > > > > > > With 1120 it takes a few minutes.
> > > > > > > >=20
> > > > > > > > With any of 1225, 1155, 1132 the device doesn't freeze o=
ver the full 5 minute load test.
> > > > > > > >=20
> > > > > > > > I'm using ondemand now with the above at 1132 without is=
sue so far.
> > > > > > >=20
> > > > > > > Great, thank you for testing!
> > > > > > >=20
> > > > > > > Can you check if switching between any two lower frequenci=
es 200000
> > > > > > > 300000 600000 is stable?
> > > > > >=20
> > > > > > This is stable using 1132 mV for MIN_VOLT_MV_FOR_L0_L1_1GHZ:=

> > > > > >=20
> > > > > > while true; do
> > > > > >   # down
> > > > > >   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0=
/scaling_setspeed;
> > > > > ...
> > > > >=20
> > > > > Hello!
> > > > >=20
> > > > > Could you please re-run test without tee, in form as I have sh=
own above?
> > > > > UART is slow and printing something to console adds delay whic=
h decrease
> > > > > probability that real issue is triggered as this is timing iss=
ue.
> > > >=20
> > > > The test was done over SSH.
> > >=20
> > > Ok! But it is still better to not print any results as it adds unw=
anted
> > > delay between frequency switching.
> > >=20
> > > > > Also please do tests just between two frequencies in loop as I=
 observed
> > > > > that switching between more decreased probability to hit issue=
.
> > > >=20
> > > > > > > > echo userspace | tee /sys/devices/system/cpu/cpufreq/pol=
icy0/scaling_governor
> > > > > > > > while true; do
> > > > > > > >   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/pol=
icy0/scaling_setspeed;
> > > > > > > >   echo 600000 | tee /sys/devices/system/cpu/cpufreq/poli=
cy0/scaling_setspeed;
> > > > > > > > done
> > > >=20
> > > > The first test ^ switched between 600 MHz and 1.2 GHz.
> > > >=20
> > > > > The real issue for 1 GHz variant of A3720 is only when doing s=
witch from
> > > > > 500 MHz to 1 GHz. So could you try to do some tests also witho=
ut
> > > > > changing MIN_VOLT_MV_FOR_L0_L1_1GHZ and switching just between=
 non-1.2
> > > > > frequencies (to verify that on 1.2 GHz variant it is also from=
 600 MHz
> > > > > to 1.2 GHz)?
> > > >=20
> > > > With 1108 mV and switching between 600 MHz and 1.2GHz, I always =
saw a freeze within a minute.
> > >=20
> > > I mean to try switching with 1.108 V between 200 MHz and 300 MHz o=
r
> > > between 300 MHz and 600 MHz. To check that issue is really only wi=
th
> > > switch from 600 MHz to 1.2 GHz.
> >=20
> > With:
> >=20
> > +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108
> >=20
> > with 5 min load:
> >=20
> > # no lock-up
> >=20
> > echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_gov=
ernor
> > while true; do
> >   echo 200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_sets=
peed;
> >   echo 300000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_sets=
peed;
> > done
> >=20
> > # no lock-up
> >=20
> > echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_gov=
ernor
> > while true; do
> >   echo 300000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_sets=
peed;
> >   echo 600000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_sets=
peed;
> > done
> >=20
> > # lock-up with 10 seconds of load applied
> >=20
> > echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_gov=
ernor
> > while true; do
> >   echo 600000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_sets=
peed;
> >   echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_set=
speed;
> > done
>=20
> Ok! So it really looks like that on 1.2 GHz is the same issue. We need=

> to increase voltage for L1 load (600 MHz). But question is what is the=

> threshold (it is 1132 mV or lower?)=20

Lower then 1132 mV causes freezes. No freezes with 1132 mV.

> and second question is what
> increasing minimal voltage may cause with board.

I don't have any further information on the issue and device then that e=
xperience.

I've tested on two of these devices which suggests it's not an oddity wi=
th one instance of it.

>=20
> Basically there is absolutely no information about 1.2 GHz variant and=

> this issue...
>
> > > I need to know if current settings are fine for 200, 300 and 600 M=
Hz
> > > frequencies and the only 600 --> 1200 needs to be fixed.
> > >
>
