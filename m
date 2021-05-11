Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F72379BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhEKAkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhEKAkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:40:06 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA24FC061761
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:39:00 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id y32so14516175pga.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ThM+lz6jsS3ZEXtls72L3mRvVuWcXx5lk52kSqNPD+U=;
        b=FsZhbGYDLA4AtcPJIUv0lMZ9F5iOzaGWOwHt+KIa5S/W9Ry2hc51VQV8F6MA5K3oRD
         q28S2rMN5Ug6tTlk+liOkObCj1VhEZfWAjXrfaqNNJ/h1cpD0pN849vxsUJqySq79/lF
         4rAx4Aqco7ZUHbTcyRRL+uSv6D1GCkdGl+Bcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThM+lz6jsS3ZEXtls72L3mRvVuWcXx5lk52kSqNPD+U=;
        b=Y19QbfZCgTw90JrsWvlQW9tSOJabrVGxt018ZySa24jNEFQDGJ6DbQSEhshhl7uPNV
         ohzMFBITZoY6pGt9BOQtZY8yLiqGTxefl1VgPhlN+PV4RaHIaTX+o99hpOTrWCiEsBa8
         Jau90Fx0PfGZdadK0fbylQQjlpN/rICjLNl4bFARSDe7xQSIbu3M48drkH0mQQTAMmoL
         Q4WLTqkybR4WTN4rY+y9Hkc/XDE2JiCqo23t/uDL4zni9bn7URlf/F5f+6Zim6LLq5nK
         BqHLgqo0R2ypCC2zDoWVPXxTXVpO0y48uQCv5Ib1TXeMjDmDngCRX2qr+CVpsA7t59Ig
         XhSQ==
X-Gm-Message-State: AOAM532P0u9DEaKWOhe1tx/lCoIkpyqcpzLaOG5fw/NUcr7xNs2pmv+0
        mAAmm/aRTUkQrDswU86cowr2xg==
X-Google-Smtp-Source: ABdhPJwxtSZwFWRRTxXJoxJZ01mYXLEQk7vzAsrUH3//RiP20FeL80yQwVlKCel8qSm7EFNuh9hsQA==
X-Received: by 2002:a62:ee09:0:b029:211:1113:2e7c with SMTP id e9-20020a62ee090000b029021111132e7cmr27472397pfi.49.1620693540445;
        Mon, 10 May 2021 17:39:00 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:6765:417e:19fc:9756])
        by smtp.gmail.com with ESMTPSA id d26sm12142539pfq.215.2021.05.10.17.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 17:39:00 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v6 10/13] scripts/decode_stacktrace.sh: Indicate 'auto' can be used for base path
Date:   Mon, 10 May 2021 17:38:42 -0700
Message-Id: <20210511003845.2429846-11-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210511003845.2429846-1-swboyd@chromium.org>
References: <20210511003845.2429846-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "auto" to the usage message so that it's a little clearer that you
can pass "auto" as the second argument. When passing "auto" the script
tries to find the base path automatically instead of requiring it be
passed on the commandline. Also use [<variable>] to indicate the
variable argument and that it is optional so that we can differentiate
from the literal "auto" that should be passed.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 scripts/decode_stacktrace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 20b5af1ebe5e..5fbad61fe490 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -5,7 +5,7 @@
 
 usage() {
 	echo "Usage:"
-	echo "	$0 -r <release> | <vmlinux> [base path] [modules path]"
+	echo "	$0 -r <release> | <vmlinux> [<base path>|auto] [<modules path>]"
 }
 
 if [[ $1 == "-r" ]] ; then
-- 
https://chromeos.dev

