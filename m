Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8224734F72A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhCaDFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbhCaDFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:05:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2540FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so429371pjq.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ThM+lz6jsS3ZEXtls72L3mRvVuWcXx5lk52kSqNPD+U=;
        b=QjOPVRXbU1NeaI1ydjV1Zu0lMCPHyZuTMG1yE27JXFT/MR9ExFfIlZxQiDxdmx2uP+
         UpiB3c+LT+Hoc8zBp4xaew+lRnqoi+SEDnCvVhjGDTWi0m+YX5UbiW2RwUO7h2IdcUR4
         RKEsJiYnJhSu1ePpga6Zhsuj1cC4d0qS9XxCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThM+lz6jsS3ZEXtls72L3mRvVuWcXx5lk52kSqNPD+U=;
        b=eydjhF1CE5aHELtPwtONULdzufdQ6r39Huua+vWKGYb8km5JrrfbqYYdneuM87Ly6F
         U3DWgGMV5NkKGyybRqoR96km94cVpTsyNCYyjjO1szqFkHAkTEFi9tJdkUup46hQf5pq
         l9e6nU5qQJ0GTMWthQRV+KGjqt2gp+UQFqq8l0BXtrrgiGQGfUf7IArIO1hP6dkaeVxB
         ismK8UBbD538G0atyuRh1aynKg13YNI+umsed45H8mnWuT+v1pAavGy3wqJVS5wjLSAo
         jIl3Q7YxrviPy2Oi+7vXzdRa1rPtnpU9y0dw0dk1ZGYfAc0BaBO3m1fwhmfmzu9+4pVm
         d12w==
X-Gm-Message-State: AOAM5337EyK0CvvxcHWKON6jBmXAQnrkEYJW6mHCsr6FoJMUfLg+L67U
        xUPE4YD3l9IKiQLTOrQkRoED9w==
X-Google-Smtp-Source: ABdhPJw2iQPh9Sr09lq6dADCjHkWP8JmgE9scLVcGEA+hh23QxzgqEEoM9jQx1BXPH/w36ln9Fv/hg==
X-Received: by 2002:a17:902:b289:b029:e4:bc38:a7 with SMTP id u9-20020a170902b289b02900e4bc3800a7mr1286922plr.50.1617159934757;
        Tue, 30 Mar 2021 20:05:34 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:c8c2:b814:df0f:253f])
        by smtp.gmail.com with ESMTPSA id c6sm389024pfj.99.2021.03.30.20.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 20:05:34 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v3 09/12] scripts/decode_stacktrace.sh: Indicate 'auto' can be used for base path
Date:   Tue, 30 Mar 2021 20:05:17 -0700
Message-Id: <20210331030520.3816265-10-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210331030520.3816265-1-swboyd@chromium.org>
References: <20210331030520.3816265-1-swboyd@chromium.org>
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

