Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A1035AA11
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhDJBxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbhDJBxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:53:24 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B110DC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:53:10 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f29so5191398pgm.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 18:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ThM+lz6jsS3ZEXtls72L3mRvVuWcXx5lk52kSqNPD+U=;
        b=eUl7MAav3tveZ/WsrNPPX7gnGLC99c+L7rKGIKbuaTyidhXVBsM/r3lgnj65b2Sg5+
         aqvQ4yt7//JERwwglhhjHR5JEO7/gojK4bXcefKZmq3F4Hhma7eXgLxSA/4wECSYEBIt
         7iYZKKGsYB+lvpaDDWtc8bk6sGVeu/3naSpyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThM+lz6jsS3ZEXtls72L3mRvVuWcXx5lk52kSqNPD+U=;
        b=g77+2HsZdxLQHJQGNEekIWIfK+dlgjvn898pepf/HjgY6gMBCWOlaL/WzzbYm9Oud7
         ALJyeST5QGgsQFdOqufiV6nKouKFTHIck0SvP32isLw6uhuwSVBjxAhuSrcoerv46Kjr
         2b5/DUL9TOlNVhACXRprYGVL4jSqtWSDZTS6hhyYvbh/nfDqBXFvZibpeaPpOcDOjrRF
         94VMN8FLEoVuBRuzz3XerV2gHFlGFmNP9MYRj7x5HR2+WHcmtVamXF/H65BsSTMUZ/OS
         u6WTPef77JdMINlw/FPiRUCchPJwhwu37IfIsXsLSrcH6yCGzebqjN5CS/d2jHRmKwsz
         0+5A==
X-Gm-Message-State: AOAM533iINiLbiT4J02piPIJe3FysKVIkWJOx+OctrHk9x6k38walczt
        +bnpdeIXN8+Vtv7JNVs6ac9k5g==
X-Google-Smtp-Source: ABdhPJzurI2EwYK7JUkdyTKcrxgN2FOjAIeU1Z+gauv5xBRgkpPJW7WtLdjPWuE5oXun5M+oPOSO8g==
X-Received: by 2002:a63:da04:: with SMTP id c4mr15751589pgh.144.1618019590356;
        Fri, 09 Apr 2021 18:53:10 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5141:7881:7013:743b])
        by smtp.gmail.com with ESMTPSA id n23sm3837962pgl.49.2021.04.09.18.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:53:10 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 10/13] scripts/decode_stacktrace.sh: Indicate 'auto' can be used for base path
Date:   Fri,  9 Apr 2021 18:52:57 -0700
Message-Id: <20210410015300.3764485-11-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210410015300.3764485-1-swboyd@chromium.org>
References: <20210410015300.3764485-1-swboyd@chromium.org>
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

