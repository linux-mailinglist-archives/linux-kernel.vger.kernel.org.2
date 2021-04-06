Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C2A355429
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344158AbhDFMqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344130AbhDFMp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:45:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7241AC061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 05:45:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r8so4986172lfp.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qzax+/pLWvJYyiIHAdv41YU12arGs3IsFzSPSlTtPtM=;
        b=VXesCySQLpLhUMFCPD/bZGY383PiVyfGMpEQc7GnGlSvfopbl9/puexwZSUKTzX1ZP
         SyPbcyItJSEtkJcb05Ooma5md8eEH0QC4OlyJJv+X4IgJPiPbCh13YDhX8dVb2XnMYTI
         mONkGlcSYg1MLDhj4C+Urz37rW2n+5l70Uz+vL3rf1LuCu7RD2zgY+DGmZ8wIBiX+9iM
         DyiaNAIfE0w+P2Qplvw8s3bdkzvNHHZftUWn6fVveMfTdKOudltnsZKa0IjISDmfOJZI
         ksZ+ry0uS73QLNR01d3CLUZAyGx4g3kr+Mql3pABK9k+zlnJ41DOn6zB4rQpdu56CpbN
         O/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qzax+/pLWvJYyiIHAdv41YU12arGs3IsFzSPSlTtPtM=;
        b=kwFGAXZL985315oyjVZevrQBRm25FQWI/dwzUO/ai1a4oeLeQv13t4w21dZb+8IjtE
         xU7H3UbWZGpPn6Xwefwgm5YNqF+emyPOtLBHIjG6zfHvrz5l13j2HxY/Vv/Dtcutd/1Z
         7IPgALt1jgIaA8WpkIrHjuZ+tSHOu3huAQPjBwEDh/5n4Mqia9wP2bSp4zfXVodabxPS
         u45LWpZZBKyh1ONLpe3lL4Ak9BZ0iYhhPm1N4+8WcjvxIBiVn9je+ApUm+nk5vp9nhgd
         hYH10IUQvG3KCfp2KSzMYbnXfaGiLipnG6ZzxMF1rCoJ23X2sMWS5CGSzR/ObZTIjGoZ
         UXIQ==
X-Gm-Message-State: AOAM530DX7lVihubBwTT9V6FJyw+rnHsCGriA3iQAaYr+Dm+jgVT0qvR
        2eD453KIQgDS5NC/a8pxSZ8=
X-Google-Smtp-Source: ABdhPJwmoEzD2XGY7n2Doeo5Pr+CZDqoRx3yOfhM83vbMVtM/ICpFg3ozbgu0lq0hU0Mn03y9CcfoQ==
X-Received: by 2002:ac2:5d52:: with SMTP id w18mr20296986lfd.28.1617713145961;
        Tue, 06 Apr 2021 05:45:45 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id n17sm257111lfe.0.2021.04.06.05.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 05:45:45 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH-next 1/1] lib/test_vmalloc.c: extend max value of nr_threads parameter
Date:   Tue,  6 Apr 2021 14:45:36 +0200
Message-Id: <20210406124536.19658-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a maximum value is set to 1024 workers the user can
create during the test. It might be that for some big systems
it is not enough. Since it is a test thing we can give testers
more flexibility.

Increase that number till USHRT_MAX that corresponds to 65535.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 lib/test_vmalloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index d337985e4c5e..01e9543de566 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -24,7 +24,7 @@
 	MODULE_PARM_DESC(name, msg)				\
 
 __param(int, nr_threads, 0,
-	"Number of workers to perform tests(min: 1 max: 1024)");
+	"Number of workers to perform tests(min: 1 max: USHRT_MAX)");
 
 __param(bool, sequential_test_order, false,
 	"Use sequential stress tests order");
@@ -469,13 +469,13 @@ init_test_configurtion(void)
 {
 	/*
 	 * A maximum number of workers is defined as hard-coded
-	 * value and set to 1024. We add such gap just in case
-	 * and for potential heavy stressing.
+	 * value and set to USHRT_MAX. We add such gap just in
+	 * case and for potential heavy stressing.
 	 */
-	nr_threads = clamp(nr_threads, 1, 1024);
+	nr_threads = clamp(nr_threads, 1, (int) USHRT_MAX);
 
 	/* Allocate the space for test instances. */
-	tdriver = kcalloc(nr_threads, sizeof(*tdriver), GFP_KERNEL);
+	tdriver = kvcalloc(nr_threads, sizeof(*tdriver), GFP_KERNEL);
 	if (tdriver == NULL)
 		return -1;
 
@@ -555,7 +555,7 @@ static void do_concurrent_test(void)
 			i, t->stop - t->start);
 	}
 
-	kfree(tdriver);
+	kvfree(tdriver);
 }
 
 static int vmalloc_test_init(void)
-- 
2.20.1

