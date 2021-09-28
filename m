Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE28D41A408
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 02:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbhI1AHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 20:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhI1AHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 20:07:53 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45546C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 17:06:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c1so17330421pfp.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 17:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rL/+UBjsAdOcmWb1ULGTvColtwWXsbDceVz5fuSb5YM=;
        b=lIE5LQc0R/SYyAyIkRcdbaTbZ1UV7EriV1AVYTn9P+Anee9DaX+BrBBfZ5j9We634h
         Ykvq3KCjf5aNh1Sw1lt6uVqV3xl7bqmVIk9i/gFvW+fzhK5BNXFhobuZfVrtVxgkRnQ9
         43x2JYsO9rEEXz4pm0HfbDxktvkMrfteB+WOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rL/+UBjsAdOcmWb1ULGTvColtwWXsbDceVz5fuSb5YM=;
        b=Skk4sVMh+Y2XgLYvD64+Re2L3fVX45HZCPS/lOKR8txL0ZT6oCzhxKlA9qhtcWzNYm
         v6EGjMk4hP95thpVqDZLsyFq/0ftkafpti1jrQWweo21B7vnURA1kR1l0fX4ham7zehi
         bZoqExYiGThjKxt83MIEsCvNt9FHoQ1swTsCHVfxuM7DwwC3HTNNngsLtd38vWsSNpCu
         24+yy7z5NqArr4bW5h8FfpkzPeKg1/CHBW8tBdiHwP+sWs3NQvaZXtJ3nVsTSaI+dEra
         7ANoQu2YdiAKjCe2F90nXaBq2mXg4Ipehxk++2QEIoQ/HKsVOy94VXbP46D1iUCuXAP7
         FRrw==
X-Gm-Message-State: AOAM530bQOPq5IjUZnZS5QzcBrwc+Od0FyKQ1VuBSd412uL3/qeCbWrP
        NIvIH9cKZiGZXdu85ezM4UgIY+Hhgoe8Hw==
X-Google-Smtp-Source: ABdhPJzRvpii2aOpSPbE5hTEOXOTjJ4VYUN4Y1KTNGZnP+7iWaN9JnOjOU9JqSzJ3o49WtjdFh4ZdQ==
X-Received: by 2002:a62:5fc7:0:b0:438:9e3a:b8c0 with SMTP id t190-20020a625fc7000000b004389e3ab8c0mr2367233pfb.74.1632787574553;
        Mon, 27 Sep 2021 17:06:14 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:f28f:d202:f6e7:8129])
        by smtp.gmail.com with ESMTPSA id m10sm465321pjs.21.2021.09.27.17.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 17:06:14 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] nvmem: Fix shift-out-of-bound (UBSAN) with byte size cells
Date:   Mon, 27 Sep 2021 17:06:12 -0700
Message-Id: <20210928000612.1618110-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a cell has 'nbits' equal to a multiple of BITS_PER_BYTE the logic

 *p &= GENMASK((cell->nbits%BITS_PER_BYTE) - 1, 0);

will become undefined behavior because nbits modulo BITS_PER_BYTE is 0, and we
subtract one from that making a large number that is then shifted more than the
number of bits that fit into an unsigned long.

UBSAN reports this problem:

 UBSAN: shift-out-of-bounds in drivers/nvmem/core.c:1386:8
 shift exponent 64 is too large for 64-bit type 'unsigned long'
 CPU: 6 PID: 7 Comm: kworker/u16:0 Not tainted 5.15.0-rc3+ #9
 Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
 Workqueue: events_unbound deferred_probe_work_func
 Call trace:
  dump_backtrace+0x0/0x170
  show_stack+0x24/0x30
  dump_stack_lvl+0x64/0x7c
  dump_stack+0x18/0x38
  ubsan_epilogue+0x10/0x54
  __ubsan_handle_shift_out_of_bounds+0x180/0x194
  __nvmem_cell_read+0x1ec/0x21c
  nvmem_cell_read+0x58/0x94
  nvmem_cell_read_variable_common+0x4c/0xb0
  nvmem_cell_read_variable_le_u32+0x40/0x100
  a6xx_gpu_init+0x170/0x2f4
  adreno_bind+0x174/0x284
  component_bind_all+0xf0/0x264
  msm_drm_bind+0x1d8/0x7a0
  try_to_bring_up_master+0x164/0x1ac
  __component_add+0xbc/0x13c
  component_add+0x20/0x2c
  dp_display_probe+0x340/0x384
  platform_probe+0xc0/0x100
  really_probe+0x110/0x304
  __driver_probe_device+0xb8/0x120
  driver_probe_device+0x4c/0xfc
  __device_attach_driver+0xb0/0x128
  bus_for_each_drv+0x90/0xdc
  __device_attach+0xc8/0x174
  device_initial_probe+0x20/0x2c
  bus_probe_device+0x40/0xa4
  deferred_probe_work_func+0x7c/0xb8
  process_one_work+0x128/0x21c
  process_scheduled_works+0x40/0x54
  worker_thread+0x1ec/0x2a8
  kthread+0x138/0x158
  ret_from_fork+0x10/0x20

Fix it by making sure there are any bits to mask out.

Cc: Douglas Anderson <dianders@chromium.org>
Fixes: 69aba7948cbe ("nvmem: Add a simple NVMEM framework for consumers")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/nvmem/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 3d87fadaa160..8976da38b375 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1383,7 +1383,8 @@ static void nvmem_shift_read_buffer_in_place(struct nvmem_cell *cell, void *buf)
 		*p-- = 0;
 
 	/* clear msb bits if any leftover in the last byte */
-	*p &= GENMASK((cell->nbits%BITS_PER_BYTE) - 1, 0);
+	if (cell->nbits % BITS_PER_BYTE)
+		*p &= GENMASK((cell->nbits % BITS_PER_BYTE) - 1, 0);
 }
 
 static int __nvmem_cell_read(struct nvmem_device *nvmem,

base-commit: e4e737bb5c170df6135a127739a9e6148ee3da82
-- 
https://chromeos.dev

