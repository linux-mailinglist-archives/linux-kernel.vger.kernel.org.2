Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B21366BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239489AbhDUNE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240612AbhDUNED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:04:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42C696143B;
        Wed, 21 Apr 2021 13:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010210;
        bh=TvnieelAUSi/kput2ZUsThvUtBXN6s3HC7/1/YfUMGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n9Wk3Ea7B+86KF1Ny0YfMg1DfdhzeRJo0hftmURO542o59NIGau2KmNLZ3fAeQWhj
         fsr/8umMbsP3soqiJtRH6BitFluhnYVHJ5/jXotgz768oCIdgjizYOxjk1bdQ1SC83
         aO46y//b3FbXqLvWAmjMH5uH4dTsIRviX4JO5KIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 052/190] Revert "media: media/saa7146: fix incorrect assertion in saa7146_buffer_finish"
Date:   Wed, 21 Apr 2021 14:58:47 +0200
Message-Id: <20210421130105.1226686-53-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 639c0a5b0503fb57127fa8972208d43020a9bcf6.

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
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/common/saa7146/saa7146_fops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/common/saa7146/saa7146_fops.c b/drivers/media/common/saa7146/saa7146_fops.c
index baf5772c52a9..c256146fd3b6 100644
--- a/drivers/media/common/saa7146/saa7146_fops.c
+++ b/drivers/media/common/saa7146/saa7146_fops.c
@@ -95,6 +95,8 @@ void saa7146_buffer_finish(struct saa7146_dev *dev,
 	DEB_EE("dev:%p, dmaq:%p, state:%d\n", dev, q, state);
 	DEB_EE("q->curr:%p\n", q->curr);
 
+	BUG_ON(!q->curr);
+
 	/* finish current buffer */
 	if (NULL == q->curr) {
 		DEB_D("aiii. no current buffer\n");
-- 
2.31.1

