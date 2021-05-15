Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBAE381821
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 13:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhEOLGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 07:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbhEOLFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 07:05:11 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA16EC0611E9
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 03:57:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b21so652497plz.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQcxJYh4uOeboqIfkNqE+7kjXlD2MPDK+XHnIVhO6fY=;
        b=TCzrkTCYSpch9SI5BXvEy73UD3fFw12FBiV0Bg0JMVRTY35mtOrz9BjTBX0wSMND3X
         b6tn6t6gaOvqZRad/oWKiKg6DWN65cK/6gskR5nJ9+FF04AbtkN+8hPFBq067suBDr5x
         vcLW0Lt3H46MWkyAevGJkmFXCBb45zo/ZUl26O61R84UwHVONMCRCQ7mBk+Vo+3VnowD
         AEF7yNylLsMN0KC7dqY53FpRmVH/rbZV9pytEannW8AX7Xro8zMEM/vSh3sU3/PMtxto
         1hxFTmt+w57fUIvAXbrlyG4XELadKUa+O0KTtko/MeuZz5xoAcKKWC7pbBRTTqZjYZJB
         bPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQcxJYh4uOeboqIfkNqE+7kjXlD2MPDK+XHnIVhO6fY=;
        b=H50BvFdiTozVFSMGiIrIWjDyeLFHKB2r/bCbNhRkj2UWtjPCmIvPsb9JF/qR4vSX77
         ym6rVDOmUqcQk68sh6wCMzF0AMWKvZ1RQ1ozlVs8RtLFXX853iL/CJe2OXx9SO+mS4c2
         O0NW4h8ow2nY1Vzfd86/g1+FruBHxw8G/TmqYUqX501D3azBHLBJQ2sgrCg1qY3V8gLy
         c3sHhgDRWMHWpsTj8fYg858+Dh+OQgunDxtPH6W9te7QlgM9ihlFzcoCcZCCeOhk3MaJ
         pA8AM+tIRqV1BA9UkzB6ABePZpgiJv2oXBplCSN+IiKwtQ60QPFl2rzLiq63JTFbq3+P
         M9Og==
X-Gm-Message-State: AOAM5302LYDSAPCaI3iIRK9xDPfKit+TgN0VvTEPiOKW7hTceK9dzXFh
        yJE9BKG/zmgCdm0nYz6SxhU=
X-Google-Smtp-Source: ABdhPJws4LfASJvrgODO43bhgR1IGW7LGC2hyefto5pNSZm7kaT+PFLANHL7Sd4WLRXKv6NPStHDlQ==
X-Received: by 2002:a17:902:9b83:b029:ef:4dd5:beab with SMTP id y3-20020a1709029b83b02900ef4dd5beabmr26107696plp.76.1621076265158;
        Sat, 15 May 2021 03:57:45 -0700 (PDT)
Received: from localhost ([40.83.126.228])
        by smtp.gmail.com with ESMTPSA id e6sm5804156pfd.219.2021.05.15.03.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 03:57:44 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] tracing: Fix set_named_trigger_data() kernel-doc comment
Date:   Sat, 15 May 2021 10:57:35 +0000
Message-Id: <20210515105735.52785-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the description of the parameters.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/trace_events_trigger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index f725802160c0..023fb2d90500 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -915,7 +915,8 @@ void unpause_named_trigger(struct event_trigger_data *data)
 
 /**
  * set_named_trigger_data - Associate common named trigger data
- * @data: The trigger data of a named trigger to unpause
+ * @data: The trigger data to associate
+ * @named_data: The common named trigger to be associated
  *
  * Named triggers are sets of triggers that share a common set of
  * trigger data.  The first named trigger registered with a given name
-- 
2.25.1

