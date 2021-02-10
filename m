Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF75315D54
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbhBJCcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:32:35 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46153 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235208AbhBJCIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:08:55 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4681B580265;
        Tue,  9 Feb 2021 21:08:09 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 09 Feb 2021 21:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=tniNf
        QI9zU/BebxOxoqaAf0OdO5pRgsTSECculbGH98=; b=lNOHzNhXzvds/Gpfnclud
        imQbRei/iq/6OexwtWpZS4WXckLZJsdVP+FCmjrJvs7CuH7u9g6/OgED+fI90Adn
        wgmHoD4ydzB9GT+RirDKyeqH3EHXrsfoW/rG22h3zFJbowpdJi6igUtUwbE+WTBz
        zhdsYg7shu6491eYMIEYSDJsS3A2xGGC5A/9gjJi4b7ny08BY/M2XtAd3ST5hTtP
        xYOfWse+YnYI17PXzGjx5ToRO/ZLkIdKEBUiDUuuI/GlAzAZgtGWZjhI13qnzJLu
        QAIK2Pc4oxZgvn0vU2R35Eipv900mK+Ci5wn9k3QfJt6MWxmqPSUbP3JtL6l3z25
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=tniNfQI9zU/BebxOxoqaAf0OdO5pRgsTSECculbGH
        98=; b=GiW3i68sU1T3RobxRJUBi03JMZSxRWuiYHZ3ZZh3QL7sm0C76u2o/0vZW
        mUpb089Nm0ML2kcGY+GCxbUPnCPrrQSM/tNIV9cNH54b1jrnJUPRl3FnHbw2Zjrv
        EgME3DfnYjRDznkqBHU1rmoPZt5gT/CCcBZn4JHgeb0+UMsizJU2rAnLzoyqfgJh
        DulUQ415VP+0SAHNAhCZth51VzPr3iIWP/iOvT4Yb2Rq5QXxa2ZNtSdzxDAwoYiA
        GBUMearc4HRVinNGIjHNuEm+WZdpQ9hcspamNt6BtVe3lQpHy+cYofvA72h0NIMK
        x518zJp3sX70gyypowvmeVitM32Og==
X-ME-Sender: <xms:CEAjYHwMoOIdujvThycrbUf7iec9Q1DUOTGIyxldEy7yCbWyVSLNTQ>
    <xme:CEAjYPTUoptirJ_W09YJqSrtGJDGERrU2S3bc9m52hCQcM0FeUCCpbuRDnooRhtz9
    1nvWoUqJY0CtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheeigdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepnhhnvght
    uceonhhnvghtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeeugeekvd
    ehheevheetieetudeljedvvddtieevvdeukeejgfeuheffueelueegueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnnhgvthesfhgrshhtmh
    grihhlrdhfmh
X-ME-Proxy: <xmx:CEAjYBU8-G9X60fKnHLAUvHAMtyMwDGOCuhZPqY-q4KT2TI8CFfj_A>
    <xmx:CEAjYBjf65BcHqC5n6LtAu7kgtfXWcXRKXe0Kzudp9LiSPNtTehBCQ>
    <xmx:CEAjYJBRQVUpS77Kjsn5Zak6YLW9Rri-TNXTjLjw4svPMEo7fa6bhA>
    <xmx:CUAjYBbru1n7XKKUKbZJc5W13sXwTPjKB1I9v-ENY-QNNUctSEzhhQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3AAC1A0005E; Tue,  9 Feb 2021 21:08:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-93-gef6c4048e6-fm-20210128.002-gef6c4048
Mime-Version: 1.0
Message-Id: <a1277b1f-f829-4d02-9e54-68ab4faaa047@www.fastmail.com>
In-Reply-To: <1cd0c2ee-aa3a-4da2-9c0c-57cc5a1dad49@www.fastmail.com>
References: <d59ba191-43db-4b7b-b201-62a60ca752c0@www.fastmail.com>
 <20210209213330.hnc7op72zoj24mgz@pali>
 <7b0988cc-eeb8-4ea7-92f6-e8234ca910d3@www.fastmail.com>
 <20210209224223.p22yhjdy7ibzepss@pali>
 <93745280-dbe9-491c-a79d-c9c364b83880@www.fastmail.com>
 <20210209225630.mdwnzkvnaz3r4blt@pali>
 <a86c5069-d423-44db-92dd-b3e406b7ec91@www.fastmail.com>
 <20210210002619.43104a9b@kernel.org>
 <ac03801e-87e2-4e57-b131-bff52f03579d@www.fastmail.com>
 <1cd0c2ee-aa3a-4da2-9c0c-57cc5a1dad49@www.fastmail.com>
Date:   Tue, 09 Feb 2021 18:07:41 -0800
From:   nnet <nnet@fastmail.fm>
To:     =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, a.heider@gmail.com,
        andrew@lunn.ch, gerald@gk2.net, gregory.clement@bootlin.com,
        kostap@marvell.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        luka.perkov@sartura.hr, miquel.raynal@bootlin.com,
        mturquette@baylibre.com, rmk+kernel@armlinux.org.uk,
        sboyd@kernel.org, tmn505@gmail.com, vladimir.vid@sartura.hr
Subject: =?UTF-8?Q?Re:_[PATCH_mvebu_v2_00/10]_Armada_37xx:_Fix_cpufreq_changing_b?=
 =?UTF-8?Q?ase_CPU_speed_to_800_MHz_from_1000_MHz?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Feb 9, 2021, at 5:51 PM, nnet wrote:
> On Tue, Feb 9, 2021, at 5:31 PM, nnet wrote:
> > On Tue, Feb 9, 2021, at 3:26 PM, Marek Beh=C3=BAn wrote:
> > > On Tue, 09 Feb 2021 15:16:45 -0800
> > > nnet <nnet@fastmail.fm> wrote:
> > >=20
> > > > I've two of these and I've just swapped them (and re-pasted the =
heat sinks).
> > > >=20
> > > > The second one ran under load for awhile and now has frozen as w=
ell.
> > > >=20
> > > > Under a moderate load `wget -O /dev/null <large.bin>` @X00Mbits =
they are fine.
> > > >=20
> > > > Under a 1 min speed test of load ~200Mbits routed WireGuard they=
 freeze.
> > > >=20
> > > > They fine with both those workloads @1000_800.
> > > >=20
> > > > Perhaps it's heat? Unfortunately I don't have any numbers on tha=
t ATM.
> > >=20
> > > Try disabling cpufreq in kernel completely, compile boot image at
> > > 1200 MHz. If it continues freezing, then I fear we can't help you =
with
> > > 1200 MHz :(
> >=20
> > cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_freque=
ncies=20
> > 200000 300000 600000 1200000=20
> >=20
> > I'm not getting any freezes with 1.2GHz fixed after 20 minutes of lo=
ad:
> >=20
> > echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_f=
req
> >=20
> > Setting it back to min 200MHz I get a freeze within a minute:
> >=20
> > echo 200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_fr=
eq
> >=20
> > > Marek
> > >
>=20
> > +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108
>=20
> Based on the below at boot time might an equivalent of the above need=20=

> to be 1225 for 1.2GHz?
>=20
> 1200_750
> SVC REV: 5, CPU VDD voltage: 1.225V
>=20
> 1000_800
> SVC REV: 5, CPU VDD voltage: 1.108V

I did this for a quick test for 1.2GHz:

+#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1225

This is working well so far. Frequency is shifting up/down with load app=
lied/stopped.
