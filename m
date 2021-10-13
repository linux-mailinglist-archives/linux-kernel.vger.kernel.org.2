Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F9042BE35
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhJMK7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:59:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35360 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhJMK6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:58:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D60D91F4415E
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        geert+renesas@glider.be, vkoul@kernel.org,
        jagan@amarulasolutions.com, agx@sigxcpu.org,
        biju.das.jz@bp.renesas.com, enric.balletbo@collabora.com,
        aford173@gmail.com, nm@ti.com,
        andrey.zhizhikin@leica-geosystems.com, saravanak@google.com,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/2] arm64: defconfig: Enable multimedia clocks on SC7180
Date:   Wed, 13 Oct 2021 12:56:11 +0200
Message-Id: <20211013105613.250450-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device trees for SC7180 Trogdor machines are enabling DPU1 and Venus, but
these are never getting up due to missing clock drivers; after a test, it
was discovered that both of them are fairly ok, except for the Venus
encoder, which doesn't seem to work fine, but it's anyway not introducing
any unstability (the device won't crash), so there is no reason to keep
them out of the game.

Since both of these clock drivers aren't boot-critical and can be inserted
later, it's proposed to enable them as module: this will avoid increasing
the kernel image size, which is especially important to keep lower loading
times (from the bootloader).

AngeloGioacchino Del Regno (2):
  arm64: defconfig: Add SC7180 GPUCC and DISPCC as module
  arm64: defconfig: Add SC7180 VIDEOCC as module

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.33.0

