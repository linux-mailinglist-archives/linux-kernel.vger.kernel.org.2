Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3103E316D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhBJRnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:43:17 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:43311 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231876AbhBJRm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:42:28 -0500
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Feb 2021 12:42:28 EST
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 30C58E21;
        Wed, 10 Feb 2021 12:34:30 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 10 Feb 2021 12:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=os5D8
        3SLQ+8HE1xA+G3BTW1ShQ/LEiTTmyl/JCLibZU=; b=gZKOFuZs9dCmVwCCMWRlK
        97AfGOGzFkSHp/OL/bocJf0NUK2InmI6hJOhqc74VhfXYyBWOXklLss3QjEi13uw
        0s0OOFg6HnwiquJ6LYmgUm+2OazO8YqofXCSy55eurVK0n2bWgd19VT0a55bR3Lc
        W2vOQkoACKpVdimRIyxCHiE6QVIiPpSlObNDyAFCrb3v70+YOydb7KrQCp1lGjry
        oEAuiTVrQyJo3D2KaiFOqZUsWxPHSGrQ1foU1fTK5q4g5PzQuqyWe5ei7nfoP8FM
        TZiSPhG1AyG0NjiWDjTKW3BjSa6g7rPugmIf1Nbv9/vnrHAEt+O1NA1UZg0d+woN
        A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=os5D83SLQ+8HE1xA+G3BTW1ShQ/LEiTTmyl/JCLib
        ZU=; b=Z/q6OMijt76MH5GGsU4GrelruZBCV0Ylpg9XQx4fCgdRT6KxEDxFChvGD
        a1rxD1fW184HnRGh63YfSkoD2LEtgGFPZfmsaMXa2sdVfWyJoSpLhyRXYmztp+aH
        NraLitp/tpS+R4f0Daz9ttCJjvdkEVVQDq9ag9wdZZ/Cp44WqmWsvMt3pVyE2c5T
        o3q89gZH6SWxPMrTqeIFzWSv0lNVgCdQs4Qlzbt44BsCeuulI3LoT6ww+PcPlw5O
        fvK+twjrUnELM46wLxzWe3r4QftNk2WcoBGeK1Bo3Q58vAFeLjVZVHVlsFor9ilQ
        UqMryCLxRMpdOVdRvSyX6l+tSFGqw==
X-ME-Sender: <xms:IxkkYPuXRto7I-c-7nkRwGd9FfOt9whGnFleq8Vvr8qyhgRMdJpWMQ>
    <xme:IxkkYAdU9GkGa5VJn6kvZEVyuwOPS0oc3xpoI9MAhz_qQj3aJk8AXVkpGQo13VaZJ
    ejKqeDziCJ84w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheejgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpehnnhgv
    thcuoehnnhgvthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepueegke
    dvheehveehteeiteduleejvddvtdeivedvueekjefgueehffeuleeugeeunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhnvghtsehfrghsth
    hmrghilhdrfhhm
X-ME-Proxy: <xmx:IxkkYCxpWiCEAvlhkJCgEzxhc8v9w6Q05OTk5p0XSch04ZUOy749IA>
    <xmx:IxkkYOO7b2KiqD9HJqeMK7RBVuKMvo6_UUTzXeyXIFcM0yZPPFZwcQ>
    <xmx:IxkkYP-16JfOauFac4jTfpRCPw2MmWqWjMoOt_MQlQDKw6MphVslXQ>
    <xmx:JRkkYDWdrget_uIblcdA7mK5EaVakdI8X0MKh5Js5MGK191GNOa_BfssYL0>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D1EC8A0005E; Wed, 10 Feb 2021 12:34:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-93-gef6c4048e6-fm-20210128.002-gef6c4048
Mime-Version: 1.0
Message-Id: <d6971325-af71-4f71-91c2-7b661804c022@www.fastmail.com>
In-Reply-To: <20210210092339.qy6wwuq6qr5m2ozr@pali>
References: <20210209213330.hnc7op72zoj24mgz@pali>
 <7b0988cc-eeb8-4ea7-92f6-e8234ca910d3@www.fastmail.com>
 <20210209224223.p22yhjdy7ibzepss@pali>
 <93745280-dbe9-491c-a79d-c9c364b83880@www.fastmail.com>
 <20210209225630.mdwnzkvnaz3r4blt@pali>
 <a86c5069-d423-44db-92dd-b3e406b7ec91@www.fastmail.com>
 <20210210002619.43104a9b@kernel.org>
 <ac03801e-87e2-4e57-b131-bff52f03579d@www.fastmail.com>
 <1cd0c2ee-aa3a-4da2-9c0c-57cc5a1dad49@www.fastmail.com>
 <a1277b1f-f829-4d02-9e54-68ab4faaa047@www.fastmail.com>
 <20210210092339.qy6wwuq6qr5m2ozr@pali>
Date:   Wed, 10 Feb 2021 09:34:07 -0800
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

On Wed, Feb 10, 2021, at 1:23 AM, Pali Roh=C3=A1r wrote:
> On Tuesday 09 February 2021 18:07:41 nnet wrote:
> > On Tue, Feb 9, 2021, at 5:51 PM, nnet wrote:
> > > On Tue, Feb 9, 2021, at 5:31 PM, nnet wrote:
> > > > On Tue, Feb 9, 2021, at 3:26 PM, Marek Beh=C3=BAn wrote:
> > > > > On Tue, 09 Feb 2021 15:16:45 -0800
> > > > > nnet <nnet@fastmail.fm> wrote:
> > > > >=20
> > > > > > I've two of these and I've just swapped them (and re-pasted =
the heat sinks).
> > > > > >=20
> > > > > > The second one ran under load for awhile and now has frozen =
as well.
> > > > > >=20
> > > > > > Under a moderate load `wget -O /dev/null <large.bin>` @X00Mb=
its they are fine.
> > > > > >=20
> > > > > > Under a 1 min speed test of load ~200Mbits routed WireGuard =
they freeze.
> > > > > >=20
> > > > > > They fine with both those workloads @1000_800.
> > > > > >=20
> > > > > > Perhaps it's heat? Unfortunately I don't have any numbers on=
 that ATM.
> > > > >=20
> > > > > Try disabling cpufreq in kernel completely, compile boot image=
 at
> > > > > 1200 MHz. If it continues freezing, then I fear we can't help =
you with
> > > > > 1200 MHz :(
> > > >=20
> > > > cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_fr=
equencies=20
> > > > 200000 300000 600000 1200000=20
> > > >=20
> > > > I'm not getting any freezes with 1.2GHz fixed after 20 minutes o=
f load:
> > > >=20
> > > > echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_m=
in_freq
> > > >=20
> > > > Setting it back to min 200MHz I get a freeze within a minute:
> > > >=20
> > > > echo 200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_mi=
n_freq
>=20
> Hello! Could you please enable userspace governor during kernel
> compilation?
>=20
>     CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
>=20
> It can be activated via command:
>=20
>     echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_g=
overnor
>=20
> After that you can "force" CPU frequency to specific value, e.g.:
>=20
>     echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_set=
speed
>=20
> I need to know which switch (from --> to freq) cause this system hang.=

>=20
> This patch series (via MIN_VOLT_MV_FOR_L0_L1_1GHZ) is fixing only
> switching from 500 MHz to 1000 MHz on 1 GHz variant. As only this swit=
ch
> is causing issue.
>=20
> I have used following simple bash script to check that switching betwe=
en
> 500 MHz and 1 GHz is stable:
>=20
>     while true; do
>         echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling=
_setspeed;
>         echo 500000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_=
setspeed;
>         echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling=
_setspeed;
>         echo 500000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_=
setspeed;
>     done

echo userspace | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_gov=
ernor
while true; do
  echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_set=
speed;
  echo 600000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_sets=
peed;
done

>> +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108

With 1108 I get a freeze within a minute. The last output to stdout is 6=
00000.

With 1120 it takes a few minutes.

With any of 1225, 1155, 1132 the device doesn't freeze over the full 5 m=
inute load test.

I'm using ondemand now with the above at 1132 without issue so far.

>> Update the CPU voltage value for loads L0 and L1 accordingly when bas=
e
>> frequency is 1000 or 1200 MHz. The minimal value is updated from the
>> original 1.05V to 1.108V.

Perhaps similiar to how a minimum of 1108 mV is useful when shifting to =
1GHz, using a minimum of 1132 is useful when shifting to 1.2GHz.

> (of course on 1.2 GHz variant you need to adjust values as only
> following frequencies 200000 300000 600000 1200000 are supported)
>=20
> > > > > Marek
> > > > >
> > >=20
> > > > +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108
> > >=20
> > > Based on the below at boot time might an equivalent of the above n=
eed=20
> > > to be 1225 for 1.2GHz?
> > >=20
> > > 1200_750
> > > SVC REV: 5, CPU VDD voltage: 1.225V
> > >=20
> > > 1000_800
> > > SVC REV: 5, CPU VDD voltage: 1.108V
>=20
> This value is printed in WTMI avs.c by following code:
>=20
>     shift =3D OTP_SVC_SPEED_1000_OFF;
>     (OR)
>     shift =3D OTP_SVC_SPEED_1200_OFF;
>=20
>     vdd_otp =3D ((otp_data[OTP_DATA_SVC_SPEED_ID] >> shift) +
>                 AVS_VDD_BASE) & AVS_VDD_MASK;
>     regval |=3D (vdd_otp << HIGH_VDD_LIMIT_OFF);
>     regval |=3D (vdd_otp << LOW_VDD_LIMIT_OFF);
>     printf("SVC REV: %d, CPU VDD voltage: %s\n", svc_rev,
>             avis_dump[vdd_otp].desc);
>=20
> So voltage value is read from the OTP memory.
>=20
> But I do not know what this value means.
>=20
> > I did this for a quick test for 1.2GHz:
> >=20
> > +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1225
> >=20
> > This is working well so far. Frequency is shifting up/down with load=
 applied/stopped.
>
