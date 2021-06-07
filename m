Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19DC39E798
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhFGTky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:40:54 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:45868 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFGTkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:40:49 -0400
Received: by mail-pj1-f44.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso711172pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 12:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yuwW7mrMHLyFj1IPMINuhhkcEWX3mno1x4n7QfPqTmQ=;
        b=NtGNQYWISuTtMiZDF0BdY9h16yPfOezWPhgvmGzUqo6w0YwZWfhOHdzDWKiDlS2RQB
         d8qE3fDuOziglbhBF9wN6BrBxDYxDz0scf7ryFmFUs9tI9cI7T8Ngpjdwb1IxOgVTHqm
         AMGRjmGB/XRiamKuPpe+srromtO4Temy/tq9iTYrGaqZoU7pBhyX/gWY9+MZhtgD2QW1
         nnHNX2S0U6vbj4NANqiO4yxyvxojyxsy41I54lO8n0OJQJs9M7NR0s+bWu6vtEP20OMz
         7yEfKLsiiD0W+FBMcEf9cX2sz51wzoIxLu1YdBH8AsXHX+U9dwEG9VZz1QamYJ5hczJc
         XvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yuwW7mrMHLyFj1IPMINuhhkcEWX3mno1x4n7QfPqTmQ=;
        b=qjlBfRx6YWnkhX1MHCGj0qM4U7P//q5idWwnmLl3cVxw641er70wADrjLw9YWP238P
         Q2Vwf1zW4pS+x+IwNsEEItRlffX+4SXheC6M6Wb5NQ8NrS47l2aVzJ1E0r5WANeK8oG6
         3hxQLyatclLuF9E47bXxF7s9qkjVmeiDYYld+RLxQHtVnJWZ2Nd1NZ7W9FRVDNkCCdNg
         AucuKJwJpr0QjvflHhKThtEhKta+k8drvpjLQxMsbajF3q8XT2ZHBAbRC4aFho6bmtxM
         AhanSLT5p2RvOm1IypfZ2sX51/eqFe3Z5nL1k2KbZx0jjXEyFIgRWZJrKjG39UXLNYan
         MY3A==
X-Gm-Message-State: AOAM531Kcpoxuu9ZQdymjS31C9JhUNhdzossUElSj8tsARGIyARn+5RG
        QnXLu/1L2VkxZFwonjeTUVY=
X-Google-Smtp-Source: ABdhPJwLuyE2XW3Ft5QdLpx6P5/OR0T+JQApU6qwp1muXbXdRvaV0w6g9cJmXtaJRl+V2+zjHnNf9Q==
X-Received: by 2002:a17:90b:1188:: with SMTP id gk8mr21585439pjb.138.1623094665943;
        Mon, 07 Jun 2021 12:37:45 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9005:8001:a09b:9c7c:331d:38fe])
        by smtp.gmail.com with ESMTPSA id p36sm9471490pgm.74.2021.06.07.12.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 12:37:44 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] mtd: rawnand: marvell: Minor documentation correction
Date:   Tue,  8 Jun 2021 01:07:36 +0530
Message-Id: <20210607193736.4654-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot throws below warning ->
drivers/mtd/nand/raw/marvell_nand.c:454: warning: This comment starts
with '/**', but isn't a kernel-doc comment. Refer
Documentation/doc-guide/kernel-doc.rst

Minor documentation correction.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
---
v2:
	Address review comment.

 drivers/mtd/nand/raw/marvell_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 79da6b02e209..f4efdb59467d 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -451,7 +451,7 @@ struct marvell_nfc_timings {
 };
 
 /**
- * Derives a duration in numbers of clock cycles.
+ * TO_CYCLES() - Derives a duration in numbers of clock cycles.
  *
  * @ps: Duration in pico-seconds
  * @period_ns:  Clock period in nano-seconds
-- 
2.25.1

