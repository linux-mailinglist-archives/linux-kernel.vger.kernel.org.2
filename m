Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DB332E4B0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhCEJWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhCEJWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:22:21 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361AAC061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 01:22:21 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id x29so958445pgk.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 01:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m2Q6KIs5amBgu/hMc+Rzg+zGlMbW3gQUxIbh9qBKo+U=;
        b=q3HjWY/tNgwaMddH4Zu9n1APFR2hYgjJoJozFO672vMnxL3fi2uuC2eZB69E/nOEZM
         AFQt+TtJDlv0tNPGqigE0JlieI/FfBvVpsyj4xNljRxnh7gZvz9AX56Xv+CcrIYTCKUC
         vDf1gMbgF9VlctY8YsosHlBm7bTaF27rMZ8uz9kBgUB7Cn3aG9ghxtORTuV75PX4HWKs
         OHGo1aSCLY768VUWwDUtLgi/rfDPpMP6emXXjYygaKdGoKhIzu8Li48Ir2aGxOExe6sx
         nPEigfpxz9dUen3deXagLQvNKbZI4IQvqskNdD2b2U+53RAcVueeE9boY4FzcLzW0wDj
         50jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m2Q6KIs5amBgu/hMc+Rzg+zGlMbW3gQUxIbh9qBKo+U=;
        b=uBjIheJziSYOS75IVPiRBJsKm+VI4lMD2x/wMFe7CQ6DWOCHn/YKNVEdiHF+qaFbwz
         UrKmcKKHdO0i48EYuujHajcWfd4ASg6jAXIMhfXwLDrKNaHSeHhQa2tBDZNCDzokklSJ
         pwLj2BXHbMVeBo/jMsdG6H6AFcgmDr3RWvVHQjosZ3NlyOfd6OcWTMs3M2P9WAjaenb+
         IAHHOSENAqNrabHIHym5xmroikeUXzwHewjFdQay0R4km4fsp8iTPdaYOsBwTQOZ1Hu2
         cC8BdvhshATrIrdK0659LuL+bfO28adD8z3VPyXohF5egFpN/MZml/EjbO34DXRGbtRC
         JVrw==
X-Gm-Message-State: AOAM5313k9DnW5sOBUqXVRJjHcqwBQQGE14k7eD2o6Me1AtLgyZePHcA
        HX7Km6mJKwv4Wzb4dce7D4Y=
X-Google-Smtp-Source: ABdhPJw7dT2wFRyLFSn5lD5wGY8NnQq5XIj9kU6lEH/exU15d2GI5nY8fTQXtuiFvt+BYJUwb8EGWg==
X-Received: by 2002:a63:2214:: with SMTP id i20mr7401533pgi.189.1614936140753;
        Fri, 05 Mar 2021 01:22:20 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id p190sm1754580pga.78.2021.03.05.01.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 01:22:20 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: xiong.zhenwu@zte.com.cn
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com, xiong.zhenwu@zte.com.cn,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tool/perf/bench: fix misspellings using codespell 
Date:   Fri,  5 Mar 2021 01:22:12 -0800
Message-Id: <20210305092212.204923-1-xiong.zhenwu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>

$ codespell ./tool/perf/bench
tools/perf/bench/inject-buildid.c:375: tihs  ==> this 

Fix a typo found by codespell.

Signed-off-by: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
---
 tools/perf/bench/inject-buildid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index 280227e3ffd7..55d373b75791 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -372,7 +372,7 @@ static int inject_build_id(struct bench_data *data, u64 *max_rss)
 			len += synthesize_flush(data);
 	}
 
-	/* tihs makes the child to finish */
+	/* this makes the child to finish */
 	close(data->input_pipe[1]);
 
 	wait4(data->pid, &status, 0, &rusage);
-- 
2.25.1

