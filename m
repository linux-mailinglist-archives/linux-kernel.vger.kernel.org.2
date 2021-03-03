Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7AA32C00D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580762AbhCCSez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:34:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233934AbhCCRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1YEVSMla8UOmgBC4LmzAJMeE/UB0SCvN1vHTnN1GioY=;
        b=PtOIQBFBcQ8bp3oWN8BEj8aCa24b2apPDMHML/WO8yFtGIZRpoLUvDvuA3pFmI4jGLtr1H
        OKOSwyfKt9luKNGdvqENvG+kqfk2CbbWtpRcUW0dC7ZNpY6MrJ9pSgq+1QZxqnXGLrA8My
        i4Hvsw6Hmnjutkfk4kFwPedxIL3mUdo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-EyGpuE6yPCyerUU-ne1lEw-1; Wed, 03 Mar 2021 12:09:42 -0500
X-MC-Unique: EyGpuE6yPCyerUU-ne1lEw-1
Received: by mail-wr1-f72.google.com with SMTP id e29so12992541wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:09:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1YEVSMla8UOmgBC4LmzAJMeE/UB0SCvN1vHTnN1GioY=;
        b=ljB3yWjPGIDV4TMBFlkdqSq0/yjkQijRxnqVgyvbVyvXlvOh4zzzaBLZ/p6bjIryBb
         LABXHPuqT1jzhmmHcvJsBO/FdfR+8tMmW9b6w7yt5C1XN/WpTinFMeupxK9fLfPmWBjT
         YM1fP5PabcG01EzqFwwjzpaX9Jamt1OBA1llYiQkJI4jA7eJlW43VkxR30bVTK1ZbUuT
         1XKMtR77qOEAEiYZIlJgnpZKwMDbe3B/WAnrt8YHNU4j0QtNvv+g5RZt3DkRRe/TN2H9
         NrSoMOA/tgCqA9Kws5lG1L/QXf1klJ7Z5WMAXyTcHy9c1Jog1XdGzlgxi+TesBSi916w
         dMjg==
X-Gm-Message-State: AOAM530pMZXbMqonCMFPmbJKyH+3Ehw9sUEz70tgXrzv04DUvZ9fN37b
        Oouv58LePSwBFoxPZyA2fDELVxAV1Yu/A7J9Akvke2I/O7V7ThVgQJRjD2OhOyLBOhk0BMQ5fJ/
        x+6T6e4yCn8Soif9/Kt5u/aL4pdYAhotlKFg0Hjq4DVtAUYStbDU5WYfdlWK1BZeOp+ySkDU5yM
        L5
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr1684wmi.117.1614791381012;
        Wed, 03 Mar 2021 09:09:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwIImTFgzOt8MQZOzCEwSA6Uw7WaOSsf2aCOzgesHaqq1/c7Ru6SY01IxtrxnwNpeTXV0PpXQ==
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr1592wmi.117.1614791379697;
        Wed, 03 Mar 2021 09:09:39 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id r7sm33066226wre.25.2021.03.03.09.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:09:39 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 03/13] tools: bug: Remove duplicate definition
Date:   Wed,  3 Mar 2021 18:09:22 +0100
Message-Id: <20210303170932.1838634-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170932.1838634-1-jthierry@redhat.com>
References: <20210303170932.1838634-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under tools, bug.h only defines BUILD_BUG_ON_ZERO() which is already
defined in build_bug.h. This prevents a file to include both headers at
the same time.

Have bug.h include build_bug.h instead.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/include/linux/bug.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/include/linux/bug.h b/tools/include/linux/bug.h
index 85f80258a15f..548be7cffa8e 100644
--- a/tools/include/linux/bug.h
+++ b/tools/include/linux/bug.h
@@ -2,10 +2,6 @@
 #ifndef _TOOLS_PERF_LINUX_BUG_H
 #define _TOOLS_PERF_LINUX_BUG_H
 
-/* Force a compilation error if condition is true, but also produce a
-   result (of value 0 and type size_t), so the expression can be used
-   e.g. in a structure initializer (or where-ever else comma expressions
-   aren't permitted). */
-#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
+#include <linux/build_bug.h>
 
 #endif	/* _TOOLS_PERF_LINUX_BUG_H */
-- 
2.25.4

