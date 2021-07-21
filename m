Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895DC3D18CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhGUUcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhGUUcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:32:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576DCC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 14:12:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j1so1329981pjj.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 14:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HlI02XKC+lC64ms+XQgCKJ3PfplWwxDKPnFmnzw9MfE=;
        b=ulCaX/p88ZfWSpF+Ii1S4YqwetBd6S+SZkGnm03Y5R3Dpat641FDjcFESiIZcsdZj8
         lfidCeNRnwld+4irqOzXwaRVRrC2c/09z4dzS2O/bbUX8qG0n6QfO7akq/9ajDY691tC
         P3TxV6U7w4zdnbCygYn5qM66DOevjLtdhu5n/O1J4CyDe3XGrl1zqwXwXTqTjUWnVdP0
         t9oSXoKcWnj71Opxh56c5eIt8HYm3PGjU3f+GPLgI1ismU/qFoB0b7ysSrpYZ5pQHoTp
         dHR/qVPGVbQgmKJfKnlumpgtcODBkstWaDVSrBfrS0L5ng4uvLwmPrVPlUl2MT5zfWZ2
         vL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HlI02XKC+lC64ms+XQgCKJ3PfplWwxDKPnFmnzw9MfE=;
        b=MsebPsJDEGJPF8OtX5vn3ZkjVVHN5A0fh2Fl3P927EWBxYZsLkHDnCRWfnM8WxCoE2
         rY+rqtviSXwU+ofFwNf/NAKYXKWwsziBYKEVZcPalvDxqGhw4ubuYJ+hqyNyMGE4/XUZ
         JKJqwxynhMLxNkZKK8JXEZQuBGavXh5bhWbRQvv31/pr+NhE3Vo/WMlIEMLgoX7KTKzW
         IeJKTB4z8R/ZEyvXfWzX3liH5WOnOpodcajjZXKjOttSDcBpWYLHxDtDxh41/XvTHIem
         fDm+9Dfx4C7KFOpjnZZhDYniXjXO/kxAB3EJpXoS/YWIZWxLZUt64IndQdhYP47u1crh
         UrNA==
X-Gm-Message-State: AOAM530NEAxO6fbLWfNMH7IL6vGJPn/t8imnpMmVS0q84hE60J2pTep8
        NwTDUSUmRfezNWO8klcu5tg5WG6racM=
X-Google-Smtp-Source: ABdhPJxTSpgCKdEscQOAy+Ld8ZZWYmwDHZllWnT3zkt8BtrHaaZ4TqrQOeV9QqBbdTKvYRbt80qDxg==
X-Received: by 2002:a17:902:c64b:b029:12b:25f7:9b17 with SMTP id s11-20020a170902c64bb029012b25f79b17mr28874638pls.24.1626901964990;
        Wed, 21 Jul 2021 14:12:44 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:a0d4:143d:6e70:369d])
        by smtp.gmail.com with ESMTPSA id y9sm7667498pgr.10.2021.07.21.14.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:12:44 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: make fiemap command in accordance with uapi
Date:   Wed, 21 Jul 2021 14:12:40 -0700
Message-Id: <20210721211240.3632817-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Made "fiemap" command in accordance with user api manual. So, eliminated
NEW_ADDR print out and made it ends in the last extent.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 tools/f2fs_io/f2fs_io.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index aa1a7e4..42dbd60 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -757,10 +757,11 @@ static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
 			die_errno("FIEMAP failed");
 
 		phy_addr = fm->fm_extents[0].fe_physical / F2FS_BLKSIZE;
-		if (phy_addr == NEW_ADDR)
-			printf("NEW_ADDR ");
-		else
-			printf("%llu ", phy_addr);
+		printf("%llu: %llu\n", fm->fm_start / F2FS_BLKSIZE, phy_addr);
+
+		if (fm->fm_extents[0].fe_flags & FIEMAP_EXTENT_LAST)
+			break;
+
 		fm->fm_start += F2FS_BLKSIZE;
 	}
 	printf("\n");
-- 
2.32.0.402.g57bb445576-goog

