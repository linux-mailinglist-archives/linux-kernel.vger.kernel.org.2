Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0849316FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhBJTKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:10:24 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:58731 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234500AbhBJTKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:10:17 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 48D4758024B;
        Wed, 10 Feb 2021 14:09:22 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 10 Feb 2021 14:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=ZBz7x
        kFpjv29bV9hHPAsF1wCNJUnjwxMkO1OwDKzLiw=; b=gpob5cYTBZT+2hWPmxrMC
        HY9j7VlFtTcxiQB3K02v0TYozM6m07kW4dz4QiQ02pTSMIfcv56bF6TKKgnrfZ2b
        q0IdOZ8IQe1BvXJtci1d9Bn2hn6sZnUOHg5Ze4brmFTlUMRxFGIheqBwNiLovvG0
        K+VyXKVpFOtVZyaL3/XbWyztGsPB1+ERkGCa2J5s2RGwjAmIM+vUQ3m8dTXUs2Hq
        YwoHl8i6hUnG0c5XaJhL3iPtgdCCs8rdS7o51UHvmntDpGknXqV7e+kjtmR9jgVM
        MIBCx6dygCuotfoUQ/8Fz+KI/1BNcP4k07y8ac16lqbFW1ydFu/3BIN9e4uUFRHY
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=ZBz7xkFpjv29bV9hHPAsF1wCNJUnjwxMkO1OwDKzL
        iw=; b=gxAORxC7ExH+GdBJwOq9/cdnjk12gApqDlHugjOYs8QxNZ2eT02OO6qcY
        3ZwKeY2QyzgFk7cZ0wQ68MUOJW/+YFQuXXk1PJail9NGLtrEgigkWUZtGkmBVg5D
        OUQxMBLaiZjZMX+KhvzED/Vaq/YrWLYclpqcRAfiXYzORUT3Wf0StWgeNauqMedf
        CAlvxzA4eAnWVtglgcPp9+4vM4Pc+WDR5CQ/0WBn8sOvHDJv3/tNW4GQ73zFWGKG
        zzUyuo6+fk2Y5eB9eY+8RwX1EUn24AWSKEIkg9Um+7+BHv194HbZ658PNVpShIs+
        4d1n7bwIanxtR6gFJMmljEoCNAZlw==
X-ME-Sender: <xms:Xy8kYG_ICHNpPzMJkvm_c3JF_SqnQkCLScWPZUbYR5DhXpAjcohXOw>
    <xme:Xy8kYGstGy8B526cKDOws4c-f_qV_mRARNMotqDwLSqS0uq_fOWpi8iWrFOyxST3s
    icY_erveVbNsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheejgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpehnnhgv
    thcuoehnnhgvthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepleekff
    ekudejfeefgeeludeijefhieejueejleeluefftdeluedujeekudffvdfhnecuffhomhgr
    ihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehnnhgvthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:Xy8kYMDQZBlnq7OMe2V_L-clvMcZBXa3qnTtOedBsGDw9IFkRbpZUg>
    <xmx:Xy8kYOfNXJkvJbbzoVh2wUBlKk4Q5F2hSK-B9iXJV4P0Uvd8eXAomw>
    <xmx:Xy8kYLP5uAzph8fyfqHcPUlMrsFnxosAY_BmRCEStuPlwu-yquBBhQ>
    <xmx:Yi8kYCmNyxkyEx-TRxaIK-HFpS6J8EqLuTxd4ZMzLis2NjLNoPNwwQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DC62BA0005E; Wed, 10 Feb 2021 14:09:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-93-gef6c4048e6-fm-20210128.002-gef6c4048
Mime-Version: 1.0
Message-Id: <966f50f2-68b2-4d4f-85f0-396df112c0f4@www.fastmail.com>
In-Reply-To: <20210210180322.rlfxdussqhejqpo6@pali>
References: <20210209224223.p22yhjdy7ibzepss@pali>
 <93745280-dbe9-491c-a79d-c9c364b83880@www.fastmail.com>
 <20210209225630.mdwnzkvnaz3r4blt@pali>
 <a86c5069-d423-44db-92dd-b3e406b7ec91@www.fastmail.com>
 <20210210002619.43104a9b@kernel.org>
 <ac03801e-87e2-4e57-b131-bff52f03579d@www.fastmail.com>
 <1cd0c2ee-aa3a-4da2-9c0c-57cc5a1dad49@www.fastmail.com>
 <a1277b1f-f829-4d02-9e54-68ab4faaa047@www.fastmail.com>
 <20210210092339.qy6wwuq6qr5m2ozr@pali>
 <d6971325-af71-4f71-91c2-7b661804c022@www.fastmail.com>
 <20210210180322.rlfxdussqhejqpo6@pali>
Date:   Wed, 10 Feb 2021 11:08:59 -0800
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



On Wed, Feb 10, 2021, at 10:03 AM, Pali Roh=C3=A1r wrote:
> On Wednesday 10 February 2021 09:34:07 nnet wrote:
> > On Wed, Feb 10, 2021, at 1:23 AM, Pali Roh=C3=A1r wrote:
> > > On Tuesday 09 February 2021 18:07:41 nnet wrote:
> > > > On Tue, Feb 9, 2021, at 5:51 PM, nnet wrote:
> > > > > On Tue, Feb 9, 2021, at 5:31 PM, nnet wrote:
> > > > > > On Tue, Feb 9, 2021, at 3:26 PM, Marek Beh=C3=BAn wrote:
> > > > > > > On Tue, 09 Feb 2021 15:16:45 -0800
> > > > > > > nnet <nnet@fastmail.fm> wrote:
> > > > > > >=20
> > > > > > > > I've two of these and I've just swapped them (and re-pas=
ted the heat sinks).
> > > > > > > >=20
> > > > > > > > The second one ran under load for awhile and now has fro=
zen as well.
> > > > > > > >=20
> > > > > > > > Under a moderate load `wget -O /dev/null <large.bin>` @X=
00Mbits they are fine.
> > > > > > > >=20
> > > > > > > > Under a 1 min speed test of load ~200Mbits routed WireGu=
ard they freeze.
> > > > > > > >=20
> > > > > > > > They fine with both those workloads @1000_800.
> > > > > > > >=20
> > > > > > > > Perhaps it's heat? Unfortunately I don't have any number=
s on that ATM.
> > > > > > >=20
> > > > > > > Try disabling cpufreq in kernel completely, compile boot i=
mage at
> > > > > > > 1200 MHz. If it continues freezing, then I fear we can't h=
elp you with
> > > > > > > 1200 MHz :(
> > > > > >=20
> > > > > > cat /sys/devices/system/cpu/cpufreq/policy0/scaling_availabl=
e_frequencies=20
> > > > > > 200000 300000 600000 1200000=20
> > > > > >=20
> > > > > > I'm not getting any freezes with 1.2GHz fixed after 20 minut=
es of load:
> > > > > >=20
> > > > > > echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scali=
ng_min_freq
> > > > > >=20
> > > > > > Setting it back to min 200MHz I get a freeze within a minute=
:
> > > > > >=20
> > > > > > echo 200000 > /sys/devices/system/cpu/cpufreq/policy0/scalin=
g_min_freq
> > >=20
> > > Hello! Could you please enable userspace governor during kernel
> > > compilation?
> > >=20
> > >     CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
> > >=20
> > > It can be activated via command:
> > >=20
> > >     echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scali=
ng_governor
> > >=20
> > > After that you can "force" CPU frequency to specific value, e.g.:
> > >=20
> > >     echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling=
_setspeed
> > >=20
> > > I need to know which switch (from --> to freq) cause this system h=
ang.
> > >=20
> > > This patch series (via MIN_VOLT_MV_FOR_L0_L1_1GHZ) is fixing only
> > > switching from 500 MHz to 1000 MHz on 1 GHz variant. As only this =
switch
> > > is causing issue.
> > >=20
> > > I have used following simple bash script to check that switching b=
etween
> > > 500 MHz and 1 GHz is stable:
> > >=20
> > >     while true; do
> > >         echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/sca=
ling_setspeed;
> > >         echo 500000 > /sys/devices/system/cpu/cpufreq/policy0/scal=
ing_setspeed;
> > >         echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/sca=
ling_setspeed;
> > >         echo 500000 > /sys/devices/system/cpu/cpufreq/policy0/scal=
ing_setspeed;
> > >     done
> >=20
> > echo userspace | tee /sys/devices/system/cpu/cpufreq/policy0/scaling=
_governor
> > while true; do
> >   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling=
_setspeed;
> >   echo 600000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_=
setspeed;
> > done
> >=20
> > >> +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108
> >=20
> > With 1108 I get a freeze within a minute. The last output to stdout =
is 600000.
> >=20
> > With 1120 it takes a few minutes.
> >=20
> > With any of 1225, 1155, 1132 the device doesn't freeze over the full=
 5 minute load test.
> >=20
> > I'm using ondemand now with the above at 1132 without issue so far.
>=20
> Great, thank you for testing!
>=20
> Can you check if switching between any two lower frequencies 200000
> 300000 600000 is stable?

This is stable using 1132 mV for MIN_VOLT_MV_FOR_L0_L1_1GHZ:

while true; do
  # down
  echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_set=
speed;
  echo 600000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_sets=
peed;
  echo 300000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_sets=
peed;
  echo 200000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_sets=
peed;
  # up
  echo 300000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_sets=
peed;
  echo 600000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_sets=
peed;
  echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_set=
speed;
  # all down
  echo 200000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_sets=
peed;
  # all up
  echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_set=
speed;
  # almost down
  echo 300000 | tee /sys/devices/system/cpu/cpufreq/policy0/scaling_sets=
peed;
done   =20

> > >> Update the CPU voltage value for loads L0 and L1 accordingly when=
 base
> > >> frequency is 1000 or 1200 MHz. The minimal value is updated from =
the
> > >> original 1.05V to 1.108V.
> >=20
> > Perhaps similiar to how a minimum of 1108 mV is useful when shifting=
 to 1GHz, using a minimum of 1132 is useful when shifting to 1.2GHz.
>=20
> Maybe... We can only wait if Marvell provide some details about this
> issue.
>=20
> > > (of course on 1.2 GHz variant you need to adjust values as only
> > > following frequencies 200000 300000 600000 1200000 are supported)
> > >=20
> > > > > > > Marek
> > > > > > >
> > > > >=20
> > > > > > +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108
> > > > >=20
> > > > > Based on the below at boot time might an equivalent of the abo=
ve need=20
> > > > > to be 1225 for 1.2GHz?
> > > > >=20
> > > > > 1200_750
> > > > > SVC REV: 5, CPU VDD voltage: 1.225V
> > > > >=20
> > > > > 1000_800
> > > > > SVC REV: 5, CPU VDD voltage: 1.108V
> > >=20
> > > This value is printed in WTMI avs.c by following code:
> > >=20
> > >     shift =3D OTP_SVC_SPEED_1000_OFF;
> > >     (OR)
> > >     shift =3D OTP_SVC_SPEED_1200_OFF;
> > >=20
> > >     vdd_otp =3D ((otp_data[OTP_DATA_SVC_SPEED_ID] >> shift) +
> > >                 AVS_VDD_BASE) & AVS_VDD_MASK;
> > >     regval |=3D (vdd_otp << HIGH_VDD_LIMIT_OFF);
> > >     regval |=3D (vdd_otp << LOW_VDD_LIMIT_OFF);
> > >     printf("SVC REV: %d, CPU VDD voltage: %s\n", svc_rev,
> > >             avis_dump[vdd_otp].desc);
> > >=20
> > > So voltage value is read from the OTP memory.
> > >=20
> > > But I do not know what this value means.
>=20
> Link to code:=20
> https://github.com/MarvellEmbeddedProcessors/A3700-utils-marvell/blob/=
master/wtmi/sys_init/avs.c
>=20
> You can read this OTP memory (otp_data[] array) in U-Boot by command:
>=20
>     md d0012604 1; md d0012604 1; md d0012604 1

=3D> md d0012604 1; md d0012604 1; md d0012604 1
d0012604: 2b417501                               .uA+
d0012604: 0000945b                               [...
d0012604: 00000000                               ....

> > > > I did this for a quick test for 1.2GHz:
> > > >=20
> > > > +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1225
> > > >=20
> > > > This is working well so far. Frequency is shifting up/down with =
load applied/stopped.
> > >
>
