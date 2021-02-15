Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD0F31C06A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhBORXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbhBOQSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:18:34 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D82C061A30
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:14:09 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id w19so6767037qki.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vUuAAALAJI+fG2870accHSSNYQyYhwy7cx5c7d7E6Y4=;
        b=PdbEFtYoJ7fLCoJclskCNrywQzZFn7Ehke/MEjfGzebydpPcze/MbHTovjhEJ3Gxwz
         lU//OV8u/i/u5TFvO6g54OIG15qqYb3eLSH/9sD+SE4p5e7ib0AE1MXIEVuj6QOppUqK
         5wgQZOykjgGcg4HGOhAcTdS5+DdkmYNK0JMovhC+Rr2BW6px4HxAjAQclgTlx++aXrRg
         dORz3YdX21yrIDCMgbEttpCZ3oMi4PgsrkUQjLGE0Iefwqi27AtMcIHKJDoOwHXlk/HJ
         At1ADH74dBa2oeIzVAN8ePzthxpfhxXOMUbN95jy/B1U2QBL/hOLhTs7JWZ+tePxvsM1
         kVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUuAAALAJI+fG2870accHSSNYQyYhwy7cx5c7d7E6Y4=;
        b=P/qkLP1f479SmAELzRmIlcz28yZv2wfYE7Kiy0ElCHMAg2Ig2zbS3tld89kVVotk3w
         lYEsVJQN/9lgBuEF3L1mV73FlIhUUrBCHUIhiCDH4UDzvNiTXkO2ygOsRD/frOXDDUaP
         1MwczVshyV2wdbQcerkPpNqPl8zil3ioASqsRUJbiOnyYvIH0lEeP9HV5A6/eL83fVq0
         IBqe34ooiF0PVLBEibggZcEk+rAVOYyLvRW6y1r2gWj7jCnMi2yler1oj8ZFOEJZfmGU
         2VJZ8WGlYdm/dBbYLBYhccrLVbX9KTQV+TKbNCsJb8of82jv2cY5lC6/nSuX1kM2hDDF
         9PTA==
X-Gm-Message-State: AOAM532x0RW87vKGR+45vepiWlssOdhQ/OhhLeWht7lNKVnH0RbQK3Ch
        rNfyLODcDj1fP3rSs0uCsBV8yXVFKkkrqca/
X-Google-Smtp-Source: ABdhPJxSYuHk8rlO/e3c8oYUvO2n9UzI0eM2ykQ1xa7yO+vQpCjOgaDKiXLGr3gxZJzO/JFgBjQdFQ==
X-Received: by 2002:a37:9b0c:: with SMTP id d12mr15164482qke.215.1613405648876;
        Mon, 15 Feb 2021 08:14:08 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u7sm10909213qta.75.2021.02.15.08.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 08:14:08 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org, ira.weiny@intel.com,
        linux-kselftest@vger.kernel.org, jmorris@namei.org
Subject: [PATCH v11 11/14] mm/gup: change index type to long as it counts pages
Date:   Mon, 15 Feb 2021 11:13:46 -0500
Message-Id: <20210215161349.246722-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215161349.246722-1-pasha.tatashin@soleen.com>
References: <20210215161349.246722-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __get_user_pages_locked() i counts number of pages which should be
long, as long is used in all other places to contain number of pages, and
32-bit becomes increasingly small for handling page count proportional
values.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index da6d370fe551..fab20b934030 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1472,7 +1472,7 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 {
 	struct vm_area_struct *vma;
 	unsigned long vm_flags;
-	int i;
+	long i;
 
 	/* calculate required read or write permissions.
 	 * If FOLL_FORCE is set, we only require the "MAY" flags.
-- 
2.25.1

