Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA6E35E18D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346500AbhDMOcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241146AbhDMOaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:30:01 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21A2C06138C;
        Tue, 13 Apr 2021 07:29:40 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id i3so2598970qvj.7;
        Tue, 13 Apr 2021 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wsPt6ZyZKtel+h7n+9l66V0YibnbW9ZpDXXI3HL5J6w=;
        b=r+biRY2BGEAwIBiMnbaP0XXPZ4RIvk8aQM547tQs5bKqFwjCFEF+o4tqSQxVTY44cY
         WTAV+qlYwUCkLjTTf2PsoRUjsTLp9PblXNEopoZHNM5OXawi1iYIZouHUZtuFwUqEPVh
         ET4EYz4m4AIL3LLwaOSHOuw0SDjWHLabippOFQVITp68s1o7rFE30w5R3Jw06nTE8+h4
         pdhWj0DeEod/RfSXoF+EmhDc0LNP3d++Xs06Q8KA7r0IVLbwZRPieBJfW48Xx7KmcgXA
         hVJPnmIyStQ5SD94FT+qhVIwLJo/khFIbvAXv6bc3LY4G0L29dZSggpMs8Cjsy0frlyf
         KeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wsPt6ZyZKtel+h7n+9l66V0YibnbW9ZpDXXI3HL5J6w=;
        b=nj68li4WwVAt/VmXVL3tnGB5O7xcbdJbpsScOPFVYr/J22/LwVvbDPkRH8NCXE+dbE
         5d5r3tIGaz6FsWMQ2Iw8zS08USCstcnGdMwWSJPLsw2QJlhNAMzo10jDrS5+4c3kMm3b
         4M9r7ET9RYlP7tcAnzAzNuCZSMktuXQAc9VIOwwdzpuWQBWfio0g4+1G/BcLwnDlAPGi
         NINHjM7REgtVD6DNML263Y3aHg4AcvwsxBkpfg3DTIBRKWBtEyvB+vRJE/wNI5q9WUWQ
         m8vnGAEASkoA0Uvm0kjglPTtuSQTvlm9Fgh/LWYiaAOdF5Yc5e2CCzJOIVrB5uokJskZ
         WakQ==
X-Gm-Message-State: AOAM533AC47hmeY8isEgXAABvz2Ow5GF+RR8qHQzc4LNiuQe2l5iMVMA
        b+ggucy/iEA/C5hPIrczFnk=
X-Google-Smtp-Source: ABdhPJy7P2/Mgf/wLss5O9CsJ6jvWBFWAd983/dA3xh4TZeiqCh7YHwPx7mOPBkOIf7+ZUuFbbjS1g==
X-Received: by 2002:a0c:8e86:: with SMTP id x6mr21257683qvb.34.1618324180316;
        Tue, 13 Apr 2021 07:29:40 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id 2sm6160911qko.134.2021.04.13.07.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:29:39 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sj38.park@gmail.com, snu@amazon.de, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v28 13/13] MAINTAINERS: Update for DAMON
Date:   Tue, 13 Apr 2021 14:29:04 +0000
Message-Id: <20210413142904.556-14-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210413142904.556-1-sj38.park@gmail.com>
References: <20210413142904.556-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit updates MAINTAINERS file for DAMON related files.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d68184d3f76..42bbcaec5050 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5025,6 +5025,18 @@ F:	net/ax25/ax25_out.c
 F:	net/ax25/ax25_timer.c
 F:	net/ax25/sysctl_net_ax25.c
 
+DATA ACCESS MONITOR
+M:	SeongJae Park <sjpark@amazon.de>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	Documentation/admin-guide/mm/damon/*
+F:	Documentation/vm/damon/*
+F:	include/linux/damon.h
+F:	include/trace/events/damon.h
+F:	mm/damon/*
+F:	tools/damon/*
+F:	tools/testing/selftests/damon/*
+
 DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
 L:	netdev@vger.kernel.org
 S:	Orphan
-- 
2.17.1

