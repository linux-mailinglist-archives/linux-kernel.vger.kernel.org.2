Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9225B458B08
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbhKVJKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 04:10:03 -0500
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:36311 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229716AbhKVJKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:10:01 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 1803F2B01C7D;
        Mon, 22 Nov 2021 04:06:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 22 Nov 2021 04:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        3sAYDhdU8A/Wo/wR51x2QNHufjbDBbL+eEem9wZy/BE=; b=YjQgWbk1fEx+mRCE
        N2IyrXzXMxMT6Bi8dEdXkHvwPVx+skHzxolDlWeZ+PjoixxVsNVprIUzZp1kB7LE
        B5ryQqsxyb1t2cTLh9RF6m2QKY0LCv6XeSoAHrV7dv6N1yNzLGcOE6q4XO5ijqng
        zJYBSeiAdT5+W5ooKq0VJZ6hThSho6xCJ2dLd5gQAGYanxktjkfJ7IYp6bErhPuZ
        En35MTx48YLGN9+TLaIXF9qKL1Y6sVUA8Pq7LJaZHYzyxxQSjCcF4C2Y3dC1QFWj
        StbrhAzSSa/5JQB3QmpnqUZJnAzz8+msRV1hjmvat4nAJ4fLB6LpxiNKJQlyYdxK
        GlTUCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=3sAYDhdU8A/Wo/wR51x2QNHufjbDBbL+eEem9wZy/
        BE=; b=kK+Ag1tFMj2D4Thqhnd3vQaVNbySJBY+KWz+iKaORexurPizJJGXmmIGS
        L3ZE9b0OgMPNPb1FoRuXUcHgWux/4//wesdlSTQsINRIc1JGyMy9YMLDl1WwOpbg
        hCquhCuwskubV2Y+L7jjz5rAcThAn51y/FpCAiQopGRGC1xf1JUhbdsLgoaYBzwJ
        TQTZu95+tUBvZhB2kww/fKjZ0PN1byi8VxzzP8pmbXwa3RsAVn4kEnlAHAFHhKKW
        K6GI54UzNm9zLND0gqDPw4HE1Vanim9eWoLmYxoSq1INyvoxGpQQyPOdPbE9ZiDh
        HN6VPJw/xRz4BVrrqm37uzahyKP5w==
X-ME-Sender: <xms:rV2bYSxhZnKc6bQeyk2njC-pz30-joVHb01-RfkyKBnh0qVzkMegQw>
    <xme:rV2bYeQDa7WQcc3_vaJIKbgzGfKAf7pw05yjuZER7L8DILQxwJzkGlz4pnzoo89Ez
    b4l2rAIXIPX6PW9Ih8>
X-ME-Received: <xmr:rV2bYUXYn6nnijuPzv5J1gxvDIAWBplu7W8RQBekPzps7rAZBR4zvw_jBTEaZhzqcaiaQv2EdXtmrCgi0Qv891gtGgtYwJoQr10>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeefgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:rV2bYYh_3E_bgI-B6eSeaSiPHyAOgAM5OF8vdemmpk9KYrB9Z3CslQ>
    <xmx:rV2bYUBBGtmJ0W6lAXnY8NYaxaQZ17LAq19YQqAyTcFFWr7XC19npg>
    <xmx:rV2bYZLksy5GxP_nFxnnxd2OwWZFB0kAuhc08E9t93hU7gvDgzjW7w>
    <xmx:rV2bYdI_NNSyXCCegfwICYDl95QcQSjHz9N2lkzDB7i85z1_g6QJ_8sSofY>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Nov 2021 04:06:52 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>, linux-sunxi@lists.linux.dev
Cc:     Maxime Ripard <maxime@cerno.tech>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/6] clk: sunxi-ng: Allwinner D1 clock support
Date:   Mon, 22 Nov 2021 10:06:48 +0100
Message-Id: <163757200586.20884.2695235529451513458.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119043545.4010-1-samuel@sholland.org>
References: <20211119043545.4010-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 22:35:38 -0600, Samuel Holland wrote:
> This series adds support for the D1's CCU and R_CCU.
> 
> I attempted to hook up clock parents the "right" way, not using global
> names. To accomplish that, I added several new macros. I am open to
> comments on this approach. It looks a bit messier, but seems like it
> could be less prone to errors.
> 
> [...]

Applied to sunxi/linux.git (sunxi/clk-for-5.17).

Thanks!
Maxime
