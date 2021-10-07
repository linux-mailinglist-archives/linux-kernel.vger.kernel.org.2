Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583E1424BEA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 04:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbhJGCub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 22:50:31 -0400
Received: from dnyon.com ([82.223.165.189]:43402 "EHLO dnyon.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232254AbhJGCu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 22:50:29 -0400
Received: from dnyon.com (55.red-81-39-194.dynamicip.rima-tde.net [81.39.194.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id B059B3FD71;
        Thu,  7 Oct 2021 02:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1633574393; bh=InGqucc62ZYMr1WtkutA5FBp7KXBlrC8+tssE6HbyFA=;
        h=From:To:Cc:Subject:Date:From;
        b=zhwnJWAw0ou5BaKphNIfrtWm2WGiX8PSehems8NJwg0IeHNblYaTZIuBw99YUwjrW
         loA2+uLXLeC7qyFWxfOscZlgw57HWHZslp4iGKXHFMggm+pBzmk+7XZNpRqjp1lf+g
         ZY5TkYAg/z+6fPQDh0fFFe0RznPa44QAIzA7XMyNcUQCqfAZXiOpvVUcs9d12yc6zC
         2XK8qiTOg0mKz5sQrdumOriaSgEV1eDdvnNSp375FoW/c8H7AdayKqAY/4g2Uc5QXo
         qSVX0L31txEF7u9+UIqdWqgbGHe4lpAkZChuPT0xC+m5E4BS8C+1ZDelfgajVbeQFh
         vWEyLDd5WLkvg==
From:   Alejandro Tafalla <atafalla@dnyon.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Alejandro Tafalla <atafalla@dnyon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org
Subject: [PATCH v4 0/2] Add reset-gpios handling for max98927
Date:   Thu,  7 Oct 2021 04:38:54 +0200
Message-Id: <cover.1633572679.git.atafalla@dnyon.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max98927 codec on some devices (i.e. Xiaomi Mi A2 Lite phone) requires
hardware-resetting the codec by driving a reset-gpio. This series adds
support for it through an optional reset-gpios property.

v4:
* Correctly assert/deassert the GPIO states
* Wait for the i2c port to be ready after reset
* Reset device when removed

v3:
* Fix indentation on the dev_err_probe line

v2:
* Use dev_err_probe instead of dev_err

Alejandro Tafalla (2):
  ASoC: max98927: Handle reset gpio when probing i2c
  dt-bindings: sound: max98927: Add reset-gpios optional property

 .../devicetree/bindings/sound/max9892x.txt    |  3 +++
 sound/soc/codecs/max98927.c                   | 25 +++++++++++++++++++
 sound/soc/codecs/max98927.h                   |  1 +
 3 files changed, 29 insertions(+)

-- 
2.33.0

