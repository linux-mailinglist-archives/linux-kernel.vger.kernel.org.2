Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7387A423889
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbhJFHLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 03:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhJFHLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:11:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F93C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 00:09:10 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b20so6339319lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 00:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tHWsVDacCHE7fgjlzD98Sz7Ok2UoY5exOGKzNdgYxpU=;
        b=evAMNNcoyAbp+p83vXfxIaj3+zBeYiQZGr6POh08smOh6c7zEaKbIwICaQ2+yX2A9j
         EkBSYPmiFAfQ+qc5sGcFx7XNrVTF6S9WCXVu/hJlwOTNRTIjlbt8KyCvWEnYzLKKWmrK
         aD9Dj181mFu/AtU8dPClNzGJlz3cPo7/Fn/v5Qz4xP2f0tiDJSo+k8yRzcX6uGX21Nt4
         GONKcmE3QkBreXjkqXDZgZ4JbtsD1cDlNiwk8Iec0tpgG2dXg7UFwkj1ddhNAx1fGHI4
         cYJpdfVd7/WBg9dAHWPlkbX0TeX1OJoerVkQCVFu64lpDhFIAVMVXPa/iwPXtwW2Hjlo
         dLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tHWsVDacCHE7fgjlzD98Sz7Ok2UoY5exOGKzNdgYxpU=;
        b=ur0t4t+tI7hbz4yVdk5oegEIxcdLso4eDdvM0TaqnJvAtJUzwEQfH/g0mkJNzhMDYB
         FGvUaY9bhOXH6JSp+olv5tcGcbIWB+BBdoeVBi2s1+MwulIWRAbeWqywC8cWikwuYS/j
         gKG/K612/jPkDDuHXLgFQ1FEEoP5Dp3Wihw6xojxsDXVbDs7p5s631qp+ioscUHTBZFa
         mnaMWVUcbAdYdIjdJseDdWv+dvyw7k3NgNuZs+UWPSuMTC7WqwRsr2lGNpeDRxOLD6Dy
         5A7nhIhUP42iXxf1sjHAqg0sKT2pIkP4Q+YfnrcmB2FLGJ8oI9rKufgPktCfwyBQUOaG
         qvLA==
X-Gm-Message-State: AOAM533Wx7+SIMCVve5dPBMSXOWNx9RMhhdKWgNMXC3bt/WecstK/1ri
        7FPUAn5NUkmaN5/477+PbPVHMjQ+Yt7w0w==
X-Google-Smtp-Source: ABdhPJwo3ibQLHf9/NhlGvXKmzR6QJS3wD20Z6aDuxjXQIqe6vXO3yPeHZz9wNUW2d/7XTHmsz5KDg==
X-Received: by 2002:a05:6512:2e8:: with SMTP id m8mr7792796lfq.172.1633504148289;
        Wed, 06 Oct 2021 00:09:08 -0700 (PDT)
Received: from jade.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id u15sm2381032lfl.20.2021.10.06.00.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 00:09:08 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        sughosh.ganu@linaro.org, Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v6 0/5] Add FF-A support in OP-TEE driver
Date:   Wed,  6 Oct 2021 09:08:57 +0200
Message-Id: <20211006070902.2531311-1-jens.wiklander@linaro.org>
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

These patches are also available at
https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=optee_ffa_v6
Note that there's three patches there not included in this patchset
"tee/optee/shm_pool: fix application of sizeof to pointer",
"firmware: arm_ffa: Fix __ffa_devices_unregister" and
"firmware: arm_ffa: Add missing remove callback to ffa_bus_type"
already have or are about to be sent to arm-soc with separate pull requests.

This can be tested QEMU
The repo for SPMC at S-EL1 retrieved by
repo init -u https://github.com/jenswi-linaro/manifest.git -m
qemu_v8.xml -b ffav4_spmc
repo sync
# Then checkout the branch optee_ffa_v6 from
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

v5->v6:
- Rebased on v5.15-rc2
- Addressing comments from Sudeep Holla to work with ARM_FFA_TRANSPORT=m
- Fixing a couple of warnings in "optee: isolate smc abi" reported by
  kernel test robot <lkp@intel.com>
- Adding the fix from "tee/optee/shm_pool: fix application of sizeof to
  pointer" into "optee: isolate smc abi" since the function code has been
  moved to another file.

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

 drivers/tee/optee/Makefile        |    5 +-
 drivers/tee/optee/call.c          |  445 ++--------
 drivers/tee/optee/core.c          |  719 ++-------------
 drivers/tee/optee/ffa_abi.c       |  911 +++++++++++++++++++
 drivers/tee/optee/optee_ffa.h     |  153 ++++
 drivers/tee/optee/optee_msg.h     |   27 +-
 drivers/tee/optee/optee_private.h |  155 +++-
 drivers/tee/optee/rpc.c           |  237 +----
 drivers/tee/optee/shm_pool.c      |  101 ---
 drivers/tee/optee/shm_pool.h      |   14 -
 drivers/tee/optee/smc_abi.c       | 1360 +++++++++++++++++++++++++++++
 include/linux/tee_drv.h           |    7 +-
 12 files changed, 2726 insertions(+), 1408 deletions(-)
 create mode 100644 drivers/tee/optee/ffa_abi.c
 create mode 100644 drivers/tee/optee/optee_ffa.h
 delete mode 100644 drivers/tee/optee/shm_pool.c
 delete mode 100644 drivers/tee/optee/shm_pool.h
 create mode 100644 drivers/tee/optee/smc_abi.c

-- 
2.31.1

