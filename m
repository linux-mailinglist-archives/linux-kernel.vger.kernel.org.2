Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A053F39B9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 11:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhHUJVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 05:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbhHUJUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 05:20:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC30EC0613A3;
        Sat, 21 Aug 2021 02:20:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bq25so25121389ejb.11;
        Sat, 21 Aug 2021 02:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CmrhphcsjFgBuYDW3B3fapu6bDNA5VX52WO9R+24v9s=;
        b=m2Viv4XboyvSZ5ruFP2UcLsLcQlJdXhMk3zU5fb+39f8d7ebSn4ZdCh4T8UX14mQ2z
         W4ID/VE0LvTD2JctHUBQ8vkdFSgXeHBuWEoMl2rGCgD8NrcqsUdultrrHN5K8XPp4RCk
         S1lCRsEg57Ev8dqjmhSIFQL0XJ2xSuyREDfgswxtTZrdR9X4mZP9xg5whV58VA78gTdS
         ZSam1S1hAdd8UR/3I20u71XPVpmzLPDOCWKrnATGSk5U2ffqhb/ZAW3srPEyfZsJGJWj
         ErHTWSt5Ab4nh8OCKS0cYmZbHO2GszTzOVAuKNHDhRFFGjiL7qVxSpyzfVrOsLvyBn8y
         e8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CmrhphcsjFgBuYDW3B3fapu6bDNA5VX52WO9R+24v9s=;
        b=nbxA2nrm3K6M2X/+1ut8dbAwZ7qKMjGMYMHHpHrKk1gAf1V1qHTV7KlxoVfaSmV21R
         pu8b0aHBjbl5WcbVONKqqQMSUMj9Zr75s/c2p39U0Z3v0FOx2CM7kLBn0SeCcVC7lf6Y
         /n8MJ2CMu4pjiVYGiAYOyZF/EDcUOInmyhpHUsK6O79bjkI1e5PiLUi6w/foxXSplGo1
         bfsqBanYiXViiXpYHhNF+jOXdjQS9tvd94e/Gu17XkCZtWO5vZb6f8CSMMtk3LhylABX
         DPuyRXAdFzkbeava3nvaAhRl7H+dElrfTH/xvBExG6ahVQbwyEa8AhA7VFEipDkXlIjU
         VhwQ==
X-Gm-Message-State: AOAM531w9CTthtUEJymj3lThSfiZebWOpCCGKSRUirfEOXZdG439W81d
        4yVKVbT68kU06Ai0hE5oceY=
X-Google-Smtp-Source: ABdhPJyVyJQVRW66l7EIYPAWWjnr3xxvDU7hN6mBExB62tdaMgYjtYKgB4xTi6fcRR+NL8HxLaCA3w==
X-Received: by 2002:a17:906:c4c:: with SMTP id t12mr25950039ejf.217.1629537599242;
        Sat, 21 Aug 2021 02:19:59 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:19:59 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v1 09/37] perf python: add workqueue dependency
Date:   Sat, 21 Aug 2021 11:19:15 +0200
Message-Id: <6fd8b091eb4765fde55a1d35a273c4b3765b0c3d.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds util/workqueue/*.c to python-ext-sources, which is
needed for the following patch, where workqueue will be used in
util/evlist.c.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/python-ext-sources | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index d7c976671e3a131a..7453f65c6f7a4396 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -39,3 +39,5 @@ util/rwsem.c
 util/hashmap.c
 util/pmu-hybrid.c
 util/fncache.c
+util/workqueue/threadpool.c
+util/workqueue/workqueue.c
-- 
2.31.1

