Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780C6430A58
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 18:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241829AbhJQQCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 12:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbhJQQCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 12:02:45 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12C7C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 09:00:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w14so60264877edv.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 09:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=8kT8uxQmVp/XocDx24aLnGXhZi2Xo78WndzfJoxUXf4=;
        b=qrLR02zphJEnatJargVO7TxpS34lT74UJQ7lr8oE5lRkxlgLQ8ArQlSrMq0GflGD4D
         7dsC4ii8/jjoRXXFbXupZOzWH72mJb3LlTLH51cGjaN1yZtLeYc/5IbApZp/Vef1FWLv
         O/AxFsGAUDTwmk8J170VCDyJIOH8E6WyzOhazTkVUwtTpQvU++ESv905EVNkdr2mXK2S
         1DDGvigBCQr5Rvcn8nh1zzwlQEdsXI/GzB8f6/MOmg4Kw9q9PTawl64ev7SjmyS1jQoc
         YTIdRXAompcx+ZsrJvdyZdBUbv6WIDveBO4RmE7looBbHelfcJlV7jz1ubenysiOzKEZ
         cvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8kT8uxQmVp/XocDx24aLnGXhZi2Xo78WndzfJoxUXf4=;
        b=n2Aut80nYzNy/1M4kOx6L6Jvn+LAbswG5+OsuPSF1KZ8TN9yTYAXx1yYB3ncg9+Bax
         sfEV8iwsxEzMpBC+mNjITQkxU0s3NtADFsxjlsG0mNffoOY0xzzs6pnBSz0VejHsP/fV
         C+DQgsME98hk7zAfiIK85wcOgCflSDakgoN+I0f5V+1rrlQgS1D0LbvelqmJT0BtV6Fb
         5BOv9Q1ey/kzk/kAmbKqS5zXHRT/1WX86ur8D3S7CPpI/wxuD+NREtN0ocHTsFWnfBN8
         Dy8A74yOSduHCOfFP9eUPZR4s8KZWLjmj0bgONF4wdVa0Zpgf9158jsutCrOZ5gxYb1e
         I1/w==
X-Gm-Message-State: AOAM5317EngO1l25HopYMZOFkTlS2RfdodWzzdUKaJIQwgUjnCqNqn86
        AvxolHUMJ4iXR/B+da/UuJY=
X-Google-Smtp-Source: ABdhPJwTB0vfk1m5xsCYFd2NXY/+qkTRYqLJ8qato/ZDGtv+VE5V+xBNUFGnEFhH9R8hZ1fiItRyuA==
X-Received: by 2002:a05:6402:3547:: with SMTP id f7mr36201251edd.395.1634486434122;
        Sun, 17 Oct 2021 09:00:34 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id yz9sm7693135ejb.51.2021.10.17.09.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 09:00:33 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Matthias Reichl <hias@horus.com>
Subject: [PATCH] ASoC: meson: implement driver_name for snd_soc_card in meson-card-utils
Date:   Sun, 17 Oct 2021 16:00:28 +0000
Message-Id: <20211017160028.23318-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement driver_name to provide an alternative to card_name for userspace
configuration of Amlogic audio cards.

Suggested-by: Matthias Reichl <hias@horus.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
The meson AIU/AXG drivers currently require alsa confs based on the board
model name which is unique to each board. This is very flexible for audio
use-cases, but not very maintainable for distros with a single use-case
that need to support a large number of different Amlogic boards. Using a
driver name to match the card conf instead of card/model name reduces the
number of confs needed in the LibreELEC (Kodi) distro from 41 to 2.

 sound/soc/meson/meson-card-utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/meson/meson-card-utils.c b/sound/soc/meson/meson-card-utils.c
index 415cc0046e4b..29b0174f4b5c 100644
--- a/sound/soc/meson/meson-card-utils.c
+++ b/sound/soc/meson/meson-card-utils.c
@@ -302,6 +302,7 @@ int meson_card_probe(struct platform_device *pdev)
 
 	priv->card.owner = THIS_MODULE;
 	priv->card.dev = dev;
+	priv->card.driver_name = dev->driver->name;
 	priv->match_data = data;
 
 	ret = snd_soc_of_parse_card_name(&priv->card, "model");
-- 
2.17.1

