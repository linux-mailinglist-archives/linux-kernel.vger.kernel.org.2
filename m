Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3865937FC34
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 19:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhEMRQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 13:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhEMRQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 13:16:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719B8C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 10:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=GYMhmXsmdrjlnWGnL6+nxVrgu8lGFEA0H37PhG86aQ8=; b=mqBXwPBQla6ml+BrpmXll5BPBb
        hGWRqaOvtw0wlMp8Z1oUwrQq+b9dqQJh03s9QFITWnYm+vDnAulcfCTVIPtcEgz9Rype9eM8mPeex
        KextsbC5cMovd2AoiVEC1yYQngVsI5V8otPiSqEI86QrpHLmnSeJU+3XR/whOqdaX2lxhKTRsmlPq
        AmnFjkGOJZtpEgyzULWjfoUt0VC1M0P/9kfg8Pg9yruuyWu4ZlNvnmfrKla+/kvrQxAg7HQrO2oJ0
        wxpaT9GcGRC5uPJLBe07vYYgzvRU3GOHspO7QhiqigLeaDFVRESjrtrIAewsRWbcKELbgA5thBoqE
        mVren8Dw==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhEvW-00BPTy-Nu; Thu, 13 May 2021 17:15:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH -next] buildid: fix build when CONFIG_MODULES is not set
Date:   Thu, 13 May 2021 10:15:10 -0700
Message-Id: <20210513171510.20328-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Omit the static_assert() when CONFIG_MODULES is not set/enabled.
Fixes these build errors:

../kernel/kallsyms.c: In function ‘__sprint_symbol’:
../include/linux/kernel.h:53:43: error: dereferencing pointer to incomplete type ‘struct module’
 #define typeof_member(T, m) typeof(((T*)0)->m)
                                           ^
../include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(typeof_member(struct module, build_id)) == 20"
 #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                         ^
../kernel/kallsyms.c:454:4: note: in expansion of macro ‘static_assert’
    static_assert(sizeof(typeof_member(struct module, build_id)) == 20);
    ^~~~~~~~~~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/kallsyms.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20210513.orig/kernel/kallsyms.c
+++ linux-next-20210513/kernel/kallsyms.c
@@ -451,7 +451,9 @@ static int __sprint_symbol(char *buffer,
 #if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
 		if (add_buildid && buildid) {
 			/* build ID should match length of sprintf */
+#if IS_ENABLED(CONFIG_MODULES)
 			static_assert(sizeof(typeof_member(struct module, build_id)) == 20);
+#endif
 			len += sprintf(buffer + len, " %20phN", buildid);
 		}
 #endif
