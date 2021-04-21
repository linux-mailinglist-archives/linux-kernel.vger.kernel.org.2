Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5BC366BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241540AbhDUNJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:09:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241024AbhDUNGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:06:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68A746145F;
        Wed, 21 Apr 2021 13:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010362;
        bh=0ZEwjABnJptGu2Z4uoQca2QnVVVB3eYxPhwHonNiRXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkWL9/cewR33KuS7gStJhdipIWU+f2aXT7FS5YV5B+hF8u3U0jA4YgwJXP3JrnjiA
         eBeKD8OfGmcqtq3JvO+Kr2Zqj1iwy06eIOnEooDuyZTCAGgly+12hgQqmBKBhXA/u9
         kR54d01qoJVplf6f2aLg94wK0mQsMfl8MvAsEL0g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 073/190] Revert "media: rcar_drif: fix a memory disclosure"
Date:   Wed, 21 Apr 2021 14:59:08 +0200
Message-Id: <20210421130105.1226686-74-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d39083234c60519724c6ed59509a2129fd2aed41.

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

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/rcar_drif.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/rcar_drif.c b/drivers/media/platform/rcar_drif.c
index 83bd9a412a56..1e3b68a8743a 100644
--- a/drivers/media/platform/rcar_drif.c
+++ b/drivers/media/platform/rcar_drif.c
@@ -915,7 +915,6 @@ static int rcar_drif_g_fmt_sdr_cap(struct file *file, void *priv,
 {
 	struct rcar_drif_sdr *sdr = video_drvdata(file);
 
-	memset(f->fmt.sdr.reserved, 0, sizeof(f->fmt.sdr.reserved));
 	f->fmt.sdr.pixelformat = sdr->fmt->pixelformat;
 	f->fmt.sdr.buffersize = sdr->fmt->buffersize;
 
-- 
2.31.1

