Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9403B8FE4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 11:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbhGAJnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 05:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbhGAJnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 05:43:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD24C061756;
        Thu,  1 Jul 2021 02:40:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6A0131F43DC5
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH 0/3] Misc bug fixes in mtk power domain driver
Date:   Thu,  1 Jul 2021 11:40:21 +0200
Message-Id: <20210701094024.1273759-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series, originally sent by Bilal Wasim [1], initially broke my
display in mainline (no gpu driver). The problem was not in the series
itself, and, after [2], this series works as expected. I was able to go
to the UI with and without the imgtec gpu driver on my Acer Chromebook
R13 (elm). Hence I rebased on top of mainline and resend it to take into
account for next merge window.

Best regards,
  Enric

[1] https://yhbt.net/lore/all/20210216165926.46bbafc7@a-VirtualBox/T/
[2] https://patchwork.kernel.org/project/linux-mediatek/patch/20210625062448.3462177-1-enric.balletbo@collabora.com/


Bilal Wasim (3):
  soc: mediatek: pm-domains: Use correct mask for bus_prot_clr
  soc: mediatek: pm-domains: Add domain_supply cap for mfg_async PD
  arm64: dts: mediatek: mt8173: Add domain supply for mfg_async

 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts  | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi     | 2 +-
 drivers/soc/mediatek/mt8173-pm-domains.h     | 1 +
 drivers/soc/mediatek/mtk-pm-domains.h        | 2 +-
 5 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.30.2

