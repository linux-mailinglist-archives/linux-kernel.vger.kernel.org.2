Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B303067AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbhA0XTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:19:34 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54815 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235131AbhA0XR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:17:58 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 89FC55C00E9;
        Wed, 27 Jan 2021 18:16:47 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Wed, 27 Jan 2021 18:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=gGcwVS/68YhbCGlzsQkOFgWjM+FCtEk
        PcloKgFmi6Pc=; b=EEk6+7Uv7zZFrOgpqzSxNCsPYT+upXvbPKB9zpYJsn8Agqw
        oP2+ZQU2qMWIzwUEt8ysK9NWkd7TuVBNEPzWAti16+JNkDDVfzhT6RGY3Dr/m0BE
        OMlkyCtDNH68HRl3rRXlOdKFAODAVg3wib363PDaWBaIQ2lKINw02uCSPV+p9MOF
        /YGjYSE3XkYSAVb6Ka4//g/6b9S0mGIZyi1+o83RwDc/Oi5wahGDLaueFmykaJvg
        1WvRG3l8CyBBiPBWef7FFR79EhbjnDImGL+jZNvOpm8Nmx88oJV4Pbvvt69ge953
        VPhWE/yHLG75ftHkSKh7LgMVeUueWygT3txmlXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=gGcwVS
        /68YhbCGlzsQkOFgWjM+FCtEkPcloKgFmi6Pc=; b=pfwUWuzTZm5eBII5lNS7u3
        4UYD5OuT+ES2cSYMMZ9MWDVGxVYxp209jO1PMqBu9KnkNaykNYD0Fu9argdqij18
        VmC5J9H/hn27bU7qadWNmKpgwRPSnNcAwix7mhByKArnhBbwAw9lE5MRMqxC0+9Q
        /sY8nyXn142eQ8D+RlO3e/j/8rvJRLJfmnFqwWGEbl2QL7AbK0GCcGGWHubGM1Up
        NVNB6oVFMv1bHqBjJ3cGGhDQ+fO723NyG6V2elYOO5x+QpwYnCoonMkskcjEiMWa
        NsxuvPZHU+AUkN5V0hXXAf7d6OBkaIYjgdMaXytl9K8WLCxCXI7kMNZQtWXUVHFQ
        ==
X-ME-Sender: <xms:XfQRYHDebcMnOZep2n0u5Aoj9_QIPSRCp1lLiwnqkslYf0JCMkoWfA>
    <xme:XfQRYNhx1mLGtVLhMMQFT0zmqUBBHaeKWtwZ7dMdA69D8nly3D9DuUtzOzFcTWohb
    UnPtZkxtIEmtqgKSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdelgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrg
    htthgvrhhnpedutddtkeeugeegvddttdeukeeiuddtgfeuuddtfeeiueetfeeileettedv
    tdfhieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:XfQRYCnhFvrsbmvWH7AIk48UIgNlF36fmKNXupN-BUc4maz2soussQ>
    <xmx:XfQRYJwguG4iygmfPqouLBzSi6JgEpWOiYRoK78ftTqXBeC_mx9tCA>
    <xmx:XfQRYMTOxSUF5y7FMB9NqOQ-E-0bxhLu6ltCvwm5G5CXYeM62J20GQ>
    <xmx:X_QRYBJvdAcOqOBWd45DqZd626LDG84vJNZbv1bakRpudRdcm3q96w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AD14AA0005D; Wed, 27 Jan 2021 18:16:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-84-gfc141fe8b8-fm-20210125.001-gfc141fe8
Mime-Version: 1.0
Message-Id: <7d7a0990-c9ca-4113-aa41-415b5cb54cf5@www.fastmail.com>
In-Reply-To: <20210127182326.424-1-aladyshev22@gmail.com>
References: <20210127182326.424-1-aladyshev22@gmail.com>
Date:   Thu, 28 Jan 2021 09:46:25 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Konstantin Aladyshev" <aladyshev22@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>, supreeth.venkatesh@amd.com,
        linux-arm-kernel@lists.infradead.org
Subject: =?UTF-8?Q?Re:_[PATCH]_ARM:_dts:_aspeed:_amd-ethanolx:_Enable_secondary_L?=
 =?UTF-8?Q?PC_snooping_address?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Jan 2021, at 04:53, Konstantin Aladyshev wrote:
> AMD EthanolX CRB uses 2-byte POST codes which are sent to ports 0x80/0x81.
> Currently ASPEED controller snoops only 0x80 port and therefore captures
> only the lower byte of each POST code.
> Enable secondary LPC snooping address to capture the higher byte of POST
> codes.
> 
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
