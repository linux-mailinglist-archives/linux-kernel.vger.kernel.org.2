Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25672398E62
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhFBPVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:21:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57900 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhFBPUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:20:15 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1D1E31FE5B;
        Wed,  2 Jun 2021 15:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622647112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0WscZvippHZ7wtqacl/8cbJxus8Tb6iR+2d606Ez+I=;
        b=AjIB/zRAm6E8Q3jksk9Zl0TM1cnwquIkkkkryqhL3cY9ukS39f67OIqJt6klh6DydjTGmh
        ncjAq4kXUjmpigucitrwhgyu7oKsj9vYvTJv6uujo96bg+MDrDofsl07crhSMk/YZXvJZW
        UtATUGLFWNM65uXeRpNg27afJ1BElSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622647112;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0WscZvippHZ7wtqacl/8cbJxus8Tb6iR+2d606Ez+I=;
        b=61fY9QyAbkQ3Pdy/7EWob7DcHhCt15L2dOYDENWmHOm78tByiXM7MF8GUkQN9aGvonYvdJ
        9vqobodT69PrwBBw==
Received: by imap.suse.de (Postfix, from userid 51)
        id 14CD711CD4; Wed,  2 Jun 2021 15:28:32 +0000 (UTC)
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 8E19711D83;
        Wed,  2 Jun 2021 10:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622629499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0WscZvippHZ7wtqacl/8cbJxus8Tb6iR+2d606Ez+I=;
        b=KUBpb5FdXAF8VdpuBB3HHHmDE2DrSP6i0jy+Ktmxg6yWnHeOnkrxx7EPnD6HIAMD+JbHYI
        d8bDu8StoUbZ7uiNuqm/vZH6Z7VKUR34Hgz3N+yR4qmuN7wxj3CQb1Gjk0mc9WZdRrawb7
        s7kTd18n6UIZpoTOOFWW4YlDZ/NuKOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622629499;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0WscZvippHZ7wtqacl/8cbJxus8Tb6iR+2d606Ez+I=;
        b=FnoqjmDNeudYK1Cj5ZWsOkHLOEn1RJChhf+DhlqkslEUtiXIkPqFS0JxUNLxV7jGFJnLs0
        9cZFFlr991+S/XDw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id sJf2H3tct2AsSwAALh3uQQ
        (envelope-from <lhenriques@suse.de>); Wed, 02 Jun 2021 10:24:59 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id a0152c8c;
        Wed, 2 Jun 2021 10:24:58 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.de>
Subject: [RFC PATCH] gcov: add basic gcov_info validation to gcov initialization
Date:   Wed,  2 Jun 2021 11:24:55 +0100
Message-Id: <20210602102455.11724-1-lhenriques@suse.de>
In-Reply-To: <YLZYwgs5hyzFZMlw@suse.de>
References: <YLZYwgs5hyzFZMlw@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a basic gcov_info struct validation helper to gcc to ensure we have
sane from the compiler.

Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
Hi!

I know this won't really validate the gcov_info struct, but it will at
least prevent kernel crashes in simple scenarios (such as the one I'm
seeing with gcc 9.3.1).

Cheers,
--
Luis

 kernel/gcov/gcc_4_7.c  | 8 ++++++++
 kernel/gcov/gcc_base.c | 5 +++++
 kernel/gcov/gcov.h     | 1 +
 3 files changed, 14 insertions(+)

diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
index 460c12b7dfea..028d9b94463d 100644
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -126,6 +126,14 @@ struct gcov_info *gcov_info_next(struct gcov_info *info)
 	return info->next;
 }
 
+bool gcov_info_is_valid(struct gcov_info *info)
+{
+	if (!info || !info->functions)
+		return false;
+
+	return true;
+}
+
 /**
  * gcov_info_link - link/add profiling data set to the list
  * @info: profiling data set
diff --git a/kernel/gcov/gcc_base.c b/kernel/gcov/gcc_base.c
index 3cf736b9f880..3e02a89f69b6 100644
--- a/kernel/gcov/gcc_base.c
+++ b/kernel/gcov/gcc_base.c
@@ -13,6 +13,11 @@ void __gcov_init(struct gcov_info *info)
 {
 	static unsigned int gcov_version;
 
+	if (!gcov_info_is_valid(info)) {
+		pr_err_once("Invalid gcov_info structure\n");
+		return;
+	}
+
 	mutex_lock(&gcov_lock);
 	if (gcov_version == 0) {
 		gcov_version = gcov_info_version(info);
diff --git a/kernel/gcov/gcov.h b/kernel/gcov/gcov.h
index 912b8ea01d33..4b3d924c2031 100644
--- a/kernel/gcov/gcov.h
+++ b/kernel/gcov/gcov.h
@@ -45,6 +45,7 @@ struct gcov_info;
 const char *gcov_info_filename(struct gcov_info *info);
 unsigned int gcov_info_version(struct gcov_info *info);
 struct gcov_info *gcov_info_next(struct gcov_info *info);
+bool gcov_info_is_valid(struct gcov_info *info);
 void gcov_info_link(struct gcov_info *info);
 void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info);
 bool gcov_info_within_module(struct gcov_info *info, struct module *mod);
