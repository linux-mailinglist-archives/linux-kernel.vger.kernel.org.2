Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2115E30743B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhA1K4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhA1K4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:56:34 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88FBC061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 02:55:53 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id kx7so3642827pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 02:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f/W8U0bQIHa5GKUt/WPMmEx9gyM4ao9W0NLGedSTZKI=;
        b=YgRvvCJU82FxEFYYvkucqYGubJMzsecaRcI/QeQgEAZrmbrgILelxqBiMuPyhyIcPK
         wB3fRlfo3tKWH4ErJ1tQE9QrHj0wQl67rsyHOf0B8jfLpoFwWKnxy02pobSiNhUQcxa7
         3vfi7bbd04UEpLeCGg2aOAqV2l48tK0IaZ9ptLPzcMTZD6KA72g/vJrhnRSHaJ1siyx9
         iGEegxrM6KvKqULXHmLcmgjr5qPww2lFR2iLpZSJtFcAajSU52KUwtO2a6FNgM2UxY+8
         bmjQB+SZBEPEDlo9mf1FOilojRzfuKXZrdTXTkzHYnBcw6TEoQqeevWSfCDRntmVsmxa
         1zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f/W8U0bQIHa5GKUt/WPMmEx9gyM4ao9W0NLGedSTZKI=;
        b=kGWH/JM/LSbjKfNINhRVQ3RMfWtFPfZasCt2tmmKni80lvbu4N4apm0//VooARQfbt
         twt3JAPjIXfb/8G3EmveC9pXr+M70hoOKGU/utNQIi9UpTmlfoXv2VtiESdhfpAAsfM/
         onRVLxe6rUUVv28YCTL4udKVuVWZpWtLccu6buIJa6uE0aKyf3WpcDbZeVsOwMUoFF9K
         i/SlyfmkKP6tj2mtdbpASTjNBC2OxgBWDqEshBF4R7DU31abP6d4SnWW16sgxil/k96p
         OQ/xvrAcauf9AO9KX/NBHTkFJvpGmKadwCpfU1RrRDHpTRSvlbr4z9j092Ymx81GTXvA
         K0lw==
X-Gm-Message-State: AOAM532ECGmzKa78KZmTDmK+x/YkDoKUCluIDqbXJqUeP7/FbVEOH50S
        LN+xjCmokqfyIseV1aAwi2c=
X-Google-Smtp-Source: ABdhPJy9LOELd1U5MGNpya0BrTNkr2QpCCK/dMPlGvpZw95ob+BeyANXjUimvNm+bzW/Sk561oWqGg==
X-Received: by 2002:a17:90b:602:: with SMTP id gb2mr10413949pjb.170.1611831353453;
        Thu, 28 Jan 2021 02:55:53 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id r15sm5391451pgh.39.2021.01.28.02.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 02:55:51 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     dwmw2@infradead.org
Cc:     richard@nod.at, yang.yang29@zte.com.cn,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] jffs2: check the validity of dstlen in jffs2_zlib_compress()
Date:   Thu, 28 Jan 2021 02:55:35 -0800
Message-Id: <20210128105535.49479-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

KASAN reports a BUG when download file in jffs2 filesystem.It is
because when dstlen == 1, cpage_out will write array out of bounds.
Actually, data will not be compressed in jffs2_zlib_compress() if
data's length less than 4.

[  393.799778] BUG: KASAN: slab-out-of-bounds in jffs2_rtime_compress+0x214/0x2f0 at addr ffff800062e3b281
[  393.809166] Write of size 1 by task tftp/2918
[  393.813526] CPU: 3 PID: 2918 Comm: tftp Tainted: G    B           4.9.115-rt93-EMBSYS-CGEL-6.1.R6-dirty #1
[  393.823173] Hardware name: LS1043A RDB Board (DT)
[  393.827870] Call trace:
[  393.830322] [<ffff20000808c700>] dump_backtrace+0x0/0x2f0
[  393.835721] [<ffff20000808ca04>] show_stack+0x14/0x20
[  393.840774] [<ffff2000086ef700>] dump_stack+0x90/0xb0
[  393.845829] [<ffff20000827b19c>] kasan_object_err+0x24/0x80
[  393.851402] [<ffff20000827b404>] kasan_report_error+0x1b4/0x4d8
[  393.857323] [<ffff20000827bae8>] kasan_report+0x38/0x40
[  393.862548] [<ffff200008279d44>] __asan_store1+0x4c/0x58
[  393.867859] [<ffff2000084ce2ec>] jffs2_rtime_compress+0x214/0x2f0
[  393.873955] [<ffff2000084bb3b0>] jffs2_selected_compress+0x178/0x2a0
[  393.880308] [<ffff2000084bb530>] jffs2_compress+0x58/0x478
[  393.885796] [<ffff2000084c5b34>] jffs2_write_inode_range+0x13c/0x450
[  393.892150] [<ffff2000084be0b8>] jffs2_write_end+0x2a8/0x4a0
[  393.897811] [<ffff2000081f3008>] generic_perform_write+0x1c0/0x280
[  393.903990] [<ffff2000081f5074>] __generic_file_write_iter+0x1c4/0x228
[  393.910517] [<ffff2000081f5210>] generic_file_write_iter+0x138/0x288
[  393.916870] [<ffff20000829ec1c>] __vfs_write+0x1b4/0x238
[  393.922181] [<ffff20000829ff00>] vfs_write+0xd0/0x238
[  393.927232] [<ffff2000082a1ba8>] SyS_write+0xa0/0x110
[  393.932283] [<ffff20000808429c>] __sys_trace_return+0x0/0x4
[  393.937851] Object at ffff800062e3b280, in cache kmalloc-64 size: 64
[  393.944197] Allocated:
[  393.946552] PID = 2918
[  393.948913]  save_stack_trace_tsk+0x0/0x220
[  393.953096]  save_stack_trace+0x18/0x20
[  393.956932]  kasan_kmalloc+0xd8/0x188
[  393.960594]  __kmalloc+0x144/0x238
[  393.963994]  jffs2_selected_compress+0x48/0x2a0
[  393.968524]  jffs2_compress+0x58/0x478
[  393.972273]  jffs2_write_inode_range+0x13c/0x450
[  393.976889]  jffs2_write_end+0x2a8/0x4a0
[  393.980810]  generic_perform_write+0x1c0/0x280
[  393.985251]  __generic_file_write_iter+0x1c4/0x228
[  393.990040]  generic_file_write_iter+0x138/0x288
[  393.994655]  __vfs_write+0x1b4/0x238
[  393.998228]  vfs_write+0xd0/0x238
[  394.001543]  SyS_write+0xa0/0x110
[  394.004856]  __sys_trace_return+0x0/0x4
[  394.008684] Freed:
[  394.010691] PID = 2918
[  394.013051]  save_stack_trace_tsk+0x0/0x220
[  394.017233]  save_stack_trace+0x18/0x20
[  394.021069]  kasan_slab_free+0x88/0x188
[  394.024902]  kfree+0x6c/0x1d8
[  394.027868]  jffs2_sum_write_sumnode+0x2c4/0x880
[  394.032486]  jffs2_do_reserve_space+0x198/0x598
[  394.037016]  jffs2_reserve_space+0x3f8/0x4d8
[  394.041286]  jffs2_write_inode_range+0xf0/0x450
[  394.045816]  jffs2_write_end+0x2a8/0x4a0
[  394.049737]  generic_perform_write+0x1c0/0x280
[  394.054179]  __generic_file_write_iter+0x1c4/0x228
[  394.058968]  generic_file_write_iter+0x138/0x288
[  394.063583]  __vfs_write+0x1b4/0x238
[  394.067157]  vfs_write+0xd0/0x238
[  394.070470]  SyS_write+0xa0/0x110
[  394.073783]  __sys_trace_return+0x0/0x4
[  394.077612] Memory state around the buggy address:
[  394.082404]  ffff800062e3b180: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
[  394.089623]  ffff800062e3b200: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
[  394.096842] >ffff800062e3b280: 01 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  394.104056]                    ^
[  394.107283]  ffff800062e3b300: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[  394.114502]  ffff800062e3b380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[  394.121718] ==================================================================

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 fs/jffs2/compr_rtime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jffs2/compr_rtime.c b/fs/jffs2/compr_rtime.c
index 406d9cc84ba8..79e771ab624f 100644
--- a/fs/jffs2/compr_rtime.c
+++ b/fs/jffs2/compr_rtime.c
@@ -37,6 +37,9 @@ static int jffs2_rtime_compress(unsigned char *data_in,
 	int outpos = 0;
 	int pos=0;
 
+	if (*dstlen <= 3)
+		return -1;
+
 	memset(positions,0,sizeof(positions));
 
 	while (pos < (*sourcelen) && outpos <= (*dstlen)-2) {
-- 
2.25.1

