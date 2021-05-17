Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8D1383DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbhEQTzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:55:33 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:42553 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbhEQTz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:55:27 -0400
Received: by mail-ot1-f49.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso6597096otg.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R/csVDDllSt3emYyHrP2ssqRcgt8VzW5pyN/WluRGw8=;
        b=RGl7TiIcvaxsOkOcLVfpQpK/qgDq7qiIJDhTnXEsHSUxJUpj+2MY3EKNDdE7zvQ/zs
         Cn5saxa4AuUKW4XJIrpsLdg+LVt99FzfgM/6mtGR29u+jf3xF6Xjkb7ls8pbxjzNhwNl
         FF8TXVvakT+OkxeT2noZfnkn/10ETyzk2jbsvSbjIPCcNXUu67Ja9wSCmCi/BXPFym1f
         gTjADqMtegE0X4xcliVzgsaLNEPYHhOBa+iKN0CO4RkLS90XwfOszEDuXMIehKzAH2Rc
         vImKxg+fSR/wBjdBrfTDMB3tNfGun9Ln7GE0p2FHt4sJE3QLWm40FB6bVItnSf5IMCJQ
         sYaQ==
X-Gm-Message-State: AOAM532WmQgR5WPlIrihJ/UGUgZXTofRg4yUxdOL1uGtksel3JWuEdph
        h40U/rIkA3y7KP13N91Agw==
X-Google-Smtp-Source: ABdhPJxh6jQjL6XmPIMt25DCnayEdf+Py+/iq0NzU1Co90JjmoA1HWjiwZq/KDDW1BPXkVBt9fHD/A==
X-Received: by 2002:a9d:4101:: with SMTP id o1mr1037986ote.281.1621281249787;
        Mon, 17 May 2021 12:54:09 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m81sm2920758oig.43.2021.05.17.12.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 12:54:09 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/5] perf: Add a counter for number of user access events in context
Date:   Mon, 17 May 2021 14:54:01 -0500
Message-Id: <20210517195405.3079458-2-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210517195405.3079458-1-robh@kernel.org>
References: <20210517195405.3079458-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When scheduling a task's context, we need to know if the task has any
user accessible events in order to enable or disable user access.
Walking the context's list of events would be slow, so add a counter
to track this.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 include/linux/perf_event.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f5a6a2f069ed..4cf081e22b76 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -822,6 +822,7 @@ struct perf_event_context {
 	int				nr_stat;
 	int				nr_freq;
 	int				rotate_disable;
+	atomic_t			nr_user;
 	/*
 	 * Set when nr_events != nr_active, except tolerant to events not
 	 * necessary to be active due to scheduling constraints, such as cgroups.
-- 
2.27.0

