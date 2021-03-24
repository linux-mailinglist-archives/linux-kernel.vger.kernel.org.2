Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FA2346F37
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbhCXCFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234730AbhCXCE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:04:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41996C0613D9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:58 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so1837219pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ThM+lz6jsS3ZEXtls72L3mRvVuWcXx5lk52kSqNPD+U=;
        b=cvMiBIdRc9V3ZoG5KZESNzQ1E4E+MkFuoy+2tS7PZMYd27CEKBUVG/05XJ4hjObnYB
         cZ3qcXhq4s7Do5BciXE1CUQPrlL9cvj5N85xZ6+J5EM2kIv/Dnd9gGsyW0Kqgaath2Tc
         KgjYu7hbLXv7HDfpQks4c2Se4lMFWmbxLWlh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThM+lz6jsS3ZEXtls72L3mRvVuWcXx5lk52kSqNPD+U=;
        b=mAH5PLQqQbj2HtLAlWkhFNcPhHUBjfC7KcmriqVlgXoGFZ84C9P7HNbo7rupUS9I7u
         kmr4Cl/cJDRamaHBISs6RPKXZRB1nvR5U6VWz9nrnL5PQdNUoM6nisTx+5wkp0owASiN
         Q8QuGKG3Uh5J+Cm34+0mMtVMjpOcbDgpwv4ED+iQ3S+6eJ3VE+smWbSHvlXPrjOdKx3J
         xpLRxtzjfXMwba6UZ/QVedtHDyIc+VcWSzQx5C3tfhEpNX3bkdFR+yeHkGdjqAiLaWPE
         RBVdaomEP8SgPqa07NK7yO3NN0RcvWBNXvD4TrfgJEBkhOSBVI5VasYskupqZtaKVxgz
         c+HA==
X-Gm-Message-State: AOAM5323oaqq1GXA67yHgU4Qh5htWVosR6HCCkiNi4NvcXJAA/iFrV9V
        LFMqufflGxJoyVj9pHsjj9bh6A==
X-Google-Smtp-Source: ABdhPJwFHlVdYrW5wT0zhzkYsTVDFk1G2Tl4W8wxKK0q19Hkbt5AjVW+iodzzxnqK6Pj/4qS5EdXIw==
X-Received: by 2002:a17:902:a412:b029:e5:d7dd:9e41 with SMTP id p18-20020a170902a412b02900e5d7dd9e41mr1322291plq.78.1616551497887;
        Tue, 23 Mar 2021 19:04:57 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id b3sm389441pjg.41.2021.03.23.19.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:04:57 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 09/12] scripts/decode_stacktrace.sh: Indicate 'auto' can be used for base path
Date:   Tue, 23 Mar 2021 19:04:40 -0700
Message-Id: <20210324020443.1815557-10-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324020443.1815557-1-swboyd@chromium.org>
References: <20210324020443.1815557-1-swboyd@chromium.org>
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

