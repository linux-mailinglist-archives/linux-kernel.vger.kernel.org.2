Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D9F39294F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhE0IP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbhE0IPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:15:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED38CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 01:14:19 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b26so6697338lfq.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 01:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JDGsr0U4UtFbfy6pCEyWwnWchkdCO7T0vgGbUXWCyRg=;
        b=x3cAUnU79NNxvjxeEWLk4ICt9sTWNhW+w604z+y/8JXOJ9GzZM2Vnl5Mhp0uk+tKAr
         qBeK3zhuEkF5sr0RJvZObHZTgNIaZP1sT0uoVxOFuDepK5F5nGUAob2jFzSDYClTg2RB
         PBplDABMCEeZQzjRZKM/eqnVMYsOMATbC7Xlp570wDEyKb5Qi74FgqjTqQlGqsGDpHRW
         QuSububR795TYW5Y+SwPzV8v/v7FHO+QlkShLK04qWp4VFeQqmMHkaFziB9ZTBBnyRaS
         2I6LM+dUtb0EoJn9jlvBCD8BfARQvdY0HbeVdc9p5jWhrdQXW11xtvdMyynC/G2uIYKR
         eBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JDGsr0U4UtFbfy6pCEyWwnWchkdCO7T0vgGbUXWCyRg=;
        b=R3YCp1xP3ISHaFQKJ5Cnr234oHNASDLgMgsZlz5IDhNq8c631aCsrabHbk76u/Sn9D
         jSnvxaqdZr/1Mh9whHlyDZjB1eLucpKU1dlHz844RX6AtKF61nLP21iK7ZnfWOF7hJjo
         hMDZ7TG5AdcB0bjVOaWLuoIY9YEXvzHD3JTWjtEz1l7TvD1C8CZZfwT8PEeUFCfZ2Rd7
         EHI3iQSrA3rRqXjwf7QRS6HYcEJG+mOylSCNHz87wErU7KC59ZZdiVmxmGeUIYMSA3so
         SaJywtAT4t9BcOYyBjpQIMjmVU1lL8jJsf5yTHnncffn050GCzRMhsdUZNHlgUcANrMg
         3Gag==
X-Gm-Message-State: AOAM5301EKUeiK56D/woH4WWG3uOcbLWDqtSySErDF++kwiN71WMKu0b
        LPFUQ7IMjS8xQlcVevXwvkZfInlt+oCNQw==
X-Google-Smtp-Source: ABdhPJx8w8Q7nbjMppCGZsyDerHBswss6+er8da62g4Np1Gsg8vZOyripxpDkfD1jzmNXpXtnqUDAw==
X-Received: by 2002:a19:4307:: with SMTP id q7mr1570617lfa.262.1622103258102;
        Thu, 27 May 2021 01:14:18 -0700 (PDT)
Received: from jade.urgonet (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id z10sm133186lfe.228.2021.05.27.01.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 01:14:17 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2 0/5] Add FF-A support in OP-TEE driver
Date:   Thu, 27 May 2021 10:13:59 +0200
Message-Id: <20210527081404.1433177-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This adds supports for the OP-TEE driver to communicate with secure world
using FF-A [1] as transport.

These patches are based on the FF-A v7 patch set by Sudeep Holla [2] [3].

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
[2] https://lore.kernel.org/linux-arm-kernel/20210521151033.181846-1-sudeep.holla@arm.com/
[3] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git v5.13/ffa

v1->v2:
- Rebased to the FF-A v7 patch
- Fixed a couple of reports from kernel test robot <lkp@intel.com>

Jens Wiklander (5):
  tee: add sec_world_id to struct tee_shm
  optee: simplify optee_release()
  optee: refactor driver with internal callbacks
  optee: add a FF-A memory pool
  optee: add FF-A support

 drivers/tee/optee/call.c          | 325 +++++++++++---
 drivers/tee/optee/core.c          | 689 ++++++++++++++++++++++++++----
 drivers/tee/optee/optee_ffa.h     | 153 +++++++
 drivers/tee/optee/optee_msg.h     |  27 +-
 drivers/tee/optee/optee_private.h |  88 +++-
 drivers/tee/optee/rpc.c           | 137 +++++-
 drivers/tee/optee/shm_pool.c      |  65 ++-
 drivers/tee/optee/shm_pool.h      |   1 +
 include/linux/tee_drv.h           |   7 +-
 9 files changed, 1326 insertions(+), 166 deletions(-)
 create mode 100644 drivers/tee/optee/optee_ffa.h

-- 
2.25.1

