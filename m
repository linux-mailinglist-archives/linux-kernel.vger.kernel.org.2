Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FDF3A10FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbhFIKZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238732AbhFIKZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:25:44 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130C5C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 03:23:39 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id r14so11813218ljd.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7k+X7CK1t92BiWhgV+56w9YZbTfNSIvP69C+r0N5nUY=;
        b=riiSaDwlPrILoa+dn8LTnJirS6z5UNlmyDKkq2oKKjtMmB31qolaw+BY1nmmHbi5ab
         KqI2buyeebORN25DkSI5Lsl7AprFGdHE9154XH3UrPr+ric6p3Jpx+6ZJvUtZXUhCHJw
         4/WudfP65VmzqICS6U2X6RNPW/rxNTUchORslSSMmxQPapeMETvt02LYig0G38Rd1YDV
         Qhy3hHgI8SnUqneyMVMMw2yqGy0CcRIRK+JcRlAApOoR85eK+HEt3xUL++cj6KOyWFQI
         t8PPaGKYQl2+UAyzGExBjcGqyppVzUFf/n+7tOjcP4ZTBk/uRXgBIataPATeNdisidJ7
         BFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7k+X7CK1t92BiWhgV+56w9YZbTfNSIvP69C+r0N5nUY=;
        b=VC33ftPb0TBoBOD4yUQ1+XT2DuUJAaSAWLnzMYiTlNvVU09Eps6GaBJwUJ8IKvz8t/
         Ev7DUYLO2oGZaesWaO8yyHxR64JkIxuVCGNUmrLfnS1zULGvDjGqAdXeZFXrmk2I8oTt
         FwsGqVqVWzOOCaqjU/mhDYCtSp3m1uVfkf+H51vKWeCSfknphNl6CZGz/e2qk7xK+ZSg
         5ibj3Tl2us8EqOC24u95nC+rcIPUbf40J0CxH35DmF90XmrpwcvNrosTXDZSnghAhCal
         J8xup0a4ZCRgDmZYSfRSyCbgTnZK68sFV6WCZpXi0jrGyFbQ2vn6MO2lXNeje0dQoJdH
         +X/Q==
X-Gm-Message-State: AOAM532mREgEivve9XN8jvYqoAeQvvXK3WCxAPDDAkKcM7epBSqfs/N/
        wt2X+I8ltjH2R1J/dIAGj+3Yw3XibfWuXl5M
X-Google-Smtp-Source: ABdhPJxab+7rKOPjvqtNoCA/sS6DcDEEV6CnuWiKYFXW+QhxpI6x8xsC6wkvE77QD5kBxEvAIi8NHQ==
X-Received: by 2002:a2e:94d7:: with SMTP id r23mr22199127ljh.380.1623234217100;
        Wed, 09 Jun 2021 03:23:37 -0700 (PDT)
Received: from jade.urgonet (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id m4sm302966ljp.9.2021.06.09.03.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:23:36 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 0/7] tee: shared memory updates
Date:   Wed,  9 Jun 2021 12:23:17 +0200
Message-Id: <20210609102324.2222332-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Until now has the in-kernel tee clients, tpm_ftpm_tee, hwrng: optee-rng and
firmware: tee_bnxt used shared memory objects which has been exported by
dma-buf. Dma-buf isn't needed here since it's only an interaction between
the kernel and secure world.

This patchset fixes this by intruducing three new function
tee_shm_alloc_user_buf(), tee_shm_alloc_kernel_buf() and
tee_shm_alloc_anon_kernel_buf() to be used instead of the old
tee_shm_alloc(). This should make the API a bit easier to use both within
the TEE subsystem and for the tee clients in various drivers.

The patch set starts with simplifying the shared memory pool handling, an
internal matter for the two TEE drivers OP-TEE and AMDTEE.

Thanks,
Jens

Jens Wiklander (7):
  tee: remove unused tee_shm_pool_alloc_res_mem()
  tee: simplify shm pool handling
  tee: add tee_shm_alloc_kernel_buf()
  hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
  tpm_ftpm_tee: use tee_shm_alloc_kernel_buf()
  firmware: tee_bnxt: use tee_shm_alloc_kernel_buf()
  tee: replace tee_shm_alloc()

 drivers/char/hw_random/optee-rng.c      |   6 +-
 drivers/char/tpm/tpm_ftpm_tee.c         |   8 +-
 drivers/firmware/broadcom/tee_bnxt_fw.c |   5 +-
 drivers/tee/amdtee/shm_pool.c           |  55 ++-----
 drivers/tee/optee/Kconfig               |   8 -
 drivers/tee/optee/call.c                |  16 +-
 drivers/tee/optee/core.c                |  76 +--------
 drivers/tee/optee/device.c              |   5 +-
 drivers/tee/optee/rpc.c                 |   8 +-
 drivers/tee/optee/shm_pool.c            |  51 +++---
 drivers/tee/optee/shm_pool.h            |   2 +-
 drivers/tee/tee_core.c                  |   2 +-
 drivers/tee/tee_private.h               |  11 --
 drivers/tee/tee_shm.c                   | 209 ++++++++++++++++++------
 drivers/tee/tee_shm_pool.c              | 160 ++++--------------
 include/linux/tee_drv.h                 | 106 +++---------
 16 files changed, 291 insertions(+), 437 deletions(-)

-- 
2.31.1

