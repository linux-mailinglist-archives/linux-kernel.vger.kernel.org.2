Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD170319793
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 01:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhBLAnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 19:43:11 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:33447 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229714AbhBLAmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 19:42:44 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id E2E8BA09;
        Thu, 11 Feb 2021 19:41:35 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 11 Feb 2021 19:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=lq1Mg
        yURT/+FvHph6bNyVR+n3tqnPDI+rDy1fPdgW94=; b=AVhtDn53IA8cD0v6GxrFX
        Z7vzLOKcV0/KKec4L+z3qWmfRjQx4bBXTnMOUdpFXfCEzm3I2S7RGqNa1dEhd/yP
        N7vKZWJMQK6FQWkPD1gBH5krZZVCUWdHFR2mmc+vjY/JQXrbBRzIHWMm079k85rm
        elPY1cIyQUj/1Z6TVVEj5HUL9HZ8ncpesJ0g5YB46uvExSDxdkt7SKGqqM/j4dPU
        CrzIaWuIcXoWaXifpAXs2MFaM9pucKqocRjZztKstA/9DJWIefPyNTbFx2biDqZD
        d0csDEh5i90hRZzXNWkhJpMiEPo0n1nf39Ls0qjEf1WMsPWS7A5v5VygDtlZb1PF
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=lq1MgyURT/+FvHph6bNyVR+n3tqnPDI+rDy1fPdgW
        94=; b=s4rsHYhWqu9S1Ov9cvQBPCElVPg79zYML7GS0VcDcz/2aCispB7Qj0VjI
        V7M2IH41lD2MCHhx0BP5vwaB1lJ0uCncS8wzlO25X75D2LTXGWvw8xUmY9TmR0UF
        QKXxOPBGUI/N1WqlVSAdLLGvBqzHqiFkxl3MROWzmeYiDgThLwGMybGKyd6Nb4lO
        i1dVBsMU6HqrGB5sO9iS3N0nxpuCYs7b9Q6jiWEQ59CCFV224bgtbKosU+4goc2l
        zdpwP+6h5b8B3oMAs9+o46VFgQeotfgpFP2wNN83dGHmfpZTIRBYxYN0/bKZJRHg
        iMWYfOlxojZ2L223QiZ+dcmbeYh6Q==
X-ME-Sender: <xms:vc4lYFeGToQWuZsPp0_3xPYYB-PKQCD5AGUU_ANQq9mksw89ktPKew>
    <xme:vc4lYDN5S3TjJjjygNZiJz2qqaS7I3XnUDUCHQD0v9U0f6HtSShpOv-Q_Pm-EORnn
    NTFzJbK_Ueqww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledriedtgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepnhhnvght
    uceonhhnvghtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeeugeekvd
    ehheevheetieetudeljedvvddtieevvdeukeejgfeuheffueelueegueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnnhgvthesfhgrshhtmh
    grihhlrdhfmh
X-ME-Proxy: <xmx:vc4lYOjEaj-HynicqRVM_tyktWi-PfxmnnWObo-cG7qb4e52gqQ7MQ>
    <xmx:vc4lYO-yIegTwl9lEn_pb-OTFDbTXpg8OuCfVNsxy4OLIeVGJyvmdw>
    <xmx:vc4lYBuus4_ekGeZQbhoTUN3jWKHwgHl8-L-uZJoVvPXdBSMX5N1BQ>
    <xmx:v84lYBGqrg9D8slf9hC0qmZdhkLFZLlVgLzULC06AsENMRH5SirIv5OXwHQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E7215A0005E; Thu, 11 Feb 2021 19:41:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-141-gf094924a34-fm-20210210.001-gf094924a
Mime-Version: 1.0
Message-Id: <000b92cc-9b54-4af9-b95c-d1317fb6f97f@www.fastmail.com>
In-Reply-To: <20210211234445.hbv2diphmgbir76u@pali>
References: <20210210002619.43104a9b@kernel.org>
 <ac03801e-87e2-4e57-b131-bff52f03579d@www.fastmail.com>
 <1cd0c2ee-aa3a-4da2-9c0c-57cc5a1dad49@www.fastmail.com>
 <a1277b1f-f829-4d02-9e54-68ab4faaa047@www.fastmail.com>
 <20210210092339.qy6wwuq6qr5m2ozr@pali>
 <d6971325-af71-4f71-91c2-7b661804c022@www.fastmail.com>
 <20210210180322.rlfxdussqhejqpo6@pali>
 <966f50f2-68b2-4d4f-85f0-396df112c0f4@www.fastmail.com>
 <20210211195559.n2j4jnchl2ho54mg@pali>
 <1ad78446-4a40-4c3e-8680-6dbf19616515@www.fastmail.com>
 <20210211234445.hbv2diphmgbir76u@pali>
Date:   Thu, 11 Feb 2021 16:41:13 -0800
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



On Thu, Feb 11, 2021, at 3:44 PM, Pali Roh=C3=A1r wrote:
> On Thursday 11 February 2021 12:22:52 nnet wrote:
> > On Thu, Feb 11, 2021, at 11:55 AM, Pali Roh=C3=A1r wrote:
> > > On Wednesday 10 February 2021 11:08:59 nnet wrote:
> > > > On Wed, Feb 10, 2021, at 10:03 AM, Pali Roh=C3=A1r wrote:
> > > > > > > Hello! Could you please enable userspace governor during k=
ernel
> > > > > > > compilation?
> > > > > > >=20
> > > > > > >     CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
> > > > > > >=20
> > > > > > > It can be activated via command:
> > > > > > >=20
> > > > > > >     echo userspace > /sys/devices/system/cpu/cpufreq/polic=
y0/scaling_governor
> > > > > > >=20
> > > > > > > After that you can "force" CPU frequency to specific value=
, e.g.:
> > > > > > >=20
> > > > > > >     echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0=
/scaling_setspeed
> > > > > > >=20
> > > > > > > I need to know which switch (from --> to freq) cause this =
system hang.
> > > > > > >=20
> > > > > > > This patch series (via MIN_VOLT_MV_FOR_L0_L1_1GHZ) is fixi=
ng only
> > > > > > > switching from 500 MHz to 1000 MHz on 1 GHz variant. As on=
ly this switch
> > > > > > > is causing issue.
> > > > > > >=20
> > > > > > > I have used following simple bash script to check that swi=
tching between
> > > > > > > 500 MHz and 1 GHz is stable:
> > > > > > >=20
> > > > > > >     while true; do
> > > > > > >         echo 1000000 > /sys/devices/system/cpu/cpufreq/pol=
icy0/scaling_setspeed;
> > > > > > >         echo 500000 > /sys/devices/system/cpu/cpufreq/poli=
cy0/scaling_setspeed;
> > > > > > >         echo 1000000 > /sys/devices/system/cpu/cpufreq/pol=
icy0/scaling_setspeed;
> > > > > > >         echo 500000 > /sys/devices/system/cpu/cpufreq/poli=
cy0/scaling_setspeed;
> > > > > > >     done
> > > > > >=20
> > > > > > echo userspace | tee /sys/devices/system/cpu/cpufreq/policy0=
/scaling_governor
> > > > > > while true; do
> > > > > >   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0=
/scaling_setspeed;
> > > > > >   echo 600000 | tee /sys/devices/system/cpu/cpufreq/policy0/=
scaling_setspeed;
> > > > > > done
> > > > > >=20
> > > > > > >> +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108
> > > > > >=20
> > > > > > With 1108 I get a freeze within a minute. The last output to=
 stdout is 600000.
> > > > > >=20
> > > > > > With 1120 it takes a few minutes.
> > > > > >=20
> > > > > > With any of 1225, 1155, 1132 the device doesn't freeze over =
the full 5 minute load test.
> > > > > >=20
> > > > > > I'm using ondemand now with the above at 1132 without issue =
so far.
> > > > >=20
> > > > > Great, thank you for testing!
> > > > >=20
> > > > > Can you check if switching between any two lower frequencies 2=
00000
> > > > > 300000 600000 is stable?
> > > >=20
> > > > This is stable using 1132 mV for MIN_VOLT_MV_FOR_L0_L1_1GHZ:
> > > >=20
> > > > while true; do
> > > >   # down
> > > >   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0/sca=
ling_setspeed;
> > > ...
> > >=20
> > > Hello!
> > >=20
> > > Could you please re-run test without tee, in form as I have shown =
above?
> > > UART is slow and printing something to console adds delay which de=
crease
> > > probability that real issue is triggered as this is timing issue.
> >=20
> > The test was done over SSH.
>=20
> Ok! But it is still better to not print any results as it adds unwante=
d
> delay between frequency switching.
>=20
> > > Also please do tests just between two frequencies in loop as I obs=
erved
> > > that switching between more decreased probability to hit issue.
> >=20
> > > > > > echo userspace | tee /sys/devices/system/cpu/cpufreq/policy0=
/scaling_governor
> > > > > > while true; do
> > > > > >   echo 1200000 | tee /sys/devices/system/cpu/cpufreq/policy0=
/scaling_setspeed;
> > > > > >   echo 600000 | tee /sys/devices/system/cpu/cpufreq/policy0/=
scaling_setspeed;
> > > > > > done
> >=20
> > The first test ^ switched between 600 MHz and 1.2 GHz.
> >=20
> > > The real issue for 1 GHz variant of A3720 is only when doing switc=
h from
> > > 500 MHz to 1 GHz. So could you try to do some tests also without
> > > changing MIN_VOLT_MV_FOR_L0_L1_1GHZ and switching just between non=
-1.2
> > > frequencies (to verify that on 1.2 GHz variant it is also from 600=
 MHz
> > > to 1.2 GHz)?
> >=20
> > With 1108 mV and switching between 600 MHz and 1.2GHz, I always saw =
a freeze within a minute.
>=20
> I mean to try switching with 1.108 V between 200 MHz and 300 MHz or
> between 300 MHz and 600 MHz. To check that issue is really only with
> switch from 600 MHz to 1.2 GHz.

With:

+#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108

with 5 min load:

# no lock-up

echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governo=
r
while true; do
  echo 200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed=
;
  echo 300000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed=
;
done

# no lock-up

echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governo=
r
while true; do
  echo 300000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed=
;
  echo 600000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed=
;
done

# lock-up with 10 seconds of load applied

echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governo=
r
while true; do
  echo 600000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed=
;
  echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspee=
d;
done

> I need to know if current settings are fine for 200, 300 and 600 MHz
> frequencies and the only 600 --> 1200 needs to be fixed.
>
