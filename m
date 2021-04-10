Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FA335AA13
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbhDJBxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbhDJBxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:53:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FFDC061764
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:53:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t23so3743689pjy.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 18:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8DA0cKUORF4YTDoj9+CZV5OhH1j4HxHSI4vRtNS4Gb0=;
        b=M7956K+bD1wly7ULMBt4fN/gppFFdFlz+FeH00b30RPMOBva0uM+tpirXMgb6BLiia
         QaX3bcrRu5B+M1/IkSLfP++QpKtrNCtNOFGGMFTFvL0YzFy/omO7ix0e4ZKunzh9Q9j1
         TmOsqfadgBIWRxowPj88xM9ix2JpB4sFqxk3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DA0cKUORF4YTDoj9+CZV5OhH1j4HxHSI4vRtNS4Gb0=;
        b=na8bOJyoTBavrOPNWZAbW3KSGR9qh9yDah6mmmqol2ult/4T7uq3YwKo7W3w/LjWJ+
         R5ox2qoeBx7qf4gzB+URBP2eW6VLWQ5X6yitfc8eKdR1kK2jHRy4rFnV6dn6cl2V23+3
         gyUx6Xl4TfrWtF4dtAJvLGjvkbwFJJnxM/d72fv9/ffWdO6p3P+GWMMDR3hookUpjlKP
         SwD2R7RkHKuPuYeal1jTcRbucXvj5nXa+Q/v2cSVa9c4/7pDv2zqXw5D4plLcf4v5Odh
         0LnM0xJar2NBBQ7x2HuQ5I7ad1Eiv2spVG+uCEzfRlBG8tV0YkXqzdlsNjF0IKt39WTB
         gBVw==
X-Gm-Message-State: AOAM531Rf8fdAoULpbNUZpLiFA+tb+G/holVDcJGxPBvpSwQr8fz9hsG
        9jadI/Lmra3w6eb1/CqClz/bVw==
X-Google-Smtp-Source: ABdhPJys09LEkn7emoJ2aMQVdcWjoAsoIxsyDI25vXHJ0MsUzwyIDbakCetGnJrrRG+qgHNJBlZc0w==
X-Received: by 2002:a17:90a:31c1:: with SMTP id j1mr17113903pjf.4.1618019591741;
        Fri, 09 Apr 2021 18:53:11 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5141:7881:7013:743b])
        by smtp.gmail.com with ESMTPSA id n23sm3837962pgl.49.2021.04.09.18.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:53:11 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v4 12/13] buildid: Fix kernel-doc notation
Date:   Fri,  9 Apr 2021 18:52:59 -0700
Message-Id: <20210410015300.3764485-13-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210410015300.3764485-1-swboyd@chromium.org>
References: <20210410015300.3764485-1-swboyd@chromium.org>
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
index df42282b36ff..ce88133f8dc4 100644
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

