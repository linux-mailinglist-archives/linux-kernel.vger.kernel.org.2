Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1D4440976
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 16:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhJ3OWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 10:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhJ3OWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 10:22:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620F7C061570;
        Sat, 30 Oct 2021 07:20:12 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v127so10198961wme.5;
        Sat, 30 Oct 2021 07:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZFTYT6IC4NLo8CTX3uHADufxZSHsQHANfpdDkatrvm0=;
        b=hJxH6Ugw++00fYcTpUDu9jMLnXmwJTbIkf95xjTu2Nr8Aq5KxRBgvwvSd0K3Xi2eXn
         Ahq29tGkixhXxNXNQfJdDhasqP0vQfu/BU3WZM9mqXlsvOpSxXO+UQso12fDw6OwAqh/
         oxcGiB26rfk6UfdUsMaZON0Ag84rISE72AabU3g33J+cx1HpcNaxEKH+LD8ddJHGP8gD
         QsTkWqmqAbCIoNDv4E4rFSF0jti+EuaQcEK9eO3lf6v+S4KvwOnu4AeorzQ8W4wO2Tk1
         5lHoKVwL7L+xvegGFXDGgIo1Zvf01wS28lfitbN1Rl9Wq5Hi52QzkC47lXbUnXKP+IUW
         tYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZFTYT6IC4NLo8CTX3uHADufxZSHsQHANfpdDkatrvm0=;
        b=TqWO7sAPf77s+PFpVtzHfu9g9fqMiWRvcUi0KxeHD8nIK+HfPUlxMq9BzC26SP+ybR
         j/rJAuDNOrPljdEOA7fSw+nZ6lYEFluFhcY54sjFrM+VXzenbKjRxoona1fcBW8PX8kQ
         jRjrEnTX5sdaaYy4gK7GowUDLe5dDClGsbAk+a9jwGAv4W/WAOYhJ1BDqDS5ErsmFcEL
         WQ1jMz0WswZmWxj9KZ4z9rPhH7/ainhiVmXh2PZ3o2sRfjbOXLlfZgAgYXonYj5CoA0k
         Z9eqalOLz4M6K0H5RLKMD79zB+8zvHMCEOJZj9Htf8kGBbJV0Zfgkzlcu9j01pG0I3Wx
         yzDg==
X-Gm-Message-State: AOAM532uqNcxBDAqfQ5bMUk9Vyd2XgwBe1ekfg9/DyFe5bgqMmSnvEgf
        rZN37kXi8EYNn7XFlpTB8mSPotXA3I190w==
X-Google-Smtp-Source: ABdhPJyLolcJnyhOlakjMd7/G2CYaY63bgSXRgSX++VpQLBOLJU7CiZ8qGTExh8xJ52gMaBhnQ/acg==
X-Received: by 2002:a05:600c:354d:: with SMTP id i13mr18513917wmq.189.1635603610627;
        Sat, 30 Oct 2021 07:20:10 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id m12sm8208521wrq.69.2021.10.30.07.20.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Oct 2021 07:20:09 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org, john@phrozen.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name
Subject: [PATCH v3 0/4] clk: ralink: make system controller a reset provider
Date:   Sat, 30 Oct 2021 16:20:03 +0200
Message-Id: <20211030142007.27085-1-sergio.paracuellos@gmail.com>
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

Regarding the way of merging this:
 - I'd like patches 1 and 4 which are related going through staging tree.
 - The other two (patches 2 and 3) can perfectly go through the clock tree.

Thanks in advance for your feedback.

Changes in v3:
  - Collect Rob's Acked-by for patches 1 and 2. 
  - Rebase on the top of staging-next since there were already many
    changes there and PATCH 4 of the series didn't apply cleanly.

Changes in v2:
  - Address review comments of Dan Carpenter [1]:
     + Avoid 'inline' in function definition.
     + Return proper error codes (-EINVAL) instead of '-1'.
     + Make use of 'devm_kzalloc' instead of 'kzalloc'.

Best regards,
   Sergio Paracuellos

Sergio Paracuellos (4):
  dt-bindings: reset: add dt binding header for Mediatek MT7621 resets
  dt-bindings: clock: mediatek,mt7621-sysc: add '#reset-cells' property
  clk: ralink: make system controller node a reset provider
  staging: mt7621-dts: align resets with binding documentation

 .../bindings/clock/mediatek,mt7621-sysc.yaml  | 12 +++
 drivers/clk/ralink/clk-mt7621.c               | 79 +++++++++++++++++++
 drivers/staging/mt7621-dts/mt7621.dtsi        | 25 +++---
 include/dt-bindings/reset/mt7621-reset.h      | 37 +++++++++
 4 files changed, 139 insertions(+), 14 deletions(-)
 create mode 100644 include/dt-bindings/reset/mt7621-reset.h

-- 
2.33.0

