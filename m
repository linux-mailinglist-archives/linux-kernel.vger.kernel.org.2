Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEBD430239
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 12:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbhJPK4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 06:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbhJPK41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 06:56:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6024FC061570;
        Sat, 16 Oct 2021 03:54:19 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x27so53502643lfu.5;
        Sat, 16 Oct 2021 03:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1nXEEQOI2UyvJFPHSDiyUoFnaQvmSXlf0s7F8x76wlc=;
        b=l/7qp0MVktj3pxcjYP9oXhD8My/pkVceyXH3oedix5GS9BxwMQjo7JAd2GUyEpLgFJ
         6A3jHx9ICFXkVdu49qN0hEKmZrz2ZEhlTdvdmse34ktf0ATlExTZ3OMVZu32xnbqJW2P
         FDxZAHo9raJeXntES+2CUbL1k0Ay4WGatGyhMlmjXlTTBLjbACCTP2AdAj1spaQXMZVO
         5lD3PoaKhStIqLiTf/+T+GH2ACtOO/3folt0bgzpwcCp/jolrhr64pEViAd1HVdYa5lH
         VG6/fFrRSBy+fuIPUTC8+vbdCVoec4GuTn2lbS5SElm+OCp1q+t72Rg40uIFVSVr6ps7
         0a6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1nXEEQOI2UyvJFPHSDiyUoFnaQvmSXlf0s7F8x76wlc=;
        b=YGvieu6l+k7j40pZxPn3mn3GWmGhwKghZtLIt7wQ2/wkSv+m98Pqg7KQxJCb2oz7XQ
         mmIlGyVjwn/houC05X/1Ov9v5K7FHA6u4i2dm4Gp359eK6Xm3GELK2OpjuBn/FraDDZB
         5XC2KmAEsmYJi25GoUXJMLcarjd2y6M4tvu3Qf5zEbPtjTKd2/ml9vRCX1JN2ks9qVRO
         y9TEsD0KgBha5UB9mX2FLosCHSBZ/+JEt1hV0rQOVZfhyTHt+ddB4EYRfL4o3pDhbq+O
         CHOudnPEhFn/2vTDklvO9HUvKXAWbp1UhdCH+suOUUrn22FT65yxdzC2V1jB9ulczixV
         +quQ==
X-Gm-Message-State: AOAM530h7ZISd+GGJVjCmO+tt8ITB8Shemk49Dl5fOCcpqsiugQn13hS
        iL/DkktJueVOixdAk4setwIOc96n+vE=
X-Google-Smtp-Source: ABdhPJy71ErVHEZBd5Yxc8l9Ddc4qLHPXpX6v/GjX9j4ndPss0lcNvuXGDEW7DzF5dJ7R5zXECcltg==
X-Received: by 2002:a05:651c:2121:: with SMTP id a33mr6782437ljq.490.1634381657633;
        Sat, 16 Oct 2021 03:54:17 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id r3sm814224lfc.131.2021.10.16.03.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 03:54:17 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Getting rid of the reset controller in i2s-tdm
Date:   Sat, 16 Oct 2021 12:53:49 +0200
Message-Id: <20211016105354.116513-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

after some discussion with Heiko on IRC, he has admitted to me
that the rockchip,cru property, and its corresponding half a reset
controller in the driver, is weighing heavily on his mind.

The background is that if the lrck only uses one clock for both rx
and tx direction, then according to the downstream driver, the rx
and tx resets should be asserted at roughly the same time to keep
things in sync.

Since there is no existing kernel way of doing this, the driver
would manually write to the CRU's registers to achieve this,
violating abstractions.

We've agreed that an atomic bulk reset API would be the best way to
achieve what it does in a clean fashion. The details of such an API
have yet to be worked out by me, but as it turns out, this is not
a pressing need.

During my investigation, I noticed that I can simply drop the
synchronised reset for now and assert the two resets manually one
after the other, and deassert them in the same manner.

For the case I care about, which is audio playback, this seems to
work just fine. Should someone actually find a case where this
causes a problem, it should be fixed with an atomic bulk reset API.

Patch 1 removes the direct CRU writing stuff from the i2s-tdm driver.

Patch 2 drops the rockchip,cru property from the bindings; they have
not yet been in a kernel release, so as far as I know, we can still
change them with no regard for backwards compatibility.

Patch 3 adds the rk356x i2s1 node without the rockchip,cru property.

Patch 4 adds the analog audio output on Quartz64, included here for
Heiko's convenience.

Regards,
Nicolas Frattaroli

Nicolas Frattaroli (4):
  ASoC: rockchip: i2s-tdm: Strip out direct CRU use
  ASoC: dt-bindings: rockchip: i2s-tdm: Drop rockchip,cru property
  arm64: dts: rockchip: Add i2s1 on rk356x
  arm64: dts: rockchip: Add analog audio on Quartz64

 .../bindings/sound/rockchip,i2s-tdm.yaml      |  16 ---
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  31 ++++-
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  25 ++++
 sound/soc/rockchip/rockchip_i2s_tdm.c         | 126 +++---------------
 4 files changed, 76 insertions(+), 122 deletions(-)

-- 
2.33.1

