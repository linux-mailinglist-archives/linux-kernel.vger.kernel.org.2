Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F3044CE45
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 01:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhKKAYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 19:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbhKKAYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 19:24:18 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D32C06120A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:21:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s189-20020a252cc6000000b005c1f206d91eso6630571ybs.14
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=w9hyMELVK5RajRlcXxABefy1CjWCBZ8xUiCsBp5TLFg=;
        b=JontxKB2TOFbiUG+TGdXP7SsS4dJ8hBxMYkiTFUuUW8g98126ot7Lp23TVDK7XOTWa
         P42//RXgGhR6rWPSHbqOP12RndI5OxEdUZ9gX1ZDa3VhwRkaA04gyUQrNOCaIzLjB7Cv
         luKbL2pbIn1zx46fKYn/BBzqBWvtBTfV+3D/fbUoaJtB0ku6JhSDdi4utwB7oqiopgvE
         QvB/WqPNcTo7qAiddO22uWkXVCJKUi6e28GEJXsLIL3PJcntml3cscsK4mfXtrcEnGmH
         8Cd/9VImsX+rVcqG7QgH7yatP/4ysykidHS3a7WPoyguUaXUkl39lBLhy43d/CAla6qn
         OiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w9hyMELVK5RajRlcXxABefy1CjWCBZ8xUiCsBp5TLFg=;
        b=645SKjOw0vxAYCmxbpKG+jQ/eJek/hIHWMpgH3YNjXe9uLpvy0jegmH5574kzis9Ai
         rPRiGt7Ueu7+9b4YiN2/lKxB5er/WFjFX5V4LOna+Av3h3b3g+jdSPmgcVyBpBonBLKw
         5eFpIPwwC6XIrR31YYK2eo2s0tpxjBQPB/LezCRIBFeEEZLtoPePFRs13gZiWvZwvQjV
         Jj2jZOeMXFhCVr5fClM3Iy94YGbqmjrRkn8TW17aXhGEKji6gDsoBqysaCrXz1+2o3HX
         2HqNKroVR0JeC+aOtKn6cQsE7Rs04N7tGb84lmib5WMsd1Zjo8AdgwU/xAUOrOEpH7iV
         4v2w==
X-Gm-Message-State: AOAM53374MpMYcCSpyOGhhYO8+n029MiUbbaUfnD6M+XpYX5USc6SGIr
        I+ykIv2K3PzksFQYXJyEyjsdYX4ll9v+
X-Google-Smtp-Source: ABdhPJyRWNlcB5I5NgoHd/oqBAvfM+AnMXvrzetTEMclh1nrPe9pNyxTkSis+relvtDX0WgKCVirT56drYdk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9510:b6b5:241:e409])
 (user=irogers job=sendgmr) by 2002:a25:2c92:: with SMTP id
 s140mr3832807ybs.308.1636590089436; Wed, 10 Nov 2021 16:21:29 -0800 (PST)
Date:   Wed, 10 Nov 2021 16:21:08 -0800
In-Reply-To: <20211111002109.194172-1-irogers@google.com>
Message-Id: <20211111002109.194172-8-irogers@google.com>
Mime-Version: 1.0
References: <20211111002109.194172-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v2 7/8] perf expr: Move ID handling to its own function
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Song Liu <song@kernel.org>, Wan Jiabing <wanjiabing@vivo.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will facilitate sharing in a follow-on change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 60 ++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index ba6c6dbf30c8..d90addf9b937 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -3,6 +3,7 @@
 #define YYDEBUG 1
 #include <assert.h>
 #include <math.h>
+#include <stdlib.h>
 #include "util/debug.h"
 #define IN_EXPR_Y 1
 #include "expr.h"
@@ -82,6 +83,38 @@ static struct ids union_expr(struct ids ids1, struct ids ids2)
 	return result;
 }
 
+static struct ids handle_id(struct expr_parse_ctx *ctx, char *id,
+			    bool compute_ids)
+{
+	struct ids result;
+	if (!compute_ids) {
+		/*
+		 * Compute the event's value from ID. If the ID isn't known then
+		 * it isn't used to compute the formula so set to NAN.
+		 */
+		struct expr_id_data *data;
+
+		result.val = NAN;
+		if (expr__resolve_id(ctx, id, &data) == 0)
+			result.val = expr_id_data__value(data);
+
+		result.ids = NULL;
+		free(id);
+	} else {
+		/*
+		 * Set the value to BOTTOM to show that any value is possible
+		 * when the event is computed. Create a set of just the ID.
+		 */
+		result.val = BOTTOM;
+		result.ids = ids__new();
+		if (!result.ids || ids__insert(result.ids, id)) {
+			pr_err("Error creating IDs for '%s'", id);
+			free(id);
+		}
+	}
+	return result;
+}
+
 /*
  * If we're not computing ids or $1 and $3 are constants, compute the new
  * constant value using OP. Its invariant that there are no ids.  If computing
@@ -167,32 +200,7 @@ expr: NUMBER
 	$$.val = $1;
 	$$.ids = NULL;
 }
-| ID
-{
-	if (!compute_ids) {
-		/*
-		 * Compute the event's value from ID. If the ID isn't known then
-		 * it isn't used to compute the formula so set to NAN.
-		 */
-		struct expr_id_data *data;
-
-		$$.val = NAN;
-		if (expr__resolve_id(ctx, $1, &data) == 0)
-			$$.val = expr_id_data__value(data);
-
-		$$.ids = NULL;
-		free($1);
-	} else {
-		/*
-		 * Set the value to BOTTOM to show that any value is possible
-		 * when the event is computed. Create a set of just the ID.
-		 */
-		$$.val = BOTTOM;
-		$$.ids = ids__new();
-		if (!$$.ids || ids__insert($$.ids, $1))
-			YYABORT;
-	}
-}
+| ID		{ $$ = handle_id(ctx, $1, compute_ids); }
 | expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
 | expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
 | expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
-- 
2.34.0.rc1.387.gb447b232ab-goog

