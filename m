Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC183EB2F3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239826AbhHMIwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:52:16 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43216 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239398AbhHMIwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:52:15 -0400
Received: from 82-99-180-238.static.bluetone.cz ([82.99.180.238] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mESun-00077D-Tt; Fri, 13 Aug 2021 10:51:46 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3] arm64: dts: rockchip: add thermal fan control to rockpro64
Date:   Fri, 13 Aug 2021 10:51:39 +0200
Message-Id: <162884469492.2596417.6101553398444696759.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210730151727.729822-1-pgwipeout@gmail.com>
References: <20210730151727.729822-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2021 11:17:27 -0400, Peter Geis wrote:
> The rockpro64 had a fan node since
> commit 5882d65c1691 ("arm64: dts: rockchip: Add PWM fan for RockPro64")
> however it was never tied into the thermal driver for automatic control.
> 
> Add the links to the thermal node to permit the kernel to handle this
> automatically.
> Borrowed from the (rk3399-khadas-edge.dtsi).

Applied, thanks!

[1/1] arm64: dts: rockchip: add thermal fan control to rockpro64
      commit: 440f361af90acff36eb3d89c1f03debeab7b3fb8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
