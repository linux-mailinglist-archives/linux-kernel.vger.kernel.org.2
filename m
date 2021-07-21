Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173C13D13FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 18:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhGUPkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhGUPko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:40:44 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FADFC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 09:21:20 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id o201so2612326pfd.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 09:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wfihw5vcbXFixYEyu3107hsiuCejF8uRx6y/SePajmw=;
        b=tbVCQwqRZb3xhEMcZ9kLY+1IVVouRY9tXs6Rl4ekyBejDdtSM0U6rjkPFY1iwP4e/c
         5jthu5nvI2j3re94YzfiEFH2WlCz9Xie1Y160I+QFCGVKBh4QHifFpMQTZ5bKctPxVHI
         kvbyYH5ULKzkToxKnV4lt4/9gHp5rxseOP8+uVE6Jc2+3yEKmVsz4K8w3d9i5cZAfgFU
         Lzgn4oXWVAZukm/+FbXLwE2fwa8w3uSSyBr/Fx/EXFar1s70JG3DsCSaqS0JBGRW2vYe
         F5yTPfKmRb66HPX8z7BsARx1ndix8SaOgExCbhAIrRmiGK+gEfYQ606LjuRRcRG0A+Ll
         T1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wfihw5vcbXFixYEyu3107hsiuCejF8uRx6y/SePajmw=;
        b=OSiaXr/wT70epV8twABfiUa3PzJjjHt2U0kP/euTA6+y4ryABf24+TCBsqpfoUS+n4
         WjMTRhPC+p308tftX/ddriitpreIujGIQcCGvitB8ArU0e6NY6BCUr7GqP7aUBEWUthB
         X6t2JaN+QgcA3+1UrVsvTSXqq7Dsw/zsLD5q5sg4/XA6qClktIkSoU/HtFkd+L3e6Td2
         wj7H7SP6RjgvrH/kWKf6/rh7J9PnHr9LaGWvUFdxEZOZfFutZ3NuEnQuuNXh3owGM/jZ
         knRVzErjQNrEVsxepBpzb1QVCaRVQNl9ctFhOnJ7u61XG9WbDwyermEYb5yy2sPHoOOi
         awKQ==
X-Gm-Message-State: AOAM533L9lrXdx/DQTaPIzxDXhOA3KYwtNmmwW/cFXcttAW29Ej53ZFu
        kV2NrPdo8SGeC3XDwX9cKak=
X-Google-Smtp-Source: ABdhPJzUdZLTOl8wsS8QTCjlq7wqHJqyEdEigh67lI78uBVhYimW1o5Mr9SVnhi2jFdrHxMJBGyFvg==
X-Received: by 2002:a63:df14:: with SMTP id u20mr36675457pgg.348.1626884480181;
        Wed, 21 Jul 2021 09:21:20 -0700 (PDT)
Received: from localhost.localdomain ([122.161.48.33])
        by smtp.googlemail.com with ESMTPSA id s21sm3013459pfw.69.2021.07.21.09.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 09:21:19 -0700 (PDT)
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     nsaenz@kernel.org
Cc:     Ojaswin Mujoo <ojaswin98@gmail.com>, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, dan.carpenter@oracle.com,
        phil@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] vchiq: Patch to separate platform and cdev code
Date:   Wed, 21 Jul 2021 21:50:48 +0530
Message-Id: <cover.1626882325.git.ojaswin98@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adderesses the TODO item number 10 specified at:

    drivers/staging/vc04-services/interface/TODO

For reference, the task is:

    10) Reorganize file structure: Move char driver to it's own file and join
    both platform files

    The cdev is defined alongside with the platform code in vchiq_arm.c. It
    would be nice to completely decouple it from the actual core code. For
    instance to be able to use bcm2835-audio without having /dev/vchiq created.
    One could argue it's better for security reasons or general cleanliness. It
    could even be interesting to create two different kernel modules, something
    the likes of vchiq-core.ko and vchiq-dev.ko. This would also ease the
    upstreaming process.

A summary of the patches is as follows:

- Patch 1: Move cdev init code into a function
- Patch 2: Shift some devlarations from vchiq_arm.c to vchiq_arm.h for
           sharing
- Patch 3: Move vchiq cdev init code from vchiq_arm.c into vchiq_dev.c
- Patch 4: Decouple cdev code by defining a Kconfig entry to allow
           optional compilation of it.
- Patch 5: Merge code in vchiq_2835_arm.c to vchiq_arm.c

Changes since v3 [2]:

* In Patch 5, replace forward declarations of some of the functions with
  function definition 

Changes since v2 [1]:

* In Patch 1, as suggested, I have added error handling code back to
  ensure the driver exits when there is an error in creating vchiq cdev
  
* I have built this patch against the right kernel (gregkh/staging,
  staging-next branch) to avoid introducing any unwanted inconsistencies
  like whitespace changes

I have tested the patch using vchiq_test utility on RPi 3B+.

Regards,
Ojaswin

[1] v2: https://lore.kernel.org/patchwork/cover/1449117/
[2] v3: https://lore.kernel.org/patchwork/cover/1453915/

Ojaswin Mujoo (5):
  staging: vchiq: Refactor vchiq cdev code
  staging: vchiq: Move certain declarations to vchiq_arm.h
  staging: vchiq: Move vchiq char driver to its own file
  staging: vchiq: Make creation of vchiq cdev optional
  staging: vchiq: Combine vchiq platform code into single file

 drivers/staging/vc04_services/Kconfig         |   10 +
 drivers/staging/vc04_services/Makefile        |    5 +-
 .../interface/vchiq_arm/vchiq_2835_arm.c      |  564 ----
 .../interface/vchiq_arm/vchiq_arm.c           | 2330 +++++------------
 .../interface/vchiq_arm/vchiq_arm.h           |   82 +
 .../interface/vchiq_arm/vchiq_dev.c           | 1440 ++++++++++
 6 files changed, 2251 insertions(+), 2180 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c

-- 
2.25.1

