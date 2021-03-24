Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C02346F39
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhCXCFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbhCXCFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:05:00 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610D1C0613D9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:05:00 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b184so16221193pfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5KE1H3m6CiaD+fr+ulKPZpmzMCjz8PIDz+KZf1Q0tKo=;
        b=A4ZVyjvSzPHBM+aZ0/LCak7TErZ4iA/yTR+EaYpnmM3z7kZgaV0h+qygTE2R7dx2f7
         ernrXF88xmVUdmlnwECkKVyUhQ3L+PyGOTZEi1XrVgsh421AeZMPuyh8xtyPYfb7kgXd
         B4UgV8ufyii4lZMN8vfXoU8dgWUVKsnLWS4UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5KE1H3m6CiaD+fr+ulKPZpmzMCjz8PIDz+KZf1Q0tKo=;
        b=Eesr/tWYxbHaoVq6vRtH7fko7Nf2nj6xVYUQpt3Z/fh8PZWGL7WgTyu+8SSvSvL8KL
         pKYQYykBgMfj2for28ep82SIhhO7CZbkoY/rdNx4iT5EVu1rLTHkCTuauRM/VznskWKR
         pkIhA0VcynrTvEjBPpa0jnBdZD4G/ObBr/lyipLv9+7KHTjWF6QZIwWIDw0OL5LRxXCM
         q2q5spwbfjm1y0CxyB+dOWu1+KH9vYYlnFuVVV7Y7ybNJKSj6gFuRJyJNqT+9/sdyom7
         9NJEdTpfqtIikeHs1z46XBO9hMLBuiDXgUiIROUgaMuf+UkAJhnL3+5r8aajkTBPgoo+
         yw+g==
X-Gm-Message-State: AOAM533UAvwI/dCVOR0SnLjqxwLADgBrbeI3T/DvQSZYm2TXghiVoX/c
        vLbrtMffMQAdnCey8eQyeP+8W997IFlVpQ==
X-Google-Smtp-Source: ABdhPJyE6AmVvlJtbJUuDVJpk2wLj0+G8dv9VP+u1WuJB45HzccIepwciqCMrE9ZNxU6i4Pk23Kq4w==
X-Received: by 2002:a63:c646:: with SMTP id x6mr1053097pgg.126.1616551499938;
        Tue, 23 Mar 2021 19:04:59 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id b3sm389441pjg.41.2021.03.23.19.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:04:59 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v2 11/12] buildid: Fix kernel-doc notation
Date:   Tue, 23 Mar 2021 19:04:42 -0700
Message-Id: <20210324020443.1815557-12-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324020443.1815557-1-swboyd@chromium.org>
References: <20210324020443.1815557-1-swboyd@chromium.org>
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
index 1a35b28a85d8..f797e4439bda 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -120,7 +120,7 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
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

