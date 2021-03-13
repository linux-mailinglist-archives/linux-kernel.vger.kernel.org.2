Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9B2339BB5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 05:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhCMEYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 23:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCMEXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:23:49 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462DCC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 20:23:49 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id l2so17143331pgb.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 20:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oMCpQqyUmSQjSr80rsOJXosqlWy8Gl0QQf1Kq8Lcoek=;
        b=JroatRMk7+OVfpS8r+i+5mOCpVI149rx1EqMOm3xVlEupv0XtDdMafEdg3KAbR6Gvt
         kJuZsHVUl3yyV2RafE3R+Df5GmcBv44pscj5zH62S7C9ZCBUE6CPdMJAFesBIU/kjwxR
         QWLN9j0Xp3pdCumMLaGyPhbMYXpPLLTf+KAKXSXvfsxamkjYNx5o6Pn7LsSoppiBSR3o
         4KNW1FCvL/TfrT2qzFnb1adI0trsiYqx1pxkfl/vkfF/7y5DdmEssdKV+3Bu1yieQQ+f
         7YCgXEo41C1uNHmJAulQY0kCViOKFFP7TJJm1ItN1+fQPBgTOnD9I4qAlCIa0wxdaOU1
         ibxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oMCpQqyUmSQjSr80rsOJXosqlWy8Gl0QQf1Kq8Lcoek=;
        b=ZPkzSiPMoBgwsoV8cget708sSdUhvMp5dPra8QjS3ZrLsw6ZMU+aTtt7OauFMAJhMT
         Zd9WqhSYEG9ynimGinpauyD8iAmub/g+Sn1JYJPW5XztjexOdS/txGCkj4skHcmtASHb
         DVB1y5kn0j8/beAMKJbp3eyj/HWevOt1cnC63sXBh7MKUo1Gi3vPunn1H0pxdBoTn5cS
         GbxnqH24iOsUDgT5/t8R26PeL+IRVYbiXip3WcrqyPx505wro9R0VuqidD9KkIIiTyNp
         RXqCAL/U5qxrQzEx37SBvw4Jfsv4GkRFFpQIl83ju3eRiOyV6C+p+yVGFETw4LIdsB9/
         5ukg==
X-Gm-Message-State: AOAM531u4Ael2u+AqjYyIU9DIUU6zxg9xTAbCnqiRIqkGgtEpkbMMRfo
        ggsQKKU6q+AHk6h5edbKp9m3oItq6JlOYA==
X-Google-Smtp-Source: ABdhPJwphksWTeFBOL6qO49urJACDUxjU/U1jAgjvWD2MQLR7f7WnP3G+7S2PHCvvCJ9nBDNXkd1AA==
X-Received: by 2002:a62:62c1:0:b029:1ee:7ad:8cb3 with SMTP id w184-20020a6262c10000b02901ee07ad8cb3mr15903727pfb.21.1615609428704;
        Fri, 12 Mar 2021 20:23:48 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.64])
        by smtp.gmail.com with ESMTPSA id x1sm3560026pje.40.2021.03.12.20.23.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Mar 2021 20:23:48 -0800 (PST)
From:   Jiang Biao <benbjiang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        robinlai@tencent.com, benbjiang@tencent.com
Subject: [PATCH] mm/oom_kill: fix wild pointer in out_of_memory
Date:   Sat, 13 Mar 2021 12:23:00 +0800
Message-Id: <20210313042300.3833-1-benbjiang@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Lai <robinlai@tencent.com>

From: Bin Lai <robinlai@tencent.com>

The oc->chosen is used by oom implementation, and the caller does
not initialize this variable. If the tasks of memcg are all unkillable,
oom_evaluate_task cann't choose any task, and the oc->chosen will be
a wild pointer. So we should initialize oc->chosen before calling
oom_evaluate_task.

Signed-off-by: Bin Lai <robinlai@tencent.com>
Reviewed-by: Jiang Biao <benbjiang@tencent.com>

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 9efaf43..0658a30 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -366,6 +366,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 static void select_bad_process(struct oom_control *oc)
 {
 	oc->chosen_points = LONG_MIN;
+	oc->chosen = NULL;
 
 	if (is_memcg_oom(oc))
 		mem_cgroup_scan_tasks(oc->memcg, oom_evaluate_task, oc);
-- 
1.8.3.1

