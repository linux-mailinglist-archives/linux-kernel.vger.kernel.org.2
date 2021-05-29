Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA38394DFD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhE2UD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhE2UDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:03:53 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446A7C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:16 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id b25so8011685oic.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dS6uHjz9CiOVRNfXnDoINC1MJqAgC4MzLCRQqOhkkl0=;
        b=tBSnO/0KLaRdn04JG9dRxMj47YCnNvyf2t/wJdcXZ8OMhedUtP7i60gpGvcj1bIqw1
         UYfKQtO+hkI1Z/YR7SY7P5lxaRH796Y0idzGqwZCWgtVVCOfjxxvsvTNN7OOs5zmj7oV
         W4kKSpBJdkFJ/BfteSf+ms+F1YXoJMqDNDM4aD9edlDmUIE7eV02VyNyLdEvMXyAwzRZ
         6DbMCj+vIAhwisfVIfsNWwtZDOd2EdztM8cthdEpfTdL9Ecy4ScEi5F8eVHjTw81aLIa
         CkKST9AfuEc+HDjjJq2TZ5WHHEVW3X/GUnEpmubScWmS8nxKFMv+oze0PNPEc3M+OGhF
         yqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dS6uHjz9CiOVRNfXnDoINC1MJqAgC4MzLCRQqOhkkl0=;
        b=PJYGITfhJ2ESg6uj1epCm+QaOqAgMKUfrMd3Mshk07wPQoFz1wg0HjbHhy5D4vT8ny
         Jt66SLWI6+dvT3pzxHm+DaJmbHhqmMRF0hn+wzmnvkUhI+SVZUBQlR4loxO7KiFxDtPP
         PkMkshNbcPmFNY/7q+M/gePrkE/GnNwgnSpeVGnOpj4LvpLlIzDF4s5oh1MnSU1H9yA9
         H2BFZr8WL9d5XqggL7s7G2hzBKxb6EfYCzw3Qtr5d24a3CUdSY2fepi0PWAxX8jDKcOs
         tO7yFjs0yfbyk7CM5HHRE4AC7ZOvnbru8eGyib3LWnmFejUokVEb402en22/0dw3hxMn
         bV8Q==
X-Gm-Message-State: AOAM531JiTOXnXY8VaCQC1G/IREutN5EimhQ+0ht/yrCqK7wAlaTy34I
        b/5MC946UfF4ljSsEdTq5ws=
X-Google-Smtp-Source: ABdhPJzrDROf5/GZRdLI9HXtlgdWFFjlC/neIfpL8TzSAxYz/csNKKUW5vdb35VriQgXhhCbuQg4TQ==
X-Received: by 2002:aca:4c58:: with SMTP id z85mr10193453oia.46.1622318535634;
        Sat, 29 May 2021 13:02:15 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:15 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 02/34] dyndbg: drop uninformative vpr_info
Date:   Sat, 29 May 2021 13:59:57 -0600
Message-Id: <20210529200029.205306-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a vpr_info which I added in 2012, when I knew even less than now.
In 2020, a simpler pr_fmt stripped it of context, and any remaining value.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ede4a491ee87..3a7d1f9bcf4d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -920,7 +920,6 @@ static const struct seq_operations ddebug_proc_seqops = {
 
 static int ddebug_proc_open(struct inode *inode, struct file *file)
 {
-	vpr_info("called\n");
 	return seq_open_private(file, &ddebug_proc_seqops,
 				sizeof(struct ddebug_iter));
 }
-- 
2.31.1

