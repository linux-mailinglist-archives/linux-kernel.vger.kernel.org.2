Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A8C458B16
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbhKVJLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 04:11:13 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:51965 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239002AbhKVJLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:11:04 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D6D623200E83;
        Mon, 22 Nov 2021 04:07:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 22 Nov 2021 04:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        G/XaaQn1wpINf7ztTpVzNG/AUZxJhlmbIY1Y0oQZkGg=; b=nhwkT/eLzc38lou4
        OXDf9ZsWteb3IyvPSH9UeoHSGuS+iO0IHaHYuodkHjKXxgBQ4ihLZ9HJNuc2kuOa
        aT5AGDfMu2PFndKAJlI/d+O3ymj8Js7P3GkKRIr7lnXzjY0aMVAb4WQ5DaDTCBOk
        2P2oHTPJsSo43ugUlqVnpui1i0P1o1apQl9zTKyMARw6JJLTg1aoQ2uvQRlv/05Y
        NGhwfD+OX/BYM+4JHNZqbWKc1f9qMksI+sNnqaMLGmpivGK6A+Gsw1dRYwgzscqg
        hong4BZBwFpa0hF6glZN5w/wqhzwhRS6Z2CIpNDESlSR8l65xB843lgAC72f2XhF
        Ac58Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=G/XaaQn1wpINf7ztTpVzNG/AUZxJhlmbIY1Y0oQZk
        Gg=; b=MTsa4PRzKRhbw2EAoa/k1da4JIP2iEAwM6Y4mjbTGVdRvuv2uLHF4gQZZ
        nZO8nGJK8cwu11eRQ+PY0M3p5vUZYxbmTNPyb4Tgf2moDPOAaXoMtsNKi3uIVpqY
        VhSFryDmI5UWK5sTJjV8/yCuucPWN17NzORuGZOpn3tkHRcVn8h+sknuD0FmDb1T
        fAAT+pQywBMje5bU3kMhYmupKzuxgw/hcanmVsr9nCFt3LzTx6UsYSJ6A/K0yzWe
        gbYtyC+lersA+xwTA207K+VqZEbp4Fu4LLhpmnhbgDng6cuDy5vhUQ4ZLuiqnGGm
        si115r/Uqy9aMAJaRRylFD7aExCRA==
X-ME-Sender: <xms:7V2bYUyuL7oUONUJwYZ3cB52g-m1Cvc67f4BptJXgdhqn1zcXIotqA>
    <xme:7V2bYYSa6_rlKMja9F6_oi975Rpqp8JnSo4QbMx9XHW8aKwjB1b6naoXeg3xKQN0w
    3SRoNiznUhdiftKjFQ>
X-ME-Received: <xmr:7V2bYWW6M2RY8e1fR_5J0TyM12tCwzZ-JveWfFcDvVnm57XApEsK_seWcfpkFOWhOiBmVHNiajkFsLZ157-wt5yFvOMLzOfiink>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeefgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:7V2bYSiHfNOcsjUv9xYsm6XHTkB5aZPrPFUNA8rcjZMxRZ7Svg4hIA>
    <xmx:7V2bYWBAl3LKqTz-_sPtXbh7F15QZZXGuMYv-g1Hkc3v2bsA1u0g5w>
    <xmx:7V2bYTJFo8eMKqQGG5bKby02-MOm_AauA-KqKhGYqVaH0B6Q4235rA>
    <xmx:7V2bYcDNQAMyl0mAMGzVWOi7wNJ8ZaHL8BZTcRqtRfFPUwF-u4CHaA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Nov 2021 04:07:56 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     mripard@kernel.org, wens@csie.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] ARM: dts: sun8i: h3: beelink-x2: Sort nodes
Date:   Mon, 22 Nov 2021 10:07:44 +0100
Message-Id: <163757205949.21212.16601638001637017389.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211121070321.601659-1-jernej.skrabec@gmail.com>
References: <20211121070321.601659-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2021 08:03:21 +0100, Jernej Skrabec wrote:
> Nodes are not sorted alphabetically. Do it.
> 
> There is no functional change.
> 
> 

Applied to sunxi/linux.git (sunxi/dt-for-5.17).

Thanks!
Maxime
