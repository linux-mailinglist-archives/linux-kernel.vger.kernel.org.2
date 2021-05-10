Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83714378B67
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 14:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbhEJMIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236394AbhEJLH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:07:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07D3661987;
        Mon, 10 May 2021 11:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620644444;
        bh=YIr8WSY9Mb81kzT2q6GTGarSSE0EZ9Tq4XGoyh3TDv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FSyoUKFD6bMVtDwc16Ja6BeDrBL83iYx80T7J7oXKvRZfkZpcPfaX4BNAKKDZn537
         S/HPU0Bu0rSAk1iQ+YOC+Jo7+MubzqECPAeNmE67RovyBc+XvVUE8cskI+VIZ2vkdl
         t/6Op1o6F6y4S/n45jsH8XHU6P0CDT/BDxoGH0Yc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.12 086/384] ARM: tegra: acer-a500: Rename avdd to vdda of touchscreen node
Date:   Mon, 10 May 2021 12:17:55 +0200
Message-Id: <20210510102017.724658346@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510102014.849075526@linuxfoundation.org>
References: <20210510102014.849075526@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit b27b9689e1f3278919c6183c565d837d0aef6fc1 ]

Rename avdd supply to vdda of the touchscreen node. The old supply name
was incorrect.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
index d3b99535d755..f9c0f6884cc1 100644
--- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
@@ -448,7 +448,7 @@
 
 			reset-gpios = <&gpio TEGRA_GPIO(Q, 7) GPIO_ACTIVE_LOW>;
 
-			avdd-supply = <&vdd_3v3_sys>;
+			vdda-supply = <&vdd_3v3_sys>;
 			vdd-supply  = <&vdd_3v3_sys>;
 		};
 
-- 
2.30.2



