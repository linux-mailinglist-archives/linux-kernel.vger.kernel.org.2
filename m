Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D96D366BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbhDUNI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240759AbhDUNGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:06:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E11761457;
        Wed, 21 Apr 2021 13:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010342;
        bh=juUxxHyTJNXY+DhWA+mtTWofbBqB/c0g4+Ki/KsCe38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAXjs9Sk9BPSZnVBD30gz9H01sud8IxcsrLofdFT7IwwO7iwzuJeT1Zx1mijzT8aE
         adS6XWX1WPWtIxr+fOxUWccFKqNUvXznhoEm9Q8zfhCaCFBC/p9L8wus6U0sKZzSt7
         R/Grm8+iNaoQ/3UiX9DZHKXXVa8nSCQp5aKWJ5DQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 100/190] Revert "staging: greybus: audio_manager: fix a missing check of ida_simple_get"
Date:   Wed, 21 Apr 2021 14:59:35 +0200
Message-Id: <20210421130105.1226686-101-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b5af36e3e5aa074605a4d90a89dd8f714b30909b.

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
Cc: Vaibhav Agarwal <vaibhav.sr@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/greybus/audio_manager.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/greybus/audio_manager.c b/drivers/staging/greybus/audio_manager.c
index 9a3f7c034ab4..7c7ca671876d 100644
--- a/drivers/staging/greybus/audio_manager.c
+++ b/drivers/staging/greybus/audio_manager.c
@@ -45,9 +45,6 @@ int gb_audio_manager_add(struct gb_audio_manager_module_descriptor *desc)
 	int err;
 
 	id = ida_simple_get(&module_id, 0, 0, GFP_KERNEL);
-	if (id < 0)
-		return id;
-
 	err = gb_audio_manager_module_create(&module, manager_kset,
 					     id, desc);
 	if (err) {
-- 
2.31.1

