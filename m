Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC4032F71C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 01:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhCFAGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 19:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhCFAGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 19:06:03 -0500
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC71BC06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 16:06:02 -0800 (PST)
Received: by mail-lf1-x14a.google.com with SMTP id m16so1386116lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 16:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=fj2q1zjTS7x5AWIG0dea58z8gWp6VMPPrsYTyOmyMJM=;
        b=UM8dPWueQ2rP8EQo22LdiFyFIdNcCm2LrTSYmDM5rdipYyWdvPnCGXqzzc47WHtSsy
         hQkeEeT7Ssu8oPpE1PgktnWl0RccYYOCRoDcrhs4G3kfHceJK9WbSVmkpsfAXbwrLYO5
         o1Laczp1zvUGvOkZpzzwBWHaUjHUJaJU3YWWeO3Oovo1hrmE1WKm3qhhSz78IQK5ORPQ
         QD+UAm0N7kAwsHGr9UDhMzI99Kq4GktDYPgKl5HXdujIwjSqUEzKyeVK+AYmD6YAc2QC
         GnTl1m7b2eHmW9gNVCAN1UR0DDmMSG3P7jD+nztIZfiYhmCvpTXyRu6g+FyTNRmi/0cm
         jjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=fj2q1zjTS7x5AWIG0dea58z8gWp6VMPPrsYTyOmyMJM=;
        b=XZ9AjzcxWxfngGHUSSjkHxP4yPVT09lyijYcmXd3akjOE6Pxs3oV6qkkwMVc9e7cQ6
         A9npa7HA7sn5frYzsioej6SU9gaZTwmOAyZs2XGrE8iRWSbBQ3tSoZ1QB8a1gq3/UAHT
         c2ceT/FNMcl1btD8W6UCsEHu1B7+e1tyIvXZMnodDuhxD9dE650754cJyHLxxtNpD7bt
         MP3eexnYoCEp91gcIEfC3SKZMWxKLhyiSoCO2pYv9K4YAuXqT9hbKsqNFGEgDzo106ZV
         cAY0ryvpSpFO6O46VmM9N6lH6If7TDiRQWERpQrrcVXvMgL5HUx6BlLxcrWPPc4YnXug
         4joA==
X-Gm-Message-State: AOAM532puUaLksb+v44HAarlS79BdM3bPyA6Mc7ReZhru5jZwcJzvhVw
        96ICDHNxnvtarFiwMRaK0CjV+mAgTGlk4oOQ
X-Google-Smtp-Source: ABdhPJwSPDStaX/1ocLrHIISD3Qbk8FBkFPpRGzbZcmX+3ex2F1wrfrqzwIzWVswDnjpK5pWJshVddfpd1SJiy9a
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:953b:d7cf:2b01:f178])
 (user=andreyknvl job=sendgmr) by 2002:a2e:8e86:: with SMTP id
 z6mr833578ljk.27.1614989161291; Fri, 05 Mar 2021 16:06:01 -0800 (PST)
Date:   Sat,  6 Mar 2021 01:05:57 +0100
Message-Id: <b6cd96a70f8faf58a1013ae063357d84db8d38d6.1614989145.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 1/2] kasan: initialize shadow to TAG_INVALID for SW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, KASAN_SW_TAGS uses 0xFF as the default tag value for
unallocated memory. The underlying idea is that since that memory
hasn't been allocated yet, it's only supposed to be dereferenced
through a pointer with the native 0xFF tag.

While this is a good idea in terms on consistency, practically it
doesn't bring any benefit. Since the 0xFF pointer tag is a match-all
tag, it doesn't matter what tag the accessed memory has. No accesses
through 0xFF-tagged pointers are considered buggy by KASAN.

This patch changes the default tag value for unallocated memory to 0xFE,
which is the tag KASAN uses for inaccessible memory. This doesn't affect
accesses through 0xFF-tagged pointer to this memory, buut this allows
KASAN to detect wild and large out-of-bounds invalid memory accesses
through otherwise-tagged pointers.

This is a prepatory patch for the next one, which changes the tag-based
KASAN modes to not poison the boot memory.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index b91732bd05d7..1d89b8175027 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -30,7 +30,8 @@ struct kunit_kasan_expectation {
 /* Software KASAN implementations use shadow memory. */
 
 #ifdef CONFIG_KASAN_SW_TAGS
-#define KASAN_SHADOW_INIT 0xFF
+/* This matches KASAN_TAG_INVALID. */
+#define KASAN_SHADOW_INIT 0xFE
 #else
 #define KASAN_SHADOW_INIT 0
 #endif
-- 
2.30.1.766.gb4fecdf3b7-goog

