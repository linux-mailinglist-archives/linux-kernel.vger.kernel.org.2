Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34E63D233A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 14:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhGVLhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 07:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbhGVLhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 07:37:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C827C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 05:18:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i5so8226755lfe.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 05:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UtOWa2lL7DU7+uz9y77s+2dIz9u9H/PKNPEgTCXPwT4=;
        b=FuFu3y+Cme1GCFNZiFBIv37H2HS/O/Cy1DUZmxv7gbVtxUxjDIVAHbyZUdWm4qmiWY
         a0emq6HIL6CrntNYbiOhubaM/T+3zctQRWTKBz276xz6hlclOdYRulERamlH3wGIYFOY
         lrglYhNTBkPmRHtcn2vIVrukXodl83js8pujNoAXpV+xenJKtV63LAIQDn8cf0PCKJx/
         KGEaIHnTo8+fL8MFOeJSQaO1Ril53ef3lKNzfQD0ClgT8DA9AwGcwvlJfBd75ckalTvV
         pDu40cG/hevkIRyfuzIUivgcmFne1zr7DU7rHx2LLQaCKMwT0i0GovgXAI97xBlJXd4C
         Wlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UtOWa2lL7DU7+uz9y77s+2dIz9u9H/PKNPEgTCXPwT4=;
        b=IotPalEeyf9PrGcA4Mkp40jeVnTJTWJ9NQUOIi5qb+zQB+DG1pOjaabFJn10wPqH//
         pR/cpkGGsRMMmwjkLBu2zJ1Vu3hYCsPjwGxwOslvd673SmC/ncyN1ZynA3+9v6W1q2mD
         QtILUhMy6Z/PGnzfi2ktkXT3xOJmpqXEjEgCgnII3Eq2bGQrQOH7U6opxr6S9PJm5NL4
         ZZSYe3FDZXJSNj9hPFT52ErPAKVzVV+R0FbXdedsQnE2DQ3YHVpBBAfXYXQcYYcfQgHJ
         fvtLWH0ErIn25vHqVF1LjIQcnIC6E6muH6NAi3zDCw5nqqFn9Y54ikEY4DtNKeUNrnOQ
         s0Xg==
X-Gm-Message-State: AOAM533mz5uCy8JAVJf1Dq52+w8/nMx5zEdhfV/4wShODMwIxjoGsDhu
        OvMsKt8Hh7/aSXQgoJuYIOgahJ6Uvh/PUw==
X-Google-Smtp-Source: ABdhPJzAuK8mnM/roxQJVP/OoPkjfnPfIN0iaMP4V5osxSOh0fVjK8sVGS6gosrD0e44IU/RBlyigQ==
X-Received: by 2002:a19:a403:: with SMTP id q3mr29802876lfc.287.1626956286415;
        Thu, 22 Jul 2021 05:18:06 -0700 (PDT)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id b41sm845090ljr.67.2021.07.22.05.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:18:06 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        sughosh.ganu@linaro.org, Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 0/5] Add FF-A support in OP-TEE driver
Date:   Thu, 22 Jul 2021 14:17:52 +0200
Message-Id: <20210722121757.1944658-1-jens.wiklander@linaro.org>
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
# Then checkout the branch optee_ffa_v3 from
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
 drivers/tee/optee/call.c          |  415 ++-------
 drivers/tee/optee/core.c          |  673 ++-------------
 drivers/tee/optee/ffa_abi.c       |  910 ++++++++++++++++++++
 drivers/tee/optee/optee_ffa.h     |  153 ++++
 drivers/tee/optee/optee_msg.h     |   27 +-
 drivers/tee/optee/optee_private.h |  155 +++-
 drivers/tee/optee/rpc.c           |  270 +-----
 drivers/tee/optee/shm_pool.c      |   89 --
 drivers/tee/optee/shm_pool.h      |   14 -
 drivers/tee/optee/smc_abi.c       | 1301 +++++++++++++++++++++++++++++
 include/linux/tee_drv.h           |    7 +-
 12 files changed, 2650 insertions(+), 1371 deletions(-)
 create mode 100644 drivers/tee/optee/ffa_abi.c
 create mode 100644 drivers/tee/optee/optee_ffa.h
 delete mode 100644 drivers/tee/optee/shm_pool.c
 delete mode 100644 drivers/tee/optee/shm_pool.h
 create mode 100644 drivers/tee/optee/smc_abi.c

-- 
2.31.1

