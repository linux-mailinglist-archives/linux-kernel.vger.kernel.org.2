Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55102454A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbhKQPor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:44:47 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:60807 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238514AbhKQPoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:44:46 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5753858054D;
        Wed, 17 Nov 2021 10:41:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 17 Nov 2021 10:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        qGoNrB8MmSWjk4fStkb5QZHrvZbDVOv+blS2NAOcX34=; b=jRPlhi3olJn1rKCd
        afqF/1TVudA1PzZNVdODwGt+qzjnbToT61M8wDh4qUM7kvoTo0F9Xs6L0mBqI8Mh
        qOWeRBJ86KAhDdj5sfYemWNW1KBRUG5Ym26VPyvNInUusMKFnQennPB/x/I66aFJ
        3peswOzW/X/xh04bcQFzHKGvyBbIGUHTMfPthcqkLGR7PFhKmIa531Xk8v2Vv3jx
        gdU7wyAHB6Mw+Gp7ewd0Gz2agYnPLAcqeJ63yAqaaEQIwrdqP3oDeEAPE+amh+Ta
        KOFY8xMDMap4+cCoCe1o9UwrQcfAU3jZrogN+y3VvrleaccT8F5OzvctKB4x/U5F
        bAMxjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=qGoNrB8MmSWjk4fStkb5QZHrvZbDVOv+blS2NAOcX
        34=; b=CMpAtcDGCIjAn9qndl/7O4ynB1f9SeU3kDDZ3I1uLOyTW+xsqDfxMMLS1
        CmNCnFXPFhgIob7kgU/v4OIf+04T9gy2gD4nzNY2ZUv0g4dxdG8uXNX/FzYlgPgl
        NdYZb5kv4WqlvodWroScfgpx1dZcizfLnCPAElgS5NfpVWe9gcNc24UZOaXnJUS/
        vzv6mUzQQy6db+okSixau+SH3dkTNmn2Gnsqo0NxtfC9QIgDi2ktiOoY7fc4qbm+
        73siSVX9NweVVd+wrISOVZmPhThDOEKI1tvScDJGhIpGjQKS0Ca9BEGKQg9RIq3+
        idwie26SnU5ldj8Hf80m+Vkpexl+A==
X-ME-Sender: <xms:uyKVYUploxFJihwWfKWiDHKHX7kALr0lTfRKzeKnssuxGTAKiqCxKg>
    <xme:uyKVYaq4wCMeYzL2bWD3OyuxFB79agXavuP8lMGm3qIU1uMEHBDzY_4NsiEYXymIJ
    -YQBgCVbaHMA6mPgcc>
X-ME-Received: <xmr:uyKVYZO0D__HdXIwWqc7FnOPC7NA7MWOWks9xOuhY9C8ZH309fCUnyTb6_LLHGSHhuM636oetFmA8yFnGoNO5OrUZ0DBg6kXf1QjlTpNZLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeggdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeeugfegkeffgfeuvedtvddufffhjeffjeejvddvudduteehhfefhfefgeei
    keeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:uyKVYb5gU-y26SOe56DgEKMnB1FHvQo35pVYadco1BczJWZyraZRfg>
    <xmx:uyKVYT6p1rcp2xrMs-GuJ0wD5BliojHEFIR8V2h25KuJryVkTtiv7A>
    <xmx:uyKVYbhfgmx3yIStpXpHmkesAckOdAdTDy3f8kKdhg-E6NZOY3LsZg>
    <xmx:uyKVYXjQzy8TS6WPna9274jZkGZQJTXcpLso8wnY1ZcIGs6bC_D6oQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Nov 2021 10:41:46 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     linux-sunxi@lists.linux.dev, wens@csie.org, mripard@kernel.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        hauke@hauke-m.de, jernej.skrabec@gmail.com,
        Robert Marko <robert.marko@sartura.hr>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Ron Goossens <rgoossens@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: (subset) [PATCH v2] arm64: dts: allwinner: orangepi-zero-plus: fix PHY mode
Date:   Wed, 17 Nov 2021 16:41:44 +0100
Message-Id: <163716369742.342081.15629886204343104754.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117140222.43692-1-robert.marko@sartura.hr>
References: <20211117140222.43692-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 15:02:22 +0100, Robert Marko wrote:
> Orange Pi Zero Plus uses a Realtek RTL8211E RGMII Gigabit PHY, but its
> currently set to plain RGMII mode meaning that it doesn't introduce
> delays.
> 
> With this setup, TX packets are completely lost and changing the mode to
> RGMII-ID so the PHY will add delays internally fixes the issue.
> 
> [...]

Applied to local tree (sunxi/fixes-for-5.16).

Thanks!
Maxime
