Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE19315D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbhBJCVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:21:07 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:54837 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234845AbhBJBcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:32:42 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D3B6A580282;
        Tue,  9 Feb 2021 20:31:32 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 09 Feb 2021 20:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=s6nVz
        auOg7gdaQYo/9fMFzd6zZgEJznU8/zLh2CdmOo=; b=MEXjeX3rRsUgs0ZDcn5vz
        QpFqnnHy2vR1gLGXE2JUlbaipu3xNNMijwn0/eiASJ7oeI3Q33cIl3ho84QYEbLQ
        FlGZ9aG7QFYxa/qL8pd73Ly5R1vZNBqrlvY/OI4dpjr1EgqKq3W0/zj8b9PM2834
        VkLKipeW772ZYzYo6p0Ln25HVsAkAqGZEqqyc1Lmq4J/X/HYj5Maf2JzUCV9u0J/
        ox7LXeRskYgp71FU1Es7zHzOVSbL9sZLP2H1mQvivyj4k4dKReWv8ql1AE1wHx9Z
        Zc9d4+0kETLTIyCiz9J1i17Qs/p3ZeXPXTRU9fi5I/JnqNRJxYSVoE0IAx7LXNyP
        w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=s6nVzauOg7gdaQYo/9fMFzd6zZgEJznU8/zLh2Cdm
        Oo=; b=ZNmYjG/ZFbB3ZX12HoeFDrMAvmcSvkgSXVVNd1essph1wxtgysSQ/Ar8p
        yTPdIjDCzpjYngxNJKOejGvE5BxgZ3p0RIXUgNJ0G5MIUYFtcQCyn5lORmXVDavo
        DlQ06hxokmRMwGucnanksUwQKVDM0XZh2fqtez6ToHfnx1/XQH0WO6zKc0IY/K/C
        4jp/1VFU5spt+23R9PG86St1GyPaUBRa4e6kBZdgcKZsLucGvHKf2aAG0Yn7BE30
        6+wQtjesK8dKWmN5YKpKVtQSpzvrcksN/yyKFcigqo/wtpGAhUNFZdECA03emMje
        Y93EqN73w/JxQI8nf9kNiZ1kuV4bg==
X-ME-Sender: <xms:czcjYFma3q3L73P8PK0ZS9T2ECdQxpz2K7SkBnRfrGVhfuWq2haQ_w>
    <xme:czcjYA3KdcYntNHd4LXehIyak3LIeFG0g0w4QwF5YTH5oymGR6dvUEwoMtPM1PPJ1
    RY4_ue2XaX3AQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheeigdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepnhhnvght
    uceonhhnvghtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeeugeekvd
    ehheevheetieetudeljedvvddtieevvdeukeejgfeuheffueelueegueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnnhgvthesfhgrshhtmh
    grihhlrdhfmh
X-ME-Proxy: <xmx:czcjYLoNC9XxFq-xySFKpkf4r9g_dvM8xMDAh4QtmCi1-_thPxoHWQ>
    <xmx:czcjYFlgZdxWOepSB7uUSbXuYxOcfeLOPtSZkElXP7eqotoatqJGwA>
    <xmx:czcjYD3ACSh_liAFqXMa4gcU-pJNEz8S47EOHJpU21-PvsMhMVlsFw>
    <xmx:dDcjYNOQ-TXMBAyf5bctxW0NxDGsOugwGEcYso_wmwin2kcD2qDOtw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2AFF6A0005E; Tue,  9 Feb 2021 20:31:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-93-gef6c4048e6-fm-20210128.002-gef6c4048
Mime-Version: 1.0
Message-Id: <ac03801e-87e2-4e57-b131-bff52f03579d@www.fastmail.com>
In-Reply-To: <20210210002619.43104a9b@kernel.org>
References: <d59ba191-43db-4b7b-b201-62a60ca752c0@www.fastmail.com>
 <20210209213330.hnc7op72zoj24mgz@pali>
 <7b0988cc-eeb8-4ea7-92f6-e8234ca910d3@www.fastmail.com>
 <20210209224223.p22yhjdy7ibzepss@pali>
 <93745280-dbe9-491c-a79d-c9c364b83880@www.fastmail.com>
 <20210209225630.mdwnzkvnaz3r4blt@pali>
 <a86c5069-d423-44db-92dd-b3e406b7ec91@www.fastmail.com>
 <20210210002619.43104a9b@kernel.org>
Date:   Tue, 09 Feb 2021 17:31:10 -0800
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

On Tue, Feb 9, 2021, at 3:26 PM, Marek Beh=C3=BAn wrote:
> On Tue, 09 Feb 2021 15:16:45 -0800
> nnet <nnet@fastmail.fm> wrote:
>=20
> > I've two of these and I've just swapped them (and re-pasted the heat=
 sinks).
> >=20
> > The second one ran under load for awhile and now has frozen as well.=

> >=20
> > Under a moderate load `wget -O /dev/null <large.bin>` @X00Mbits they=
 are fine.
> >=20
> > Under a 1 min speed test of load ~200Mbits routed WireGuard they fre=
eze.
> >=20
> > They fine with both those workloads @1000_800.
> >=20
> > Perhaps it's heat? Unfortunately I don't have any numbers on that AT=
M.
>=20
> Try disabling cpufreq in kernel completely, compile boot image at
> 1200 MHz. If it continues freezing, then I fear we can't help you with=

> 1200 MHz :(

cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencie=
s=20
200000 300000 600000 1200000=20

I'm not getting any freezes with 1.2GHz fixed after 20 minutes of load:

echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq

Setting it back to min 200MHz I get a freeze within a minute:

echo 200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq

> Marek
>
