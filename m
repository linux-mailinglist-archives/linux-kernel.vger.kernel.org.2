Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7387381C19
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 04:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhEPCZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 22:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhEPCZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 22:25:34 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE21C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 19:24:20 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d78so1763321pfd.10
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 19:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ab6hgGPbUP9BgKDrCkHnIw3b4MlsQsU1cJD8XNIJouY=;
        b=eV71jEtr1xda09Z1QUgqU65DhVDgpGsN1jiciV67OqH1eJOgladtTe6C0rbObGrlT5
         wgkR6Z8yWln38upA7Uv86zozogy3yaEYSROHS8ZolL3K3KrZUpqj0+0NztWq2STMfznC
         V68DhxIOC2bpZd1lXAySBYgzHTlyDJ5inU2M9hVDJpFQ5OUe1AR9M6cUyoGKFYPnQl+v
         6ww58Jqst9eJyWPBB2yheIyVW/rFMXab1kU5XUUEjI0XDRuVUFrDNTPhlRMEVc4doEYH
         lfWXWe91CP8kWaTy12XX7dVSUGooNqGfu5SF/zsmTraB6uOFBu2ELg6LFRUy5ahWTI03
         kGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ab6hgGPbUP9BgKDrCkHnIw3b4MlsQsU1cJD8XNIJouY=;
        b=jZOByeVWjvN3XDT09cVIu8ZhPHq4Qb5s4090h0wIw3r0HdZSuE65LkoR76J64hX8ey
         rXP478bGux/TsJ5Fcb1kpL46DE6P6S8Paqc45z1TTk6zScbFD/H65waCMY1OnUduXDm+
         BcbFOBQDfV6lDmz+dcj9aSio2h4TDfctU7eYQxHh3jkIELA4g6k8ixrl1NgVsbvt95Y+
         rwGCmTJvMoWde4IyDA5HFP4zuzCsDdRhMJQ+Vdh9tmn4LCwcphQKgqG4KHrsrLkPucGo
         Oo5a3PrFh15hZV6K0o3efb2S2NbaPjkYLauvKwfkS3Vx9E97KLOlVJLcoHY5nAuCi/nO
         wPYQ==
X-Gm-Message-State: AOAM530HVmTVqbeOdvXXUEiePKYDkmWIloPbVaSduXGTqq9UUhQAqzsD
        8JTPf2mKYpPKE9ylgIz2WLM=
X-Google-Smtp-Source: ABdhPJw2W2FIbTBhxD8w3g2NCvF1gtZgV6//P7QwG9X+jpex5OAZ9hOPWmMGTMHmX/euw27nfqPigg==
X-Received: by 2002:a65:414d:: with SMTP id x13mr14726882pgp.86.1621131860514;
        Sat, 15 May 2021 19:24:20 -0700 (PDT)
Received: from localhost ([40.83.126.228])
        by smtp.gmail.com with ESMTPSA id g8sm2597664pju.6.2021.05.15.19.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 19:24:20 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] tracing: Fix synth_event_add_val() kernel-doc comment
Date:   Sun, 16 May 2021 02:24:10 +0000
Message-Id: <20210516022410.64271-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's named field here.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/trace_events_synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 2ac75eb6aa86..971bbd9ad329 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1978,7 +1978,7 @@ EXPORT_SYMBOL_GPL(synth_event_add_next_val);
 /**
  * synth_event_add_val - Add a named field's value to an open synth trace
  * @field_name: The name of the synthetic event field value to set
- * @val: The value to set the next field to
+ * @val: The value to set the named field to
  * @trace_state: A pointer to object tracking the piecewise trace state
  *
  * Set the value of the named field in an event that's been opened by
-- 
2.25.1

