Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C2441F81A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 01:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhJAXQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 19:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhJAXQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 19:16:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFD1C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 16:14:55 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id b192so8261178wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 16:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y9ABR8B6BNYJ2xlGbb1bJXgj66kSZyagreZCx+sYhhg=;
        b=S4aZWiBSzpRm1KLmI3VYiciGQc0Zk919jGRl7PW56JAIT56VW6JqnNpGSRmb0O/135
         nX+uAfnbj61FQE/rBv5lask9whrVboyFOYkiNyemSqSv4RDwPsBMB6QJSakd1TGApBa0
         rIAktlAG16Ui6Uct7+PLdTKYb4YHivSaoOT7anWiAG56+K0ACfWIGTNl2WyEpNKK35L1
         52Y3t/TUS7VLBWO4IJv4LSjawCFrYxlhbeoduIXOkMrsfdGvd8IHwaDWMDs22GzOBz7h
         EEi7ol86GmvJ3yIUlKwsS/MqRJZYb+ROSzD/b9xE860XnYQamh48rltmw0KuLXH9n7jy
         +deQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y9ABR8B6BNYJ2xlGbb1bJXgj66kSZyagreZCx+sYhhg=;
        b=Gba+E6838ecgPtGOnw0KbNh6nmZ2gEcKRhLPaAdF5n9M7SA7RtDD/fWF0XUk7IEt47
         raj5sDK9EdrDYrKWFDfrvrrZXC8j7i1GvjnMunVWp5sOFODrJ4Gckh7f1+dCqY3tqJ49
         Obz30CiyVxlEbGLV/JetaWi0V+1WM7gekIahASVLc7RHAWAzD4e9hEie07qcZuAb4jwq
         EtYFBxrHcMsVuePIiK5vVP8abKVC9cXdvxQh86TTeiMspAD7qHQxynnog1OcMAtGUWym
         L65ouF+C7m+IOK2gR+tDgGP8SIw4A3084NtnqD9dH+s7iLyysW9fBLkh3buCw+sDj8nY
         TtSw==
X-Gm-Message-State: AOAM530HhhHmaRlNefuk116F/iZQnleomlDlegTOWv60w62wXj8OsT7T
        yxKRJjWkitfLkJixpl3AhQ3VLMX+nDtv
X-Google-Smtp-Source: ABdhPJz46BGDrlI2WP1vV/vE/Hq8NqZPYDKxvax2nzVae3gJqQYTwqitwoBl7J2iWPFXKRKA1C2dSg==
X-Received: by 2002:a05:600c:5103:: with SMTP id o3mr7101340wms.12.1633130094360;
        Fri, 01 Oct 2021 16:14:54 -0700 (PDT)
Received: from localhost.localdomain (88-108-171-137.dynamic.dsl.as9105.com. [88.108.171.137])
        by smtp.gmail.com with ESMTPSA id q10sm6817801wmq.12.2021.10.01.16.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 16:14:54 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH] x86/vector: Add missing annotation for void lock_vector_lock() and unlock_vector_lock()
Date:   Sat,  2 Oct 2021 00:14:44 +0100
Message-Id: <20211001231445.8934-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at lock_vector_lock() and unlock_vector_lock()

The root cause is the missing annotations at lock_vector_lock() and unlock_vector_lock()

Add the missing __acquires(&vector_lock)
Add the missing __releases(&vector_lock)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 arch/x86/kernel/apic/vector.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index c132daabe615..c824c346e501 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -48,6 +48,7 @@ static DEFINE_PER_CPU(struct hlist_head, cleanup_list);
 #endif
 
 void lock_vector_lock(void)
+	__acquires(&vector_lock)
 {
 	/* Used to the online set of cpus does not change
 	 * during assign_irq_vector.
@@ -56,6 +57,7 @@ void lock_vector_lock(void)
 }
 
 void unlock_vector_lock(void)
+	__releases(&vector_lock)
 {
 	raw_spin_unlock(&vector_lock);
 }
-- 
2.32.0

