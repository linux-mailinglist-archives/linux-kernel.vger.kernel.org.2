Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E1635FC13
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbhDNT62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:58:28 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:44916 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345147AbhDNT6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:58:22 -0400
Received: by mail-oi1-f174.google.com with SMTP id e66so6543360oif.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nx0zRs2XybSWr9usv14o4OKWxqlO9Cwb/2Nflg0vIEA=;
        b=UXHle3yb2X1DQ3hB0NzMzb5jNho6g9dEpfL7Pubkzvnfx0wi6prsL12x3uVKDTE3+v
         C5aTFQ0D/j6xbD8ji/sYfQBAejpE2QJ2tASI7G78mrV9akR9NwPPv71HSouQRO/+ym6q
         2DiNmuKyAmK6dhhQh+LYyMOfnEsMGXJCB+vK5pQM0sV72k2X9nWfBDIcu09ncs2o9PY2
         ofI4GW55JKYsswwb7Y68zQa0Mall03bXvHfeXb5pwj84ewaA/4DrC5hf20BPoZU1lZxM
         Pqy6XJBJKyRW0MGc3//05P8PfjbRaLYlADuS6ICco86JydiaI64AkWe4bemOyR10rJ2Z
         vgCA==
X-Gm-Message-State: AOAM532+YiKoSP3sheljcyzFHwV6oxdc4RZzMIildxTejUXb12wWObHw
        kN1Zp3jS/+3Tmp119ufSnA==
X-Google-Smtp-Source: ABdhPJydTdsoxzeBlDx8mN+iotXH2h8TeFrMXe+MxmVwCgvNPKItUZv2B0vCZdoJhczN9GW++8fPYg==
X-Received: by 2002:aca:3286:: with SMTP id y128mr3578775oiy.145.1618430280254;
        Wed, 14 Apr 2021 12:58:00 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id j8sm138743otj.49.2021.04.14.12.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 12:57:59 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] libperf: xyarray: Add bounds checks to xyarray__entry()
Date:   Wed, 14 Apr 2021 14:57:58 -0500
Message-Id: <20210414195758.4078803-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xyarray__entry() is missing any bounds checking yet often the x and y
parameters come from external callers. Add bounds checks and an
unchecked __xyarray__entry().

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 tools/lib/perf/include/internal/xyarray.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/include/internal/xyarray.h b/tools/lib/perf/include/internal/xyarray.h
index 51e35d6c8ec4..f0896c00b494 100644
--- a/tools/lib/perf/include/internal/xyarray.h
+++ b/tools/lib/perf/include/internal/xyarray.h
@@ -18,11 +18,18 @@ struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size);
 void xyarray__delete(struct xyarray *xy);
 void xyarray__reset(struct xyarray *xy);
 
-static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
+static inline void *__xyarray__entry(struct xyarray *xy, int x, int y)
 {
 	return &xy->contents[x * xy->row_size + y * xy->entry_size];
 }
 
+static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
+{
+	if (x >= xy->max_x || y >= xy->max_y)
+		return NULL;
+	return __xyarray__entry(xy, x, y);
+}
+
 static inline int xyarray__max_y(struct xyarray *xy)
 {
 	return xy->max_y;
-- 
2.27.0

