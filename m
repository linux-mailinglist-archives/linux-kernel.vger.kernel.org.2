Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A31E3B91D6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 14:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbhGAM5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 08:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbhGAM5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 08:57:09 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7668BC061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 05:54:38 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so6463206otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 05:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ki9YLtCfQTGb7pej90Hp/SMduHeqHAJeUuadkg/p5L4=;
        b=s3n2fzzLNhl+Pbqbh0ngHQxfy01ZkHQnyaNLJo/HLUru6FGx7hXzu5+0i6mGL3vC6W
         EwaWvSOTW1bWmFrQK9GJmJC5mK8qKGpKd82bplpKhjurGUXTkTBra2zy7YoyTvxXsMdT
         +vvV6gIWlzzUwesN4RkmVIqgSU2V0IQNeO4KXjzepNERqmPxiJH13oHglCFb96ZOf5fT
         GgAuwr7EW4CwHnjS4P+cRufJrS1N+tSoh6VVCgXrS/7BGiFsEwfrLINC9XcnJtJm0un8
         cff+FG44MBUhSi0Oo6vY8VMyLRFttxXbDGANQGabvqPPfnO54krYawYQYitBDnQn45yn
         oO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ki9YLtCfQTGb7pej90Hp/SMduHeqHAJeUuadkg/p5L4=;
        b=OCfhhnn9xzA86kFHWxq0tObuOr+jHMdyhKrXPalRcrUPNiRVRrDXoMe8r8/6dUsVRX
         ekImnrLheRJaE6ZYQM5voT/WLgrhnv3ZII6piVC9/P+kisR3Eyex+znoL/KBhjUnCDGH
         RFgFvvMRdE48t06M+Le+KEBXKEPj492aUZL2Qcb8O+Y8yG272h8KThQjwjAjpcrek64P
         LD/Uvg+VLaLQ2ZlNEagWUao1Ko9TTepjkf7//663RgQwRq2mlcIf0ngMpcnf8FwvsN5Y
         ywelnbTPi598w2xMVdtDmwBKuHcXICxAvRzGNJ1SDf7WP78dU2Op+kpOQu8571qM1o1H
         YnRw==
X-Gm-Message-State: AOAM533bSRIH7h9OVNUoBPLLvbL4Ydi/tx0g2dFg7KRW3iHVpo20sfFH
        bWoRSIX9dFab4dPguGHaisb9dkQyow==
X-Google-Smtp-Source: ABdhPJxl+F7Gc0AYbf9HXcFQqyvOQetib16gmTVy73GLRr7aAkyPgpcvNKBJyVggtX7F7LKjaF/Qnw==
X-Received: by 2002:a9d:4c08:: with SMTP id l8mr3538972otf.149.1625144077782;
        Thu, 01 Jul 2021 05:54:37 -0700 (PDT)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id q203sm3631578oig.1.2021.07.01.05.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 05:54:36 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:2948:9e00:9282:8e98])
        by serve.minyard.net (Postfix) with ESMTPA id 6E05718010F;
        Thu,  1 Jul 2021 12:54:35 +0000 (UTC)
From:   minyard@acm.org
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] oom_kill: oom_score_adj broken for processes with small memory usage
Date:   Thu,  1 Jul 2021 07:54:30 -0500
Message-Id: <20210701125430.836308-1-minyard@acm.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

If you have a process with less than 1000 totalpages, the calculation:

  adj = (long)p->signal->oom_score_adj;
  ...
  adj *= totalpages / 1000;

will always result in adj being zero no matter what oom_score_adj is,
which could result in the wrong process being picked for killing.

Fix by adding 1000 to totalpages before dividing.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
I ran across this trying to diagnose another problem where I set up a
cgroup with a small amount of memory and couldn't get a test program to
work right.

I'm not sure this is quite right, to keep closer to the current behavior
you could do:

	if (totalpages >= 1000)
		adj *= totalpages / 1000;

but that would map 0-1999 to the same value.  But this at least shows
the issue.  I can provide a test program the shows the issue, but I
think it's pretty obvious from the code.

 mm/oom_kill.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index eefd3f5fde46..4ae0b6193bcd 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -233,8 +233,11 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
 		mm_pgtables_bytes(p->mm) / PAGE_SIZE;
 	task_unlock(p);
 
-	/* Normalize to oom_score_adj units */
-	adj *= totalpages / 1000;
+	/*
+	 * Normalize to oom_score_adj units.  You should never
+	 * multiply by zero here, or oom_score_adj will not work.
+	 */
+	adj *= (totalpages + 1000) / 1000;
 	points += adj;
 
 	return points;
-- 
2.25.1

