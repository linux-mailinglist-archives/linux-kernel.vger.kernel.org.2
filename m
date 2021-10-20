Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93693434A52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhJTLou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTLos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:44:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67853C061746
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:42:34 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id s198-20020a1ca9cf000000b0030d6986ea9fso9520501wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1H7Jji7fIBx6bP4sgM7SKKuxwv994hR/z172a1Gf+IQ=;
        b=clVBu1hn1ydfk9h4lru/P+UxNhcv1Kv3w9oJAiA8PQbnMt0aRyKG3l3dAU4NBndB7q
         Pzg7rt2/mgBfXQ7zGU3HYXy+t9Jp/32h/JWn6Un/ciCyJ/mOLlWS+Lwa5QgWgvkPtF7A
         7KrzklV1v5pGzTatrZceRo1p5uMk6zz3xwww4iOoJrhg75Ky5i9NYkvbdqWIAYrpvpjg
         yHii6VOaUDAU6zrSGXgzb37ksn0HxQuG2k93RIFDiEXm/SdF/D4yH89hnLBtsWbf1L4Z
         3PZXRdYyqnKAi2u1hANQyRwqx/jcU+WtX/K7TMefqXHDOziedCeR/VO2wkuYnfEf1vS1
         zPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1H7Jji7fIBx6bP4sgM7SKKuxwv994hR/z172a1Gf+IQ=;
        b=lZg0NNfSEfJojSA6PckAwX0KTnJ9VKcsUNBCj3nQbf6RwI3Rep0clSjxJr3A/rgUJk
         B5Uf6PGoHqKDqwZxEALgNIKuok7dFAlu37zcRZUhwAfroIYyvrR6sBp+yUQxnTR48dRE
         +POnqLIW4MsPp9NrfdQnhBFxh8Xu0RlrxY37DXltCYWF34LkpZAYu7Op0YzodPPImJVZ
         2dHC8WBU1CMjn4wSkFPc6QnjrJO7HRPPr32gEn1QaquQU0kUzsbyIgLJe2TQgY/vnxiu
         OPti2m1cEvnduUAmOX7qwnTsm9MGrRqda71IaTwuLh8dowJpdonzO42EV2HzA69205Zg
         Bxaw==
X-Gm-Message-State: AOAM531YNxXXNUW9GKhVJWDIjj7rEJxoo5u4yxu0bp4LD8YhPI4seHML
        64TD9hEDEL4sFE2auiaBt1+LlDAcC1nrzw==
X-Google-Smtp-Source: ABdhPJz8QPobdNYOL533FNTMX2BasL1v0I2f1T3Hos3cXMcZGEiO6xYWEl9dLTPZbfnGUl78FI7H8Q==
X-Received: by 2002:a1c:f712:: with SMTP id v18mr13600190wmh.104.1634730152920;
        Wed, 20 Oct 2021 04:42:32 -0700 (PDT)
Received: from jackdaw.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s14sm1732927wro.76.2021.10.20.04.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 04:42:32 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH 0/2] ASoC: meson: axg: fix TDM channel order sync
Date:   Wed, 20 Oct 2021 13:42:15 +0200
Message-Id: <20211020114217.133153-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Amlogic AXG series, the TODDR FIFO may get out of sync with the TDM
decoder if the decoder is started before the FIFO. The channel appears
shifted in memory in an unpredictable way.

To fix this, the trick is to start the FIFO before the TDM decoder. This
way the FIFO is already waiting when the 1st channel is produced and it is
correctly placed in memory.

Jerome Brunet (2):
  ASoC: meson: axg-card: make links nonatomic
  ASoC: meson: axg-tdm-interface: manage formatters in trigger

 sound/soc/meson/axg-card.c          |  1 +
 sound/soc/meson/axg-tdm-interface.c | 26 +++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

-- 
2.33.0

