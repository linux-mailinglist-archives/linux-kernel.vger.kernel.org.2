Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEC53FF566
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 23:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345929AbhIBVNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 17:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhIBVND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 17:13:03 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915EAC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 14:12:04 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g14so2654079pfm.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 14:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Txn1oZJ1MZmkpCJOG+Tm0yfaGtr1VC7mq6fqUTut+Ko=;
        b=GzTMiuL+QmxK8UlAEtb5m0CQN4bpLtZ+YfESXJlbQLFjU2t4LBatxhmSW/Y7VD3ylz
         SWAygdhOpOAFGtZsrbnwqN6GH6SYeNqlsURavQ5x65++g35n1JCeieHNKrt43GKvCvlJ
         fRhNt6kQR4V2pNYDSxSsY8VrW1i3J4xvLtGwpDmSWTJVFfoJ6mdxgMprX367btnKM0Ga
         AEfSBmGSV+w7mQ0NiPJRGGBcMChjGT+ylgMYaFBguoFN+DYj4ZRTVlMosyjOOLN20rMW
         Omn9kI3btvQjQaiXOZDpltOjkMoSyX0xfXJujbQp1uLKw0+5oHWfvpIIKFQ8g4QqYcgs
         WLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Txn1oZJ1MZmkpCJOG+Tm0yfaGtr1VC7mq6fqUTut+Ko=;
        b=lOVLo+4fHgZJxADe6WzsCFkyGU4nMVNAPCjovnCd9X9zrDIk1TfERUbZldpmOk2AX2
         Zb2uwNfUPYMU2Cjs+Ubp1lXq4vUXgp99t9T2p2kCvn3+absmHDcOLd/zs9vJhajCPTke
         WgggTXLyjqlHmeiLb5TKCzfVcVFch4vjLesZyeDqDrLJmfG0pER0/CrTFuBcekU+yeSx
         w8F+KNm8k0TW5fxYZaaUxRjaOoadTPy+YIJOTaeyrpyBS7YtF95l8TOvVefFxOS0JAnY
         ppuouug0wOJjhnukO3AVxnz87qJqRdtsvghPcNPSKEfTP1/ZCGTvr6GnQUWAnAUZGQ/X
         X82Q==
X-Gm-Message-State: AOAM531kp4Ny72axmQKw46at2fSa8UPYyCJSPRdhnfUbuOIgHRWLxU3R
        VGoO5u7lg9LZIRIovgCkXOBNAF6b7AY=
X-Google-Smtp-Source: ABdhPJxK59ChOqIb0khEwblgYuzFbJIGr60dbANf2fvPMx8FE5HinOdOVMXWTzJ+JfAqaIiZ0AIWfw==
X-Received: by 2002:a63:4e45:: with SMTP id o5mr315096pgl.191.1630617124011;
        Thu, 02 Sep 2021 14:12:04 -0700 (PDT)
Received: from localhost (g163.222-224-165.ppp.wakwak.ne.jp. [222.224.165.163])
        by smtp.gmail.com with ESMTPSA id z17sm3111442pfa.125.2021.09.02.14.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 14:12:03 -0700 (PDT)
Date:   Fri, 3 Sep 2021 06:12:01 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for 5.15
Message-ID: <YTE+IdUiJ+k+bpDR@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider for pull:

The following changes since commit c500bee1c5b2f1d59b1081ac879d73268ab0ff17:

  Linux 5.14-rc4 (2021-08-01 17:04:17 -0700)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 1955d843efc3b5cf3ab4878986a87ad4972ff4e1:

  openrisc/litex: Update defconfig (2021-08-31 22:41:46 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.15

A few cleanups and compiler warning fixes for OpenRISC.  Also, this
includes dts and defconfig updates to enable Ethernet on OpenRISC/Litex
FPGA SoC's now that the LiteEth driver has gone upstream.

----------------------------------------------------------------
Joel Stanley (3):
      openrisc/litex: Update uart address
      openrisc/litex: Add ethernet device
      openrisc/litex: Update defconfig

Randy Dunlap (2):
      openrisc: don't printk() unconditionally
      openrisc: rename or32 code & comments to or1k

Stafford Horne (1):
      openrisc: Fix compiler warnings in setup

 arch/openrisc/boot/dts/or1klitex.dts      | 13 +++++++++++--
 arch/openrisc/configs/or1klitex_defconfig | 26 ++++++++++++++++----------
 arch/openrisc/include/asm/pgtable.h       |  6 +++---
 arch/openrisc/include/asm/setup.h         | 15 +++++++++++++++
 arch/openrisc/include/asm/thread_info.h   |  2 +-
 arch/openrisc/kernel/entry.S              |  6 ++++--
 arch/openrisc/kernel/head.S               |  6 +++---
 arch/openrisc/kernel/setup.c              | 20 +++-----------------
 arch/openrisc/lib/Makefile                |  2 +-
 arch/openrisc/mm/fault.c                  |  2 +-
 10 files changed, 58 insertions(+), 40 deletions(-)
 create mode 100644 arch/openrisc/include/asm/setup.h
