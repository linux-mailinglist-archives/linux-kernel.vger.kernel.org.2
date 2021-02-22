Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C82321D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhBVQij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:38:39 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:34453 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230218AbhBVQiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:38:16 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A258D5814F6;
        Mon, 22 Feb 2021 11:37:17 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 22 Feb 2021 11:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=c28hTrZAUemv4yqSSQH1LBZ4DoA5FmR
        Q414ixUeMM2Y=; b=n93/MUxYnt1mfFwvp4bF0iuyRDq8QMpIVFEbx8M9zL7YEmt
        Bsduc60yoriiSYl7qeQjaHqVDthjcRsMtJEcXBtPp8QLd5BZgmPEthKFnoanJO/U
        paa39Ym2UEK8cq6vIspTomaya9HrCKUCDnfn90sUDpHHjHyf/L5rQZrAw/cNoA4A
        0t9vo0ZrSEVXkLwMVlvaIRWTff9RAhxcK1B00dXv1Thrvo6oJrK48VQAgA/Ub1f2
        w7DrjRgI7fTu/cPYqp110ODlgXMTaig6ctquyiki0FvYsTb8rjUz2j6H+ZNCjTS6
        MPGvyjlS26TLbTwG45UHRMqCpd9Uu5QQf2//J0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=c28hTr
        ZAUemv4yqSSQH1LBZ4DoA5FmRQ414ixUeMM2Y=; b=ciGz/ivIUjuQDtCQrdmQ2D
        PZFPWMX1m2D1JYbSIpFf9TKQJoMW3SyiWY6VHuV7bO01O0HRDRRUffXfAh7Ki0IJ
        uOpR0LFHunD4tncFxv4eU58LcK8dLqL51fhbvqJBwRvFHvw6aYjx7cxdBJTajIvT
        U4VR1+DGZcK+jhxP12rXRYb1975tILeCbYPply1QPAoXZjBgKqOYRAM4mjRT7BnJ
        gg+OG+inm6XQAku6fCWVVf5Jud2OkocUl1i8vnZAIQz9ogyWMLXmbB5IKJRWuMEA
        N9euqRYv2f8tzensKapWiD0oT4q/oiPVVSnzrWcX7+cJbsWQgaKr7iiBXVvMynHw
        ==
X-ME-Sender: <xms:u90zYFX2EZSAy4eU3W1YL3QgUhx16WEv1PWjfscv7xn7aBkWYfqhIQ>
    <xme:u90zYFlcSEMGLcbHVbEN2O4g3IUjXoEkYi_nadE_PRy4PjKtRlZI2zF3neWMTFrq_
    -h7fjDnOsEaEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeefgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpehnnhgvthcu
    oehnnhgvthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhephfejledtke
    ehtdejtdekgfegheehfeevfeejffevkeevveekjefhtdehfeeffeegnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhnvghtsehfrghsthhmrg
    hilhdrfhhm
X-ME-Proxy: <xmx:u90zYBagM_A9SEqUYG8w4a7FZCSaCJl84_uPZr_ZcsUxm86Qmuk_gw>
    <xmx:u90zYIVZ-pTsyNkFoHDH-9NBXJR-Sp0Un4YsuN9JIlB42OlmeifgPA>
    <xmx:u90zYPlf5XMHBmcfvB0kKIWkbkxC33RNWqXA8bHC1YTF7t-70t064g>
    <xmx:vd0zYHngyDr_RocKIPve-KTS1ROUxGoxpTfwogCF5WdU8C8NudBCYg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C0D59A00060; Mon, 22 Feb 2021 11:37:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-141-gf094924a34-fm-20210210.001-gf094924a
Mime-Version: 1.0
Message-Id: <780f6c9d-388c-4d52-bab5-790cdd62b689@www.fastmail.com>
In-Reply-To: <20210222095111.zcokx4g3sqghjgyl@pali>
References: <20210211234445.hbv2diphmgbir76u@pali>
 <000b92cc-9b54-4af9-b95c-d1317fb6f97f@www.fastmail.com>
 <20210213100139.ckrscepg72zjkj4f@pali>
 <c0b02aa0-1789-43a3-8d73-057890f703f1@www.fastmail.com>
 <20210214123310.d6armpep7kxbymbu@pali>
 <675b7a74-066b-4dc0-8dcb-f11c5606ae52@www.fastmail.com>
 <20210216104141.umy6zrrkal3dlj5j@pali>
 <d057d7f7-27a5-45ec-88f0-a653572a8ca6@www.fastmail.com>
 <20210219193302.odcjcaukxxjaedd5@pali>
 <c0ade595-9bfa-4cfc-8c87-0e955173d5db@www.fastmail.com>
 <20210222095111.zcokx4g3sqghjgyl@pali>
Date:   Mon, 22 Feb 2021 08:36:55 -0800
From:   nnet <nnet@fastmail.fm>
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        a.heider@gmail.com, andrew@lunn.ch, gerald@gk2.net,
        gregory.clement@bootlin.com, kostap@marvell.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, luka.perkov@sartura.hr,
        miquel.raynal@bootlin.com, mturquette@baylibre.com,
        rmk+kernel@armlinux.org.uk, sboyd@kernel.org, tmn505@gmail.com,
        vladimir.vid@sartura.hr, "Philip Soares" <philips@netisense.com>
Subject: =?UTF-8?Q?Re:_[PATCH_mvebu_v2_00/10]_Armada_37xx:_Fix_cpufreq_changing_b?=
 =?UTF-8?Q?ase_CPU_speed_to_800_MHz_from_1000_MHz?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Could I add your Tested-by line to patch series?

Yes, by: Philip Soares <philips@netisense.com>

Thank you for the patches!
