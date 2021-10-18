Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEA24316D6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhJRLJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhJRLJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:09:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781DEC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 04:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8ekJQdX7jlhJtUiwWf8Al/Y9FMjcTQ9YgLpyr7wHCr4=; b=RTUdIzEC9YzCDf9ka4l5bBGd3K
        P5e5lWoGnBReK0FYWJ7hR+6uzFDXm6eiEM4ttdauMFTukDzEWnvLPN/nEwreSY6Pw8cGRLbcv2FH+
        NUpb2TeMUBZUNVA8URHM3qiwVXKRqSW2i+ZVXOXLwBypJ+06c3yOdA7qmJ9QhwU/S+uLk9Y4df1LD
        A36i9rhqPpBS4VqOv50dYuRF+ghuINCMH4eeL5ctsX5H2IrzcAcZGI8kYJnRir0sRrdSlCJpvJ8/l
        xY+ytdB3UgHXGSLas5qyJnEELuLOzJuf6ewV/C1oC7pXzjMWp/Wnzsj6jwcUqq5anPhnZtDoECjfg
        TmUjC3kQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcQTd-00AXJT-IK; Mon, 18 Oct 2021 11:06:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2B7B3300242;
        Mon, 18 Oct 2021 13:06:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D14F22C4A3AD7; Mon, 18 Oct 2021 13:06:43 +0200 (CEST)
Date:   Mon, 18 Oct 2021 13:06:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:locking/core 41/43]
 kernel/locking/rwsem.c:1023:19: error: variable has incomplete type 'enum
 owner_state'
Message-ID: <YW1VQ80yoUmWC8Zv@hirez.programming.kicks-ass.net>
References: <202110152145.nWCivoXy-lkp@intel.com>
 <8c0f011a-db83-001e-3cce-326cb8228a75@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c0f011a-db83-001e-3cce-326cb8228a75@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 02:41:17AM +0800, Xu, Yanfei wrote:
> 
> 
> On 10/15/21 9:51 PM, kernel test robot wrote:
> > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> > head:   44e63f63c47dfb202eb25cdd97d04ec7e47f51d8
> > commit: b08614038dba3f6982e1e7701f23784bb0aedba6 [41/43] locking/rwsem: disable preemption for spinning region
> > config: hexagon-randconfig-r041-20211014 (attached as .config)
> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project acb3b187c4c88650a6a717a1bcb234d27d0d7f54)
> > reproduce (this is a W=1 build):
> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=b08614038dba3f6982e1e7701f23784bb0aedba6
> >          git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
> >          git fetch --no-tags peterz-queue locking/core
> >          git checkout b08614038dba3f6982e1e7701f23784bb0aedba6
> >          # save the attached .config to linux build tree
> >          mkdir build_dir
> >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/locking/
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> > > > kernel/locking/rwsem.c:1023:19: error: variable has incomplete type 'enum owner_state'
> >             enum owner_state owner_state;
> >                              ^
> >     kernel/locking/rwsem.c:1023:7: note: forward declaration of 'enum owner_state'
> >             enum owner_state owner_state;
> >                  ^
> >     1 error generated.
> > 
> 
> 
> Hi Peter,
> 
> I send a patch named ("locking/rwsem: Introduce __rwsem_spin_on_owner()")
> for fixing this.

How about we do something like this instead? That makes the whole
CONFIG_RWSEM_SPIN_ON_OWNER=n side more consistent.


---

--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -577,6 +577,24 @@ static inline bool rwsem_try_write_lock(
 	return true;
 }
 
+/*
+ * The rwsem_spin_on_owner() function returns the following 4 values
+ * depending on the lock owner state.
+ *   OWNER_NULL  : owner is currently NULL
+ *   OWNER_WRITER: when owner changes and is a writer
+ *   OWNER_READER: when owner changes and the new owner may be a reader.
+ *   OWNER_NONSPINNABLE:
+ *		   when optimistic spinning has to stop because either the
+ *		   owner stops running, is unknown, or its timeslice has
+ *		   been used up.
+ */
+enum owner_state {
+	OWNER_NULL		= 1 << 0,
+	OWNER_WRITER		= 1 << 1,
+	OWNER_READER		= 1 << 2,
+	OWNER_NONSPINNABLE	= 1 << 3,
+};
+
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 /*
  * Try to acquire write lock before the writer has been put on wait queue.
@@ -632,23 +650,6 @@ static inline bool rwsem_can_spin_on_own
 	return ret;
 }
 
-/*
- * The rwsem_spin_on_owner() function returns the following 4 values
- * depending on the lock owner state.
- *   OWNER_NULL  : owner is currently NULL
- *   OWNER_WRITER: when owner changes and is a writer
- *   OWNER_READER: when owner changes and the new owner may be a reader.
- *   OWNER_NONSPINNABLE:
- *		   when optimistic spinning has to stop because either the
- *		   owner stops running, is unknown, or its timeslice has
- *		   been used up.
- */
-enum owner_state {
-	OWNER_NULL		= 1 << 0,
-	OWNER_WRITER		= 1 << 1,
-	OWNER_READER		= 1 << 2,
-	OWNER_NONSPINNABLE	= 1 << 3,
-};
 #define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER | OWNER_READER)
 
 static inline enum owner_state
@@ -878,12 +879,11 @@ static inline bool rwsem_optimistic_spin
 
 static inline void clear_nonspinnable(struct rw_semaphore *sem) { }
 
-static inline int
+static inline enum owner_state
 rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
-	return 0;
+	return OWNER_NONSPINNABLE;
 }
-#define OWNER_NULL	1
 #endif
 
 /*
@@ -1095,9 +1095,16 @@ rwsem_down_write_slowpath(struct rw_sema
 		 * In this case, we attempt to acquire the lock again
 		 * without sleeping.
 		 */
-		if (wstate == WRITER_HANDOFF &&
-		    rwsem_spin_on_owner(sem) == OWNER_NULL)
-			goto trylock_again;
+		if (wstate == WRITER_HANDOFF) {
+			enum owner_state owner_state;
+
+			preempt_disable();
+			owner_state = rwsem_spin_on_owner(sem);
+			preempt_enable();
+
+			if (owner_state == OWNER_NULL)
+				goto trylock_again;
+		}
 
 		/* Block until there are no active lockers. */
 		for (;;) {
