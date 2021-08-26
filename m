Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5E13F8774
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241009AbhHZMba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240725AbhHZMb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:31:29 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D770CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 05:30:41 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id f2so4846843ljn.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 05:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=phwK6HApLhy3x/6hExSzTZ7ylEqvksp6SGMj/MzgDCA=;
        b=tzP45EWP9X1pw46yUJS9KMtpNLka8QQPWnUvXAqr2pvOJwQVd2+4wPYsOMIQhbF2Ha
         jvM0cW+7Mby5WK+nZMt1RqnIB31Tb34UM6fFs0cDUKdRSA8qeTBY8WEfha1BSQ6i3Yis
         Ny5dzlAm61y9JIcRNV2v6ar5JnWmpQRGTTFbKItrD4h3/tBYcMMHVNtfJI6C9muVObBU
         P6rMrnvHJsyL/lcIQWlIu2jYwPHtIDoFmZ1E6cU0leR69asJhRRTvygvFWzorAtNwEPu
         nvuoCPduYHp9FdqlibZPrKJhnQdL4ijNy1dNWtffktOuO4bLNWvtXbv63C8IwNvEeBvw
         ub2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=phwK6HApLhy3x/6hExSzTZ7ylEqvksp6SGMj/MzgDCA=;
        b=LLofB5oep42asxKdyYA2nGv2/ijXmIKDUF5bOinQAre8vOIgH1sF/gYMBe9wwDgcuL
         jUrUYDkIcBnkqzW2hGTRP8uRrqwzAhiJuxfdWDxpEhT4poBGFet/NiRG/0A+LiNoiIAe
         e3bhn9j1foMcyXbEpeXTmnLm7islPebhEnCgUGWf8+jv7t5whVQdwy5gbG6VRFe87eVt
         NT2iJhGbg+xC7H4WN+y2J79XnLZTh+vbcjOghOlIphhNgjJpEImn56Qw/egigybydbl5
         YGTYkgVxE0bZUVWBHgug6p0VEvqAaDesbZqX1eJJyCJ9075ZoPxdgtx/xz7oX1CsgJXE
         3vrw==
X-Gm-Message-State: AOAM533gyJiYdWZ8aakKK9VIQIPykiQ6WECgzlQBBQ7J6EQ9LivBldVq
        ZHIuaPbVcwYF6o/qjzlhrlBbD+w9DMQFBQ==
X-Google-Smtp-Source: ABdhPJyrmUgDM1afmYmZ3eE3unD9fi176XSiNwF3ztwgvgdohetnFDFbK/kSfRL6hOFTU2zISOEMHg==
X-Received: by 2002:a2e:a595:: with SMTP id m21mr2790949ljp.399.1629981040078;
        Thu, 26 Aug 2021 05:30:40 -0700 (PDT)
Received: from jade.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j21sm332283ljh.87.2021.08.26.05.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 05:30:39 -0700 (PDT)
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
Subject: [PATCH v5 0/6] Asynchronous notifications from secure world
Date:   Thu, 26 Aug 2021 14:30:26 +0200
Message-Id: <20210826123032.1732926-1-jens.wiklander@linaro.org>
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
  tee: add tee_dev_open_helper() primitive
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
 drivers/tee/tee_core.c                        |  37 ++-
 include/linux/tee_drv.h                       |  27 +++
 13 files changed, 529 insertions(+), 124 deletions(-)
 create mode 100644 drivers/tee/optee/notif.c

-- 
2.31.1

