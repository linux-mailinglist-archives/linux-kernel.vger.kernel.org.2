Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F7E3540F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhDEJtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 05:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240524AbhDEJtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 05:49:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D25661359;
        Mon,  5 Apr 2021 09:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617616140;
        bh=aEJQX3Prc+mmN1VZ61GJFoZWPNIy4rZJOUL2CXjAc90=;
        h=From:To:Cc:Subject:Date:From;
        b=NZQDnxyNey6R2wbMAtrMT96O5vlqun1adLgtC/XFav1DVx5NZ3HnLOJt8ml8g2IBb
         JjAENU7V0h4B3aW+xua0Tlu89t0clYEiUJh1YGH/71TcmZ+U1Tm+kPWRCDvz8gvRlN
         rOgPz1dKVrDhcFDNA+UXYV9UXl0EVbxAOzlnr1cU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzbot+92340f7b2b4789907fdb@syzkaller.appspotmail.com,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] kobject_uevent: remove warning in init_uevent_argv()
Date:   Mon,  5 Apr 2021 11:48:52 +0200
Message-Id: <20210405094852.1348499-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot can trigger the WARN() in init_uevent_argv() which isn't the
nicest as the code does properly recover and handle the error.  So
change the WARN() call to pr_warn() and provide some more information on
what the buffer size that was needed.

Link: https://lore.kernel.org/r/20201107082206.GA19079@kroah.com
Reported-by: syzbot+92340f7b2b4789907fdb@syzkaller.appspotmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/kobject_uevent.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 7998affa45d4..c87d5b6a8a55 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -251,12 +251,13 @@ static int kobj_usermode_filter(struct kobject *kobj)
 
 static int init_uevent_argv(struct kobj_uevent_env *env, const char *subsystem)
 {
+	int buffer_size = sizeof(env->buf) - env->buflen;
 	int len;
 
-	len = strlcpy(&env->buf[env->buflen], subsystem,
-		      sizeof(env->buf) - env->buflen);
-	if (len >= (sizeof(env->buf) - env->buflen)) {
-		WARN(1, KERN_ERR "init_uevent_argv: buffer size too small\n");
+	len = strlcpy(&env->buf[env->buflen], subsystem, buffer_size);
+	if (len >= buffer_size) {
+		pr_warn("init_uevent_argv: buffer size of %d too small, needed %d\n",
+			buffer_size, len);
 		return -ENOMEM;
 	}
 
-- 
2.31.1

