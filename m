Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876783D550A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 10:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhGZHaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbhGZHaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:30:14 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF46EC061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:10:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m13so13892232lfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=uhBYFS3kcrFSzUp+99m4qpuPqHmdy7DA1vxoHG2YpBo=;
        b=NMqlYTqW/lndtqqHyPiFLM6rKPoHHYZHYwW7+jnlb6T8g26zSGu5wBdOgmvlgttoD9
         ubbH32dNkwfzgC+9alfK8agoc5+COrbTU16cAPLPc333Mldr2cuGOuezk7zKUQO3kGum
         TJbTAPv4dtvb2SGwq2VENVB9H7UNNgi3tTd1qvmbPAWgURCGGrNAeAs728bElIhjRDps
         CRqGXwAF5zVT3SWVH68uW9QD5hMaS/Q8opTCkca7GuJIU1QrNYZyrX9L7Akzi8CJva+C
         6zl9IGO84AdkjSfN70jgi5fo1Ra+6yy+jIvL2cb2kwAL1LSaLnzmt1iXfDN1tb/vKTi+
         7+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uhBYFS3kcrFSzUp+99m4qpuPqHmdy7DA1vxoHG2YpBo=;
        b=M3HndImgLPItvRyKGVr779eHgpSSNBxy8uBtclh1iQdjE1xhR5ZaH1ekduk49GhKvs
         K+KhrzuBfAWja15TrAwJSHFiQNEtUBfxZjDJ8xkmFjDoqi5KHhUDK6owcpiy2ahqW97x
         QC6sda3zQ6IHaoKZDfYFHUN25G4yfrotJOs8xbFvwHmeKlKkwn/pkTRSUu1U/F2CkTpt
         kcsqfsCiFjK8U/I/+eIzYgIgQNzBm9Y+U4GdK+odd7h2GrqlO8X4EmksLPH6GXVNNf10
         +fDZot1Y2gsvH2ML+DLZfwevzLCmI0DBJLCE34xX6ClI6p/KciRvDbg8r5FJWjIkfx49
         KtuA==
X-Gm-Message-State: AOAM531YUh3KkaVfh0pLWyhj/QNGqJ1107CChZl6z18cip/ZOb/1s/ar
        EJt3jRnGHcXVxoTTW7EvNII17w==
X-Google-Smtp-Source: ABdhPJzr0Z5y4Twf5n/G2SkMcR8Be0DIW4CEwE7lwxefCBKqF7n4oehjLY7Ar8Nd/ya3HmLfUYdS9w==
X-Received: by 2002:ac2:4e09:: with SMTP id e9mr12539781lfr.431.1627287041314;
        Mon, 26 Jul 2021 01:10:41 -0700 (PDT)
Received: from jade (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id t7sm2973379lfc.103.2021.07.26.01.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:10:41 -0700 (PDT)
Date:   Mon, 26 Jul 2021 10:10:39 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: [GIT PULL] TEE kexec fixes for v5.14
Message-ID: <20210726081039.GA2482361@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull these fixes relating to OP-TEE, ftpm (firmware TPM), and
tee_bnxt_fw (Broadcom BNXT firmware manager) drivers in kexec and kdump
(emergency kexec) based workflows.

The two patches "firmware: tee_bnxt: Release TEE shm, session, and context
during kexec" and "tpm_ftpm_tee: Free and unregister TEE shared memory
during kexec" are acked by their respective maintainers.

For more details please see the description of the last patch set
https://lore.kernel.org/lkml/20210614223317.999867-1-tyhicks@linux.microsoft.com/

Thanks,
Jens

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-kexec-fixes-for-v5.14

for you to fetch changes up to 914ab19e471d8fb535ed50dff108b0a615f3c2d8:

  firmware: tee_bnxt: Release TEE shm, session, and context during kexec (2021-07-21 07:55:50 +0200)

----------------------------------------------------------------
tee: Improve support for kexec and kdump

This fixes several bugs uncovered while exercising the OP-TEE, ftpm
(firmware TPM), and tee_bnxt_fw (Broadcom BNXT firmware manager) drivers
with kexec and kdump (emergency kexec) based workflows.

----------------------------------------------------------------
Allen Pais (2):
      optee: fix tee out of memory failure seen during kexec reboot
      firmware: tee_bnxt: Release TEE shm, session, and context during kexec

Jens Wiklander (1):
      tee: add tee_shm_alloc_kernel_buf()

Sumit Garg (1):
      tee: Correct inappropriate usage of TEE_SHM_DMA_BUF flag

Tyler Hicks (4):
      optee: Fix memory leak when failing to register shm pages
      optee: Refuse to load the driver under the kdump kernel
      optee: Clear stale cache entries during initialization
      tpm_ftpm_tee: Free and unregister TEE shared memory during kexec

 drivers/char/tpm/tpm_ftpm_tee.c         |  8 +++---
 drivers/firmware/broadcom/tee_bnxt_fw.c | 14 ++++++++---
 drivers/tee/optee/call.c                | 38 ++++++++++++++++++++++++++---
 drivers/tee/optee/core.c                | 43 ++++++++++++++++++++++++++++++++-
 drivers/tee/optee/optee_private.h       |  1 +
 drivers/tee/optee/rpc.c                 |  5 ++--
 drivers/tee/optee/shm_pool.c            | 20 ++++++++++++---
 drivers/tee/tee_shm.c                   | 20 ++++++++++++++-
 include/linux/tee_drv.h                 |  2 ++
 9 files changed, 132 insertions(+), 19 deletions(-)
