Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F254A3A97A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhFPKj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhFPKjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:39:17 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071F6C061760
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:37:11 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id r16so3101936ljk.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b7VdJEU0rTTCUa4ZBdIREuYAtQWfk2gNqxWTeP8ttgw=;
        b=ZCXHnYHl+0AT+7BONvro4DzCy5ufAcHrcQX5ytJG5jo+OfOYC3ZyS22kRtBvFGR8kR
         fbOx99+CnWCfYPAMjsFgZ3oBeWCc+ItYMdF+ypiJdbIjojGGYCfF7awql7UXOrL7cZ66
         P5j+dgyzgI+hY2thlTOaLefCptLQb2t1TeJsz72zP/5+hnVbQm3lh+Vepiso6RpK7yWh
         U8CjmwONzsPvLT5dU3EVeFjcR+83aDowkE8UH/eQC18qF3NKrje9u+xFsAv5EgtBZ8kb
         yns8QOxPP8d3eaQ9oc+saGGzMqd0OpVj5ZxbEaI+sPhkhFLuD2DYmG5OokafLPrwwnLg
         nAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b7VdJEU0rTTCUa4ZBdIREuYAtQWfk2gNqxWTeP8ttgw=;
        b=FexLDYUZA/gKNa+FbMqCWKsl8CaLtiFYy7gGdNzW5hXkqI2W5AsmxXu1xBjP/og1/G
         d326g/5czdPbsFxG4+esIUFpXbvBeH0IAIqDpGt+d6DSNXJkqo3Ql3qNf16uZofWx9mx
         hx5TTLL/XV6qYKX/yg6hFkSuMJh/o/PeF4kj9UiBaWDHIhHznpBDyZJck6cJqCBei2zk
         EV/A+ciH5RkFa3vFV6rALUUMtmi1yubPSvhL7TvbdLcI9hNgPm55rtcv4MoxTh8+RaTi
         u51wfEPCZUN0L6TVpQKnx8Triw7Bz5dme0T+MYMoJJBLOLybGQcoxaTpPuB5Uyu34G+J
         A16A==
X-Gm-Message-State: AOAM533kx95tKt2hGnA+tkWGln8KCW5wIeJbPHXnaRO9HkvP3sNk7JVj
        UvYGxBfXhSbRl5qOLnqJwfA8jnABZiOXOg==
X-Google-Smtp-Source: ABdhPJwLU5RpnLUnL4Junjt28owZW8zzr9JX42D48ieAQPbH8IWYa7EBR9wbPUnGFtbb9a9ZGvvYqg==
X-Received: by 2002:a2e:b170:: with SMTP id a16mr3889189ljm.67.1623839829193;
        Wed, 16 Jun 2021 03:37:09 -0700 (PDT)
Received: from jade.urgonet (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id m17sm205621lfh.288.2021.06.16.03.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 03:37:08 -0700 (PDT)
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
Subject: [PATCH v2 0/7] Asynchronous notifications from secure world
Date:   Wed, 16 Jun 2021 12:36:42 +0200
Message-Id: <20210616103649.2662395-1-jens.wiklander@linaro.org>
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

v2:
* Added documentation
* Converted optee bindings to json-schema and added interrupt property
* Configure notification interrupt from DT instead of getting it
  from secure world, suggested by Ard Biesheuvel <ardb@kernel.org>.

Thanks,
Jens

Jens Wiklander (7):
  docs: staging/tee.rst: add a section on OP-TEE notifications
  dt-bindings: arm: Convert optee binding to json-schema
  dt-bindings: arm: optee: add interrupt property
  tee: fix put order in teedev_close_context()
  tee: add tee_dev_open_helper() primitive
  optee: separate notification functions
  optee: add asynchronous notifications

 .../bindings/arm/firmware/linaro,optee-tz.txt |  31 ---
 .../arm/firmware/linaro,optee-tz.yaml         |  57 +++++
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
 14 files changed, 576 insertions(+), 155 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
 create mode 100644 drivers/tee/optee/notif.c

-- 
2.31.1

