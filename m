Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACDF3B91F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 15:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbhGANDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 09:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbhGANDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 09:03:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8CAC0613A2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 05:59:01 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b14-20020a17090a7aceb029017261c7d206so813425pjl.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 05:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LP1zw9D1kU9DP50D5jN5AmF+x1tEmTJj8I96Pc25WU4=;
        b=gI7SJdQ7wg1lgzynuAr9lL8WzUyoXSAjQ05lrp7Cvw1p+Rr55+i5TVBPS89Fg6ffq9
         HrFoUOrQ2sRYuv/p+3jxRIeLDEQ/soS13C+nyZHt0yhDP/pAlXak939aLX55oLj3wZEX
         uDNomBhFCvUz72GJWCwi4gJLS7pwBGYvChKlgetSUZ1zVrE8qW8Z8VAcFn/aolRLQ8Lv
         +kvzVQ4Jl/MV7OjiOYANqabQzaqPD6Ok8SV6eNxC8nO5OKSuK5m3K7YLcQcZuw+akdto
         ZeGl5bDrTvqEQ0j9CPpdxtenu9X0arUBtwF80SinIB2Z8pb7QTvUySx1gBbc0HN9Uq9i
         pi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LP1zw9D1kU9DP50D5jN5AmF+x1tEmTJj8I96Pc25WU4=;
        b=VHYQeT7IWknsxCGslC4uCAANvsoH5Rf22rtUy3nTWHAoLXzmOV1MyiVH+vv+F4njOP
         UO1LPrUSnf/Gqb+id3BlBWVsuhjlXe7pekfCzMMF5cmxSM0IOIb5hRUEUSe8av+rPbyU
         PSxI3jFjpHn8hs36+pCcJYNbufkLUH9NpvpF0MLGy8Vw7M6ur2Ebtlr7vz3pqJq8MBFy
         5hY/AsOncu0QJ/DQNwSNsS5IYcsud3fziuae3krOLmJpS+Gn4okdGG8yA8RlMnmBUFv7
         HgU4P5DZKgY6UGJeHpNHXzgpS17pjb9j1eoOFeW1xG4bRNFAIN62kdazPCgq331jYh8t
         QSaQ==
X-Gm-Message-State: AOAM533N2YEfMu7NEn/sZUR3Q/7R2O1E2G8bw8Cyym3u85qt6DvkRHhd
        BYmiYjrdUlkUuOW3MkYTqeTWgXFjifY8IyL2pi4=
X-Google-Smtp-Source: ABdhPJzR9E3jqYlE+tS1clZtRd4v/GIXkYjSUkW2tmbvOJEO/fzyRFRqfgzIGN9tHiE+qI6OSsXREQ==
X-Received: by 2002:a17:90a:540d:: with SMTP id z13mr46566490pjh.159.1625144341362;
        Thu, 01 Jul 2021 05:59:01 -0700 (PDT)
Received: from ubuntu.localdomain ([218.17.89.92])
        by smtp.gmail.com with ESMTPSA id r10sm26971191pga.48.2021.07.01.05.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 05:59:00 -0700 (PDT)
From:   gushengxian <gushengxian507419@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gushengxian <gushengxian@yulong.com>
Subject: [PATCH] tools lib traceevent: avoid memory leak: buf
Date:   Thu,  1 Jul 2021 05:58:53 -0700
Message-Id: <20210701125853.710636-1-gushengxian507419@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

buf is realloced so free(buf) should be added to avoid memory leak.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 tools/lib/traceevent/trace-seq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/traceevent/trace-seq.c b/tools/lib/traceevent/trace-seq.c
index 8d5ecd2bf877..deafb773087e 100644
--- a/tools/lib/traceevent/trace-seq.c
+++ b/tools/lib/traceevent/trace-seq.c
@@ -87,11 +87,13 @@ static void expand_buffer(struct trace_seq *s)
 	buf = realloc(s->buffer, s->buffer_size + TRACE_SEQ_BUF_SIZE);
 	if (WARN_ONCE(!buf, "Can't allocate trace_seq buffer memory")) {
 		s->state = TRACE_SEQ__MEM_ALLOC_FAILED;
+		free(buf);
 		return;
 	}
 
 	s->buffer = buf;
 	s->buffer_size += TRACE_SEQ_BUF_SIZE;
+	free(buf);
 }
 
 /**
-- 
2.25.1

