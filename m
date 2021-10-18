Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE80430D87
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 03:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345010AbhJRBdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 21:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242987AbhJRBdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 21:33:51 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AADC06161C;
        Sun, 17 Oct 2021 18:31:41 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id y17so13202679ilb.9;
        Sun, 17 Oct 2021 18:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=itLvXSj0egwKycv7hBiTETZl/qGBc0N5NpF6/aBGmVc=;
        b=orLHn8u4jjhyFCfzKFpAzi2rQJmd88jiYGaqjb92RBSMNszikVp+zQtLmaE3roqg78
         EzATwJKjM1rcnZP4R+e5Nqzdr0/GZn1brABXGYWdJOQfrT6fcl5/SvG4xv6s0eNG2ChV
         sSCzphvdSlNcoiJx0qGJBU7uosns0QomXzSJxwW9EWro0RozXnHJrSPCMVRHq/SBPe1I
         vMh60KNI5PAf8DqI5OI6ciEe4jdBMS0XtVvpTzUVIk6SrbT9wdFOMj8rtdWXg/SDoeG6
         FKWP7y0zExIOPakwt5fgEpHmnHostGeoz2hZ094ZpJGkpG9D8NqvWbYUJCtNwbMvc2zz
         bxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=itLvXSj0egwKycv7hBiTETZl/qGBc0N5NpF6/aBGmVc=;
        b=MkEXBQ5jzHw8ANddVqR2idMb6UXrE8aHisHy5p6BEGHWdtZJTiRkfj/uRaxu18qinz
         XBI0pMYKZ/Nazo2w7W5vgtB3Vl6oxro7Z4hzUHx8IgithZt7CBz+xq+84DOCuIuJji5N
         erwLXNK3EWrQIwjG70oGu4eRn9bhSvP0nrT/E+bpYIiGgFH3R1ruZ0h9gj+nbr1WL3VW
         qbYgdz0K0rEk9k9N29vPWw922gMLKt973uwJk2E1rAxi1gw9Cgax5VElnKbFci9Zj8/R
         bhDAvYRtituTbehZNabN0x5J3XwNmP4sGfs0YjNKtz09ydQHkr3tPt/JX+sXgxjUxqDT
         Kicw==
X-Gm-Message-State: AOAM531gsUzCOAOfSWXXqDUnnj6sQPRLkVVEoP1VasVQeKAsNwzxZCY1
        nhRrDFwr/4fdU2PWcFfZIiw=
X-Google-Smtp-Source: ABdhPJwQlEHrXTGaOUuVuaKbb9jxTFAFbQUZeoZie34DIKawGs0W6o8NGfigxsaTf3yIw3rCdAWSUg==
X-Received: by 2002:a05:6e02:1a61:: with SMTP id w1mr12669237ilv.197.1634520700570;
        Sun, 17 Oct 2021 18:31:40 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id y16sm6207914iln.74.2021.10.17.18.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 18:31:39 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 67CCE27C0054;
        Sun, 17 Oct 2021 21:31:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 17 Oct 2021 21:31:38 -0400
X-ME-Sender: <xms:ec5sYYoFjjPQScP7LZH8BCjdAkMzIYTtV91ktgA12_tlL_KcQYan_A>
    <xme:ec5sYepzoJu5v9dEYE7YcoJXIetf_RUCfFXKFjQk0VH1sr740iV41brykOifwXao2
    qpiChAOfzmEBfhzJA>
X-ME-Received: <xmr:ec5sYdPujSo2jMwY_kP9W6VmHc-ztFvGENHr9DYxdgnPUbiiRuzdR2MTLQDiKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdduledggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepieeuveejleehudetfeevfeelgfejteefhedvkedukefggedugefhudfhteevjedu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ec5sYf6tZwwQ1E4mdr2zVrHFcAGV-uaSspSI9tL8HdrBIqMUdZdxYw>
    <xmx:ec5sYX4N41RaTJPOrWS2nWdIjByQWlhNKvnzdU_Ut4z6fMV30SkwBQ>
    <xmx:ec5sYfiO2ldkjHTgRM07PoQb2wroXlAmXHHSEzL32FzbIHW2vnh7zA>
    <xmx:es5sYRsyMnnc1b78eJFnlOttbe0KBxZpiwuktZzT3pL7lmCo4dY3Jg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Oct 2021 21:31:37 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] workqueue: doc: Call out the non-reentrance conditions
Date:   Mon, 18 Oct 2021 09:31:17 +0800
Message-Id: <20211018013117.256284-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current doc of workqueue API suggests that work items are
non-reentrant: any work item is guaranteed to be executed by at most one
worker system-wide at any given time. However this is not true, the
following case can cause a work item W executed by two workers at
the same time:

        queue_work_on(0, WQ1, W);
        // after a worker picks up W and clear the pending bit
        queue_work_on(1, WQ2, W);
        // workers on CPU0 and CPU1 will execute W in the same time.

, which means the non-reentrance of a work item is conditional, and
Lai Jiangshan provided a nice summary[1] of the conditions, therefore
use it to improve the doc.

[1]: https://lore.kernel.org/lkml/CAJhGHyDudet_xyNk=8xnuO2==o-u06s0E0GZVP4Q67nmQ84Ceg@mail.gmail.com/

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 Documentation/core-api/workqueue.rst | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 541d31de8926..3b22ed137662 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -216,10 +216,6 @@ resources, scheduled and executed.
 
   This flag is meaningless for unbound wq.
 
-Note that the flag ``WQ_NON_REENTRANT`` no longer exists as all
-workqueues are now non-reentrant - any work item is guaranteed to be
-executed by at most one worker system-wide at any given time.
-
 
 ``max_active``
 --------------
@@ -391,6 +387,23 @@ the stack trace of the offending worker thread. ::
 The work item's function should be trivially visible in the stack
 trace.
 
+Non-reentrance Conditions
+=========================
+
+Workqueue guarantees that a work item cannot be re-entrant if the following
+conditions hold after a work item gets queued:
+
+        1. The work function hasn't been changed.
+        2. No one queues the work item to another workqueue.
+        3. The work item hasn't been reinitiated.
+
+In other words, if the above conditions hold, the work item is guaranteed to be
+executed by at most one worker system-wide at any given time.
+
+Note that requeuing the work item (to the same queue) in the self function
+doesn't break these conditions, so it's safe to do. Otherwise, caution is
+required when breaking the conditions inside a work function.
+
 
 Kernel Inline Documentations Reference
 ======================================
-- 
2.33.0

