Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3100932331E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 22:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhBWVP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 16:15:57 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:39338 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhBWVNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 16:13:49 -0500
Received: by mail-ot1-f46.google.com with SMTP id h22so56371otr.6;
        Tue, 23 Feb 2021 13:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eEgdrPzWNXGUH81pCWlP9U2+TPBwQBKgS6ObcqHLUQ4=;
        b=iH/YBYqrzT8t2rH3J9zFrE2R9FkoQ6bR0lItjB6PGcuYEWAuvV/r/FzG1nWZ5I70Kt
         37tlemYkItdNISgeHeyK7gkBLhx5Dwe4mGfPAT/Dvpw8qvHPwXw0D+KSvsmNfyr/Yxkw
         M8d+b/gNUHj9KtTfRcGMRStBtE0H+j7IuN6SscVs435GxETZ/44GwPSeunOB0pE6VxdW
         cTr0+JYTa7mX38P4IyXes4affHRzgIWeJp9bGYtoEYdUu8ygvrqWOnhiqtSyqe3aw7Rd
         q1sJj8RBi4ale/oy/W/72X+osnyBVuOgDe4G+9pyZvkWvjBTFZoDTWl7Ix2K1SBVHVvh
         oh/A==
X-Gm-Message-State: AOAM5301AVqG0f1HHIZoBckCWZXldffekyXL9+a2RXFnFSxF++NrIn1n
        NPzx+hwhR+qIJvETXezdew9UVEZExg==
X-Google-Smtp-Source: ABdhPJymjGGvHGfyK+/ryr2N2x2BFG2Aet+SoL7SUf9PHTcORY9a+23OsqUKgYF0hyzCRareBer1IA==
X-Received: by 2002:a05:6830:3495:: with SMTP id c21mr21786378otu.97.1614114773364;
        Tue, 23 Feb 2021 13:12:53 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id j10sm235054oos.27.2021.02.23.13.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 13:12:52 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] scripts/dtc: Add missing fdtoverlay to gitignore
Date:   Tue, 23 Feb 2021 15:12:52 -0600
Message-Id: <20210223211252.66286-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0da6bcd9fcc0 ("scripts: dtc: Build fdtoverlay tool") enabled
building fdtoverlay, but failed to add it to .gitignore.

Also add a note to keep hostprogs in sync with .gitignore.

Fixes: 0da6bcd9fcc0 ("scripts: dtc: Build fdtoverlay tool")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Linus, please pick this up directly if you want. I'm going to be offline
most of the next couple of days, will have a few other DT fixes to send 
you later this week.

Rob

 scripts/dtc/.gitignore | 1 +
 scripts/dtc/Makefile   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/scripts/dtc/.gitignore b/scripts/dtc/.gitignore
index b814e6076bdb..8a8b62bf3d3c 100644
--- a/scripts/dtc/.gitignore
+++ b/scripts/dtc/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 dtc
+fdtoverlay
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index c8c21e0f2531..95aaf7431bff 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # scripts/dtc makefile
 
+# *** Also keep .gitignore in sync when changing ***
 hostprogs-always-$(CONFIG_DTC)		+= dtc fdtoverlay
 hostprogs-always-$(CHECK_DT_BINDING)	+= dtc
 
-- 
2.27.0

