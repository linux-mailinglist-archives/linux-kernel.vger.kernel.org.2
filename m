Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FEE37275E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 10:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhEDIkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 04:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230061AbhEDIhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 04:37:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52435613B3;
        Tue,  4 May 2021 08:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620117385;
        bh=P4R0wIusFfi+tbxKIZS7tgEnt8ABZzayysHovlokyMo=;
        h=From:To:Cc:Subject:Date:From;
        b=bIPqeI8pW4RBFXUepre+PYKq1BHhmvJ8C6VpOjZxh6kF+0XT6h8eqrIvVbE/eQfhQ
         DpqV+H2if46G4y+VWTPXKdUdvyoephpaqXzg3O+hvkhTJH3AvfpjtPHlcwSMmXkehY
         4KH/zPjsTHKa5MImDS81sei29P9hyeYRSiqAdFgYSFOEp3sNzXxC06kr/eOBBONFY9
         INf71MfINptRxTHQk+e0XvfqiwbXMu8zXAItR9rGfwBHn8qAG6jGtPeD9ErfF9478W
         bDg3r5cI6UyBQv42V9jjT0ZWTCcfuL9BEnXDo52lj1fjemB+Sl6zlrwgy8VkRO7Onp
         I/BenehoI9oSw==
Received: by wens.tw (Postfix, from userid 1000)
        id 2BA645FBFA; Tue,  4 May 2021 16:36:23 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] arm64: dts: rockchip: rk3328: Enable USB3 on some SBCs
Date:   Tue,  4 May 2021 16:36:12 +0800
Message-Id: <20210504083616.9654-1-wens@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi everyone,

Here are some patches that enable USB3 on RK3328 SBCs that I own. The
changes are quite straightforward, except for the NanoPi R2S, which
has a USB3 Ethernet chip attached. I am aware that there's already a
patch [1] for that. This is my spin on things using the USB device
binding, with comments on how the USB ports are arranged, that I had
done but couldn't find the time to send out.

The last patch also results in some warnings from checkpatch.pl:

    WARNING: DT compatible string "usbbda,8153" appears un-documented -- 
	check ./Documentation/devicetree/bindings/
    #88: FILE: arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts:398:
    +               compatible = "usbbda,8153";

    WARNING: DT compatible string vendor "usbbda" appears un-documented -- 
	check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
    #88: FILE: arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts:398:
    +               compatible = "usbbda,8153";

At least the first warning should be covered by the USB device binding

    Documentation/devicetree/bindings/usb/usb-device.yaml

while we probably should add an exception to vendor-prefixes.yaml for
the second warning.

Please let me know what you think.


Regards
ChenYu

[1] https://lore.kernel.org/linux-rockchip/20210405093423.16149-1-cnsztl@gmail.com/


Cameron Nemo (1):
  arm64: dts: rockchip: rk3328: Enable USB3 for Rock64

Chen-Yu Tsai (3):
  arm64: dts: rockchip: rk3328: Enable USB3 for ROC-RK3328-CC
  arm64: dts: rockchip: rk3328: Enable USB3 for Rock Pi E
  arm64: dts: rockchip: rk3328: Enable USB3 Ethernet on NanoPi R2S

 .../boot/dts/rockchip/rk3328-nanopi-r2s.dts   | 32 +++++++++++++++++++
 .../arm64/boot/dts/rockchip/rk3328-roc-cc.dts |  5 +++
 .../boot/dts/rockchip/rk3328-rock-pi-e.dts    |  5 +++
 .../arm64/boot/dts/rockchip/rk3328-rock64.dts |  5 +++
 4 files changed, 47 insertions(+)

-- 
2.31.1

