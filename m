Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0468D3262DB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 13:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBZMok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhBZMoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:44:39 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B82C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 04:43:58 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a22so14588346ejv.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 04:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bBcc/vkNvUAGFdj3wzc7S7VWJQzLNUlsdvKbE3OeWQ=;
        b=Wf/KIuJlM2IOpiPHzycmUw7QwBiy58BKb+AeK3A4o686xTUY6QTrS5araybibKUqxl
         cFPtfsEHpUgkDOWLtt5XecOZlQVS1KoMUaqu41viLFHSN8pYo3cZsSf74/0RTGn7EtN1
         lcbZIeCOqj0KFM0p/bXwoK6wXAQvYYTVk6F9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bBcc/vkNvUAGFdj3wzc7S7VWJQzLNUlsdvKbE3OeWQ=;
        b=MPfxvKvuG2btEJFek9KRutPatnclFTwC+MDaaniQGsGx21RD7lSjkfUVCDxnZjeMpU
         KIOrG5nf/xuIIRWNeX5kL76/UKzdaxpdDgRFrzslwi+MBVVjEBsnTagvJQbXafWacsi/
         6iqEkgnKrXcTn3S1rUK/X2Rvrnr3v7l2OEP/5xeAOOu11BF1djz+swhwvxI6PuJJ+z2R
         +3768jiUgM004kFsIh49stIpTA+319mWcqtX2NtRONnW1VKBOc2sjY3FwG/2tygmbCEK
         gpPLFwvv2m8zXA0M50O6GPUFguWQRLmeA2NxlzcUxMdPiJkrAcCpUn9i1+Pqg6SqpyeH
         7dzw==
X-Gm-Message-State: AOAM531Tna5FeC47sWeChqEzTtXorK5aKw2DY2kS4ZgdBHiIPYsXFoUv
        XloFbwiylru6q8SLePBW8FhxAw==
X-Google-Smtp-Source: ABdhPJy6jm1qpVdPfLlI3FhFMsyq0RfNwQ3gAGCpDvqNfpqUDwUbtdWHJweI+CxJdHS3OZ5OOkh0cw==
X-Received: by 2002:a17:906:39c5:: with SMTP id i5mr3071843eje.163.1614343437422;
        Fri, 26 Feb 2021 04:43:57 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id dz7sm5701713edb.74.2021.02.26.04.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 04:43:56 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] kernel/async.c: fix pr_debug statement
Date:   Fri, 26 Feb 2021 13:43:55 +0100
Message-Id: <20210226124355.2503524-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An async_func_t returns void - any errors encountered it has to
stash somewhere for consumers to discover later.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/async.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/async.c b/kernel/async.c
index 33258e6e20f8..45a867b8644a 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -124,7 +124,7 @@ static void async_run_entry_fn(struct work_struct *work)
 	if (initcall_debug && system_state < SYSTEM_RUNNING) {
 		rettime = ktime_get();
 		delta = ktime_sub(rettime, calltime);
-		pr_debug("initcall %lli_%pS returned 0 after %lld usecs\n",
+		pr_debug("initcall %lli_%pS returned after %lld usecs\n",
 			(long long)entry->cookie,
 			entry->func,
 			(long long)ktime_to_ns(delta) >> 10);
-- 
2.29.2

