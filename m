Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA93833A613
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 17:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhCNQZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 12:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbhCNQZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 12:25:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EB8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 09:25:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x13so4476522wrs.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=91rq3bqjKdvo7l94WNjyc/wnGE/INBtalXqtBAm/ssE=;
        b=ozQk2bLYQhJ/74b9+MTplzRMhQi+den7GhlqVDflk/uNPbLhjTd0ylF1gz5DAjEBY1
         wG6n94tfL+MGFijwtx5BXKlQ1VfaK7Vce6I8J+DIpHf9JvVuaKsOA/aWTKF/kECbUtJe
         4UHVzSCQfws0ALXEXOFDV9aoYWL4OAScUVDvuohGNFk7NH0L+3GFOvbJ2TOpeQysHHUt
         K9elDMo6dBaB/GbznHW7aFuq9NknmT9Bu+B6U4jT4YPw7sFntuaA/0ockJbPLt+kSZBO
         sXoUPgpYo1T172fvttVgD2hMmyEwes2Vjsp+c9J8DFS2zEj+MBAMbl9lY6xmhRqpI0WU
         zs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=91rq3bqjKdvo7l94WNjyc/wnGE/INBtalXqtBAm/ssE=;
        b=HU0hMFRtFd7zUgh0q+0+sNeV9AzernSJNX2Biq1ETT6LABboSxwo1q8pA5hpcS2xQF
         rXZ9yUu8eFp9Quw7qkD7IIk79zkj18rPAaF9U43tCYCeYp1Os498u79DJZK4EPnCy+JB
         agL6ZpWPTRLuD0W5FC1Zr/0XhQdXN5NPGlYRSxyoyuDIn/rVLhzkFF5uoFbBr8afuNpP
         2DxNjp50ljm/Kpyb3+vt0YoY/lxsUtxSFdYP4U08WWAXZK+EQsFIci4pTP5qkBJkR+ot
         tXBCNpr3mJ3kxmo4DFsAQM2HZbDBuJpGuP4rlP0sfpE4QkPxaF1cFrhhHLFZyL5Nges9
         XHyg==
X-Gm-Message-State: AOAM530H0d0OD3CRuqulDSgzR6KXByQeR0yCYd3Dp/XwIkIxG4+i33YH
        DiNsrZT2635HiLMpCF7/W4UNpcY/MA==
X-Google-Smtp-Source: ABdhPJx1hDQmLY31nMZktr7Qj+jmiCMvP09FYngGIZbzabNp28B57Fu/VcQz1Fmrbjv1DpEEJLhUuw==
X-Received: by 2002:adf:fe09:: with SMTP id n9mr23789386wrr.104.1615739103557;
        Sun, 14 Mar 2021 09:25:03 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.83])
        by smtp.gmail.com with ESMTPSA id h10sm15734356wrp.22.2021.03.14.09.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:25:03 -0700 (PDT)
Date:   Sun, 14 Mar 2021 19:25:01 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] cred: make init_groups static
Message-ID: <YE443dcHNJOIUMGT@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing really uses init_groups. It can be accessed via init_cred
if necessary.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/cred.h      |    1 -
 include/linux/init_task.h |    1 -
 kernel/cred.c             |    2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -53,7 +53,6 @@ do {							\
 		groups_free(group_info);		\
 } while (0)
 
-extern struct group_info init_groups;
 #ifdef CONFIG_MULTIUSER
 extern struct group_info *groups_alloc(int);
 extern void groups_free(struct group_info *);
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -25,7 +25,6 @@
 extern struct files_struct init_files;
 extern struct fs_struct init_fs;
 extern struct nsproxy init_nsproxy;
-extern struct group_info init_groups;
 extern struct cred init_cred;
 
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -33,7 +33,7 @@ do {									\
 static struct kmem_cache *cred_jar;
 
 /* init to 2 - one for init_task, one to ensure it is never freed */
-struct group_info init_groups = { .usage = ATOMIC_INIT(2) };
+static struct group_info init_groups = { .usage = ATOMIC_INIT(2) };
 
 /*
  * The initial credentials for the initial task
