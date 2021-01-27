Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19C63054B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhA0Hc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 02:32:26 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:39799 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S316622AbhA0A1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 19:27:01 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2F4A9580A86;
        Tue, 26 Jan 2021 19:25:17 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Tue, 26 Jan 2021 19:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=PWoGEuMDDaDq0/pzXUUiU1EckS7iVUN
        1oFV3i9oQBqU=; b=ijJP6ZrcT4CZpTc74xXzMI2pxevxBiB9raVSnMYyR3XEr9f
        ZvTbpO/Cv3Ts9ZgESw+B2H7zHkMQ81/s1YPxw9Umyf/DOkYHpTMbv0rJcFzZN6sz
        h6zLgANlm1G9OdyCsZhq4Xn0MbyT0szBEw0NDMC7qpbKb6ajKp+zZvPmxEF/Wa9h
        x/tYkP34EglzHAwI/9Rekk0jUvHjMvb95wuFVp5W6XSFv65Pe1ltmc23v8c3aKyR
        wsg+ed1PltmlLunEAQcaRBwiIRjhWa9QngDoCdl6v/QlxPArLxi8BfU0/0AskhJx
        8aZgHqfxRzfFe07tr/X0jX6RQ7Oda+lxtT7WhsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=PWoGEu
        MDDaDq0/pzXUUiU1EckS7iVUN1oFV3i9oQBqU=; b=juzHo2ERd2n3YX6adW2OnL
        1N2Lcs+iMO3u0lHnRCNU+G0QiOiQ6Bxp88DZLVuycTPl2EZbp6pSvkAJuqbIiZVk
        7hKv5/ECVpBa428xHcpHMYMTzup8Z2dufAnY3ea7drNrTx0VvoYir1BQUkOavdPN
        h6EeFMfUXFb/5t1xqgg/DtJZUH+0Zkmz0OiNmvcw+gbaj7DaqbrdIwsG0sh1RxGz
        VpljwS3yLEGoSXcKHidiY7Ji0a9l7qw3FFgbvOzQDBZtL1ulonAMYYtKs0N0IyhL
        uvhfNPw2RWvneouixTI7Y2sNMdcG7uA5AWAkqQonnsVdnvM+0gcLxbmFX4UlRG/Q
        ==
X-ME-Sender: <xms:67IQYBn8zZXF8aV1RL_0StSGOYIqxaIZpgly8jt4COCgAgtGwllFeA>
    <xme:67IQYM3oNDYWI-tCEy477uy5A8_jkyYEDz9iZAlq_ATf5fsL7z_mzbh0JBe78vlkX
    HNdvqzoh6MJdz_HIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrg
    htthgvrhhnpeehhfefkefgkeduveehffehieehudejfeejveejfedugfefuedtuedvhefh
    veeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:7LIQYHqlC_id2kk_RUPPOjvILObK-6rLPAF0rdMpgN-cO2dcN0PlBQ>
    <xmx:7LIQYBl9_LBn5Q2kfDBVLjH2lfV5yEtoavFtu2HhrMuLx4apq7EmcA>
    <xmx:7LIQYP19NXFgSEQW7lDZAmIcFU3kWOFppZ43ScCjIf_cWKOONFJySA>
    <xmx:7bIQYIt6bnrgYF6qn5gSA3F0qVPgYqpnlefxekr4vtmCelQAJagDWw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E5484A0005D; Tue, 26 Jan 2021 19:25:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-84-gfc141fe8b8-fm-20210125.001-gfc141fe8
Mime-Version: 1.0
Message-Id: <85f00459-4a39-441e-8119-8e12f8132cfe@www.fastmail.com>
In-Reply-To: <20210114131622.8951-2-chiawei_wang@aspeedtech.com>
References: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
 <20210114131622.8951-2-chiawei_wang@aspeedtech.com>
Date:   Wed, 27 Jan 2021 10:54:55 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Lee Jones" <lee.jones@linaro.org>
Cc:     BMC-SW@aspeedtech.com, "Haiyue Wang" <haiyue.wang@linux.intel.com>,
        "Robert Lippert" <rlippert@google.com>,
        "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Corey Minyard" <minyard@acm.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v5 1/5] dt-bindings: aspeed-lpc: Remove LPC partitioning
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jan 2021, at 23:46, Chia-Wei, Wang wrote:
> The LPC controller has no concept of the BMC and the Host partitions.
> This patch fixes the documentation by removing the description on LPC
> partitions. The register offsets illustrated in the DTS node examples
> are also fixed to adapt to the LPC DTS change.
> 
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>

Any thoughts Lee? If you ack it would you be happy for the patch to go through 
the Aspeed tree?

Andrew
