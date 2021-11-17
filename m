Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BED454175
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 07:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhKQG5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 01:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhKQG5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 01:57:54 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD110C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 22:54:56 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 8so1761440pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 22:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8JL79xoioeIbmRPpiAS2y4QgvfDUPpG6AwsfQpKtAsY=;
        b=gYgKhMTN/kwElRfHGc470QVkSGGkrhuDMeDNGkMsM1fRHWavnzmmd0Uk9eoRJjWQAR
         4UwV41hUR0YkE41pgyY79RlJoXNDgoNAKLsRJu54IBwt2fUs8DISCHuqw7LTskqD/cih
         pBT/MmO+tv1hGtP9tOuN4Pu/8tLfqAvORG7L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8JL79xoioeIbmRPpiAS2y4QgvfDUPpG6AwsfQpKtAsY=;
        b=howeDRjEfeuaZ1jpnRfS38p20axg5RGPlJnX1EE6B8waHL92nAXJkEUmcFXx6lBr8b
         s2bpBA0v9blGZz78GXRyGyT7rHZP5TUCffUBuuH9CEdAHgf68VMpghs7dJ5d97iIx9aR
         VhBZVhVqU9lfD53znqiHrtAInE7l6njwMRqRtrnKxlwT52SkAKGenN1TvRQS96hOG72O
         ocgdrQ+HvVOzlnHotP9KNodGwNLWW89gSubIqSwwT5j5XgBNHkO8fKqDaq4XthCIJJ+D
         BWB5YUvvcaOkSy5VAGUD1agyKm1NszJ1SGYne9XoP3tB9hy+ipUzGBWu/NrRgIvMWVt1
         iAMg==
X-Gm-Message-State: AOAM530ibU2RXtQBS0u0Sog+5aUWpUX36jbL9ax965lVwlVAsOefIbOE
        zJNrDiW9s03Q0FdONNJkV1VDZA==
X-Google-Smtp-Source: ABdhPJwszlFd+bQSVLJM+38YPQ+fcsWvw7gv4nO7aoAWmPpp/OwVWHiiK7WTPVapinau4ooaDDyAUg==
X-Received: by 2002:a63:82c3:: with SMTP id w186mr3572619pgd.96.1637132096160;
        Tue, 16 Nov 2021 22:54:56 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:47f8:c08f:374a:a54e])
        by smtp.gmail.com with ESMTPSA id l21sm20536155pfu.213.2021.11.16.22.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 22:54:55 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] remoteproc: qcom: Don't memcpy_toio more than is provided
Date:   Tue, 16 Nov 2021 22:54:54 -0800
Message-Id: <20211117065454.4142936-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the string passed into qcom_pil_info_store() isn't as long as
PIL_RELOC_NAME_LEN we'll try to copy the string assuming the length is
PIL_RELOC_NAME_LEN to the io space and go beyond the bounds of the
string. Let's only copy as many byes as the string is long, ignoring the
NUL terminator.

This fixes the following KASAN error:

 BUG: KASAN: global-out-of-bounds in __memcpy_toio+0x124/0x140
 Read of size 1 at addr ffffffd35086e386 by task rmtfs/2392

 CPU: 2 PID: 2392 Comm: rmtfs Tainted: G        W         5.16.0-rc1-lockdep+ #10
 Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
 Call trace:
  dump_backtrace+0x0/0x410
  show_stack+0x24/0x30
  dump_stack_lvl+0x7c/0xa0
  print_address_description+0x78/0x2bc
  kasan_report+0x160/0x1a0
  __asan_report_load1_noabort+0x44/0x50
  __memcpy_toio+0x124/0x140
  qcom_pil_info_store+0x298/0x358 [qcom_pil_info]
  q6v5_start+0xdf0/0x12e0 [qcom_q6v5_mss]
  rproc_start+0x178/0x3a0
  rproc_boot+0x5f0/0xb90
  state_store+0x78/0x1bc
  dev_attr_store+0x70/0x90
  sysfs_kf_write+0xf4/0x118
  kernfs_fop_write_iter+0x208/0x300
  vfs_write+0x55c/0x804
  ksys_pwrite64+0xc8/0x134
  __arm64_compat_sys_aarch32_pwrite64+0xc4/0xdc
  invoke_syscall+0x78/0x20c
  el0_svc_common+0x11c/0x1f0
  do_el0_svc_compat+0x50/0x60
  el0_svc_compat+0x5c/0xec
  el0t_32_sync_handler+0xc0/0xf0
  el0t_32_sync+0x1a4/0x1a8

 The buggy address belongs to the variable:
  .str.59+0x6/0xffffffffffffec80 [qcom_q6v5_mss]

 Memory state around the buggy address:
  ffffffd35086e280: 00 00 00 00 02 f9 f9 f9 f9 f9 f9 f9 00 00 00 00
  ffffffd35086e300: 00 02 f9 f9 f9 f9 f9 f9 00 00 00 06 f9 f9 f9 f9
 >ffffffd35086e380: 06 f9 f9 f9 05 f9 f9 f9 00 00 00 00 00 06 f9 f9
                    ^
  ffffffd35086e400: f9 f9 f9 f9 01 f9 f9 f9 04 f9 f9 f9 00 00 01 f9
  ffffffd35086e480: f9 f9 f9 f9 00 00 00 00 00 00 00 01 f9 f9 f9 f9

Fixes: 549b67da660d ("remoteproc: qcom: Introduce helper to store pil info in IMEM")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/remoteproc/qcom_pil_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_pil_info.c b/drivers/remoteproc/qcom_pil_info.c
index 7c007dd7b200..aca21560e20b 100644
--- a/drivers/remoteproc/qcom_pil_info.c
+++ b/drivers/remoteproc/qcom_pil_info.c
@@ -104,7 +104,7 @@ int qcom_pil_info_store(const char *image, phys_addr_t base, size_t size)
 	return -ENOMEM;
 
 found_unused:
-	memcpy_toio(entry, image, PIL_RELOC_NAME_LEN);
+	memcpy_toio(entry, image, strnlen(image, PIL_RELOC_NAME_LEN));
 found_existing:
 	/* Use two writel() as base is only aligned to 4 bytes on odd entries */
 	writel(base, entry + PIL_RELOC_NAME_LEN);

base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
https://chromeos.dev

