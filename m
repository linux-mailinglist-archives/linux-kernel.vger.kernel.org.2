Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B064304D2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 21:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241039AbhJPTuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 15:50:10 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47126 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234499AbhJPTuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 15:50:06 -0400
Received: from p508fce7c.dip0.t-ipconnect.de ([80.143.206.124] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mbpes-0008HL-Gg; Sat, 16 Oct 2021 21:47:54 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Peter Geis <pgwipeout@gmail.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: add spdif node to rk356x
Date:   Sat, 16 Oct 2021 21:47:50 +0200
Message-Id: <163441361289.438137.17829234976642322429.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015111303.1365328-1-frattaroli.nicolas@gmail.com>
References: <20211015111303.1365328-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 13:13:01 +0200, Nicolas Frattaroli wrote:
> This adds the spdif node to the rk356x device tree.

Applied, thanks!

I did a tiny bit of (alphabetical) sorting
(clocks about dma)

[1/2] arm64: dts: rockchip: add spdif node to rk356x
      commit: a65e6523e6dcf1dc4ea167ab78ca6fad01f16d91
[2/2] arm64: dts: rockchip: enable spdif on Quartz64 A
      commit: 7ab91acd3624de261d785e94cdfc01a703786e7a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
