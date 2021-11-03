Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7EF443EDF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 10:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhKCJFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 05:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhKCJFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 05:05:39 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46340C061205
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 02:03:03 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id g3so2595131ljm.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 02:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IOBd8zmaQ/o/1Os9BhWOC3FQNCJBCGeietUzMVOB0tg=;
        b=lkTCANroPPKqVJC2MHaOK86LkAxmqCcoPdzizhKQsu5FLX5GklvxDeJF36LAnEbriE
         /d0D/zPVKfsDXRgwEhutWoZmAA51U6dk3gI5+u9Lv3F0VUsAHP3Xv6RVDqszdo5BAoI1
         JyoHV7aHz2FclXZTqCpT1XmaI2aQbjBVX7IWMqUmOELfd4xCE95fU/YAOAnnFLaB8Vou
         qoW0LDe3srMyajm/2DrskM/J8/+Zyp+W9tkYBxloCHJHnbiFEx3Sh/zw6ehmn8mjV3ED
         jrSVMvnb93+jMNWRO/u+Gmse7D47hIk5dz4ytn6rByjj/ZLKlnTfmVppPx4KWIcV1O42
         P8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IOBd8zmaQ/o/1Os9BhWOC3FQNCJBCGeietUzMVOB0tg=;
        b=5VX88LQV/Q91R0puyZ+Y2p0WBPRTdIhi5fsl8jE74w+Gv+fYgcxvdil/lgYiwGL7Yp
         8jxFWr38FnKQqMFkAe0i8Dxck9h7XEJ2iJzZZ56/bH8a9V+JrtLxUl7bIV+IuORw6mW8
         AjR9S6ei7UNLlyjySLf5Q3sttFL+XK5twDwxRY0QtBxFsLYxOI1lHtPXkburJMosLJFj
         U5XySNWdLyk9MGPTTbjg+6G/tR+l2gEU938pfP8XtAaXJjFvAShYNBjGOOo5L0UOh1kg
         Jm1kSKF6bU67Y1g8Wi4T5JeLP19E08ZulTUEaBGcKRAfR+pEQ6hn8OceXVbfazv0GGfq
         RNcA==
X-Gm-Message-State: AOAM530/VDwOMO77EOxR7wAO9ecs1gKaOtbQvCGzYCbrvKSUbjBtUwKr
        9vuuAuszMQlxV8RQVYZ0vmXlrVM/auw9c7vZqxE=
X-Google-Smtp-Source: ABdhPJw1zrzgQqG3DycM6ORsIoM0D4GUG1DpG6pE6I48Ta4qjxKuttUcAyk2hbAKXaylJrPkGpV71w==
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr43739989ljp.307.1635930181221;
        Wed, 03 Nov 2021 02:03:01 -0700 (PDT)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id w16sm124373lfr.233.2021.11.03.02.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 02:03:00 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, jens.vankeirsbilck@kuleuven.be,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v8 0/6] Asynchronous notifications from secure world
Date:   Wed,  3 Nov 2021 10:02:49 +0100
Message-Id: <20211103090255.998070-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This adds support for asynchronous notifications from OP-TEE in secure
world to the OP-TEE driver. This allows a design with a top half and bottom
half type of driver where the top half runs in secure interrupt context and
a notifications tells normal world to schedule a yielding call to do the
bottom half processing.

An edge-triggered interrupt is used to notify the driver that there are
asynchronous notifications pending.

Only the SMC based ABI of the OP-TEE driver gains asynchronous
notifications. Future support for asynchronous notifications in the FF-A
based ABI will rely on APIs which are expected to be provided by the FF-A
driver in a not too distant future.

This patchset is also available at
https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=async_notif_v8

v7->v8:
* Fixed an error in "dt-bindings: arm: optee: add interrupt property"
  reported by Rob's bot.
* "optee: add asynchronous notifications":
  - Fixed a few spell errors in comments
  - Added a missing optee_unregister_devices() in the cleanup path of
    optee_probe().
  - Added Sumit's Reviewed-by

v6->v7:
* Rebased on 4615e5a34b95 ("optee: add FF-A support") in
  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git with
  34f3c67b8178 ("optee: smc_abi.c: add missing #include <linux/mm.h>")
  cherry-picked on top. This allows to resolve the conflicts with
  pull request "[GIT PULL] OP-TEE FF-A for V5.16"
* Factored out the interrupt handling added in "optee: add asynchronous
  notifications" to only go into smb_abi.c. A different approach is
  expected with FF-A once it has asynchronous notifications.
* Addressed review comments from Sumit Garg:
  - Replaced 0 and 1 with the macros GIC_SPI and IRQ_TYPE_EDGE_RISING in
    the example in the bindings.
  - Replaced the magic number to optee_notif_init() with
    OPTEE_DEFAULT_MAX_NOTIF_VALUE in the commit "optee: separate notification
    functions"
  - Switched back to tagged error path in optee_probe()
  - Fixed a few nits in "optee: add asynchronous notifications"
  - Applied Sumit's Reviewed-by on all commits but the last,
    "optee: add asynchronous notifications"

v5->v6:
* Rebased on v5.15-rc2
* Replaced "tee: add tee_dev_open_helper() primitive" with "tee: export
  teedev_open() and teedev_close_context()" since it turned out that the
  normal teedev functions could be used instead as noted by Sumit.
* Changed "optee: add asynchronous notifications" to use the exported
  teedev_open() and teedev_close_context() functions instead.

v4->v5:
* Rebased on v5.14-rc7
* Updated documentation to clarify that one interrupt may represent multiple
  notifications as requested.
* Applied Marc's and Rob's tags

v3->v4:
* Clarfied the expected type of interrypt is edge-triggered, both in
  the normal documentation and in the DT bindings as requested.

v2->v3:
* Rebased on v5.14-rc2 which made the patch "dt-bindings: arm: Convert
  optee binding to json-schema" from the V2 patch set obsolete.
* Applied Ard's Acked-by on "optee: add asynchronous notifications"

v1->v2:
* Added documentation
* Converted optee bindings to json-schema and added interrupt property
* Configure notification interrupt from DT instead of getting it
  from secure world, suggested by Ard Biesheuvel <ardb@kernel.org>.

Thanks,
Jens

Jens Wiklander (6):
  docs: staging/tee.rst: add a section on OP-TEE notifications
  dt-bindings: arm: optee: add interrupt property
  tee: fix put order in teedev_close_context()
  tee: export teedev_open() and teedev_close_context()
  optee: separate notification functions
  optee: add asynchronous notifications

 .../arm/firmware/linaro,optee-tz.yaml         |   8 +
 Documentation/staging/tee.rst                 |  30 +++
 drivers/tee/optee/Makefile                    |   1 +
 drivers/tee/optee/core.c                      |   2 +-
 drivers/tee/optee/ffa_abi.c                   |   6 +-
 drivers/tee/optee/notif.c                     | 125 +++++++++
 drivers/tee/optee/optee_msg.h                 |   9 +
 drivers/tee/optee/optee_private.h             |  28 +-
 drivers/tee/optee/optee_rpc_cmd.h             |  31 ++-
 drivers/tee/optee/optee_smc.h                 |  75 +++++-
 drivers/tee/optee/rpc.c                       |  71 +-----
 drivers/tee/optee/smc_abi.c                   | 241 +++++++++++++++---
 drivers/tee/tee_core.c                        |  10 +-
 include/linux/tee_drv.h                       |  14 +
 14 files changed, 525 insertions(+), 126 deletions(-)
 create mode 100644 drivers/tee/optee/notif.c

-- 
2.31.1

