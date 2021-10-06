Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC5C4237CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 08:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbhJFGOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 02:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhJFGN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 02:13:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1689FC061749;
        Tue,  5 Oct 2021 23:12:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j8so5206855wro.7;
        Tue, 05 Oct 2021 23:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hY7mBaE1rfc79Xt1tO6nEvrIJo4wYzKOrnrvEzqBGbI=;
        b=kfFT9hj5OWPpI8H6w2EX92FLH0+5ndq19A/vjdlRucIRQD8riSsBvBQdmbWGTPH3rg
         N49nq+J77k1pCf/s1H2Z8HGOZSyXuGuME9zcEJuCAVaJgXiIv9lvPrnlPEnewnPH2L98
         4X9S7nucDxHChp9ojz5sAIKBYCfEX1RHnE+mmb+H1PeU4Zidq6CaVLUSld74omNb1i8H
         2kTWqVEE5sKNuwF24I7QND0jZlpBoOGL/j+6Fj/UaS1ZOsb8rJpUKYZ+RRtTU7nftqtb
         0V9KbjOuJ0j6x5Lbl0mw7iWKDwkxKrSRmLz10tNvBdeW2+Yq1Kx7iQYOWlce2PZI+9ET
         bkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hY7mBaE1rfc79Xt1tO6nEvrIJo4wYzKOrnrvEzqBGbI=;
        b=WcP2x//+HKVHnkZw4i1h4A7COl1kLXGksWwt61dRbKsTo6mrd3n6KcOTFnRGiDfzSz
         6d+TWV+xIyhidM34c6m/2nAlTwetWw2fehvDnyT/XwzwZ5LgF1xiqL1w1jKWCWqwJKWB
         pLyMWOcguZEBtznNIbOBNwS+pHXNkYdgS+YLbsCmXtGNobcWjAmlknubHKlkSAMksM4b
         Mnw2M57abUCys+kZjx7G6e2Op4jK8OqcZ4EurJCrWreb3KqE801yfD2AIUYugCKbziRJ
         WL37ZjRRbIyk/Gv5b8WT7jMdOnWuGLKjgvqftKUI/LLGODhc9P7R7gKj7d7JA6B9HJQH
         n9LQ==
X-Gm-Message-State: AOAM533M1Dw33UGbJIBrmcLMe44ZWToy6IcGIIPTe0kPI2Y1ez+b/TvS
        Tha6fqEhp+EZGn33agmn6YlBHfqwMv4=
X-Google-Smtp-Source: ABdhPJxO1g0hZP/rindHKZdsa6Ep9hQS8U+nTlR8t2sm8gOLLKyDW25wBNMh6LbL2aV5XmPAdWStFg==
X-Received: by 2002:a05:600c:2057:: with SMTP id p23mr7782941wmg.25.1633500726733;
        Tue, 05 Oct 2021 23:12:06 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id e8sm3893071wme.46.2021.10.05.23.12.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Oct 2021 23:12:06 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-staging@lists.linux.dev, neil@brown.name,
        linux-kernel@vger.kernel.org, john@phrozen.org
Subject: [PATCH 0/4] clk: ralink: make system controller a reset provider
Date:   Wed,  6 Oct 2021 08:12:00 +0200
Message-Id: <20211006061204.2854-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series add minimal change to provide mt7621 resets properly
defining them in the 'mediatek,mt7621-sysc' node which is the system
controller of the SoC and is already providing clocks to the rest of
the world.

There is shared architecture code for all ralink platforms in 'reset.c'
file located in 'arch/mips/ralink' but the correct thing to do to align
hardware with software seems to define and add related reset code to the 
already mainlined clock driver.

After this changes, we can get rid of the useless reset controller node
in the device tree and use system controller node instead where the property
'#reset-cells' has been added. Binding documentation for this nodeq has
been updated with the new property accordly.

This series also provide a bindings include header where all related
reset bits for the MT7621 SoC are defined.

Also, please take a look to this review [0] to understand better motivation
for this series.

Thanks in advance for your feedback.

Best regards,
    Sergio Paracuellos

[0]: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210926145931.14603-3-sergio.paracuellos@gmail.com/ 

Sergio Paracuellos (4):
  dt-bindings: reset: add dt binding header for Mediatek MT7621 resets
  dt-bindings: clock: mediatek,mt7621-sysc: add '#reset-cells' property
  clk: ralink: make system controller node a reset provider
  staging: mt7621-dts: align resets with binding documentation

 .../bindings/clock/mediatek,mt7621-sysc.yaml  | 12 +++
 drivers/clk/ralink/clk-mt7621.c               | 79 +++++++++++++++++++
 drivers/staging/mt7621-dts/mt7621.dtsi        | 27 +++----
 include/dt-bindings/reset/mt7621-reset.h      | 37 +++++++++
 4 files changed, 140 insertions(+), 15 deletions(-)
 create mode 100644 include/dt-bindings/reset/mt7621-reset.h

-- 
2.33.0

