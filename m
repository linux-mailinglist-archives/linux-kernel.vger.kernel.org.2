Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D833F48EE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbhHWKuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:50:13 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:58282 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbhHWKuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:50:09 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 7FFB1FB572;
        Mon, 23 Aug 2021 18:49:23 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32763T139760957703936S1629715760494266_;
        Mon, 23 Aug 2021 18:49:23 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <11c0895db331193aa5b55d5be999c912>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 13
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Sugar Zhang <sugar.zhang@rock-chips.com>
To:     broonie@kernel.org, heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/15] Patches to update for rockchip i2s
Date:   Mon, 23 Aug 2021 18:48:14 +0800
Message-Id: <1629715710-21137-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fixup or update for rockchip i2s.


Sugar Zhang (13):
  ASoC: rockchip: i2s: Add support for set bclk ratio
  ASoC: rockchip: i2s: Fixup clk div error
  ASoC: rockchip: i2s: Improve dma data transfer efficiency
  ASoC: rockchip: i2s: Fix regmap_ops hang
  ASoC: rockchip: i2s: Fix concurrency between tx/rx
  ASoC: rockchip: i2s: Reset the controller if soft reset failed
  ASoC: dt-bindings: rockchip: Document reset property for i2s
  ASoC: rockchip: i2s: Add property to specify play/cap capability
  ASoC: dt-bindings: rockchip: i2s: Document property for
    playback/capture
  ASoC: rockchip: i2s: Add compatible for more SoCs
  ASoC: dt-bindings: rockchip: Add compatible strings for more SoCs
  ASoC: rockchip: i2s: Add support for frame inversion
  ASoC: dt-bindings: rockchip: i2s: Document property 'clk-trcm'

Xiaotan Luo (1):
  ASoC: rockchip: i2s: Fixup config for DAIFMT_DSP_A/B

Xing Zheng (1):
  ASoC: rockchip: i2s: Add support for 'rockchip,clk-trcm' property

 .../devicetree/bindings/sound/rockchip-i2s.yaml    |  30 ++++
 sound/soc/rockchip/rockchip_i2s.c                  | 153 ++++++++++++++++-----
 sound/soc/rockchip/rockchip_i2s.h                  |  10 +-
 3 files changed, 157 insertions(+), 36 deletions(-)

-- 
2.7.4



