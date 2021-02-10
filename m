Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56E0315D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhBJCYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:24:30 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:44121 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234702AbhBJBxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:53:32 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 854D4580204;
        Tue,  9 Feb 2021 20:52:45 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 09 Feb 2021 20:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=p6NRG
        9cTIZ5rhwwvHEzJDcHL3eq7csRUbH4kHhiRL5w=; b=wR/47LEdi0qRyvfWW7KDF
        NhsnaH5vFsS1Od4TZb+PpB+UGaOS2JI6Tb9T2POjzsAN/N2gWfjOqtF0NB3GY+IH
        bIzTP6Idm4QfbCOZBG4+Rml/UElqK9vNa9C3CeuxxQai3wFoz5DCAnSc3Hs3lzvN
        OJmzF1/T2l6q7kJbwKfD3sKQ9bPyLCgVQ6sN21L7nG7NWM5qsx4aQs9T8olbnbVA
        PYR4tpzEML/DzNd3bzv/1U+GSjKDuz8ixqTx9V3jZremvAi/jfm1JyUaqbOO3iO5
        YA1ZKSar7qtjNWagVvyY5uzj5hJ/dStCDYhqk51g6TkNkAH/ALHLIgl/jD6WDOgZ
        A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=p6NRG9cTIZ5rhwwvHEzJDcHL3eq7csRUbH4kHhiRL
        5w=; b=U+FX4VNcNH+xmhmFY/LBjMECTA3zbZyxH5z6IhmTlESJtxYp46pLIvIKu
        F6BhSoBqh+bPex3iekIjQxGPIGQhKs9EBP3klCd5AeLj8w5ukRNjECoo1am0ZEJm
        RhH/+Wd8re2kcEGPvns0exLOn9kGuuqr02IBl+9VgScwI4AF3Dd9hKXhpnKc9+iZ
        Sifad4sO0uYEKNB4W0awdIDh0UaDulAKIL6FRoKwgISGPIqc8kvU5ZOyNAut/Dor
        W8I6xQ/X8JCOaps+p/HPD4pQQTr/iz0BwMlxUHmSaGxTCDBicbKDsNBJPb7jqmwl
        MzQKof1w3cfT6cmAyJe/MreOveUoA==
X-ME-Sender: <xms:bDwjYEn-F0vwPGO2x-ahKWhJd7KoPnYPNhrB65SOO-8JDPMyTebCHg>
    <xme:bDwjYD337ogMvV5cYb8hsQ3WeAUwB9iNp3QN1I1sZmCb_UxGtyJD32oyze2Suyuhe
    ASQA9a-QpBZlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheeigdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepnhhnvght
    uceonhhnvghtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeeugeekvd
    ehheevheetieetudeljedvvddtieevvdeukeejgfeuheffueelueegueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnnhgvthesfhgrshhtmh
    grihhlrdhfmh
X-ME-Proxy: <xmx:bDwjYCprfMnyIoHBViYb1lRYILxetPZ4xrwQITxVoQOux6FMvQsv-w>
    <xmx:bDwjYAnJ3A36UK4NtkEoJZdjeXGwFFWLesPkz0Lmt7ZW6cyh81zK1A>
    <xmx:bDwjYC1zL6Il8MAbBuKKlDycsP7hVPZC8A5H3wpiH6BboZHA1L_k0Q>
    <xmx:bTwjYMPewVu3puKwBwJYpr4WZal_-jZu9fzuNH12ow98f6UdWruLmg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3A230A0005E; Tue,  9 Feb 2021 20:52:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-93-gef6c4048e6-fm-20210128.002-gef6c4048
Mime-Version: 1.0
Message-Id: <1cd0c2ee-aa3a-4da2-9c0c-57cc5a1dad49@www.fastmail.com>
In-Reply-To: <ac03801e-87e2-4e57-b131-bff52f03579d@www.fastmail.com>
References: <d59ba191-43db-4b7b-b201-62a60ca752c0@www.fastmail.com>
 <20210209213330.hnc7op72zoj24mgz@pali>
 <7b0988cc-eeb8-4ea7-92f6-e8234ca910d3@www.fastmail.com>
 <20210209224223.p22yhjdy7ibzepss@pali>
 <93745280-dbe9-491c-a79d-c9c364b83880@www.fastmail.com>
 <20210209225630.mdwnzkvnaz3r4blt@pali>
 <a86c5069-d423-44db-92dd-b3e406b7ec91@www.fastmail.com>
 <20210210002619.43104a9b@kernel.org>
 <ac03801e-87e2-4e57-b131-bff52f03579d@www.fastmail.com>
Date:   Tue, 09 Feb 2021 17:51:53 -0800
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

On Tue, Feb 9, 2021, at 5:31 PM, nnet wrote:
> On Tue, Feb 9, 2021, at 3:26 PM, Marek Beh=C3=BAn wrote:
> > On Tue, 09 Feb 2021 15:16:45 -0800
> > nnet <nnet@fastmail.fm> wrote:
> >=20
> > > I've two of these and I've just swapped them (and re-pasted the he=
at sinks).
> > >=20
> > > The second one ran under load for awhile and now has frozen as wel=
l.
> > >=20
> > > Under a moderate load `wget -O /dev/null <large.bin>` @X00Mbits th=
ey are fine.
> > >=20
> > > Under a 1 min speed test of load ~200Mbits routed WireGuard they f=
reeze.
> > >=20
> > > They fine with both those workloads @1000_800.
> > >=20
> > > Perhaps it's heat? Unfortunately I don't have any numbers on that =
ATM.
> >=20
> > Try disabling cpufreq in kernel completely, compile boot image at
> > 1200 MHz. If it continues freezing, then I fear we can't help you wi=
th
> > 1200 MHz :(
>=20
> cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequenc=
ies=20
> 200000 300000 600000 1200000=20
>=20
> I'm not getting any freezes with 1.2GHz fixed after 20 minutes of load=
:
>=20
> echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_fre=
q
>=20
> Setting it back to min 200MHz I get a freeze within a minute:
>=20
> echo 200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq=

>=20
> > Marek
> >

> +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108

Based on the below at boot time might an equivalent of the above need to=
 be 1225 for 1.2GHz?

1200_750
SVC REV: 5, CPU VDD voltage: 1.225V

1000_800
SVC REV: 5, CPU VDD voltage: 1.108V
