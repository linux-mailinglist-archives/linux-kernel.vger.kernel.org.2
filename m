Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E99366B76
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbhDUNCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239191AbhDUNCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:02:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67ABF613F5;
        Wed, 21 Apr 2021 13:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010095;
        bh=HjnZ+JXDjvU96Lkub7xtE2D1LDAw1uP0NBlOWN4M4L4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0OJGYJgF/WvXYM+gmdNlFGT4hWOB9ro5jvUT36NTN8UgngZAqcTynNeDVEXOrIgNr
         A8hvSQfI0Na/4C8Fp8g6AVYM1ZGmDN+Bsn4IKOlN/8HqvKQuy1zwhE/sOxzpr8cs+q
         SmDMqdcRzMIu+NtB2Nyp251OoxirlDtqRpfdHz2M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 003/190] Revert "media: sti: Fix reference count leaks"
Date:   Wed, 21 Apr 2021 14:57:58 +0200
Message-Id: <20210421130105.1226686-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6f4432bae9f2d12fc1815b5e26cc07e69bcad0df.

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

Cc: Qiushi Wu <wu000273@umn.edu>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/sti/hva/hva-hw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/sti/hva/hva-hw.c b/drivers/media/platform/sti/hva/hva-hw.c
index f59811e27f51..d0d45dc5f32f 100644
--- a/drivers/media/platform/sti/hva/hva-hw.c
+++ b/drivers/media/platform/sti/hva/hva-hw.c
@@ -272,7 +272,6 @@ static unsigned long int hva_hw_get_ip_version(struct hva_dev *hva)
 
 	if (pm_runtime_get_sync(dev) < 0) {
 		dev_err(dev, "%s     failed to get pm_runtime\n", HVA_PREFIX);
-		pm_runtime_put_noidle(dev);
 		mutex_unlock(&hva->protect_mutex);
 		return -EFAULT;
 	}
@@ -555,7 +554,6 @@ void hva_hw_dump_regs(struct hva_dev *hva, struct seq_file *s)
 
 	if (pm_runtime_get_sync(dev) < 0) {
 		seq_puts(s, "Cannot wake up IP\n");
-		pm_runtime_put_noidle(dev);
 		mutex_unlock(&hva->protect_mutex);
 		return;
 	}
-- 
2.31.1

