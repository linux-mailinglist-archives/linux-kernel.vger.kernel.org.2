Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69145432D10
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhJSFTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJSFTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:19:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18432C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q10-20020a17090a1b0a00b001a076a59640so1274439pjq.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gvwg7z4QSsgUp2TfUeW02DiDthK9vwFV8gUPgP3TG04=;
        b=mOSxTFkDrPGzbikUxswni1gp8jNZU7ZvrIQm7QAM2mSwJqGYwGC5eLPeVYVCNcUop+
         5dAo9IkXghmBC3x641HugxFL8Gw0OnMoX4uDm6LdnTrGGt2EqtLr/iZs6cgXQOdz+qPf
         HG+DtmQCD+pFBit7BKP6kFTqTsPkBwR8a5lKzrs6zU/Ya2QYBD04yEibY3cxFpKd2xQO
         UuosZN9N0GivwyY2fCdxNsN1E6hfYCKSJ4EJ0dsEXuJtToLeTbcQFtfKnG8BPf8IH1JZ
         nK/xjZxYOulo+m5sschtC1hLTVUXJSDcjgH9e5Tbj8xRDwfVogUhU3vCkrvhRRiHC/l7
         nYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gvwg7z4QSsgUp2TfUeW02DiDthK9vwFV8gUPgP3TG04=;
        b=57Rt6seIRA4K9XZ3FRCq24l0uIYyqRrY7+yGuMsOAaX2pNotE/FpC0q1t8IZpsmhv4
         XUjKlGLPzLTvqJ6F2LLdwRg2i7sEIC8A3OfqMqIfOrwONVKdJR5PRYoVM+6HWHXZo41l
         ZCPpmil/FQqV1fS8RL9MuJSsV1VN0iAjTrZnRbnSeo2GShIdNuIbz2QUIgxfPdA8zQ1k
         KUVkLJiPGrRP0onYwgzHckAZQAIGiq5qqsq20Tkfn+Yng6atkE23xuVmtepoiwIW8kjT
         uwTynDM3vZxeF63k2Hxx/A7JIqE1bvyBh9Ov7tI7ajj9ovV3ChD6z8PGBWMlIIL3WYC+
         rqjw==
X-Gm-Message-State: AOAM5328gf9gh50xVTqpyhJSIva3k59hcvBWGSuVG9ATH8KyEvNjy/od
        np2eLb4u+09fuPr9TOF1qJI=
X-Google-Smtp-Source: ABdhPJyG6DshyxtNuN17k9JnR/7C0xOeJQLCDuDrZqiI1dRwIaOe2Ua29VLWJyD9gx4anIdwusWyCQ==
X-Received: by 2002:a17:90b:2246:: with SMTP id hk6mr4189834pjb.116.1634620654610;
        Mon, 18 Oct 2021 22:17:34 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:4171:83c2:8384:24c5])
        by smtp.gmail.com with ESMTPSA id me12sm1168844pjb.27.2021.10.18.22.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 22:17:33 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 00/10] xtensa: support call0 ABI kernel
Date:   Mon, 18 Oct 2021 22:17:06 -0700
Message-Id: <20211019051716.4173-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series adds support for building kernel with call0 ABI. This
extends linux support to xtensa cores without windowed registers option.
call0 ABI kernel still supports windowed ABI userspace on cores with
windowed registers. In this case kernel entry from the userspace saves
active register windows as usual.

Max Filippov (10):
  xtensa: move _SimulateUserKernelVectorException out of WindowVectors
  xtensa: use a14 instead of a15 in inline assembly
  xtensa: don't use a12 in strncpy_user
  xtensa: don't use a12 in __xtensa_copy_user in call0 ABI
  xtensa: definitions for call0 ABI
  xtensa: implement call0 ABI support in assembly
  xtensa: use register window specific opcodes only when present
  xtensa: only build windowed register support code when needed
  xtensa: remove unused variable wmask
  xtensa: move section symbols to asm/sections.h

 arch/xtensa/boot/boot-elf/bootstrap.S     |   2 +
 arch/xtensa/boot/boot-redboot/bootstrap.S |  72 ++++----
 arch/xtensa/include/asm/asmmacro.h        |  65 +++++++
 arch/xtensa/include/asm/atomic.h          |  26 +--
 arch/xtensa/include/asm/cmpxchg.h         |  16 +-
 arch/xtensa/include/asm/core.h            |  11 ++
 arch/xtensa/include/asm/processor.h       |  32 +++-
 arch/xtensa/include/asm/sections.h        |  41 ++++
 arch/xtensa/include/asm/traps.h           |   2 +
 arch/xtensa/kernel/align.S                |   2 +
 arch/xtensa/kernel/entry.S                | 216 ++++++++++++++--------
 arch/xtensa/kernel/head.S                 |  24 ++-
 arch/xtensa/kernel/mcount.S               |  38 +++-
 arch/xtensa/kernel/process.c              |  27 ++-
 arch/xtensa/kernel/setup.c                | 102 ++++------
 arch/xtensa/kernel/signal.c               |  12 +-
 arch/xtensa/kernel/traps.c                |   6 +-
 arch/xtensa/kernel/vectors.S              |  55 +++---
 arch/xtensa/kernel/vmlinux.lds.S          |  12 +-
 arch/xtensa/lib/strncpy_user.S            |  17 +-
 arch/xtensa/lib/usercopy.S                |  28 ++-
 21 files changed, 541 insertions(+), 265 deletions(-)
 create mode 100644 arch/xtensa/include/asm/sections.h

-- 
2.20.1

