Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067D331C66B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 06:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBPFtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 00:49:53 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:50443 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229617AbhBPFtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 00:49:50 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 7FC1A132B;
        Tue, 16 Feb 2021 00:48:43 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 16 Feb 2021 00:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=WSnSql5Nk/B6CTEKY4t61hWZEpUE18B
        J+CK9zfoz99g=; b=I4oGdPxqHKObB/YTMrLFV3FNNUI+yjEZcjnVYOjZpjtwK0T
        TAbyCWcg/ojykZHGcmu7fM3Ea4MGO/J+4nOhfWS2uTUThwiuIIG6apxJEhdMPCQP
        cH9Z0ZrQVfhJgLl/mlCDi/5TEEFcmwVfXU5j4ZT0g65+UhWKoU45oo1FEDmhkrDk
        G/Rg3ujRXdPwXtkap68oWCAqzMKCZX//3SGpnWQL8v24QzZckc+tOv+uXrFxOZYJ
        eaYdhtblfF9e9xvKZHwUsM+O2D2UmnMDSXrUeUSWq6Xi9TPbEcyYm83VBhQ1fRJN
        TxDd/PThoAbs17+Li4nv7RCXFtZRP0COaKpog8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=WSnSql
        5Nk/B6CTEKY4t61hWZEpUE18BJ+CK9zfoz99g=; b=aH6eJjgHx+VbycUNBb+bC1
        /Z5tPNlocPPLrhtCc+V5ZTq1e9Nuyn7mxckueHz/RgZKV5wvQhmTi48mk5qbfDOo
        xWpf3qasjpjDuzGKqPoJVRgPb4y4Q5G9P46G6L4YIgAUQ6A1/eUnwp08FO87+Atl
        v+pGgLTLMmuDrO8QakB2jT5Y95ztnrzCnkkcMy575ySMFGE5N4yk7vDlw0hcgMAW
        +/Dlj8hOWCWoKCgccIWqPPTpCUaE/y7t298DglebHNFbBx4gJBTlKfokl33IQExG
        xMHngYrDashTOZQuxKguA7ecAb75YTPPkjSt4Im00sHU150cbtubjtKJ9YLZRt7A
        ==
X-ME-Sender: <xms:uVwrYFz-DLs9r62UGEEFLmUDlEVEyxOJIUuSth0QoGZhqJetIyIeqA>
    <xme:uVwrYFQR1d0vX2yDIchDbJJ4ymI4wdKGU7bVA0q6R-ocG1dHhd7Uh-UXj-DJ6U1lp
    Tp1q4C_antk0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrieelgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpehnnhgvthcu
    oehnnhgvthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhephfejledtke
    ehtdejtdekgfegheehfeevfeejffevkeevveekjefhtdehfeeffeegnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhnvghtsehfrghsthhmrg
    hilhdrfhhm
X-ME-Proxy: <xmx:uVwrYPUwGqozu9AFAw6U5JrLiaWh8KqwMRSrC4udlCKT6Kmhf-BaSA>
    <xmx:uVwrYHhi4tEvT6Wm0NmM6K-hF-lIELeS2Xs-BoDL6T94zvMWn4zGHQ>
    <xmx:uVwrYHCBv9Re_P6C4gvnmZ3sRBz_l49iIe7erce0aDbBA812j3I9gg>
    <xmx:u1wrYPZw0Pz3TvHMgYa2-nYD4RZ-uVIFOoSPdWZ4WhzEjFAE222TVGfAjmk>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 87BA3A0005E; Tue, 16 Feb 2021 00:48:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-141-gf094924a34-fm-20210210.001-gf094924a
Mime-Version: 1.0
Message-Id: <675b7a74-066b-4dc0-8dcb-f11c5606ae52@www.fastmail.com>
In-Reply-To: <20210214123310.d6armpep7kxbymbu@pali>
References: <20210210092339.qy6wwuq6qr5m2ozr@pali>
 <d6971325-af71-4f71-91c2-7b661804c022@www.fastmail.com>
 <20210210180322.rlfxdussqhejqpo6@pali>
 <966f50f2-68b2-4d4f-85f0-396df112c0f4@www.fastmail.com>
 <20210211195559.n2j4jnchl2ho54mg@pali>
 <1ad78446-4a40-4c3e-8680-6dbf19616515@www.fastmail.com>
 <20210211234445.hbv2diphmgbir76u@pali>
 <000b92cc-9b54-4af9-b95c-d1317fb6f97f@www.fastmail.com>
 <20210213100139.ckrscepg72zjkj4f@pali>
 <c0b02aa0-1789-43a3-8d73-057890f703f1@www.fastmail.com>
 <20210214123310.d6armpep7kxbymbu@pali>
Date:   Mon, 15 Feb 2021 21:48:08 -0800
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

> Could you test following change instead of PATCH 04/10? I added here also
> logic for 1.2 GHz variant with 1.132 V value another change is that
> value for load L0 is not touched as it is stable.

These changes to patch 04/10 worked going 600 MHz <-> 1.2 GHz , _but_ only with:

++#define MIN_VOLT_MV_FOR_L1_1200MHZ 1213

During this latest testing I saw freezes with 1132 mV.

I've had no lockups with 1213 mV which I just used from the values for L1/L0 from OTP.

I only tested with those two values.
