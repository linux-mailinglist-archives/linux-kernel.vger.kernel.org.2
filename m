Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C153FF8B7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 03:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347159AbhICBwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 21:52:39 -0400
Received: from dnyon.com ([82.223.165.189]:56336 "EHLO dnyon.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhICBwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 21:52:37 -0400
Received: from dnyon.com (55.red-81-39-194.dynamicip.rima-tde.net [81.39.194.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id EA1EF3FEB7;
        Fri,  3 Sep 2021 01:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1630633897; bh=sf2pcCMT1IxNfnOeWrCGZ5xfAX63pMAjrAvTYJj8Qlg=;
        h=From:To:Cc:Subject:Date:From;
        b=YSOoieVIDQI4TEiluzOeHfJJkwXXGBtvJuzWBk50seB3HZGBTJuVe3Q/Ym7MAmzc0
         ZmAD0FNBxf2MXvFrspHTW+KplwnDAnyC5l0xEFyNrThdbCxMZRglJOyMzYeFRoZ1Ww
         vMEpp19w0A5IhBGZ5h32sL+SQZqt3Xp3HAoGtGnOolQ4Axs3XgFqQckb2Ldx+hsr6H
         vs1RmEkgEPev9lJyQl4b76CG23Is8jdMX42f6hEyD7bMggiEy/P6RiEIyMJgUPTgk8
         Tq2NUBSOexpqgBIKPo8d+8ErZGV6WLyNsTcZi8DYuczJMiptuyxsT6HUTN40oCy1di
         HmuxMttpYvWcA==
From:   Alejandro <atafalla@dnyon.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alejandro <atafalla@dnyon.com>, Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add reset-gpios handling for max98927
Date:   Fri,  3 Sep 2021 03:49:49 +0200
Message-Id: <cover.1630632805.git.atafalla@dnyon.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max98927 codec on some devices (i.e. Xiaomi Mi A2 Lite phone) require
hardware-resetting the codec by driving a reset-gpio. This series add
support for it through an optional reset-gpios property.

Alejandro Tafalla (2):
  ASoC: max98927: Handle reset gpio when probing i2c
  dt-bindings: sound: max98927: Add reset-gpios optional property

 .../devicetree/bindings/sound/max9892x.txt         |  3 +++
 sound/soc/codecs/max98927.c                        | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

-- 
2.33.0

