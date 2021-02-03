Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926E630D981
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhBCMIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbhBCMI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:08:27 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAF7C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:07:46 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id a25so27989613ljn.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=k8SC04zhe46BAeBAdwY60XqdkZ6XgYx/7aKDZO/PFl4=;
        b=BoPzZRF8SSfs4Z15ztBzd67Z5x2sMZh/mMzxYrbAuuNWUs+PvrkTRdIsKdv0OlRjS1
         qeH6/xocFPc1rFA8y/CNRWEMgyYVevIdljOfeYq1z2WWlMW261yqalpDfSrpdaCXNFZ7
         v2QOQVlvPextTTRC/8HGF9jeokPn/VchzkagwkSV7xRdtKk6Ggpu6htu2o3q9UAb/iHP
         GPE1BfmWJMcLzdTyugZXYJLHpAShPAH0kkqU+TNeZRGMK0UNN37oycr4PERkS1o+cC4S
         xhWcNqhYMSlHRkYt4/mm0AsWP4z6Muh754tNKNecyNeQrqd1r2WzFS5D9CyHXz5CIDkH
         Sdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=k8SC04zhe46BAeBAdwY60XqdkZ6XgYx/7aKDZO/PFl4=;
        b=j9TLp9bBmJHalRLZM6s9IIsTeLJqGtJMtvAaqIYJ6dDzPCq3PiErkR0tdYAUnUekf/
         YkjYY5gtYRVYgp3BDtO1yyVZy2F4aYoQ2lDhvFz8vyL0Fa9GpjI2ofZ8W8/sI1yOSNas
         O4w24F3ZHF/id8f8Z3R+uLI0/qegt6pkKb7UTujtVd4I61gkKrJ7S7zGey9Eke+WLtbk
         e+L0Wf96Ml+jaLbBHLMTkdlcj6U3EH0FOqs8eHfxB7b/sXSsk9hxa3kRy3ZZh+4tOMec
         G1TPOsmX5WzsmvM1jp0prDqCeUlWEXrnac9jpz4tt2HsAS+BICcVycyJUmECKvoLB/d4
         6Z/A==
X-Gm-Message-State: AOAM530u9F+XIQwhG56LXzNoU7G7WAYd99uoet5anLLz/xj2BGvrP8Eh
        vuADfWw9p13k1ea2zM/jNSzxCw==
X-Google-Smtp-Source: ABdhPJwIlOOYtdIyE88BPsfaFbyDb4ITgksGHQng78HRe9TYrxbQ8xRnRodUUqlHuLT2fzTkh2C8uA==
X-Received: by 2002:a2e:8350:: with SMTP id l16mr1601390ljh.403.1612354065230;
        Wed, 03 Feb 2021 04:07:45 -0800 (PST)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id u12sm223794lff.250.2021.02.03.04.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:07:44 -0800 (PST)
Date:   Wed, 3 Feb 2021 13:07:42 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Elvira Khabirova <e.khabirova@omprussia.ru>
Subject: [GIT PULL] TEE housekeeping for v5.12
Message-ID: <20210203120742.GA3624453@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull these patches fixing some comment typos and also a larger
patch syncing some internal OP-TEE driver headers with OP-TEE OS.

Thanks,
Jens

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-housekeeping-for-v5.12

for you to fetch changes up to 617d8e8b347edcee6da38df0aeb671fc9c9ba19c:

  optee: sync OP-TEE headers (2021-02-02 14:50:41 +0100)

----------------------------------------------------------------
TEE subsystem housekeeping

- Fixes some comment typos in header files
- Updates to use flexible-array member instead of zero-length array
- Syncs internal OP-TEE headers with the ones from OP-TEE OS

----------------------------------------------------------------
Bjorn Helgaas (1):
      tee: optee: fix 'physical' typos

Elvira Khabirova (1):
      tee: fix some comment typos in header files

Jens Wiklander (1):
      optee: sync OP-TEE headers

Tian Tao (1):
      drivers: optee: use flexible-array member instead of zero-length array

 drivers/tee/optee/optee_msg.h     | 158 +++-----------------------------------
 drivers/tee/optee/optee_rpc_cmd.h | 103 +++++++++++++++++++++++++
 drivers/tee/optee/optee_smc.h     |  72 +++++++++++------
 drivers/tee/optee/rpc.c           |  39 +++++-----
 include/linux/tee_drv.h           |   2 +-
 include/uapi/linux/tee.h          |   2 +-
 6 files changed, 183 insertions(+), 193 deletions(-)
 create mode 100644 drivers/tee/optee/optee_rpc_cmd.h
