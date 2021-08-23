Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2273F3F5086
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhHWSnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:43:25 -0400
Received: from gloria.sntech.de ([185.11.138.130]:54096 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231147AbhHWSnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:43:10 -0400
Received: from dynamic-046-114-139-102.46.114.pool.telefonica.de ([46.114.139.102] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mIEts-0002Jl-9S; Mon, 23 Aug 2021 20:42:24 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Liang Chen <cl@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: add saradc to rk3568-evb1-v10
Date:   Mon, 23 Aug 2021 20:42:16 +0200
Message-Id: <162974163916.2977894.3931424916722931571.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210823110716.10038-1-michael.riesch@wolfvision.net>
References: <20210823110716.10038-1-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 13:07:16 +0200, Michael Riesch wrote:
> Add the SARADC to the device tree of the RK3568 EVB1.

Applied, thanks!

[1/1] arm64: dts: rockchip: add saradc to rk3568-evb1-v10
      commit: b12a5946f5ea7a54b8b983c42f0812152e3122de

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
