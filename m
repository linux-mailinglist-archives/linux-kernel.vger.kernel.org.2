Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590003A9410
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhFPHe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbhFPHeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:34:09 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A289FC0617AF;
        Wed, 16 Jun 2021 00:32:02 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c138so1647847qkg.5;
        Wed, 16 Jun 2021 00:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wBm5GT0ODC2F9tnQ7Fv8I9TfYbIAesfi+EBxYW0sTJQ=;
        b=O/alHBCpCuRYRuMipTfrYlhQ8poKY0d+gM8ck4sGXAnX+vpyDWGSZtldQZao69IAxe
         DN2csVZXmYEzd6raDrgSobe1u0vJ0AsgAQHRgQ0ub3RAnLB6dc/8yKKCVVX06aNOWQpe
         TxIwJ6k48eNE52G4+MJJZuF6lYQqjvE4bCBWAItRFPbWRENwDWgipRlvqZMRBoYpCDnt
         nHN3YZpDlf1XOsOMi1vYS0rMM5/6fwIT5vDizDuiRvYSezEx8vHjXrrMRFJSbVZh2Pnu
         I1nMGzfhNAWiPnTzQj+6DbcXzf87wx1a6gXQNCdo2K17VDhmykaF+X5tRKckIAj0xJYk
         N7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wBm5GT0ODC2F9tnQ7Fv8I9TfYbIAesfi+EBxYW0sTJQ=;
        b=R/I/D+6eyhXQ90FKS77ltVogx8PKzKudO7lLP4Yt6Bq5JG0PN7SeRR/Qococq9zaJF
         S+Wn0Ux5yNKT2GUagCGrZJpAQSBfZdc6jORVeehyzpujRlv+WtKuSSNio1QPM6w0m+l8
         5vhopEzJJ6xS7GUkp2g3lRImAPY3JuPIYTSqyBRuR3s7sRVLIjOIl+fYCiM3nmKaDhmS
         iy9qDjp7uRDil9fYoy97t6VpjvRVNcmktS9Z/IFxLlC2FlFLMvOeN6re1mRO06ahtd0i
         kz4SsNikEqFoX9kcQzu8XYzTLEVavESyyaR/OrVfZlpj+ej24EX048c1Am7oB0ZNi0o7
         5row==
X-Gm-Message-State: AOAM530GU3Eut+nq47ouybvc1oROtE9rtS2O83EptoNZi4n3GaaGCau5
        FwiE36C/XfsZ0OozI1ICox4=
X-Google-Smtp-Source: ABdhPJz1dWP3c85Rg8WNFwwMr9ExEEMPkgc8NMTcZ9XTFI0o5TqI0vUYIie88q60v1S69TMZB8Jnww==
X-Received: by 2002:a37:64d0:: with SMTP id y199mr3775513qkb.111.1623828721896;
        Wed, 16 Jun 2021 00:32:01 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h5sm1080697qkg.122.2021.06.16.00.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 00:32:01 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, mgorman@suse.de,
        mheyne@amazon.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        shakeelb@google.com, shuah@kernel.org, sieberf@amazon.com,
        sj38.park@gmail.com, snu@zelle79.org, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v30 13/13] MAINTAINERS: Update for DAMON
Date:   Wed, 16 Jun 2021 07:31:19 +0000
Message-Id: <20210616073119.16758-14-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210616073119.16758-1-sj38.park@gmail.com>
References: <20210616073119.16758-1-sj38.park@gmail.com>
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
index 0bcb7f4c9d74..f6577541eb15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5094,6 +5094,18 @@ F:	net/ax25/ax25_out.c
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

