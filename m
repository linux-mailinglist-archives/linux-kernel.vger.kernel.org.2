Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F118358542
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhDHNuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhDHNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:49:44 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F44EC061765;
        Thu,  8 Apr 2021 06:49:32 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c4so2208358qkg.3;
        Thu, 08 Apr 2021 06:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cnNwkrwKhB0SqDt0MNFxpIt3W6nXi+tT+3hy5zyEZ2I=;
        b=UPYWMDJxTtcDrPfSgnF+ERO3QNmJtDlXNSuQhSf+2Q1h0YY619kqWauVKUP5e/I9ot
         KK4C1w1WYdJ00xLSO2ULQSJ4vUMnSW1Mvj201l3L5bN+QEah54TVLnFhDog1POxaEn0V
         9gAvWJhHppzW2K1vsjehxP5VYoFXFms1VnWiDPe1pV+2js3PZnWHNSog8ucdiEOK5TCs
         12sHHm6rL+PpYom8GW3n8o4AOLuXaumZWJtwtuVGTIkqn8aW35ie/kD4xfbnHaO1WGYs
         4twLCNKc7KhyNkmlFZSSp7pxn8sTd+ywti1k9fX1nuSNK7atXpedspquqmHFT78wFBa4
         AYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cnNwkrwKhB0SqDt0MNFxpIt3W6nXi+tT+3hy5zyEZ2I=;
        b=n+4XK6BU1L5N0nZyEI2r8Ry06fwB5Jc8p3LGwYaIgOa9zCcvv/kbkrgEnVpvR0kKXC
         D1KnCN2onXKpl/o5s7BGa1YK0J0gCkPi9IGive6uJaF2r0FZUtCP5liEsOJICy4/qOjk
         ufQ4nwJwj0z65B8eo84pfxRixp+sH0WL66zl0gMLTi1QBDG/9qF6iAhxj2GBL2BDTtVr
         w7vFj/WtWH3bbOgpwQApFQ0PdWf6BT7SldBuKb92BFKhK/QXwX+w2wpwedPD8iFx1q/X
         1te5TkN7IkcRPd06zTAU86cAO0YmM8ssPTW9VGq9j1j6zTer0nmEEja2ujV3P9wRnb8Y
         rLeg==
X-Gm-Message-State: AOAM531tf7B/rGIC6HjL1vRDyMyoYdJrUshigSAAMZQGM7kHfR689Qi8
        bFGYqdzj9iDHMsH2aFANqtM=
X-Google-Smtp-Source: ABdhPJxVGg71Zy7MDknyIzTjKhDsLbSZfpEKKUuIIuj1POeAFBY64TgodQux7CL1Q6q6zRtX78N4Lw==
X-Received: by 2002:a05:620a:15d:: with SMTP id e29mr8781318qkn.48.1617889771465;
        Thu, 08 Apr 2021 06:49:31 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h16sm506094qkh.18.2021.04.08.06.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:49:31 -0700 (PDT)
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
Subject: [PATCH v27 13/13] MAINTAINERS: Update for DAMON
Date:   Thu,  8 Apr 2021 13:48:54 +0000
Message-Id: <20210408134854.31625-14-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210408134854.31625-1-sj38.park@gmail.com>
References: <20210408134854.31625-1-sj38.park@gmail.com>
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
index ad650102f950..0df746019eb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5003,6 +5003,18 @@ F:	net/ax25/ax25_out.c
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

