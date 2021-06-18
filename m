Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC383AD0DC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 19:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbhFRREE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 13:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhFRRD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:03:58 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD36C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:01:47 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q3so7752956iop.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EUNien+aG4u7uIUAY1T/akeSoYudRzYFUT7gMdbkf9c=;
        b=iYbXRBVdeFLx03Ub2lztmis9AW08JCEKt2++nTwTfGHjNVnkaQwyuSGFBoYypO/1+D
         s9wuUboQC4U58tcZu56HWAGybtcRcRgem9ZheUKr1u2T5PQzEhu2LOkjmhrLJUPKrUW6
         VxNTVRHK91tbcHuUh6exFcxpAO5C2A/WmYGRtGTDLeYl5uOmaG5+Ng35Y89in1BNXtsm
         pOEKZmc3SfSQJ1vVKPrh0z8Q/s4+tqV1FRZNaTYnOCJDt3dzjtxRD9sFltTULuOCdkrj
         aOckBdwHK6lesFwrdUxOC6IRzyDTmc0dLbsXT1uS9bsy+3ffSm/zQc4H8UiMnIvAM8u+
         4XUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EUNien+aG4u7uIUAY1T/akeSoYudRzYFUT7gMdbkf9c=;
        b=BE6XO7uRDZzc0IlZLD8/E4gHaTNIwQojlbsRJZpGGqhB+cYpO9nmOVjX2dGKUIdLCS
         fxePAZJ+qnLUqqbJ6SNbJ0abA3+EBSw3yBP1urARj6PkmoEhqmkD34mXm+9UL3UAS46f
         0d+aWm6payTLkFntviFB2z7IeRaTa/krwvI6FhZYZQ7T7DtsajN1Pp5dPzJVk06saM4a
         MYtHca7Zgc7vc7hs1sR9KqlEWGPSzBWEmcaF/hGBuaoBnt18M1LaXW2ME1LL9tvXrj3P
         3DrS48zXB4doTnaxN5s/mRGQ/z0OqTZlsvG4q2gvSR/+ejFijc9P/SkvF4SSTVKm1IQ7
         cwQA==
X-Gm-Message-State: AOAM530aR7uF2M+WutdnTuxHPascUZQAETdzdsLGVCRESZ7J0VvWaEyn
        HTkPmp1g/Rqnl9ihJryyv5U=
X-Google-Smtp-Source: ABdhPJz8EGPbCmSDOFMc6GMloJe9Bs7GHWyAt5R/wQ8nA5UZfpeW5ljcQ3XnFbobWJdnJ4r+NwbLTQ==
X-Received: by 2002:a02:4b44:: with SMTP id q65mr4214959jaa.28.1624035706876;
        Fri, 18 Jun 2021 10:01:46 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id l11sm1402485ilo.77.2021.06.18.10.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 10:01:46 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id C290A27C005A;
        Fri, 18 Jun 2021 13:01:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 18 Jun 2021 13:01:45 -0400
X-ME-Sender: <xms:edHMYMr4qxC-xfzlLyVYKsm2AxBVRiNqs6qhX7ZB7GIT95pLJ6XgMA>
    <xme:edHMYCqG7GjcaU-lRNl49oq3a9mfGhM2OeElhn3UuTfBLHfkbkjXWG9SZNJtypeTW
    OYVGPSdwHm4nQIn7A>
X-ME-Received: <xmr:edHMYBM0Vz9YTE2wqg3AwXTobzpH7-EhomXSKSlSsu_Ksn23KTxyhcAQfUI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeffedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeei
    ueeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:edHMYD6qURECYGHr_rHPW7P6i3yY5yakFCOt78GMG19UD6VTNhEpaw>
    <xmx:edHMYL70JLB4i1hnwP-hbZGdO5zGJVYCwJ8mbGNwmk7JF6GB3lkjVg>
    <xmx:edHMYDiFrRdM-jb9LIzDnVLMP34joxhi8tUioZEHqnKXLsX-k9brjQ>
    <xmx:edHMYBRnG3KNTTFw3foq5KmIiJRw_F2wKe7DGc3MerbSrbHURnsF4Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jun 2021 13:01:45 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 4/4] locking/selftests: Add a selftest for check_irq_usage()
Date:   Sat, 19 Jun 2021 01:01:10 +0800
Message-Id: <20210618170110.3699115-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618170110.3699115-1-boqun.feng@gmail.com>
References: <20210618170110.3699115-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg reported a lockdep problem which could be reproduced by
the special test case introduced in this patch, so add it.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/locking-selftest.c | 65 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 2d85abac1744..5c50b0910396 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -53,6 +53,7 @@ __setup("debug_locks_verbose=", setup_debug_locks_verbose);
 #define LOCKTYPE_WW	0x10
 #define LOCKTYPE_RTMUTEX 0x20
 #define LOCKTYPE_LL	0x40
+#define LOCKTYPE_SPECIAL 0x80
 
 static struct ww_acquire_ctx t, t2;
 static struct ww_mutex o, o2, o3;
@@ -2744,6 +2745,66 @@ static void local_lock_tests(void)
 	pr_cont("\n");
 }
 
+static void hardirq_deadlock_softirq_not_deadlock(void)
+{
+	/* mutex_A is hardirq-unsafe and softirq-unsafe */
+	/* mutex_A -> lock_C */
+	mutex_lock(&mutex_A);
+	HARDIRQ_DISABLE();
+	spin_lock(&lock_C);
+	spin_unlock(&lock_C);
+	HARDIRQ_ENABLE();
+	mutex_unlock(&mutex_A);
+
+	/* lock_A is hardirq-safe */
+	HARDIRQ_ENTER();
+	spin_lock(&lock_A);
+	spin_unlock(&lock_A);
+	HARDIRQ_EXIT();
+
+	/* lock_A -> lock_B */
+	HARDIRQ_DISABLE();
+	spin_lock(&lock_A);
+	spin_lock(&lock_B);
+	spin_unlock(&lock_B);
+	spin_unlock(&lock_A);
+	HARDIRQ_ENABLE();
+
+	/* lock_B -> lock_C */
+	HARDIRQ_DISABLE();
+	spin_lock(&lock_B);
+	spin_lock(&lock_C);
+	spin_unlock(&lock_C);
+	spin_unlock(&lock_B);
+	HARDIRQ_ENABLE();
+
+	/* lock_D is softirq-safe */
+	SOFTIRQ_ENTER();
+	spin_lock(&lock_D);
+	spin_unlock(&lock_D);
+	SOFTIRQ_EXIT();
+
+	/* And lock_D is hardirq-unsafe */
+	SOFTIRQ_DISABLE();
+	spin_lock(&lock_D);
+	spin_unlock(&lock_D);
+	SOFTIRQ_ENABLE();
+
+	/*
+	 * mutex_A -> lock_C -> lock_D is softirq-unsafe -> softirq-safe, not
+	 * deadlock.
+	 *
+	 * lock_A -> lock_B -> lock_C -> lock_D is hardirq-safe ->
+	 * hardirq-unsafe, deadlock.
+	 */
+	HARDIRQ_DISABLE();
+	spin_lock(&lock_C);
+	spin_lock(&lock_D);
+	spin_unlock(&lock_D);
+	spin_unlock(&lock_C);
+	HARDIRQ_ENABLE();
+}
+
 void locking_selftest(void)
 {
 	/*
@@ -2872,6 +2933,10 @@ void locking_selftest(void)
 
 	local_lock_tests();
 
+	print_testname("hardirq_unsafe_softirq_safe");
+	dotest(hardirq_deadlock_softirq_not_deadlock, FAILURE, LOCKTYPE_SPECIAL);
+	pr_cont("\n");
+
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
 		debug_locks = 0;
-- 
2.30.2

