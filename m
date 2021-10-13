Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AE342BCB9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbhJMK0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239324AbhJMK0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:26:03 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4527BC061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:24:00 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so1859916pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QcN1lxbiBE9wyni4rRyTOCt0Nmt91dwFQG7x9CaFetE=;
        b=gde1n4LRIQfssIvyGFT7ogOiShskU+v44q6+2rJSzp4T/0T5sz3oPsj/v5hvzbpnKS
         ES+rPN8mqnoyraM8QX4eXfsKfCKRWVr5WRPgLryEH3lPChzctRocNRpRAeRFX4bgL3aM
         QGOv/njAAlnJ2eFZ2l2OjCCBoEXdh47GPW7mUXtaeb0H2biSt8+ezBRXohYBcEofc2nP
         IkoJCmjgf6HMEb7IpldNjCOfLhgrS34XudCdkhAfFEklC+8oVdvYItKJO8lyLVMAt5RJ
         dzoOJeWmTFeYDvSE9kwldAQnbDhF43NRwyrCJ4yl4X0X/se1GyksRPeFcDf9D13DWB0p
         IV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QcN1lxbiBE9wyni4rRyTOCt0Nmt91dwFQG7x9CaFetE=;
        b=NdaFQcecjREpf3qRzPm4q9GsuQTdBwSADQCx/2qQIoCKkZnPIhOvjZSlolViqzph7y
         BwXF24N8PbkZyNO51hb3JWRsHC/YkXmRhWq02tQevKxJJdMP/dOl13bdCNnJBOpCG5sk
         I4ITvVmTF6sTESHkbJ8GouYleWHkZ3bZHIVk5yIQgPV0+lw+CD+UaJe+EgNsXidEYvF2
         m+oCJP+DwPNMobykMJhUfGGcuixfTFEysh+wBgmBFsk+l0BsknYCZkwWpGB2wQX5DV2X
         fh9bIL+Ew6ZzP3GJaWauAgDdG3lcV6Akip0cTeg4TQW/pEoZSIzveZZHmNAcwLWmTShV
         BepA==
X-Gm-Message-State: AOAM530dt3flfh+7hi89y9dPyWS4ecjimOcW1ABXndoLIxX69/a9yZc0
        AKjoZhohsG6nKASyUfwQVZHyqxM2eKJIm2iE
X-Google-Smtp-Source: ABdhPJy7TC/Lr1XpkvZs2GGmps/ffWWlmIDuTVdZ/449ustIktu7sJ8bXHIL0ScLc5SZn6gTDw7I0g==
X-Received: by 2002:a17:90b:4b07:: with SMTP id lx7mr12230878pjb.195.1634120639751;
        Wed, 13 Oct 2021 03:23:59 -0700 (PDT)
Received: from vultr.guest ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id 184sm13900994pfw.49.2021.10.13.03.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:23:59 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     keescook@chromium.org, rostedt@goodmis.org, peterz@infradead.org,
        pmladek@suse.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, valentin.schneider@arm.com,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 3/5] fs/exec: use strscpy instead of strlcpy in __set_task_comm
Date:   Wed, 13 Oct 2021 10:23:44 +0000
Message-Id: <20211013102346.179642-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211013102346.179642-1-laoar.shao@gmail.com>
References: <20211013102346.179642-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a warning by checkpatch -
WARNING: Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Petr Mladek <pmladek@suse.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index a098c133d8d7..de804c566200 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1224,7 +1224,7 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 {
 	task_lock(tsk);
 	trace_task_rename(tsk, buf);
-	strlcpy(tsk->comm, buf, sizeof(tsk->comm));
+	strscpy(tsk->comm, buf, sizeof(tsk->comm));
 	task_unlock(tsk);
 	perf_event_comm(tsk, exec);
 }
-- 
2.17.1

