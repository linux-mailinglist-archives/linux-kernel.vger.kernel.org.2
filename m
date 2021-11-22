Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BFF458B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbhKVJKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 04:10:06 -0500
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:45769 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229716AbhKVJKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:10:04 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 703A02B01C7F;
        Mon, 22 Nov 2021 04:06:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 22 Nov 2021 04:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        eqM54/FiBN8e0G1yCKed9r80ApXBDuOG4JGVgmMH+3E=; b=j6jin+Fm4vg8LDi8
        Qs5zcKIjySFSf8OVKz84gI6fIuJ4TF5F01D1Zg+VL/BcxQWAjYppu09CKQxS/EN/
        0N6srpzGJF5SSWaIilofDAqJynw8c8/gADoqGs84I3tofztDeiy1Nrk1vokVtXS3
        F3S17WG48zpw6AdM8H6G5h4pIv9zSD9mHNdf8KihbW7pNonbhuKMC7xH/Zi6nQk9
        zlt2T66VYxl2ih0vLedTB3HE2bDBtaQzEC8TII6ciw3dru0zDxcRUZn3hsJgGtEB
        +kwGO3KFEWTCuqa5qdCm+1MnYA+5BlyF7nQnQgbgmYXAqU8jGiTUPPQ6RkqQk7sW
        4lgBjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=eqM54/FiBN8e0G1yCKed9r80ApXBDuOG4JGVgmMH+
        3E=; b=i+GpXJ998IXC6BmkS9k4AR2Qm3cWt19qoL8W4S1Rqc5UJ7dYPc/VeC7Tl
        F8X0xvy1L0XzHTJr/VBUZ+FbWigNLi+YpPSsBYx2+0cHUBog+ygHgcS7+i3NwVf0
        ywewRok1P3Lx60l/9JXvMeEhKOtYkn4DVd9QAWBDLAB5gVoVlhY1GJMamkDUMzCR
        0u5j5YXIB9F8gqnOBhVNmiws2EJI0ub6XDXchHjNifhTf7e1U3Ji7iMoAObykhap
        3HIMf7XEUMUULDLl/0A+wACf5HFw4uMQ7I8eYZScr1MDDRm+eV52HOWbMQFuTgbX
        KX1gkS3K+cb1N31DcEfPBE26q4nDA==
X-ME-Sender: <xms:sF2bYTy6cz_-jKHEvxK45MM-nw9zVbqOGfOFU73IEiOD_63aFYcelA>
    <xme:sF2bYbRP3vz0gt_359ePurYx1O8uw0gB04raOPqyCtBzD1KZrOlm_vGOJHiPTnqRC
    s5ebxZDCJiuJYnoOss>
X-ME-Received: <xmr:sF2bYdX_k-8yJPMHM4Htdovz3nsR5eIuQbqwKpLK-LYUD04uEEiNt_HPYt-GJJ11awh7arIaWgEQzqO16cAet2-e8jmA8jbeaRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeefgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:sV2bYdi3HM0AM1uNBjYIx3DC1sQdQ3ypgKTqJ3lY75erRXkq6U2zzA>
    <xmx:sV2bYVAbyiljbyLsOYqxTf_AVhA8OreVkSLu8UmMrhjtxpQzz5BR9g>
    <xmx:sV2bYWIdPm650Pw9smersTxE3k9lOINo4itqAd9KkeumRnUkU1u-Hw>
    <xmx:sV2bYZt-r7gVqC3paxegOzrVFh9cPc7yo9668mxZNl4XJ7WzsVs7cYgi4Tc>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Nov 2021 04:06:56 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>, linux-sunxi@lists.linux.dev
Cc:     Maxime Ripard <maxime@cerno.tech>,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 0/4] clk: sunxi-ng: Module support
Date:   Mon, 22 Nov 2021 10:06:49 +0100
Message-Id: <163757200585.20884.6496466863849967854.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119033338.25486-1-samuel@sholland.org>
References: <20211119033338.25486-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 21:33:33 -0600, Samuel Holland wrote:
> This series allows the CCU core and drivers to be loaded/unloaded as
> modules. As part of this, patch 3 converts most of the early OF clock
> providers to platform drivers.
> 
> Changes in v3:
>  - Also export helper functions.
> 
> [...]

Applied to sunxi/linux.git (sunxi/clk-for-5.17).

Thanks!
Maxime
