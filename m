Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0D53661C5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhDTVvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbhDTVup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:50:45 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D17CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y1so4780715plg.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ThM+lz6jsS3ZEXtls72L3mRvVuWcXx5lk52kSqNPD+U=;
        b=FhnZNw8N8fWqEYVZm/AVBrlcAGUTphgrm9PvL/4T5AFWSmmoOP41v373jHCB/eWjqn
         aEzf4iBeqfUac5cVngmWQ3fV48tqGViHIfy5Zf4T5AnkhKQm3wkixDcO4vjBnzk6ghNA
         twSVPoridN98UNPwWD51+NRnQD9mcj3ltbqVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThM+lz6jsS3ZEXtls72L3mRvVuWcXx5lk52kSqNPD+U=;
        b=UyhClu7jUhHcGW533MUF11vFl/wiG7D9BeXJy1EpJpv+Cia2WgjwnhPi2i7dPvhmy6
         AIq5ehLeYzsjOkemSZN9yBZ8XhNTBnN4YRoUuZZHWITi2lZVco49eK83jqqD8rcimosq
         XDPo8sIFq2pl81PDSAnbT2dAYsoCsjfIHHxuy0wos4UVf2IHTSisjLAoyCrLtCzwnuwW
         +TyEqMbXB1ty0M/pQtYe5bxw1v4gA8TTxf+c5w2UEYDHj2ZPFdMNiNwwins8ULu1uVe2
         L0q0mkoC8OygTCsnCWSRoipgZBNJJrTbsoAWgFvLDX5AZFoMXshbSK/D3Pep+ExAiX2S
         AODw==
X-Gm-Message-State: AOAM533RgrPorPrRHffjUXPXc05+AFkIrgY0tQZwwXTeCgTmdoePYEOc
        nK6tRCYkP+9bi3GAQrMx2jSEGQ==
X-Google-Smtp-Source: ABdhPJy8F9kCW2PGi5aTdvBidC7YrQbwO4Um4lENPoyvYLUtVoqCOzwo8MaMjs6BdNp/vHL4iGTI3g==
X-Received: by 2002:a17:902:ee8a:b029:eb:6d3:1431 with SMTP id a10-20020a170902ee8ab02900eb06d31431mr30874940pld.60.1618955413056;
        Tue, 20 Apr 2021 14:50:13 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:bf8b:4b8b:2315:3719])
        by smtp.gmail.com with ESMTPSA id c21sm31481pfo.91.2021.04.20.14.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 14:50:12 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v5 10/13] scripts/decode_stacktrace.sh: Indicate 'auto' can be used for base path
Date:   Tue, 20 Apr 2021 14:50:00 -0700
Message-Id: <20210420215003.3510247-11-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210420215003.3510247-1-swboyd@chromium.org>
References: <20210420215003.3510247-1-swboyd@chromium.org>
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

