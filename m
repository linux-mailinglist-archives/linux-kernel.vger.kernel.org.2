Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507453495DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhCYPpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhCYPoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:44:37 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D741C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 08:44:37 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 75so3217481lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 08:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pjIa+s4yH2swmatTmtfzhFPs7yHgkDmsPtwVkJT5w6E=;
        b=H9/dj7qBCh29estNC3da7gGEoHzLC7mTj8GhYRQbAL2cz9EQ+ql5VxGZ+ledBA5Hjo
         I0OaqscxiJetkfdI1htNRbqAzEMvcQZ1/bIoY5lF5WDec2U2/6zsSKCL3AiYXAyhyJv+
         6CMCU0Z9+OdbqS5lSAfXvqP4t81iuDEe4tKvRem/ozuTIb7ZjFKSOoN6H6OC5VrHOKBY
         IkZX2i9edyvAHIHx64Gad3UPc1x5MZC9g0Gs37+Nmov0QaY2Wej1O3ncdS1uenCSgQgr
         WH3NM1IBDNHu6yHmGV7PHqsSoATpv+1vU75prP5x6XhlB7VCb38utOtBadUlnXQ+KLxm
         mi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pjIa+s4yH2swmatTmtfzhFPs7yHgkDmsPtwVkJT5w6E=;
        b=a+r0Hm6tXoU/ciogC7H4LViiojzuj64bH/8xyN+6otO5u/kMjSrGxwXKSHLMeDiCN/
         fdbu22ZCxh1qxRE8PTnQzMJg60cT1EcgspxxGkJOq8ZMnap/BVxYqDG2ZyclBAsvIoAl
         1TZg/r5HiZv3lCn0U1uMYUqtPDpyCv3s1wpr0q53ogxkHJI9R4uIcFllabtFpF01qR06
         P3nOCa11RZbJ82T9VK/WKi581D/HsvkeqQvAWddGR90+pSNAa/CRcPPyEAgTfCZavt1/
         9B30qukzp/rnalEg0t+4KPjfQ8ZwbWk+74jXpuWC8HLOlUmHJYQXBi0yJc/1cyro8MD0
         J5mQ==
X-Gm-Message-State: AOAM5337HSKztWRiOMLJnMgsoFX5L0eGOoJAd6U6bfeRaoahPxrdGcKe
        Wp6JWY++gbrKu5FdZIempFz0yNvRF4X3bypm
X-Google-Smtp-Source: ABdhPJwZ2GyiIIv40BYxMxL4qiTToJU3nCnDovQLghlO8k5n3u2EB3ALjKdG72K2ZOrGMshBPlHT0A==
X-Received: by 2002:ac2:4857:: with SMTP id 23mr5480784lfy.136.1616687075229;
        Thu, 25 Mar 2021 08:44:35 -0700 (PDT)
Received: from jade.urgonet (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id m27sm770916ljc.109.2021.03.25.08.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:44:34 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 0/6] Add FF-A support in OP-TEE driver
Date:   Thu, 25 Mar 2021 16:44:20 +0100
Message-Id: <20210325154426.3520148-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This adds supports for the OP-TEE driver to communicate with secure world
using FF-A [1] as transport.

These patches are based on the FF-A v4 patch set by Sudeep Holla [2] [3].

There is one change to the TEE subsystem with "tee: add sec_world_id to
struct tee_shm" to add support for holding globally unique handle assigned
by the FF-A. This is a field that I believe could useful for the AMDTEE
driver too.

For communication the OP-TEE message protocol is still used, but with a new
type of memory reference, struct optee_msg_param_fmem, to carry the
information needed by FF-A. The OP-TEE driver is refactored internally with
to sets of callbacks, one for the old SMC based communication and another
set with FF-A as transport.

There is also a difference in how the drivers are instantiated. With the
SMC based transport we have a platform driver, module_platform_driver(),
today which we're keeping as is for this configuration. In a FF-A system we
have a FF-A driver, module_ffa_driver(), instead.

The OP-TEE driver can be compiled for both targets at the same time and
it's up to runtime configuration (device tree or ACPI) to decide how it's
initialized.

Thanks,
Jens

[1] https://developer.arm.com/documentation/den0077/latest
[2] https://lore.kernel.org/linux-arm-kernel/20210212154614.38604-1-sudeep.holla@arm.com/
[3] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git v5.11/ffa

Jens Wiklander (6):
  tee: add sec_world_id to struct tee_shm
  optee: simplify optee_release()
  optee: sync optee_msg.h and optee_rpc_cmd.h
  optee: refactor driver with internal callbacks
  optee: add a FF-A memory pool
  optee: add FF-A support

 drivers/tee/optee/call.c          | 327 +++++++++++---
 drivers/tee/optee/core.c          | 698 +++++++++++++++++++++++++-----
 drivers/tee/optee/optee_ffa.h     | 153 +++++++
 drivers/tee/optee/optee_msg.h     | 168 ++-----
 drivers/tee/optee/optee_private.h |  88 +++-
 drivers/tee/optee/optee_rpc_cmd.h | 333 ++++++++++++++
 drivers/tee/optee/rpc.c           | 169 +++++++-
 drivers/tee/optee/shm_pool.c      |  65 ++-
 drivers/tee/optee/shm_pool.h      |   1 +
 include/linux/tee_drv.h           |   7 +-
 10 files changed, 1685 insertions(+), 324 deletions(-)
 create mode 100644 drivers/tee/optee/optee_ffa.h
 create mode 100644 drivers/tee/optee/optee_rpc_cmd.h


base-commit: 31ef391700953fb59ea8755ea38c6085bdec380e
-- 
2.25.1

