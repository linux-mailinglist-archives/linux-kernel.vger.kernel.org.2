Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1403661C7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbhDTVv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbhDTVur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:50:47 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93A9C061344
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:14 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id b17so27730789pgh.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dgZpUIUAd3xYMT7c2NM1dQuY6ynSL0c9WkBRYEuhK/Y=;
        b=bnbyKtzUWTde4lIpMbKqYNLnck18dJqHsimZU7TzBrlTtWv2drGIWXpx9Le+/kiUpF
         AhhmXWaRc1KCy2CSCxBc27zxSHNyOvOrUtfia2rNFIh72k9y1gGYCCp2LmIvvnirb6do
         jkzj3mNkRjM72Qvc/wLzi6719DMZmqwfLs7sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dgZpUIUAd3xYMT7c2NM1dQuY6ynSL0c9WkBRYEuhK/Y=;
        b=WV1u90sQYrdyOEw+Oufd4gnuW7TItozYPyLvTugdC6J169RghEV6DS3GZMCVkS7792
         t8Hty4qMe0hOS4s/XCWjSgjs5rJ86AqzMQHqcVH8Pc6mIC8suT76xsTgfxcXvnfP3sPo
         +T7sBQoZLkwisRRvzOvJjWYQ6UW9hxQTzQS/VidXx12MuwAjvsM7vEEaFfNhCXVg5/db
         Oeeb/t0A2ocTl3cWJ+jQgEB75y8BS9rBNw69nRWzgQosjELTFhUZzABVSPt+zE3Qovrk
         KZkGhuQFkVovCiD00dopD3RFnHk3NdKKgTsgSuvt1crJnIa63hRg9qEPDHIbOcfPhuVe
         CEww==
X-Gm-Message-State: AOAM531+aVplc105IBTg7U52Xn6KoW/Qn8BIeIDJEwwgev5m8hkjcmfs
        3+gnTGpxkwSp7fJAsb5SEjOvCg==
X-Google-Smtp-Source: ABdhPJwITEFkpIgBtTvfg5dtAVberYgE0eBx1HEvVcCAL6H+jkpMKOm45UIEVnO5Xqq2J9apWgrE7w==
X-Received: by 2002:aa7:824e:0:b029:20a:3a1:eeda with SMTP id e14-20020aa7824e0000b029020a03a1eedamr26336794pfn.71.1618955414436;
        Tue, 20 Apr 2021 14:50:14 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:bf8b:4b8b:2315:3719])
        by smtp.gmail.com with ESMTPSA id c21sm31481pfo.91.2021.04.20.14.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 14:50:14 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v5 12/13] buildid: Fix kernel-doc notation
Date:   Tue, 20 Apr 2021 14:50:02 -0700
Message-Id: <20210420215003.3510247-13-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210420215003.3510247-1-swboyd@chromium.org>
References: <20210420215003.3510247-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel doc should use "Return:" instead of "Returns" to properly reflect
the return values.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 lib/buildid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index a7edab4914e6..dfc62625cae4 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -121,7 +121,7 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
  * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
  * @size:     returns actual build id size in case of success
  *
- * Returns 0 on success, otherwise error (< 0).
+ * Return: 0 on success, -EINVAL otherwise
  */
 int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size)
-- 
https://chromeos.dev

