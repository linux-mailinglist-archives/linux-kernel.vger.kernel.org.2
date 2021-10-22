Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5B2436EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 02:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhJVApA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 20:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhJVAo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 20:44:57 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED6EC061764;
        Thu, 21 Oct 2021 17:42:40 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id s3so2636905ild.0;
        Thu, 21 Oct 2021 17:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fGQU2RHkVxGOExQu2OUZpB0obfWrd6o1lB0pM6j+C8w=;
        b=jQUPWRD0bTWD6LHJZFV95EshZcCSrBjWuLFBs0ZdH9BRn6D2fMHXdmHHG+u044ISvs
         bxcHB7VlcduRlttnzOm87YaaT3TQKAa+ahXhZU3Uyffv7SRX9pIw7xgDD2BcmlvqA4nx
         4YKxUnrJ0hjgHL6732sLvroNhR6rPoIctAFFmUELExZ2S5ZrBuq6wp262dPXG29qxNH5
         LODYIHwBSGv4XqiQpVZ7iD6YZRp8mQF7dbMpWHW8fKKAryyBrkMXuqqqVQibrjCseTZo
         HwGzHw0qnitY8ORdNiTLIlovgZML1ObQLaguR5tbahVcPDautsGuYbKxJ33cSTQmH3I7
         Dtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fGQU2RHkVxGOExQu2OUZpB0obfWrd6o1lB0pM6j+C8w=;
        b=0TR7PN9CG6vlJFSfxTgGIJ46SQStARD4rS/6bV2GkuDuSoP3fPMT0JPbG9/jNi3Vpz
         GivBs7efyNYm/i/kN465AY9ZZttrthyk0EsNxci2Y9Vym62FytMiJufolVZyZYd63ueT
         8fiMTvePT9Lk1aEN01LDsNCkfmfjEAAw+CaUPE2YXWTcB0l/jtKVnwcdl9FfQfJQQeR6
         w8ZkX4hv4Yew0dRtiGiikz2ILV5wdH4ENKVGIjjNooR3KWTX4ADsgBROSc6UDhOFhtM1
         WzToPEFXjKO3TXNIVv5KWxoZXoSVj+7U3ZR/8fvdihyDkulaZDrH8UwjEM5lWvTZoxbA
         PQxw==
X-Gm-Message-State: AOAM532NvRN4Zhb7yN8t+Z2RL3JlE78Pg/sCmGajTkFscqFrjsaS7id6
        n3wGGoQVvp0gf5qoK6jF4AU=
X-Google-Smtp-Source: ABdhPJzX1RUaSmHriEj5dNW0g88CUW3B5ivdmHZx1Z9XqGib/lVFxaKS2hwA/uyuKhaLoxOQBb+hRA==
X-Received: by 2002:a92:cd82:: with SMTP id r2mr6097525ilb.198.1634863360003;
        Thu, 21 Oct 2021 17:42:40 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id l10sm3282867ioq.8.2021.10.21.17.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 17:42:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4CBD827C0054;
        Thu, 21 Oct 2021 20:42:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 21 Oct 2021 20:42:38 -0400
X-ME-Sender: <xms:_QhyYVoSHpKUg7aKaCauZufLn1HLmtUoR1B9C2zuu1jcPYWP7Y6c6w>
    <xme:_QhyYXrIOHqGdNVKCBp0_z__eGBTpriaD1Tcp8bbS_PhPwNij9ooJCPpqP_vY36Fz
    BeO4vFk8UBSjHl8hA>
X-ME-Received: <xmr:_QhyYSNQI6LZ6z2Dw1FrXVuACTKUNLvRMzS5FMYbBKO--oCCKfYUjRHM5gE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvjedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepieeuveejleehudetfeevfeelgfejteefhedvkedukefggedugefhudfhteevjedu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:_QhyYQ79L0LS4oCB8ziZ1YXohLTQSkNE4JbJUCBlZYZmS9gQkHjNTw>
    <xmx:_QhyYU4X9fSZIp5JB080fSdDWYq8w-G4zJZycqe4kve4O0gLWyKwNg>
    <xmx:_QhyYYicGSDm2SO4992RHpfo32qdISCKIXeqSHH2s4wi-2lAQJc-qA>
    <xmx:_QhyYVF9ljWZhkkIqLq0zpPIBN4CTv8Kiab7zOHY9QSQBYbd-VYCOs00lj4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Oct 2021 20:42:36 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] workqueue: doc: Call out the non-reentrance conditions
Date:   Fri, 22 Oct 2021 08:42:08 +0800
Message-Id: <20211022004208.350992-1-boqun.feng@gmail.com>
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
use it to describe a work item instance and improve the doc.

[1]: https://lore.kernel.org/lkml/CAJhGHyDudet_xyNk=8xnuO2==o-u06s0E0GZVP4Q67nmQ84Ceg@mail.gmail.com/

Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
v1 -> v2:

*	Apply the suggestion from Matthew and Tejun

[v1]: https://lore.kernel.org/lkml/20211018013117.256284-1-boqun.feng@gmail.com/

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

