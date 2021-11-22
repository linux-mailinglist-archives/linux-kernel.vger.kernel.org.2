Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCDD458B15
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhKVJLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 04:11:11 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56681 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232560AbhKVJLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:11:01 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DA8A2320187F;
        Mon, 22 Nov 2021 04:07:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 22 Nov 2021 04:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        6Ms+ZvKg1RmXpLcufzRehl6C0N3v0HxGSH1+fC9MD5c=; b=iOcoMyOkihQRdiiw
        O9sUhjrIv/8cwU4fM+x7k21KIcwOzAfvscALUvdBn5Hs4xzeVmESu7yDiVs0Dmj/
        UJv6Nsjpissyf+/FxQLGzWGPKgrNUaa9/E1BVI7lrdbGTWhhpYl+Ln/DfXLDAQZ/
        QUbDG1LTq4WpFondmuVVu7dYdqWZe3vTXqk/Ml5NTUkPu7yqhWFGOPAPvhqi4ojM
        JMIXiqG/mvgKgISM3iiLKrD3lhP3An9sb6YbOWxZqnf2Ah2zMV/KHDvbJxE6dUmU
        Nka2E3yO6vEX+ORDvebGm1qx20oxLGjsDD8Z4O3mji5pMN7IaZjiQZUpcN63Vmyv
        7iqf1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=6Ms+ZvKg1RmXpLcufzRehl6C0N3v0HxGSH1+fC9MD
        5c=; b=Dd6kgV/L/PiKFZzTm/4OVqTzdYqdehduqFZVmFPpOnhZ3CrZoCPybZfB1
        M2AVb9Zi/beZ0UHEMEbaMEZkFZ/VTpeTn/5MQb8RpCaIJGMXqIbP+nQ6MjSCa1lu
        julMC5JdQSy0ge0f2DlmCCMFn+jxX2tcE/XEBDoUz4X6IbkSW1mL/F5aQ1eVPyZc
        FQXHKbtOEeM02i6iWxvW+8UpeZ3/aGjOVs2YpLWcwuf6ttH87AhvDdPnBxS2+3QD
        9meXnleTacisNaKpe0UBRtwGAL0yZVnPiTHJTAanEdpAglLC833SaFao8VDr9Yxr
        89wSnj3pftI+60YQ4cDVzlFGXoegA==
X-ME-Sender: <xms:6l2bYbgXvmqE4JjzMvS9Nui_GLQnjiPXYoubeBg5QIqxthLorfnG6g>
    <xme:6l2bYYCF1fFbEvwsihFPZ7miWGqCwZZwJGAx0jj8LtrRRnObkydlHrk-fOQHlDxPq
    jTswhLDk-vc6P_NQ4s>
X-ME-Received: <xmr:6l2bYbEvO9cZzMsMcEnGZc9lU_znyusiQ3zzC0ss8YbYPrmvxbEg8Y760KI6rZ_cPwfvYaRf9W4SdFRfh6K4A5io5hBdydrpmCk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeegucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihimhgvucft
    ihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrh
    hnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeegieekkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigih
    hmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:6l2bYYTAG4u0VR4Fwv-5kkuS9yNY8COFy21l50nrHGqzVSYzMXXTmA>
    <xmx:6l2bYYxUu1dUgAVjVJ8s23DO7d3Qgd4SI9bZcaHjaj9uddBeeb-4-g>
    <xmx:6l2bYe5jr4LL2eQ4fgv_97eqBKfi3EZW8un79uZhTnfWkUyUpbvMZA>
    <xmx:6l2bYbxvq4J0tpfI798pvyMJXIpU0L2fSkIvTPwFfwoNc-DK0cmqfw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Nov 2021 04:07:53 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     mripard@kernel.org, wens@csie.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] ARM: dts: sun8i: h3: beelink-x2: Add GPIO CEC node
Date:   Mon, 22 Nov 2021 10:07:43 +0100
Message-Id: <163757205949.21212.16394303935375288513.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120102024.439456-1-jernej.skrabec@gmail.com>
References: <20211120102024.439456-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Nov 2021 11:20:24 +0100, Jernej Skrabec wrote:
> Beelink X2 doesn't use HW CEC controller found in DW HDMI core. It has
> dedicated GPIO pin for that purpose.
> 
> Add a node for it.
> 
> 

Applied to sunxi/linux.git (sunxi/dt-for-5.17).

Thanks!
Maxime
