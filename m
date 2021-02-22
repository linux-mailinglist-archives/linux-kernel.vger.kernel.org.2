Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD58320FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 04:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBVDS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 22:18:57 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:60323 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229735AbhBVDSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 22:18:48 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 19DBD580733;
        Sun, 21 Feb 2021 22:18:02 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Sun, 21 Feb 2021 22:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=pncbO6UEb+m+8vOmGoE/SecasoVV8iw
        T/YMMuVYgrJ0=; b=ereB1HbvQy/FIy5J9cGXdt/uP/K2XPS5ttu6hK1tuZ5ypGL
        rbBhkY04K0RAKWX3HvDZw6JieXtEyp5O9rmZErTf6RVVnatIOnp3JvIIdn24vdpb
        Dg88jy4qhUh/ie5vskES2xZLpHksBE8RwAYWtzejzT2hM6l4RkYMYsQaelZAd9Zq
        0LG8yDVlrIK1g8SdcnVV5O2XDGNIpVfWNWZkkganyg8dZt09v42Xa4TvxxVuGy5z
        wf26vKLggbZfLx7v3u9TW5no/bSLa3EYoz+WttDL/qwOOJibxP51541CJjrpFssz
        ZZn7qn0aVzZiwZE6i4frOqw3s/b1CEuhyS43ffA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=pncbO6
        UEb+m+8vOmGoE/SecasoVV8iwT/YMMuVYgrJ0=; b=FalWMqtEOqXwA2nc6b8pzT
        zYp/7qtL6KnYcjY2MsOOpcvOcHNa4eZXBt8rCbOa/xMEgmgYP4CcmTSMCkF4p4hW
        QJUaKybvT4dXaN8ZGgrse0qZ/hyPHttxKXWCLjNfT3s5T5z4pd++YCzSzzkXwIYN
        tVSQu6qolDWVQ5Hm+XwnG02aTv2uaXVSgo9slZT0fohJoNvPf3/c+V4TIOEIS0FR
        MYKWxHZwbXmqvzIKH6pdFjlDT0yIOzACTqe+7homPzzJPQC5GoQBfUBghFCUtVAz
        6ptktBerlYvmUTlX65W17oIzSKAJ5miMqaYHvvQU7Ip58o9f6lf1OZjPBuBK7lBQ
        ==
X-ME-Sender: <xms:aCIzYNDKf1lfCgN6Ovl5vR5YG8zlj0sjFBt5OCCS0Gap6LcS0qE1JQ>
    <xme:aCIzYLhWVotw-At9GflSkagk0eVYQf2SmZxDn-m84p7B-d6b2M94n1FQZAjywsFPK
    0UfobiMghLWuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkedvgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpehnnhgvthcu
    oehnnhgvthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhephfejledtke
    ehtdejtdekgfegheehfeevfeejffevkeevveekjefhtdehfeeffeegnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhnvghtsehfrghsthhmrg
    hilhdrfhhm
X-ME-Proxy: <xmx:aCIzYImUrF7YZ34y7NC8ADvQSxGUVeAvbmnUxh_S6rRmQ6tinWLUKg>
    <xmx:aCIzYHzAHV447Se7x8e3u-N-p23CUG8SrCjiUnSfRUXxVDmbbPGLIQ>
    <xmx:aCIzYCQhLgQCk43-AjSs5LL3GROqzLx0TlALYxoMp8yL2QNZVeV79A>
    <xmx:aiIzYOp81DGwK7nC7moWuOr8BIr2G_1A2QDB9WyMg_ddOfs3WnWryg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 586EAA00060; Sun, 21 Feb 2021 22:18:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-141-gf094924a34-fm-20210210.001-gf094924a
Mime-Version: 1.0
Message-Id: <c0ade595-9bfa-4cfc-8c87-0e955173d5db@www.fastmail.com>
In-Reply-To: <20210219193302.odcjcaukxxjaedd5@pali>
References: <20210211195559.n2j4jnchl2ho54mg@pali>
 <1ad78446-4a40-4c3e-8680-6dbf19616515@www.fastmail.com>
 <20210211234445.hbv2diphmgbir76u@pali>
 <000b92cc-9b54-4af9-b95c-d1317fb6f97f@www.fastmail.com>
 <20210213100139.ckrscepg72zjkj4f@pali>
 <c0b02aa0-1789-43a3-8d73-057890f703f1@www.fastmail.com>
 <20210214123310.d6armpep7kxbymbu@pali>
 <675b7a74-066b-4dc0-8dcb-f11c5606ae52@www.fastmail.com>
 <20210216104141.umy6zrrkal3dlj5j@pali>
 <d057d7f7-27a5-45ec-88f0-a653572a8ca6@www.fastmail.com>
 <20210219193302.odcjcaukxxjaedd5@pali>
Date:   Sun, 21 Feb 2021 19:17:40 -0800
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

> Could you test if 1.155V voltage for L1 is stable on 1.2 GHz variant?

++#define MIN_VOLT_MV_FOR_L1_1200MHZ 1155
...
++              if (avs_min_l1 > dvfs->avs[0])
++                      avs_min_l1 = dvfs->avs[0];
++
++              if (dvfs->avs[1] < avs_min_l1)
++                      dvfs->avs[1] = avs_min_l1;

This works fine. Tested with switching 600MHz to 1.2GHz under load.
