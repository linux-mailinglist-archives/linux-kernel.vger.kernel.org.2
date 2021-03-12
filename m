Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20060338ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhCLK4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbhCLKzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:55:36 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9926AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:55:35 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g8so3532772wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U8krqYE8Ef8qnGsiAipJzGQpaVm5t8lDtkhTxaSOQf8=;
        b=yo+0Pv1vGiiRr+BRTMkp3T9EiYl7WyqiXEjQPicDPEauSFiYyR62sktJewMDa8dedY
         TtEdyo/qjJQ2oVaYRSQ7M53MZM7dmCSqleG5phx9kfrPM/3iQZKaUrptoZGtnKshKPhT
         k8vBK+orZOsk37DTLhw4a5zMwn0ZRe0W0KpUJE4c2vUJnFGNzRTKNOrfj7BUVsMiySCS
         KpG8zUZke0l4urksnmr+8FXqKdvK/LQQp9twKzZeG5Anzi66F3YJXeBbnAbLfyEs9Mdm
         33HdF8a5+NO+J+PGn7XcVBn02oWNoEAEpdVHkH2yt2jK9lzPK6A0zywtAJ78xDs41uwS
         Okkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U8krqYE8Ef8qnGsiAipJzGQpaVm5t8lDtkhTxaSOQf8=;
        b=nXuYfb1O4rJ4znu8FXqH6hlCxWa4sogjIm6UI/PF+R6IRdPdt4ur/AOvzS0ILZSYxz
         DsCih/46EcxDaYn/+TSu+Q1A1ZAkT4Ueay0Lq+x5bG/5QVMavlAJQ8B3WWJ2im2NpgHt
         1ozFTrnKBEr9xZDIDJ8ZDCN4q8TYcbusHL1zo/zJp4S0vw5Ul7aDVOsqmN84hMo1A9o8
         /NIKQnnce2oZc6uHlR8ZwjPJuJp92UTldoE4EJLK9WW3biGO30YaJTBN46a4vamysivW
         utbPCUPvyqJPlfSyzkCn7DF5Gp6WC4L2o2wAglqPR7H921HVDeGX8A4DA35zUjsJmcd9
         fqxA==
X-Gm-Message-State: AOAM5338+fQEFMhVL333OnO9grVCP6dzdnqciEg4iYLjZABnIZo46/li
        qU9+nrf+Nm3tZKrqIZbavU/XXw==
X-Google-Smtp-Source: ABdhPJwGy2yiZng+8p42AiTsODzcXCoCU2A55jsurjv+Rkg7hZ8K/NGYGP3VtK/HkA0LP08aOZ4tBg==
X-Received: by 2002:a1c:7e16:: with SMTP id z22mr12397544wmc.74.1615546534304;
        Fri, 12 Mar 2021 02:55:34 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id q15sm7264962wrr.58.2021.03.12.02.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:55:33 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        drbd-dev@lists.linbit.com, Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 00/11] Rid W=1 warnings from Block
Date:   Fri, 12 Mar 2021 10:55:19 +0000
Message-Id: <20210312105530.2219008-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (11):
  block: rsxx: core: Remove superfluous const qualifier
  block: drbd: drbd_interval: Demote some kernel-doc abuses and fix
    another header
  block: mtip32xx: mtip32xx: Mark debugging variable 'start' as
    __maybe_unused
  block: drbd: drbd_state: Fix some function documentation issues
  block: drbd: drbd_receiver: Demote non-conformant kernel-doc headers
  block: drbd: drbd_main: Remove duplicate field initialisation
  block: drbd: drbd_nl: Make conversion to 'enum drbd_ret_code' explicit
  block: drbd: drbd_main: Fix a bunch of function documentation
    discrepancies
  block: drbd: drbd_receiver: Demote less than half complete kernel-doc
    header
  block: xen-blkfront: Demote kernel-doc abuses
  block: drbd: drbd_nl: Demote half-complete kernel-doc headers

 drivers/block/drbd/drbd_interval.c |  8 +++++---
 drivers/block/drbd/drbd_main.c     | 30 +++++++++++++++---------------
 drivers/block/drbd/drbd_nl.c       | 17 ++++++++++-------
 drivers/block/drbd/drbd_receiver.c | 26 ++++++++++++--------------
 drivers/block/drbd/drbd_state.c    |  7 ++++---
 drivers/block/mtip32xx/mtip32xx.c  |  2 +-
 drivers/block/rsxx/core.c          |  2 +-
 drivers/block/xen-blkfront.c       |  6 +++---
 8 files changed, 51 insertions(+), 47 deletions(-)

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: drbd-dev@lists.linbit.com
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Joshua Morris <josh.h.morris@us.ibm.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: linux-block@vger.kernel.org
Cc: Philip Kelleher <pjk1939@linux.ibm.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: "Roger Pau Monné" <roger.pau@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
-- 
2.27.0

