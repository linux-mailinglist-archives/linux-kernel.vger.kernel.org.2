Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B24D3D3800
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 11:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhGWJEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhGWJEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:04:02 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA94C061760
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 02:44:32 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id f12so1010932ljn.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 02:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=69jIFrc5Dv4sZ7Sebk4h84MxIXo7scSCzzsjBWeKzJc=;
        b=iCTaBkn8Wq/y2QDYfWs0tpGbwl3wK0Smw2sYp7+mTg+YBR4aXfc+m4ikRdNrlBl0Lh
         dA4u+C3d6esT3X8o3/y08Ez598/S+GT1RzHcK751GikQZYnWLwtz60yH/RETvQrbG0er
         lQvWyp12oQaVqC6R2v+30vS6+91I4GIYNPmJ2jfDglJ4N0hP0Yp0Uv6uoe1Y6Il1v2ZO
         8IKbbGGNhe2prb3PBHviMLYWn9IXV1eSt5+GGznfePvz/TL+a+NcpldA855fKVT4fvBG
         eW41vRyQO4h/mt6bUMgUOoCQRw7X24snUeBogJ094lo5pxRnsE/u6I7tGUVMg+nJI+1p
         +p3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=69jIFrc5Dv4sZ7Sebk4h84MxIXo7scSCzzsjBWeKzJc=;
        b=kDfqTkXZ56n+a/Zs+/PNB4eyKBiqKHJW3UpZEC0OLwizFnBC+yUqLWur5LFLWZ0MHI
         amit/nVeic9kXhcLzYvT08mYmjqCYzOs4DoT1A/90LK4G7UJ953VHsK1c4h9nLBPwOuj
         JU1WuQDKzOPOyQ9OERPJa1ZrTxjx9VyZpEcFnGYlPIUdinEafxayjM6CxG2Qk/6vlotS
         vcJlT4zwxW0ld81xcBH5+KYYuq14TeweoVvmK6d9rO6sFacdFdb5+FnNaZMHuzXhPl0I
         /rkUhBqAq5rJcSRhbenoO2K7jY+/C3fyfIHrvF54/uJeqlMxgY/XBDsyZe/+OyUoRKd/
         0v3Q==
X-Gm-Message-State: AOAM530R3Lti2FPjZyzAE0aFFspuo0bSUuDJ/9kfxnGWQPJGZXSVjOYp
        CpB4NB5oggMlBodLRDc7Qto92AkEP4ibGAEF
X-Google-Smtp-Source: ABdhPJw89Ne0hTG4LO+wqfJGEsMvU7CNMyUkADS6cr0fy3AXG3aXIaCPSQws85V/t6u4l/fufUk38A==
X-Received: by 2002:a2e:b4b4:: with SMTP id q20mr2777859ljm.155.1627033470502;
        Fri, 23 Jul 2021 02:44:30 -0700 (PDT)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id f2sm403808ljq.131.2021.07.23.02.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 02:44:30 -0700 (PDT)
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
        Marc Zyngier <maz@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 0/6] Asynchronous notifications from secure world
Date:   Fri, 23 Jul 2021 11:44:16 +0200
Message-Id: <20210723094422.2150313-1-jens.wiklander@linaro.org>
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

An interrupt is used to notify the driver that there are asynchronous
notifications pending.

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
  tee: add tee_dev_open_helper() primitive
  optee: separate notification functions
  optee: add asynchronous notifications

 .../arm/firmware/linaro,optee-tz.yaml         |   4 +
 Documentation/staging/tee.rst                 |  27 +++
 drivers/tee/optee/Makefile                    |   1 +
 drivers/tee/optee/call.c                      |  27 +++
 drivers/tee/optee/core.c                      |  87 +++++--
 drivers/tee/optee/notif.c                     | 226 ++++++++++++++++++
 drivers/tee/optee/optee_msg.h                 |   9 +
 drivers/tee/optee/optee_private.h             |  23 +-
 drivers/tee/optee/optee_rpc_cmd.h             |  31 +--
 drivers/tee/optee/optee_smc.h                 |  75 +++++-
 drivers/tee/optee/rpc.c                       |  73 +-----
 drivers/tee/tee_core.c                        |  37 ++-
 include/linux/tee_drv.h                       |  27 +++
 13 files changed, 523 insertions(+), 124 deletions(-)
 create mode 100644 drivers/tee/optee/notif.c

-- 
2.31.1

