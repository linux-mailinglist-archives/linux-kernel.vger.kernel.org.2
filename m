Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0586C3FAD63
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 19:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhH2RIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 13:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhH2RIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 13:08:22 -0400
Received: from dnyon.com (unknown [IPv6:2001:ba0:1800:12f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DF6C061575;
        Sun, 29 Aug 2021 10:07:30 -0700 (PDT)
Received: from dnyon.com (45.74.222.87.dynamic.jazztel.es [87.222.74.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id A3C6740442;
        Sun, 29 Aug 2021 17:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1630256848; bh=K7WOQRGdrSf+PbNjqY1YtmWTU3lNTVPtvBKbaWcq284=;
        h=From:To:Cc:Subject:Date:From;
        b=Ue4Xpfz8jQCWWVN5n1TB79rkzw7GeTblHz3Mr4X4/4W81m1sFw8zbcuspenzoxfYS
         WjNSu00M2iSKGG+vBv7CFuNh9xvKYS46QOq7FTFpzWP2fvI6walzTC5roLkGcmdFy/
         iCh33lZJkjeepo73AscnNqYk1MdIwzZpeaVzrnL7EvQA8h+GL6rZBaxz4jFOh8lgAq
         7rinpQieKKLeX4dlDIaiWLs16JvA6IGUvMfzJUHPQgOTwsnbQQUobn1j+CADxyGAVf
         JmSgw3uuQr9S7EMXTFhjQQLlDnZWYmNA/WtteHWEIwwAxwXrTZfsyCZm/xYMAvzQa1
         dXQUn6mvRZo+Q==
From:   Alejandro Tafalla <atafalla@dnyon.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Alejandro Tafalla <atafalla@dnyon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/2] Add reset-gpios handling for max98927
Date:   Sun, 29 Aug 2021 19:00:15 +0200
Message-Id: <20210829170019.384632-1-atafalla@dnyon.com>
X-Mailer: git-send-email 2.32.0
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

 .../devicetree/bindings/sound/max9892x.txt       |  3 +++
 sound/soc/codecs/max98927.c                      | 16 ++++++++++++++++
 sound/soc/codecs/max98927.h                      |  1 +
 3 files changed, 20 insertions(+)

-- 
2.32.0

