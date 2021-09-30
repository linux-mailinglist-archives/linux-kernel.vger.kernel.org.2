Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF51D41DABA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349167AbhI3NLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbhI3NLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:11:17 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908ABC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:09:34 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id b12so6724267ilf.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QgV0LbzKncMrZjUG8Mlw0nvrwy2S1EwBxdEnBRU4Uus=;
        b=Gz4LG/4A5EzQ+sW66r91veaHdTH0B2JiPFcsBybaACblUgx9Ket3MPPunmjfBpSH2o
         zHZJh/+iCXH1FZO8P+g6kBvEeknhgG0e9rW5v969AHvKWwsYxYGBogoOPjzuKyIrQP5m
         F+sV3zAyMIyFenc2j7L7rPedh/gpoccyKF13YR4ffIIHda0Zq9hMwTyMf1/pmH+bavR0
         jcaIJ0ZTXDGDkIwpWFgN07MzpSBaRfFddZW4J0yPs3WABbjDin/YorI1vl5Ibd1ELBCn
         m5ulUBQj+XVTTZnmhc+pouLTm30w5eBHLD/45384rQqASILBpMfp1o5wO59NKdX1xbml
         QSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QgV0LbzKncMrZjUG8Mlw0nvrwy2S1EwBxdEnBRU4Uus=;
        b=jswtA7a93GDaHBj3PcIAIT1e+uoJ72eMJpzXSodu5GC36aApjuIE8DtBGufeKFN+ts
         n5nR75HIlWSGtGAUQrC/a/RsiUHVKxh98k7LwEh3qH49Hb5vB0sEJYkhS/BrCmlnZNHj
         4a8cLEq6RPGh73VgN9rJm//f9wKH2iIACd3IbSr9IzGfUtaicq3TJZ+3WqjpjYhBNtNj
         GJQ4Bu40MwBFSIT2Qm1ApSLrGIAOKQm1jYf03eyKSb7aL4q1v+aYwlagqqOC6nnMWx/h
         0rKn6OdZqQK+X+YN4KuWckHaiweROFNj4LzLS/k6NxfvxBmKtBPYVEfvhATQ6spYOIfT
         BpKw==
X-Gm-Message-State: AOAM532z6qfERbJmpnbaNqfyni5igYmjANoUphrMCYsuYFrKGxRc1127
        dlITlpGSwIgj/qCTh1tYScCjLanv8HsLMw==
X-Google-Smtp-Source: ABdhPJymrnFE2DZCQlZZZ3m+bFGz4x3P077t5RPeX6cCddb+v1SzoXq0RQACAkD07TS2TgGc6FO78A==
X-Received: by 2002:a05:6e02:1bc9:: with SMTP id x9mr4334732ilv.168.1633007373896;
        Thu, 30 Sep 2021 06:09:33 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id l1sm1746994ilc.65.2021.09.30.06.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:09:32 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id A408C27C0060;
        Thu, 30 Sep 2021 09:09:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 30 Sep 2021 09:09:31 -0400
X-ME-Sender: <xms:C7dVYU6Gb4Xs9UP22vPk6KegT6f4tiFg66uKskY5jYftgWw7oPK8JA>
    <xme:C7dVYV5fBL8u8ipMiEDpiu8QT8q-s7DIhQNywDPTWySKYoZwnKXl19IeTMUaPjn8a
    TkwYCNgPvZhh1VUwg>
X-ME-Received: <xmr:C7dVYTdnk6hq6DLwQ4rx8jPSeRYB2raGU7crC3eF2WDDoqJTQS5nMgAXars>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekgedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepieeuveejleehudetfeevfeelgfejteefhedvkedukefggedugefhudfhteevjedu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:C7dVYZLIFVMmTw9ZXepbKQQepi2Fv1fYXcIZMmybgR9Fog2X84I4fA>
    <xmx:C7dVYYJWVbERiTrbWSHCtglm5CmRsGxl0EN_6IXGiRk4Fl3RpDyhzQ>
    <xmx:C7dVYaw9zSmwKD5yxtlD0HQbw4l17tNF3xFMGLovlOokiVyge5oXcQ>
    <xmx:C7dVYdDYkbi5n4l89-VDd6zuc-XRYsnOlqFzcdfeg7uwtmOTmeWLBDzs5FQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Sep 2021 09:09:30 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     "Paul E . McKenney " <paulmck@kernel.org>,
        Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mpe@ellerman.id.au,
        Boqun Feng <boqun.feng@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] tools/memory-model: Provide extra ordering for unlock+lock pair on the same CPU
Date:   Thu, 30 Sep 2021 21:08:23 +0800
Message-Id: <20210930130823.2103688-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent discussion[1] shows that we are in favor of strengthening the
ordering of unlock + lock on the same CPU: a unlock and a po-after lock
should provide the so-called RCtso ordering, that is a memory access S
po-before the unlock should be ordered against a memory access R
po-after the lock, unless S is a store and R is a load.

The strengthening meets programmers' expection that "sequence of two
locked regions to be ordered wrt each other" (from Linus), and can
reduce the mental burden when using locks. Therefore add it in LKMM.

[1]: https://lore.kernel.org/lkml/20210909185937.GA12379@rowland.harvard.edu/

Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
Alan,

I added the "Co-developed-by" and "Signed-off-by" tags since most of the
work is done by you. Feel free to let me know if you want to change
anything.

Regards,
Boqun


 .../Documentation/explanation.txt             | 44 +++++++++++--------
 tools/memory-model/linux-kernel.cat           |  6 +--
 ...LB+unlocklockonceonce+poacquireonce.litmus | 33 ++++++++++++++
 ...unlocklockonceonce+fencermbonceonce.litmus | 33 ++++++++++++++
 tools/memory-model/litmus-tests/README        |  8 ++++
 5 files changed, 102 insertions(+), 22 deletions(-)
 create mode 100644 tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 5d72f3112e56..394ee57d58f2 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1813,15 +1813,16 @@ spin_trylock() -- we can call these things lock-releases and
 lock-acquires -- have two properties beyond those of ordinary releases
 and acquires.
 
-First, when a lock-acquire reads from a lock-release, the LKMM
-requires that every instruction po-before the lock-release must
-execute before any instruction po-after the lock-acquire.  This would
-naturally hold if the release and acquire operations were on different
-CPUs, but the LKMM says it holds even when they are on the same CPU.
-For example:
+First, when a lock-acquire reads from or is po-after a lock-release,
+the LKMM requires that every instruction po-before the lock-release
+must execute before any instruction po-after the lock-acquire.  This
+would naturally hold if the release and acquire operations were on
+different CPUs and accessed the same lock variable, but the LKMM says
+it also holds when they are on the same CPU, even if they access
+different lock variables.  For example:
 
 	int x, y;
-	spinlock_t s;
+	spinlock_t s, t;
 
 	P0()
 	{
@@ -1830,9 +1831,9 @@ For example:
 		spin_lock(&s);
 		r1 = READ_ONCE(x);
 		spin_unlock(&s);
-		spin_lock(&s);
+		spin_lock(&t);
 		r2 = READ_ONCE(y);
-		spin_unlock(&s);
+		spin_unlock(&t);
 	}
 
 	P1()
@@ -1842,10 +1843,10 @@ For example:
 		WRITE_ONCE(x, 1);
 	}
 
-Here the second spin_lock() reads from the first spin_unlock(), and
-therefore the load of x must execute before the load of y.  Thus we
-cannot have r1 = 1 and r2 = 0 at the end (this is an instance of the
-MP pattern).
+Here the second spin_lock() is po-after the first spin_unlock(), and
+therefore the load of x must execute before the load of y, even though
+the two locking operations use different locks.  Thus we cannot have
+r1 = 1 and r2 = 0 at the end (this is an instance of the MP pattern).
 
 This requirement does not apply to ordinary release and acquire
 fences, only to lock-related operations.  For instance, suppose P0()
@@ -1872,13 +1873,13 @@ instructions in the following order:
 
 and thus it could load y before x, obtaining r2 = 0 and r1 = 1.
 
-Second, when a lock-acquire reads from a lock-release, and some other
-stores W and W' occur po-before the lock-release and po-after the
-lock-acquire respectively, the LKMM requires that W must propagate to
-each CPU before W' does.  For example, consider:
+Second, when a lock-acquire reads from or is po-after a lock-release,
+and some other stores W and W' occur po-before the lock-release and
+po-after the lock-acquire respectively, the LKMM requires that W must
+propagate to each CPU before W' does.  For example, consider:
 
 	int x, y;
-	spinlock_t x;
+	spinlock_t s;
 
 	P0()
 	{
@@ -1908,7 +1909,12 @@ each CPU before W' does.  For example, consider:
 
 If r1 = 1 at the end then the spin_lock() in P1 must have read from
 the spin_unlock() in P0.  Hence the store to x must propagate to P2
-before the store to y does, so we cannot have r2 = 1 and r3 = 0.
+before the store to y does, so we cannot have r2 = 1 and r3 = 0.  But
+if P1 had used a lock variable different from s, the writes could have
+propagated in either order.  (On the other hand, if the code in P0 and
+P1 had all executed on a single CPU, as in the example before this
+one, then the writes would have propagated in order even if the two
+critical sections used different lock variables.)
 
 These two special requirements for lock-release and lock-acquire do
 not arise from the operational model.  Nevertheless, kernel developers
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 2a9b4fe4a84e..d70315fddef6 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -27,7 +27,7 @@ include "lock.cat"
 (* Release Acquire *)
 let acq-po = [Acquire] ; po ; [M]
 let po-rel = [M] ; po ; [Release]
-let po-unlock-rf-lock-po = po ; [UL] ; rf ; [LKR] ; po
+let po-unlock-lock-po = po ; [UL] ; (po|rf) ; [LKR] ; po
 
 (* Fences *)
 let R4rmb = R \ Noreturn	(* Reads for which rmb works *)
@@ -70,12 +70,12 @@ let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
 let to-r = addr | (dep ; [Marked] ; rfi)
-let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
+let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
 
 (* Propagation: Ordering from release operations and strong fences. *)
 let A-cumul(r) = (rfe ; [Marked])? ; r
 let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
-	po-unlock-rf-lock-po) ; [Marked]
+	po-unlock-lock-po) ; [Marked]
 let prop = [Marked] ; (overwrite & ext)? ; cumul-fence* ;
 	[Marked] ; rfe? ; [Marked]
 
diff --git a/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
new file mode 100644
index 000000000000..955b9c7cdc7f
--- /dev/null
+++ b/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
@@ -0,0 +1,33 @@
+C LB+unlocklockonceonce+poacquireonce
+
+(*
+ * Result: Never
+ *
+ * If two locked critical sections execute on the same CPU, all accesses
+ * in the first must execute before any accesses in the second, even if
+ * the critical sections are protected by different locks.
+ *)
+
+{}
+
+P0(spinlock_t *s, spinlock_t *t, int *x, int *y)
+{
+	int r1;
+
+	spin_lock(s);
+	r1 = READ_ONCE(*x);
+	spin_unlock(s);
+	spin_lock(t);
+	WRITE_ONCE(*y, 1);
+	spin_unlock(t);
+}
+
+P1(int *x, int *y)
+{
+	int r2;
+
+	r2 = smp_load_acquire(y);
+	WRITE_ONCE(*x, 1);
+}
+
+exists (0:r1=1 /\ 1:r2=1)
diff --git a/tools/memory-model/litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus b/tools/memory-model/litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus
new file mode 100644
index 000000000000..2feb1398be71
--- /dev/null
+++ b/tools/memory-model/litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus
@@ -0,0 +1,33 @@
+C MP+unlocklockonceonce+fencermbonceonce
+
+(*
+ * Result: Never
+ *
+ * If two locked critical sections execute on the same CPU, stores in the
+ * first must propagate to each CPU before stores in the second do, even if
+ * the critical sections are protected by different locks.
+ *)
+
+{}
+
+P0(spinlock_t *s, spinlock_t *t, int *x, int *y)
+{
+	spin_lock(s);
+	WRITE_ONCE(*x, 1);
+	spin_unlock(s);
+	spin_lock(t);
+	WRITE_ONCE(*y, 1);
+	spin_unlock(t);
+}
+
+P1(int *x, int *y)
+{
+	int r1;
+	int r2;
+
+	r1 = READ_ONCE(*y);
+	smp_rmb();
+	r2 = READ_ONCE(*x);
+}
+
+exists (1:r1=1 /\ 1:r2=0)
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 681f9067fa9e..d311a0ff1ae6 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -63,6 +63,10 @@ LB+poonceonces.litmus
 	As above, but with store-release replaced with WRITE_ONCE()
 	and load-acquire replaced with READ_ONCE().
 
+LB+unlocklockonceonce+poacquireonce.litmus
+	Does a unlock+lock pair provides ordering guarantee between a
+	load and a store?
+
 MP+onceassign+derefonce.litmus
 	As below, but with rcu_assign_pointer() and an rcu_dereference().
 
@@ -90,6 +94,10 @@ MP+porevlocks.litmus
 	As below, but with the first access of the writer process
 	and the second access of reader process protected by a lock.
 
+MP+unlocklockonceonce+fencermbonceonce.litmus
+	Does a unlock+lock pair provides ordering guarantee between a
+	store and another store?
+
 MP+fencewmbonceonce+fencermbonceonce.litmus
 	Does a smp_wmb() (between the stores) and an smp_rmb() (between
 	the loads) suffice for the message-passing litmus test, where one
-- 
2.32.0

