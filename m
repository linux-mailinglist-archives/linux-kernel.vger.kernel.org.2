Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD8A3D39E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbhGWLVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:21:40 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45180 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234231AbhGWLVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:21:38 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m6tsV-0004qO-47; Fri, 23 Jul 2021 14:02:07 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Liang Chen <cl@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 0/4] split rk3568 and rk3566 device trees
Date:   Fri, 23 Jul 2021 14:02:05 +0200
Message-Id: <162704168907.1329605.13579564143359977102.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210710151034.32857-1-pgwipeout@gmail.com>
References: <20210710151034.32857-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jul 2021 11:10:30 -0400, Peter Geis wrote:
> This is an example patch set that addresses the split of the rk3568 and
> rk3566 soc device trees.
> This method attempts to avoid deleting and modifing nodes by maintaining
> a common dtsi for all common items and adding in the differences in
> separate dtsi files.
> It also includes a basic dts for the Pine64 Quartz64 Model A board
> as an example of a rk3566 device.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: rockchip: move rk3568 dtsi to rk356x dtsi
      commit: 94c75b5265fe899391e298eace826e4f8d1e8e40
[2/4] arm64: dts: rockchip: split rk3568 device tree
      commit: 92eb5ffbae440700dd38378e24d8091fe166c352
[3/4] arm64: dts: rockchip: add rk3566 dtsi
      commit: 04e1ecf6099cc3ba17c2d4279c968a656320cd12
[4/4] arm64: dts: rockchip: add basic dts for Pine64 Quartz64-A
      commit: c95414d68f116462acf9622f715b8a568bb1dd00

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
