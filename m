Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F008142BFFC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbhJMMbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhJMMbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:31:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E268C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:28:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z11so10879333lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=YQxIXPosPmgxsSw+KN3L87guIjR+Zb/COJnPCTaxmBs=;
        b=Rifnnp3/msmOFFAH4gZiR/fVd2rDLGv96hGaf9c2Ia/LzmL8p8R2juMSa2fLTURRjq
         1B1/byT90AAiATYiDuE5eQ2O0+ZOX1wsRXw6vulbNWoo/jlaLnsswdT23NGtKwsWFqv/
         2KcybND8Du2UfsllhRI5e5GEc3Pb7a45xVZoCJ154HJocNmYVuyKNeGywwg23GqqV2z9
         U5UWgr0dDYh9/3mhJbaZ8OXkj62HMWpLq1/mxK0CB8tGDnpO5j6P4yjZ/AjKb5ktIgOV
         G5YZdnPY7HMqaIc0M7Xv3A5TtmR+wJueI315eQOJzBRfEn2BLyKsQ961AAbOxX5rdM7g
         X0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YQxIXPosPmgxsSw+KN3L87guIjR+Zb/COJnPCTaxmBs=;
        b=oF6sAzP6drQHXA5kWn8v9FjfWlOX0I4+sxZHSgfjyqCF7uhLJJGwtF6557aUU+s1/J
         6GcbOKiEbC8rfrQ5L1uX+uePDeUuWh2ClGjPz6/f+hKMzr6P3LqiMsAAxeld3kRbdOWu
         RnuAbF/UVFOR6PM+SBFpt/af/ITnNJozSJgMiv/B2fc/YhFyzbVtGivx+FdaqEd2xWwH
         lcARbZRp6/QRqpQTohJUycPTWJw2WT7p207JwzKyOn9bNwV98oy1C65naayskPkG9FFn
         OkQNGbItHG/2XI4X9uM7rFJndYjzDrsDzlDpCkYQ9RkPkxkjnnH5M+8sa4WcbG7t7LmV
         60kA==
X-Gm-Message-State: AOAM530GPHOtd063qnuNYtf6ffJv/8YWsJhxop5CHPvI7A72vUSWkziJ
        sg2PB7S9yMHD/DS3OirwRroUxQ==
X-Google-Smtp-Source: ABdhPJy3d9acfipfn6BL8sZ9BbGREmBgKOtPq+gewmCh9iMMxd2GpJWrn4fMfwdkZAQ+9h/hkeVUOQ==
X-Received: by 2002:a19:7516:: with SMTP id y22mr11435277lfe.197.1634128136481;
        Wed, 13 Oct 2021 05:28:56 -0700 (PDT)
Received: from jade (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id e14sm1317545lfs.287.2021.10.13.05.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:28:56 -0700 (PDT)
Date:   Wed, 13 Oct 2021 14:28:54 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [GIT PULL] another OP-TEE fix for v5.15
Message-ID: <20211013122854.GA1542549@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this OP-TEE driver fix to unregister OP-TEE client devices
from the TEE bus when the OP-TEE driver is unloaded.

Note that this is based on the previous already merged OP-TEE driver
fix.

Thanks,
Jens

The following changes since commit 88a3856c0a8c03188db7913f4d49379432fe1f93:

  tee/optee/shm_pool: fix application of sizeof to pointer (2021-09-14 07:54:56 +0200)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix2-for-v5.15

for you to fetch changes up to 7f565d0ead264329749c0da488de9c8dfa2f18ce:

  tee: optee: Fix missing devices unregister during optee_remove (2021-10-12 13:24:39 +0200)

----------------------------------------------------------------
Fix missing devices unregister during optee_remove

Unregisters OP-TEE client devices (UUIDs of some known Trusted
Applications) from the TEE bus when the OP-TEE driver is unloaded.

----------------------------------------------------------------
Sumit Garg (1):
      tee: optee: Fix missing devices unregister during optee_remove

 drivers/tee/optee/core.c          |  3 +++
 drivers/tee/optee/device.c        | 22 ++++++++++++++++++++++
 drivers/tee/optee/optee_private.h |  1 +
 3 files changed, 26 insertions(+)
