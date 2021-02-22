Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F33321D46
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhBVQmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:42:53 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:50345 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230129AbhBVQlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:41:55 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 91A4758155C;
        Mon, 22 Feb 2021 11:40:49 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute5.internal (MEProxy); Mon, 22 Feb 2021 11:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netisense.com;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=L+bj/W++TY3dKwF/2mKVbsPiYyP3
        2H13xd3PzjJYqJ4=; b=bGZS7T7E6EWijOZKXPZJr7oGjxVPIO+mf4eog5LWrPiG
        RDesySZrgmlmKhx+edhFHlAnWf5V7ll4wWNaztDeojJAOsEELqsKXJIWUIfCmTC6
        ywZS7/y43UWTCA/Zdp4hCxK5Roc6q97DtlJwpV5FeP6diYDyQrjAevUUi+KvOdPJ
        Y7oL1bwFSLHd4nsmiPAJhDPZo9RiA8cZIUSNc8Hw9NFAx5Ni+an40Y5L8YUTJgJg
        hb+GaFwdMCYvHRSgYnHyL+XVM22ppoYN0JaqMCur+G90KDaimtowgjzZT3Qb7jM8
        6KMov2HEJspitR3/qf8PjpEUG2Ue0oFhRGtqpmL3JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=L+bj/W
        ++TY3dKwF/2mKVbsPiYyP32H13xd3PzjJYqJ4=; b=fpeLB/EQyGWvViXrVKRv9R
        8iBTfJJDhas9I75FqPtE0ZnGm+C7Hn88UCJ7wyxpqpCpgaUfVzI7+kB5LTDfLolN
        XqEk+5JBeJOmOwacGE04gW9u/9abjowSUM689GJB8yp7RX5ycAhzAxEXXaXE+0sg
        iQVTeyATxMcF8C5T1oKFpuEHJmG1stHO0J4ZDy7UWNnPVqvviqaRI6K0IxT2A+1a
        acUeQsbZNyJeX4+ij9fVu8+qXnmhWpy7r/ab+OQ3ss16wnsRLPkzG0/RHnEC6jAH
        VFf20PXHFNMvnMS17f9V5B3771hKtYQrwlgeuv1cix5bU60XDSZkmqwrYm+hdiyw
        ==
X-ME-Sender: <xms:jt4zYJEee_dbtsz1eLIkqDxUAz2lDrQQcvF1Xk8TAjbMdHbNfjfbcg>
    <xme:jt4zYOVlhDAT4PGLLwynzGIlDQ5l3xyVC6tFKpUeZpCQAo8tWlbp3yOUBz7Bg_Jnm
    u5MmGq9LNZOnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeefgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedfrfhhihhl
    ihhpucfuohgrrhgvshdfuceophhhihhlihhpshesnhgvthhishgvnhhsvgdrtghomheqne
    cuggftrfgrthhtvghrnhepueeffeejgeeludeutefhkedtffelffehjefgueeuteelfeek
    geeuueegfefguedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhhihhlihhpshesnhgvthhishgvnhhsvgdrtghomh
X-ME-Proxy: <xmx:jt4zYLJ4ZxjaTsJNvOuJojKizuDhYK6jVPjqb1KF319gA0b8neyhdA>
    <xmx:jt4zYPG7eT-kKYmJkRYdDYOTMaxH6NU-BR3avgCUNdkcjGaE6KRijg>
    <xmx:jt4zYPVPH-LO4KNajobcqJW49XmkyB3Sv9IfW9o_TKhiKcfIOzfUFA>
    <xmx:kd4zYIXqSQjsBknOzO6JkLXvIQqIKJbT0SgkKOKP0c5zwUkwHx10hQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 374EAA00060; Mon, 22 Feb 2021 11:40:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-141-gf094924a34-fm-20210210.001-gf094924a
Mime-Version: 1.0
Message-Id: <100ef73c-8b60-4653-9de6-dbae0a60bd01@www.fastmail.com>
In-Reply-To: <780f6c9d-388c-4d52-bab5-790cdd62b689@www.fastmail.com>
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
 <780f6c9d-388c-4d52-bab5-790cdd62b689@www.fastmail.com>
Date:   Mon, 22 Feb 2021 08:40:25 -0800
From:   "Philip Soares" <philips@netisense.com>
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        a.heider@gmail.com, andrew@lunn.ch, gerald@gk2.net,
        gregory.clement@bootlin.com, kostap@marvell.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, luka.perkov@sartura.hr,
        miquel.raynal@bootlin.com, mturquette@baylibre.com,
        rmk+kernel@armlinux.org.uk, sboyd@kernel.org, tmn505@gmail.com,
        vladimir.vid@sartura.hr, nnet <nnet@fastmail.fm>
Subject: =?UTF-8?Q?Re:_[PATCH_mvebu_v2_00/10]_Armada_37xx:_Fix_cpufreq_changing_b?=
 =?UTF-8?Q?ase_CPU_speed_to_800_MHz_from_1000_MHz?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Philip Soares <philips@netisense.com>

On Mon, Feb 22, 2021, at 8:36 AM, nnet wrote:
> > Could I add your Tested-by line to patch series?
> 
> Yes, by: Philip Soares <philips@netisense.com>
> 
> Thank you for the patches!
>
