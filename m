Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E133FC3A3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 10:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbhHaH0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 03:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239538AbhHaH0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 03:26:02 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84359C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 00:25:07 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id i28so30119514ljm.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 00:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Szuseb+8y4B8HnmLbCqM5t+Csn1qufFrXzTDJ0QV5ns=;
        b=yLItzKXS6/yclfvZWYzwnl13GcDAf444bimgcg3SoxsijtV3paACBp7Y+PFdUwK5tn
         wREJ81/dlbK8pNsUHuIDdNhi0eKyD6aYSCW0Npv3r2ZBk1Oick/s9vhtKqWsTjoLAA4w
         0ZyGRotz5HCFnCjZ8lvLJ28pXN37f8LijIk2qtNTFeZPd+qnNCDf+GhbYEwUvcsxpRg5
         2vunoXJxfb5vkuGgBJg88WLbHje0s5CWoz58ctsHHTamX4s1YKrr1cA4N1Rw90L3A7D1
         ZhCth5BMdv/P3SSHGMRREY2HbM8aE1AGnl8b+HcXB1bF3E5T8ej6HRfJVuv4kOG0bzOU
         wcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Szuseb+8y4B8HnmLbCqM5t+Csn1qufFrXzTDJ0QV5ns=;
        b=ZagImorrOR8fZjzAJxIWVKMR9wYjJ+kOqCac/EjLYPosNI36oZz5P/XTI99VI83he3
         fBd2lXINCKf836ObjDgQdyF3bKfQDtFNM6CJVzlHGW3y8mBtwTX/XEZbkc+5r3keyQSm
         C9/9P1YbrqISSXOS8DPtrhgpniglOdKnrX6XRMVKVicj1jDsjktCf46kimjq68Tr7XwI
         d72AKu5RvfnUxTR0HGUgMySdpPS6vF40SYt6T0vuPPXeFEdP7grsXl5UKRzDgP0vqzUE
         1I618ce2TZiNXrpZmzzXh9WFQspIdEIsBFlBLK9ffrYSiUKwKi3WMYSFbvJcxR81mvKM
         YLrg==
X-Gm-Message-State: AOAM530i7W0Dxhx7Pc3O0A7XWpYCTr8VJARuabkpjmonQzCX+sYTl9PR
        9hyhVblsLFN33fcIMvhFJxbOVPeQA4UsEQ==
X-Google-Smtp-Source: ABdhPJyVQ/bNmWX4fQQ/4z2UJlDx7ZfeLXkc/Aqi05MXZy749WLfsQeTw++v3Bm6pebZWR4QNblbhA==
X-Received: by 2002:a2e:a234:: with SMTP id i20mr23873303ljm.38.1630394705709;
        Tue, 31 Aug 2021 00:25:05 -0700 (PDT)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id c10sm1642569lfv.246.2021.08.31.00.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 00:25:05 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        sughosh.ganu@linaro.org, Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v5 0/5] Add FF-A support in OP-TEE driver
Date:   Tue, 31 Aug 2021 09:24:07 +0200
Message-Id: <20210831072412.887565-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This adds supports for the OP-TEE driver to communicate with secure world
using FF-A [1] as transport.

There is one change to the TEE subsystem with "tee: add sec_world_id to
struct tee_shm" to add support for holding globally unique handle assigned
by the FF-A. This is a field that I believe could useful for the AMDTEE
driver too.

For communication the OP-TEE message protocol is still used, but with a new
type of memory reference, struct optee_msg_param_fmem, to carry the
information needed by FF-A. The OP-TEE driver is refactored internally with
to sets of callbacks, one for the old SMC based communication and another
set with FF-A as transport. The functions relating to the SMC based ABI
are moved to smc_abi.c while the FF-A based ABI is added in a ffa_abi.c.

There is also a difference in how the drivers are instantiated. With the
SMC based transport we have a platform driver, module_platform_driver(),
today which we're keeping as is for this configuration. In a FF-A system we
have a FF-A driver, module_ffa_driver(), instead.

The OP-TEE driver can be compiled for both targets at the same time and
it's up to runtime configuration (device tree or ACPI) to decide how it's
initialized. Note that it's only the old SMC based driver instance that
need device tree or ACPI to initialize. The FF-A based driver relies on the
FF-A bus instead.

This can be tested QEMU
The repo for SPMC at S-EL1 retrieved by
repo init -u https://github.com/jenswi-linaro/manifest.git -m
qemu_v8.xml -b ffav4_spmc
repo sync
# Then checkout the branch optee_ffa_v5 from
# git://git.linaro.org/people/jens.wiklander/linux-tee.git
# in the linux directory

To build do:
cd build
make toolchains
make all

To boot:
make run-only

Test with xtest, perhaps only with the command "xtest 1004" in case you're
not interested in too many tests.

Thanks,
Jens

[1] https://developer.arm.com/documentation/den0077/latest

v4->v5:
- Rebased on v5.14, tricky conflicts primarily between "optee: isolate smc
  abi" and mostly 376e4199e327 "tee: Correct inappropriate usage of
  TEE_SHM_DMA_BUF flag" but also with the other kexec fixes that went into
  v5.14-rc5.
- Addressing comments from Sumit and applying
  Reviewed-by: Sumit Garg <sumit.garg@linaro.org> on "optee: isolate smc abi"
- Addressing comments from Sumit and applying
  Acked-by: Sumit Garg <sumit.garg@linaro.org> on "optee: add FF-A support"

v3->v4:
- Made a bit more RPC code common between the SMC and FF-A ABIs as
  requested by Sumit.
- Replaced module_platform_driver() with module_init()/module_exit() as
  described in the commit "optee: isolate smc abi".
- Applied Sumit's R-B for the commits "tee: add sec_world_id to struct
  tee_shm", "optee: simplify optee_release()", and "optee: refactor driver
  with internal callbacks"

v2->v3:
- Rebased on 5.14-rc2 which now have the FF-A patches merged
- Fixed a couple bugs in optee_shm_register() and optee_shm_unregister()
  which where introduced in "optee: refactor driver with internal callbacks"
  in previous the version.
- Separated SMC ABI specifics into smc_abi.c to keep it separated from
  the FF-A ABI functions as requested by Sumit.
- Added the FF-A specifics in ffa_abi.c
- Provided an implementation for optee_ffa_remove()

v1->v2:
- Rebased to the FF-A v7 patch
- Fixed a couple of reports from kernel test robot <lkp@intel.com>



Jens Wiklander (5):
  tee: add sec_world_id to struct tee_shm
  optee: simplify optee_release()
  optee: refactor driver with internal callbacks
  optee: isolate smc abi
  optee: add FF-A support

 drivers/tee/optee/Makefile        |    7 +-
 drivers/tee/optee/call.c          |  445 ++--------
 drivers/tee/optee/core.c          |  719 ++-------------
 drivers/tee/optee/ffa_abi.c       |  907 +++++++++++++++++++
 drivers/tee/optee/optee_ffa.h     |  153 ++++
 drivers/tee/optee/optee_msg.h     |   27 +-
 drivers/tee/optee/optee_private.h |  163 +++-
 drivers/tee/optee/rpc.c           |  237 +----
 drivers/tee/optee/shm_pool.c      |  101 ---
 drivers/tee/optee/shm_pool.h      |   14 -
 drivers/tee/optee/smc_abi.c       | 1360 +++++++++++++++++++++++++++++
 include/linux/tee_drv.h           |    7 +-
 12 files changed, 2732 insertions(+), 1408 deletions(-)
 create mode 100644 drivers/tee/optee/ffa_abi.c
 create mode 100644 drivers/tee/optee/optee_ffa.h
 delete mode 100644 drivers/tee/optee/shm_pool.c
 delete mode 100644 drivers/tee/optee/shm_pool.h
 create mode 100644 drivers/tee/optee/smc_abi.c

-- 
2.31.1

