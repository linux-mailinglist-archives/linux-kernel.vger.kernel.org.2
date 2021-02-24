Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA1032401A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbhBXOil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbhBXNTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:19:14 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C52C061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:18:33 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id c16so2110644otp.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hz6BWGl7qa7h/rRrM/u0WCVRkmbtUFWO0Cr4wwVxXjY=;
        b=Wr+r6Gd6YiIT1RvRDMDejiuUXKyYgtB2MpoPj2b3REeXwS40+RrCjZUkwACLoxf4gT
         o/rd+peXH6NGy7ycvrW70vh8mQurSQ/vf+UMMP76QGzUIz1Pi2kWv8rzW8VtAg1Dee7L
         vyz3DndX9AuiBZgEYka2INaLRiEWG2EtSKVpz3YAkcynhPoftCHahRAyncfPSDHwOeW5
         XAiKbA7+VyGED1P7TFv1qLzL862DrDR1hbfdhloNhb6vcV52ldsNWrFtoggj9scep0pM
         5JVPjjg8yfHJZz0h8N+X2c8yyHEZro/iAVijjJOCxfyMKfsoXdiHmt41njDkst7xY33l
         dCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hz6BWGl7qa7h/rRrM/u0WCVRkmbtUFWO0Cr4wwVxXjY=;
        b=mmDcEc3aE1sDT3d9Sqaa6wAnQNX+FOMQInfxl9tWgfYSHkRtmigAd8K/5BAOncnzGt
         /jIDZOIWqo2gWN1FGTUwvbmHma9QaMFAX0nnvDFuDVQSsKP4W4khHLUB4nFH0i5KFd+y
         PKzJabrNivkiCq0lYpFyOVBiVT1tndfQlgXavpVbUyfRjfAVWv/4ojpz4CkFFvnF/QQ/
         NZh+2rAwWlwsosgiPHqeyONVLM9mtB8DG6e0tDhiqSpk2GWjksfDjfFUJ+jC70NmK+m9
         IOqA1PyDkT74DE2NchA81sox9rtcWgdy/fGhbVgj2rZFcC5w6ZhB8jTvisZn4z34Evzb
         kASw==
X-Gm-Message-State: AOAM531YVAz33ckrRWDSHPNVRa2wfL0+QK9Bg6Nfy81d1we9BA9RSUmd
        hQr/YGegY+fmzHgss9uCUgaEdA==
X-Google-Smtp-Source: ABdhPJz/cyH96Ef6ooNYUXuVy7sefqG5p5mJLZudZuy+rwZK1FGd75K1lFTGrg2zpDdPT0u1O1oQHw==
X-Received: by 2002:a9d:6958:: with SMTP id p24mr12470520oto.297.1614172712725;
        Wed, 24 Feb 2021 05:18:32 -0800 (PST)
Received: from winterfell.papolivre.org (winterfell.papolivre.org. [2600:3c00::f03c:91ff:fe69:3960])
        by smtp.gmail.com with ESMTPSA id w4sm378114ool.44.2021.02.24.05.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 05:18:32 -0800 (PST)
Received: from localhost (unknown [IPv6:2001:1284:f016:4cfd:27e0:441e:870:6787])
        by winterfell.papolivre.org (Postfix) with ESMTPSA id 1C7821C2F43;
        Wed, 24 Feb 2021 10:18:30 -0300 (-03)
From:   Antonio Terceiro <antonio.terceiro@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        He Zhe <zhe.he@windriver.com>, stable@vger.kernel.org
Subject: [PATCH] perf: fix ccache usage in $(CC) when generating arch errno table
Date:   Wed, 24 Feb 2021 10:00:46 -0300
Message-Id: <20210224130046.346977-1-antonio.terceiro@linaro.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was introduced by commit e4ffd066ff440a57097e9140fa9e16ceef905de8.

Assuming the first word of $(CC) is the actual compiler breaks usage
like CC="ccache gcc": the script ends up calling ccache directly with
gcc arguments, what fails. Instead of getting the first word, just
remove from $(CC) any word that starts with a "-". This maintains the
spirit of the original patch, while not breaking ccache users.

Signed-off-by: Antonio Terceiro <antonio.terceiro@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: He Zhe <zhe.he@windriver.com>
CC: stable@vger.kernel.org
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5345ac70cd83..9bfc725db608 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -607,7 +607,7 @@ arch_errno_hdr_dir := $(srctree)/tools
 arch_errno_tbl := $(srctree)/tools/perf/trace/beauty/arch_errno_names.sh
 
 $(arch_errno_name_array): $(arch_errno_tbl)
-	$(Q)$(SHELL) '$(arch_errno_tbl)' $(firstword $(CC)) $(arch_errno_hdr_dir) > $@
+	$(Q)$(SHELL) '$(arch_errno_tbl)' '$(patsubst -%,,$(CC))' $(arch_errno_hdr_dir) > $@
 
 sync_file_range_arrays := $(beauty_outdir)/sync_file_range_arrays.c
 sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
-- 
2.30.1

