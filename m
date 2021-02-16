Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D415C31CE09
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhBPQ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:28:49 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:58473 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229812AbhBPQ2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:28:41 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D670A58016D;
        Tue, 16 Feb 2021 11:27:34 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 16 Feb 2021 11:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=5u+CoCQxCQHhuISnr7oaYs4kFfzp5tD
        HZ80oWDpg/OM=; b=A5IzYkDA9xR5Ja1bOpctMItWprM6ZOFcYl/a7Eh7UOJdUKp
        uRFMNMfurMYO9pcNyLCoXIz/rG2GeMoMiQZNBuTHoqijnsFM6H4I+qf6oVdcZ37K
        RES1DgCDiEoT6F2GR8yQ7eka2u6Gj6Xl7czQbWIq6RtwjwhOduYXYiT/ccERNNFU
        udmRWfmmphm95wDJy0u6kDcGZk51/KTg5G/g3TmhdwF6brs44GnSEQB1X6gymJtp
        5Hs0XqHyInE9DHgOTNrcGFHDsYn9KWzhnt0bzZBlLnI4wDVHiw5Z7QwYxZdDaoYk
        e9/Rl25ydHuB8S3L5s72tIEcHbMaCp7Ppgtcjrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5u+CoC
        QxCQHhuISnr7oaYs4kFfzp5tDHZ80oWDpg/OM=; b=FOEfrp0zCb+crUOx+Lr0U1
        bELTWwLDVYghTOTHlUheCZQ53XtchkjaxSrhoR8iYfRT2mzejm5UE9noHzcVO8VT
        nyUDemfGb2vG/CA6seGVVL4Tu8fVkOzc3DjQINYRwuRwfugKQu3Gv0g/XZXTfS5s
        q/Bfyd36yCn51i9Km2KxJMQ6TaVLosxdq0OucfN8chyfO805osqiGQg81NJ+0CHN
        O5AxQeBD0hx0erpUrsMlA4w67pRYwx5PsmHFxuFArfITgTOrgo5Yi7DP7o5scAid
        9pbWxzBQooB9uti2JxBYtufy/Xyieg7+TJqapuX5pDSmMHaCid9Y5QLMOuMz13mA
        ==
X-ME-Sender: <xms:dfIrYNq9Q8bzQ04_33ZUcxGXlbymi05B2VFcykn-yMUnzWvnXgmtWw>
    <xme:dfIrYPrNV6BSy_q_o2mt0PInxdzACFgXrN21DPMt5bsFauQxewmc1t-U3wcMh7NUY
    EiAUOagpiy-YQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjedtgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpehnnhgvthcu
    oehnnhgvthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhephfejledtke
    ehtdejtdekgfegheehfeevfeejffevkeevveekjefhtdehfeeffeegnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhnvghtsehfrghsthhmrg
    hilhdrfhhm
X-ME-Proxy: <xmx:dfIrYKOnSc7Q_I-DeD8-ZkQGL-E2GbEC7SsRS1gcVc8wlKhq_EM3mw>
    <xmx:dfIrYI4-ICsoMAzGRPl2YrrnQQAoFxeiVPzu38ArfW15uo8eYwMA_w>
    <xmx:dfIrYM76GWCWdmlNg78Dg1eiSxWcyTwHEIfM3xUPYhhDjsvJP-FFFA>
    <xmx:dvIrYLQt--O_EPMM_JWDPZaWyneGnXxWuYc1K0sxf6A3R-PurIIFqA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 07794A00060; Tue, 16 Feb 2021 11:27:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-141-gf094924a34-fm-20210210.001-gf094924a
Mime-Version: 1.0
Message-Id: <d057d7f7-27a5-45ec-88f0-a653572a8ca6@www.fastmail.com>
In-Reply-To: <20210216104141.umy6zrrkal3dlj5j@pali>
References: <20210210180322.rlfxdussqhejqpo6@pali>
 <966f50f2-68b2-4d4f-85f0-396df112c0f4@www.fastmail.com>
 <20210211195559.n2j4jnchl2ho54mg@pali>
 <1ad78446-4a40-4c3e-8680-6dbf19616515@www.fastmail.com>
 <20210211234445.hbv2diphmgbir76u@pali>
 <000b92cc-9b54-4af9-b95c-d1317fb6f97f@www.fastmail.com>
 <20210213100139.ckrscepg72zjkj4f@pali>
 <c0b02aa0-1789-43a3-8d73-057890f703f1@www.fastmail.com>
 <20210214123310.d6armpep7kxbymbu@pali>
 <675b7a74-066b-4dc0-8dcb-f11c5606ae52@www.fastmail.com>
 <20210216104141.umy6zrrkal3dlj5j@pali>
Date:   Tue, 16 Feb 2021 08:27:10 -0800
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
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Therefore I'm thinking if the correct way is instead to use L1 := L0 voltage value for 1/1.2 GHz mode.

This latest 04/10 works fine for me going 600MHz <-> 1.2GHz under with and without load.
