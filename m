Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4A43F5BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbhHXKRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:17:36 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:53488 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbhHXKRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:17:13 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 7F7F6D76C1;
        Tue, 24 Aug 2021 18:16:15 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32763T139760989173504S1629800174340042_;
        Tue, 24 Aug 2021 18:16:15 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <83b4d9d0a8e50b7218a52c85de53c1b2>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 12
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Sugar Zhang <sugar.zhang@rock-chips.com>
To:     broonie@kernel.org, heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/4] Patches to update for rockchip spdif
Date:   Tue, 24 Aug 2021 18:15:58 +0800
Message-Id: <1629800162-12824-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fixup or update for rockchip spdif.


Sugar Zhang (4):
  ASoC: rockchip: spdif: Mark SPDIF_SMPDR as volatile
  ASoC: rockchip: spdif: Fix some coding style
  ASoC: rockchip: spdif: Add support for rk3568 spdif
  ASoC: dt-bindings: rockchip: Add compatible for rk3568 spdif

 .../devicetree/bindings/sound/rockchip-spdif.yaml  |  1 +
 sound/soc/rockchip/rockchip_spdif.c                | 38 ++++++++++++----------
 2 files changed, 22 insertions(+), 17 deletions(-)

-- 
2.7.4



