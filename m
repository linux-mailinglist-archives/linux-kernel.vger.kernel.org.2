Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890BC366BB8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbhDUNFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240663AbhDUNEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:04:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E269861456;
        Wed, 21 Apr 2021 13:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010251;
        bh=x0vsa/qDfa6fZnfroSb5vwjMRZa5ySo4U3GVJN0UZfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQ/1leI6S8PgsF2pZO4UhFWtNcvfM9fEGdavdRy8hNRL202BzHz/zPde+ubV2UElp
         0fIDd32mrtYTiM9eLIo5PhI9h3AR9dctS8kJQWUGl7DV9xc3G4i/h9cXz6a34eRiQv
         Oc3sBp5uar6uKgih54N26nFoTkznh9hrSBotwcf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 066/190] Revert "bpf: Remove unnecessary assertion on fp_old"
Date:   Wed, 21 Apr 2021 14:59:01 +0200
Message-Id: <20210421130105.1226686-67-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 5bf2fc1f9c88397b125d5ec5f65b1ed9300ba59d.

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
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: https
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 75244ecb2389..da29211ea5d8 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -230,6 +230,8 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 	struct bpf_prog *fp;
 	u32 pages;
 
+	BUG_ON(fp_old == NULL);
+
 	size = round_up(size, PAGE_SIZE);
 	pages = size / PAGE_SIZE;
 	if (pages <= fp_old->pages)
-- 
2.31.1

