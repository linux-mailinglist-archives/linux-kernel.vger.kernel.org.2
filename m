Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45ED63FACFC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 18:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbhH2P7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 11:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbhH2P7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 11:59:50 -0400
X-Greylist: delayed 539 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 Aug 2021 08:58:58 PDT
Received: from dnyon.com (unknown [IPv6:2001:ba0:1800:12f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54200C061756;
        Sun, 29 Aug 2021 08:58:58 -0700 (PDT)
Received: from dnyon.com (45.74.222.87.dynamic.jazztel.es [87.222.74.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id A336040442;
        Sun, 29 Aug 2021 15:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1630252195; bh=K7WOQRGdrSf+PbNjqY1YtmWTU3lNTVPtvBKbaWcq284=;
        h=From:To:Cc:Subject:Date:From;
        b=YomUul1yURUkZT7vFN/EK4seETy+lbrdMjRM5XfjLve9o4BKbNKAOF4cGR27klIgv
         57uMLgbQPC9pRHImkHtpjvtgtajEg1Hl4S6b9VorG0w/opcJyirfUVlE9OzI7DJKFw
         WyKnWDjackbOgKu5GaOsK38orAC8g1nHjBvQGbRxiFY5hW/fzOUFkWadBmkuKGmqhx
         uJQ54ZV32NMNlPtNFMOIOIudQE4z08729sJRDoGSxzKyeLoYa71r5Wsam1us58ezzr
         7VxnfeW9/S42vguVYF0+p6BHQqr1GqQumyvAsE/mZU8K8BEwzlHSGf+mYEvmsXVenV
         w6eR50DZYwfoQ==
From:   Alejandro Tafalla <atafalla@dnyon.com>
Cc:     Alejandro Tafalla <atafalla@dnyon.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add reset-gpios handling for max98927
Date:   Sun, 29 Aug 2021 17:45:42 +0200
Message-Id: <20210829154545.383119-1-atafalla@dnyon.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max98927 codec on some devices (i.e. Xiaomi Mi A2 Lite phone) require
hardware-resetting the codec by driving a reset-gpio. This series add
support for it through an optional reset-gpios property.

Alejandro Tafalla (2):
  ASoC: max98927: Handle reset gpio when probing i2c
  dt-bindings: sound: max98927: Add reset-gpios optional property

 .../devicetree/bindings/sound/max9892x.txt       |  3 +++
 sound/soc/codecs/max98927.c                      | 16 ++++++++++++++++
 sound/soc/codecs/max98927.h                      |  1 +
 3 files changed, 20 insertions(+)

-- 
2.32.0

