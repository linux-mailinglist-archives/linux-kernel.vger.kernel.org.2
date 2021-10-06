Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C496442389B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbhJFHRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 03:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237313AbhJFHRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:17:50 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A16C061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 00:15:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id n8so6315337lfk.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 00:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AKrh6jeg1+D2CUT4DyWcA9w76ozKBLfI8b6gpIDDpCY=;
        b=jlvFw1VyiUIGeXyBbQ9knQIXcxkL5XR1d87HM6bU+T3TKIwdXnnumNjfeQaX1d878T
         svv3scwdLS4dmAva4UIVS5EK12PD74qGcJ652OscGWQNjBkuAhLvcdubUBVqPWpiC3VI
         jhCmorePoM8uiIS2+Cu6GdwuJcx1eCQ9hpHMNsyi4arUZbX2dCNVCm3/cbkH4f8hDrGa
         7Dlf6EqmJ+v6doctL4CnV4sN6f8We+sz5hu6w/zdGmU+YUbXKpWyJoQ+ZfIIY9YzN2br
         iE/CQRmOgCbFlFOzyF6uRhd3BEV1iJp+OKQUIqi2lkWSk6jlXgYeraLdeSBPkuCyPp1H
         d5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AKrh6jeg1+D2CUT4DyWcA9w76ozKBLfI8b6gpIDDpCY=;
        b=JOUesQdNayPiVW3JPyOoSZtDUWMGjaZL+uaDhBmk7u/kqdx5jIaSCGMHKOJKYF+H3M
         6jVmwee0pKcmgrvjuZi00nQ4dCqdhbU6lfDG7sFLzkLhuT2DmGe/nGg+yelzHyOtiy/A
         EM7F5oaiRbopetfxtaENHSrLzBZgB1IW9Q1Q/zxk/PgungoDAJumuoQ+64L6zjOsI+Ii
         HC6KRVEsVfXxpbqgFExCnLYuzy8XqOrNsS77OLQxzPtLsVsqX7aSKOgb6KMqvdinDzUb
         i8qxS8iQu+8aSmaMGz0seh1YtVV7KkGk/ks5qJf/lGtfB8bsJGL/DM8/5h58J1BEGVuz
         bVSA==
X-Gm-Message-State: AOAM5311ri2p0WdMGs30XFLeSvEOb2RcH4mf5A0Kift/G/zw4pjyhuKW
        /k/vJd9dVVP58etgDZilHJj6ILP1cFkjSg==
X-Google-Smtp-Source: ABdhPJxX+Sqcew6GyVwEuZ8oDl53IzGhaBx4xrF1wNs0tSxodxjwllEsfBZ5NsFHcMMU+iWWjE3zCQ==
X-Received: by 2002:a05:651c:1039:: with SMTP id w25mr26709368ljm.440.1633504556692;
        Wed, 06 Oct 2021 00:15:56 -0700 (PDT)
Received: from jade.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id y7sm960376lfk.143.2021.10.06.00.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 00:15:56 -0700 (PDT)
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
Subject: [PATCH v6 0/6] Asynchronous notifications from secure world
Date:   Wed,  6 Oct 2021 09:15:40 +0200
Message-Id: <20211006071546.2540920-1-jens.wiklander@linaro.org>
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

The documentation and DT bindings patches are now well reviewed, but
the patches with code would do with some more attention.

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

 .../arm/firmware/linaro,optee-tz.yaml         |   7 +
 Documentation/staging/tee.rst                 |  30 +++
 drivers/tee/optee/Makefile                    |   1 +
 drivers/tee/optee/call.c                      |  27 +++
 drivers/tee/optee/core.c                      |  87 +++++--
 drivers/tee/optee/notif.c                     | 226 ++++++++++++++++++
 drivers/tee/optee/optee_msg.h                 |   9 +
 drivers/tee/optee/optee_private.h             |  23 +-
 drivers/tee/optee/optee_rpc_cmd.h             |  31 +--
 drivers/tee/optee/optee_smc.h                 |  75 +++++-
 drivers/tee/optee/rpc.c                       |  73 +-----
 drivers/tee/tee_core.c                        |  10 +-
 include/linux/tee_drv.h                       |  14 ++
 13 files changed, 496 insertions(+), 117 deletions(-)
 create mode 100644 drivers/tee/optee/notif.c

-- 
2.31.1

