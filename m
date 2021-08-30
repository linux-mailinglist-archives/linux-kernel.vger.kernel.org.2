Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9367A3FB413
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhH3KtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbhH3KtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:49:08 -0400
Received: from dnyon.com (unknown [IPv6:2001:ba0:1800:12f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9066AC06175F;
        Mon, 30 Aug 2021 03:48:14 -0700 (PDT)
Received: from dnyon.com (45.74.222.87.dynamic.jazztel.es [87.222.74.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id 8F7C640442;
        Mon, 30 Aug 2021 10:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1630320491; bh=0csqc1ZbDXmIHRbQOhyIoXigMPaPkBz6pMKmCmRXOcA=;
        h=From:To:Cc:Subject:Date:From;
        b=RuRGLtZmWZEbZSqXziYuHTi4c328X/G+cL4SX1UfhpSWYq+O3dPllp7twYJc4K6Sp
         XlRysrCA6j/VNMipnwL6oijEszJghvVMrJhqbI8jOayZ0pBB8ot9GjuotF6XBtKUB6
         UVlDhwgVhSRv5p/Os2g/7IVE8dyWkJxXOHa/Nk5BDBjBcWrTezscY9Tw5/xmLPaPIv
         Vd4ciwZiH/AZqe5nZiZ2IYhBdQ3QfVJlH2IYLeVBD98WAfygcI5hKlPyCOnfv9ouGl
         jvT7JmmrNVYmarDc2PuiEC5cUBxbosCncO1ANHbdg9vFDc6xwcVF8HHT1EDqoBdpNr
         1fPR7EqBdVEUw==
From:   Alejandro Tafalla <atafalla@dnyon.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     Alejandro Tafalla <atafalla@dnyon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add reset-gpios handling for max98927
Date:   Mon, 30 Aug 2021 12:44:22 +0200
Message-Id: <20210830104426.487246-1-atafalla@dnyon.com>
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

 .../devicetree/bindings/sound/max9892x.txt        |  3 +++
 sound/soc/codecs/max98927.c                       | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

-- 
2.32.0

