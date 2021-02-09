Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A1D315C4C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbhBJBbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:31:51 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:39817 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234902AbhBIXSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:18:20 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id BE783580130;
        Tue,  9 Feb 2021 18:17:07 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 09 Feb 2021 18:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=fEt3Y
        FQaxlrC3rwxsPeLLSKcyIdClrKAIsBNLkfSJ4k=; b=vQofj1HlniyCr+rhiMDAm
        JE3kkqRLxRAGF3imJR9moJY1vRZlGcKqeQThiabzoVRYh3Buk4dFf5YsvM00+9A6
        CiqUYiRaEtwdd9DoTwRjju8XwB9xOpv0yI5dflDcS/gDHbl2u9dmdXWDgVcT3sI4
        XjRnXFDsCmIYkGAM8RLiFuInoB8XlC841n9NaLz30Qv0thnjCwGVFGdfexlbgl/F
        Hl2mcGmDYQqpKhibA4azmxFn5zQN1OMazQrvwQDFyyyXKMDVm4EZQdZH7OgcnTGv
        SVgtdk9PmaFH1BqxboH7oK5gZQAOC2jXjv5FAEb0nVSzDLT/w6CKuOWPXvhs4Yy3
        w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=fEt3YFQaxlrC3rwxsPeLLSKcyIdClrKAIsBNLkfSJ
        4k=; b=lH/IVY3BGRwXZpmuWwxFpUoWLERLp972NnathZRHMtUX91cXimnHjlDRp
        nIePd027guv6dP3xbxqHbvQFWXwGQBaz2wGzxK/SLa87t9LxhLPX5lb6llkC/EdD
        HRFhUFCwqPYLsT7XFRHifzDwnDhFeYq7hEvcvKUt85xxAouyDx870Gozs02BfRYy
        WbtzzS5Tddmnn0aSZ4JmkDrILhltSyh/DzPF1d8mUcLntLHdqg2rFeFg7ig3XyfB
        fy5+MjrBw63njBt18J3S19VQGmUUzEsRxancfi6I5XeVR8PEQ1XAXfU3IIeZbj9A
        XUgl4Ty8CbHD8MlOJ3Uv2x7C9JnJg==
X-ME-Sender: <xms:8hcjYGDOKX_QG-oLdNG0PWNXMy8n01GrS6N94bhb09SDnOhs4NkWJw>
    <xme:8hcjYAg7rXyfjTfUtzG7APTLeqqlzrG-WOoI2lxW1m1Eoc_mnRUSk2uorJ4oTw9qK
    xBSEJE0jw31tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheeigddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepnhhnvght
    uceonhhnvghtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeeugeekvd
    ehheevheetieetudeljedvvddtieevvdeukeejgfeuheffueelueegueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnnhgvthesfhgrshhtmh
    grihhlrdhfmh
X-ME-Proxy: <xmx:8hcjYJmqiwvHmnO1GxPiQ_6QOkRjyvygDxwxuSozpsr0hncRqn6qDw>
    <xmx:8hcjYEyFrJ0PK9XWid405MclH1Q3cdn1U848nsTg2dtjRRhuLkjawg>
    <xmx:8hcjYLTNiijAktpZEIuzeyv_Hb119W7fF-Pwadrcl1AnZuL4y_Zelw>
    <xmx:8xcjYHrmCTw6zo3fOOaSw5QYhwha6jupimTJSBtpEsoCZgAxVYClQA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 014C0A0005E; Tue,  9 Feb 2021 18:17:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-93-gef6c4048e6-fm-20210128.002-gef6c4048
Mime-Version: 1.0
Message-Id: <a86c5069-d423-44db-92dd-b3e406b7ec91@www.fastmail.com>
In-Reply-To: <20210209225630.mdwnzkvnaz3r4blt@pali>
References: <d59ba191-43db-4b7b-b201-62a60ca752c0@www.fastmail.com>
 <20210209213330.hnc7op72zoj24mgz@pali>
 <7b0988cc-eeb8-4ea7-92f6-e8234ca910d3@www.fastmail.com>
 <20210209224223.p22yhjdy7ibzepss@pali>
 <93745280-dbe9-491c-a79d-c9c364b83880@www.fastmail.com>
 <20210209225630.mdwnzkvnaz3r4blt@pali>
Date:   Tue, 09 Feb 2021 15:16:45 -0800
From:   nnet <nnet@fastmail.fm>
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     a.heider@gmail.com, andrew@lunn.ch, gerald@gk2.net,
        gregory.clement@bootlin.com, kabel@kernel.org, kostap@marvell.com,
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

I've two of these and I've just swapped them (and re-pasted the heat sin=
ks).

The second one ran under load for awhile and now has frozen as well.

Under a moderate load `wget -O /dev/null <large.bin>` @X00Mbits they are=
 fine.

Under a 1 min speed test of load ~200Mbits routed WireGuard they freeze.=


They fine with both those workloads @1000_800.

Perhaps it's heat? Unfortunately I don't have any numbers on that ATM.

On Tue, Feb 9, 2021, at 2:56 PM, Pali Roh=C3=A1r wrote:
> On Tuesday 09 February 2021 14:52:56 nnet wrote:
> > On Tue, Feb 9, 2021, at 2:42 PM, Pali Roh=C3=A1r wrote:
> > > On Tuesday 09 February 2021 13:45:08 nnet wrote:
> > > > On Tue, Feb 9, 2021, at 1:33 PM, Pali Roh=C3=A1r wrote:
> > > > > On Tuesday 09 February 2021 13:00:26 nnet wrote:
> > > > > > > If you have other Armada 3720 boards (Espressobin v5/v7, u=
DPU, Devel Board, ...) then it will be nice to do an additional tests an=
d check if instability issues are finally fixed.
> > > > > >=20
> > > > > > These patches applied to the 5.4.96 in OpenWrt (98d61b5) wor=
k fine so far on an Espressobin v7 AFAICT per changing values in /sys/de=
vices/system/cpu/cpufreq/policy0.
> > > > > >=20
> > > > > > Are these changes intended to work @1.2 GHz on the v7?
> > > > >=20
> > > > > Hello! Do you have 1.2 GHz A3720 SoC?
> > > >=20
> > > > Maybe (not)? ESPRESSObin_V7_1-0 on the underside.
> > >=20
> > > Look at the package of SoC chip. On top of the package is printed
> > > identifier 88F3720. On the last line should be one of the string:
> > > C080, C100, C120, I080, I100 which identifies frequency
> > > (080 =3D 800 MHz, 100 =3D 1 GHz, 120 =3D 1.2 GHz)
> > >=20
> > > Can you check what is printed on A3720 SoC package?
> >=20
> > Both of mine are 88F3720-A0-C120.
>=20
> Interesting... it is really 1.2 GHz. I have not seen it yet. And few
> weeks ago I thought that it was never available on market.
>=20
> Well, if 1.2 GHz variant has same issues as 1 GHz variants then this
> patch series should fix it. But you said that with this patch series i=
s
> board crashing when running at 1.2 GHz?
>
