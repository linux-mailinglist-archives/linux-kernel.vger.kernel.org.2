Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24D6315BD1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhBJBBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:01:50 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:35453 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234299AbhBIWVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:21:47 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id DC4245802F6;
        Tue,  9 Feb 2021 16:45:29 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 09 Feb 2021 16:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=60hEJ
        9ZPejN7IYrMR4SNa4nZxVrUpUb1gFS1Sg1WH4E=; b=AINfIep4odvEBIbj60yZH
        viH9H5pqw6MGxVtah211WWmWYV0h+QsVqkrqd8DszSypMKsuIwEaUHJ4MZJqZ49V
        GZs0bpFdw9UZYQjKMAw4mk3DPH99JXHTeCRJS4cVjK13jIbqLVLmihWOclpy7bS1
        A80nBwuTQq8AjnqZnaiTGHIVnM0GnsyCEqa80u5ikEzNE9tH3aH9Z48tE3plEBcn
        nypicWOz6CR137O927aY7nuCnameWPxLxYFoI0qGFmrh2yeQyhq1jjRuRl89cM9p
        Hzm3WiS29922Wg4gEH94puxoOKPHHHKEQ6rucJt6he0xXUsmDF1Cldqe/n8UTAZh
        A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=60hEJ9ZPejN7IYrMR4SNa4nZxVrUpUb1gFS1Sg1WH
        4E=; b=aV8sTuo6cv+6LeAmFDBhKprqA83z46R5COXCH8X5Atn3rYejz0ZlLWHvV
        g4Q8ylSk5aADq8oCncSMYkDCmm5AMRgnhOGiOFeORaFEZO9mlmVGV4S/Af6R0pIy
        Dl2PTpvRi6UNmNB9Dza9oNfoSl4o29IqL4cFEqXOV1GNNAYlQDc2Rn+ZOk3pvhmN
        L2D0KU8vxuGytvmGZqR2PSjH2L/Ygsca1ZDRVt/oFwEgZlUauNiqiruw7PkiGV9g
        e1jDBaAk4l4Sb+7/TV1IEbHfKtwAroma+luGYRRmuRF/xUBBHxA9UA7GmyWr9eIH
        PsoZsDTpVorMynwIKwN3A3Fp7kPUA==
X-ME-Sender: <xms:eAIjYPrghdlV4YQR8i0QnzhCtHilOhRh4JbrlgQsmfVZ8juxmoOD-Q>
    <xme:eAIjYJqCj2BwjEB9NLOdYeRlVzlNMFJU5ce0PXpWlG6MJVstQfMWGkmU5tEy8N_j4
    EIqPxbfLwZ3Nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheehgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpehnnhgv
    thcuoehnnhgvthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepueegke
    dvheehveehteeiteduleejvddvtdeivedvueekjefgueehffeuleeugeeunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhnvghtsehfrghsth
    hmrghilhdrfhhm
X-ME-Proxy: <xmx:eAIjYMNPyfWFIZwhPPAI3T6NannkpdYKRiM1D27tnPMRLzBzwLBgxg>
    <xmx:eAIjYC6UB2ufdpSKjmQYMCElh19AMWEcIGPuIBJ58NGsFjKl3peX0Q>
    <xmx:eAIjYO4vBxyY7fn5ZBtRzWMed5KCDdiz433yuDzQJXZlWtfRKQy_qQ>
    <xmx:eQIjYNScGs4tyoc-ab52Qk6gndotywU2JDwE3p79fpZvI18M2zWMuw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ABF3BA0005E; Tue,  9 Feb 2021 16:45:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-93-gef6c4048e6-fm-20210128.002-gef6c4048
Mime-Version: 1.0
Message-Id: <7b0988cc-eeb8-4ea7-92f6-e8234ca910d3@www.fastmail.com>
In-Reply-To: <20210209213330.hnc7op72zoj24mgz@pali>
References: <d59ba191-43db-4b7b-b201-62a60ca752c0@www.fastmail.com>
 <20210209213330.hnc7op72zoj24mgz@pali>
Date:   Tue, 09 Feb 2021 13:45:08 -0800
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



On Tue, Feb 9, 2021, at 1:33 PM, Pali Roh=C3=A1r wrote:
> On Tuesday 09 February 2021 13:00:26 nnet wrote:
> > > If you have other Armada 3720 boards (Espressobin v5/v7, uDPU, Dev=
el Board, ...) then it will be nice to do an additional tests and check =
if instability issues are finally fixed.
> >=20
> > These patches applied to the 5.4.96 in OpenWrt (98d61b5) work fine s=
o far on an Espressobin v7 AFAICT per changing values in /sys/devices/sy=
stem/cpu/cpufreq/policy0.
> >=20
> > Are these changes intended to work @1.2 GHz on the v7?
>=20
> Hello! Do you have 1.2 GHz A3720 SoC?

Maybe (not)? ESPRESSObin_V7_1-0 on the underside.

BTW, with the 1200_750 firmware and the patches:

root@OpenWrt:/sys/devices/system/cpu/cpufreq/policy0# cat scaling_availa=
ble_frequencies=20
200000 300000 600000 1200000

Of course that could mean nothing, but thought I'd mention what I do see=
.
