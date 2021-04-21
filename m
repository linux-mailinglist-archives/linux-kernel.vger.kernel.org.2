Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A414366C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240876AbhDUNMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241571AbhDUNJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21FC76144B;
        Wed, 21 Apr 2021 13:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010503;
        bh=BGH4gs/Sb4oEddOobnSfQ3BAzaHXyA0jcebArj3gFz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BKEG5M5zanSGZbYEp7g7Q9aY6aHNjfcr3eSHkAa4pjjVweonbk3o4maqN5sK3YeLZ
         4K18fgXdKgPMrXzoV7EP+Wmhu/ook7oTb7vXsTJFoVFxyoyhX0Gu6MwPfVcSjnuf1T
         8uno6vY+K61LDaWOA9kPsifTq0o10BgyoxsgcwWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 161/190] Revert "staging: rts5208: Add a check for ms_read_extra_data"
Date:   Wed, 21 Apr 2021 15:00:36 +0200
Message-Id: <20210421130105.1226686-162-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 73b69c01cc925d9c48e5b4f78e3d8b88c4e5b924.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Aditya Pakki <pakki001@umn.edu>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rts5208/ms.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
index 9001570a8c94..37b60ba1bdfe 100644
--- a/drivers/staging/rts5208/ms.c
+++ b/drivers/staging/rts5208/ms.c
@@ -1665,10 +1665,7 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 			return STATUS_FAIL;
 		}
 
-		retval = ms_read_extra_data(chip, old_blk, i, extra,
-					    MS_EXTRA_SIZE);
-		if (retval != STATUS_SUCCESS)
-			return STATUS_FAIL;
+		ms_read_extra_data(chip, old_blk, i, extra, MS_EXTRA_SIZE);
 
 		retval = ms_set_rw_reg_addr(chip, OVERWRITE_FLAG,
 					    MS_EXTRA_SIZE, SYSTEM_PARAM, 6);
-- 
2.31.1

