Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6833CA4E3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 20:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbhGOSEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 14:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbhGOSD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 14:03:59 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E27C061762
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:01:05 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a6so10161569ljq.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Juo3AM+b40dS1hlfCODzT9PCdvoocT9eJfDW+eUcng8=;
        b=XwEA5JR850+TGWCt6vJfhkjleSiwtQZzAqAkkd/ng64jUPk6N10XXFblaVpnhTkRY6
         Vp3gHpAYGpjMuDDtFclHkmA8Lh4y7UMzJLof9RsM1a5syeWOzv3+v6uF32na48RTKEwT
         LIldxzV4RPbj9aIDeVuke1TIFzu25vg01kF7acjcZm0NXuLs4MlcQlRHKBhykj2k4RfU
         yNpSJGFgURlj/5skQIisfQs2w24QtOWyXvq7m8kz6774oCJ3scRlI02LNLQixcS69yjN
         e6WlnQotTb/gZAqBS9USBUF4Rlp+95RNCZb4xlDMDLZbTCZ3348RfmiHLELt9RyMl73X
         ov4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Juo3AM+b40dS1hlfCODzT9PCdvoocT9eJfDW+eUcng8=;
        b=nzlT5thBz1XYgQvtR1gRpsAxh5rEGCp16Ik3teaqNvGItVIFjofeyQwT2XBYwOS0pR
         2P/FhGUmwoklkwuP8LRSKMGn8WGJgCKdnHnji/y0bxrL60LxDigSNE82Z4CrZFawKUVe
         KRR5X3kmY6D5UKbmgrvckFN0eNXasiwgXrhZ3cJbaFycNVRG7ztPGXqS1Ok6M2MNU2NA
         2fIZEXdlw0dckSoMmFdLZsQ4GmUdK1AUIMaReIWdkhmKyJD/sDonK9YWZ3y/7/tCKI2c
         LUrbHCBnWl3mdUN/SPbwHfqkupDMX3iZfN2VMQ2VKBv/GHnPydGoEv65FirNE/S961wj
         Jjbw==
X-Gm-Message-State: AOAM531xunAyr/wuj02Kky3z4ACRCnlULBjgchfZB+fPj0fQSLzp0poZ
        /0A9tnp6qScDuOCWqxgsozw=
X-Google-Smtp-Source: ABdhPJwuiTKtNZkDuhZjUUNbAr6X37vDGYkYk/ZXWGJBYgBX33LWROANBmsf54sPkcLD8batIYicOQ==
X-Received: by 2002:a2e:950:: with SMTP id 77mr5203883ljj.438.1626372063632;
        Thu, 15 Jul 2021 11:01:03 -0700 (PDT)
Received: from asus ([37.151.208.206])
        by smtp.gmail.com with ESMTPSA id b14sm461804lfb.149.2021.07.15.11.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 11:01:03 -0700 (PDT)
Date:   Fri, 16 Jul 2021 00:01:01 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     akpm@linux-foundation.org
Cc:     tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: KSM: fix ksm_run data type
Message-ID: <343394260f599d940cacc37f1dcc0309239ae220.1626371112.git.zhansayabagdaulet@gmail.com>
References: <cover.1626371112.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626371112.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ksm_run is declared as unsigned long but in run_store(), it is converted
to unsigned int. Change its type to unsigned int.

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
 mm/ksm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 3fa9bc8a67cf..057d0c245bf4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -289,7 +289,7 @@ static int ksm_nr_node_ids = 1;
 #define KSM_RUN_MERGE	1
 #define KSM_RUN_UNMERGE	2
 #define KSM_RUN_OFFLINE	4
-static unsigned long ksm_run = KSM_RUN_STOP;
+static unsigned int ksm_run = KSM_RUN_STOP;
 static void wait_while_offlining(void);
 
 static DECLARE_WAIT_QUEUE_HEAD(ksm_thread_wait);
@@ -2874,7 +2874,7 @@ KSM_ATTR(pages_to_scan);
 static ssize_t run_show(struct kobject *kobj, struct kobj_attribute *attr,
 			char *buf)
 {
-	return sysfs_emit(buf, "%lu\n", ksm_run);
+	return sysfs_emit(buf, "%u\n", ksm_run);
 }
 
 static ssize_t run_store(struct kobject *kobj, struct kobj_attribute *attr,
-- 
2.25.1

