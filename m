Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208FB3F3B2E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 17:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhHUPjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 11:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhHUPjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 11:39:15 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BECC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 08:38:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t1so12251065pgv.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=RTMJMW0nE10jtTlMIfTd0xjDXr/ztqWVbOop2zPkMIw=;
        b=DKif8Co6Mq/DJlrMwu2uroQUZwYZ6i0/rWx/+11A8iih4dM2ucXPel4otpAQg6dOks
         gPwxkF2N0jtikITGE72bcgVyrL9ZsLrv9XW1oqc3qg1rjY7m/M5OSAzP5BILiGv16dzI
         ZMG0KJX2Uz585+PFaV07oqpgA09jgeo0GtA30e0Pb2XTxRRwREfCgppr7emKU45/o8Yy
         i/Sg4m7b9suOWb4sL4Uyy7X8wEdTdGkMDF7Uofjqx8iqjs0aG3uMZoCJnSVeO1K+qtu8
         LuDOsd4PBGmJF7M06vULXKF7ptfe3vtSgmw9DfAHPw2PCO3HoE1dMzpIu6bgHQ3bk717
         6bDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=RTMJMW0nE10jtTlMIfTd0xjDXr/ztqWVbOop2zPkMIw=;
        b=Fc3D1yt/VHfagJVJSdwN3Kwi5Xlx5nT4jIGWS5IHo2Z0f5WQQGJlyDv3CjUBArEgpG
         vsXbFbfv2IhJwz6ZebZHFSbCqVP2qpVlIfx0J1YBZ+NUPj7dUF41n0GW4+wROaM0WuRf
         ywNhBMsGyLZhH/4MEccAKasV6UjbBRUJqpr3b14RuraVf+QSOU0EJ1KPvTkMMTfyPY0g
         EuGq82JumH/CuXI13UDN2UB6dU7ouyhhGRmw0NzfWGMybV7QWcgj9PN2FKJ0FmJIanrY
         R48bx8fYdsJQB9s6ivV2BgVpfqdWX9M2skVK2JoE6lar9wwMZUOI2gKfV/hzkjX+sV3R
         9iQQ==
X-Gm-Message-State: AOAM531a0uSjPW9SNq6TdsiiuwVDg4IL+Bf3cxvw1cSXB7oCvrl7FmKR
        bm1Cs2rxZNjmJoPRFuTQ2Z1OQQ==
X-Google-Smtp-Source: ABdhPJwu3TlVxRJa93Y6m+d60OVdtrl1funU4u6Hndsj90YBDfb6327psOtIcsvH54agNq0QqJmrdA==
X-Received: by 2002:a05:6a00:2ba:b0:3e1:d586:c92a with SMTP id q26-20020a056a0002ba00b003e1d586c92amr25275975pfs.43.1629560315367;
        Sat, 21 Aug 2021 08:38:35 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e13sm10816946pfi.210.2021.08.21.08.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 08:38:34 -0700 (PDT)
Date:   Sat, 21 Aug 2021 08:38:34 -0700 (PDT)
X-Google-Original-Date: Sat, 21 Aug 2021 08:38:25 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.14-rc7
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-182cc50e-78d7-4a85-a5bc-19e7a4648e87@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fdf3a7a1e0a67a52f631b055975c6ac7e0e49a65:

  riscv: Fix comment regarding kernel mapping overlapping with IS_ERR_VALUE (2021-08-12 07:16:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-rc7

for you to fetch changes up to aa3e1ba32e553e611a58145c2eb349802feaa6eb:

  riscv: Fix a number of free'd resources in init_resources() (2021-08-20 10:15:51 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.14-rc7

* A fix to the sifive-l2-cache device tree bindings, for json-schema
  compatibility.  This does not change the intended behavior of the
  binding.
* A fix to avoid improperly freeing necessary resources during early
  boot.

----------------------------------------------------------------
Petr Pavlu (1):
      riscv: Fix a number of free'd resources in init_resources()

Rob Herring (1):
      dt-bindings: sifive-l2-cache: Fix 'select' matching

 Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml | 8 ++++----
 arch/riscv/kernel/setup.c                                    | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)
