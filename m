Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6E2378335
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhEJKmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232738AbhEJKfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:35:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91E2B61361;
        Mon, 10 May 2021 10:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642493;
        bh=c8pIg8lDIM6NuLPj6G5dlS5nO09A6nePNdtVZf0UxD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pYDsaqfCezeRVMT1gbSiCDXlvY9aV1EQaqWAdvXhljosJCVxGGXnbB0d3gAH8mumn
         zWHy+rSSiN7JUt0MB6FfSUXbjDTTsbwH3bmc7Yi8Mwejfuksl7C0gC/ae0/PFDPMAi
         b5YaFx49QTQUgk99l5LAwwHCCokOX0iZAYS2irs5Tgb7KVjNY39+i6iQi1cAJPeimG
         YI/CRWnvfKjKmmX1gGX9BQhjDDkdRA2QQlQ44PbOcwPMZ0tz6Vp+z422bI3eZ7F/aX
         eeU+Lr4AAgbaqhq+JgHO0W+al/blOeLZHWroTDVQh6equOSaGhpuvwN9MJg21HY+rN
         a2Mte59RjGXNw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38z-000UYa-Oh; Mon, 10 May 2021 12:28:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: [PATCH 53/53] docs: RCU: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:27:05 +0200
Message-Id: <7958bf32e6986fa9804b7f0d4a34e961067bb6fd.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+00a0 (' '): NO-BREAK SPACE
	- U+2013 ('–'): EN DASH
	- U+2014 ('—'): EM DASH
	- U+201c ('“'): LEFT DOUBLE QUOTATION MARK
	- U+201d ('”'): RIGHT DOUBLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../Data-Structures/Data-Structures.rst       |  52 ++++----
 .../Expedited-Grace-Periods.rst               |  40 +++---
 .../Tree-RCU-Memory-Ordering.rst              |  10 +-
 .../RCU/Design/Requirements/Requirements.rst  | 126 +++++++++---------
 4 files changed, 114 insertions(+), 114 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
index f4efd6897b09..e95c6c8eeb6a 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
@@ -301,7 +301,7 @@ The ``->gp_max`` field tracks the duration of the longest grace period
 in jiffies. It is protected by the root ``rcu_node``'s ``->lock``.
 
 The ``->name`` and ``->abbr`` fields distinguish between preemptible RCU
-(“rcu_preempt” and “p”) and non-preemptible RCU (“rcu_sched” and “s”).
+("rcu_preempt" and "p") and non-preemptible RCU ("rcu_sched" and "s").
 These fields are used for diagnostic and tracing purposes.
 
 The ``rcu_node`` Structure
@@ -456,21 +456,21 @@ expedited grace periods, respectively.
 | Lockless grace-period computation! Such a tantalizing possibility!    |
 | But consider the following sequence of events:                        |
 |                                                                       |
-| #. CPU 0 has been in dyntick-idle mode for quite some time. When it   |
+| #. CPU 0 has been in dyntick-idle mode for quite some time. When it   |
 |    wakes up, it notices that the current RCU grace period needs it to |
 |    report in, so it sets a flag where the scheduling clock interrupt  |
 |    will find it.                                                      |
-| #. Meanwhile, CPU 1 is running ``force_quiescent_state()``, and       |
-|    notices that CPU 0 has been in dyntick idle mode, which qualifies  |
+| #. Meanwhile, CPU 1 is running ``force_quiescent_state()``, and       |
+|    notices that CPU 0 has been in dyntick idle mode, which qualifies  |
 |    as an extended quiescent state.                                    |
-| #. CPU 0's scheduling clock interrupt fires in the middle of an RCU   |
+| #. CPU 0's scheduling clock interrupt fires in the middle of an RCU   |
 |    read-side critical section, and notices that the RCU core needs    |
 |    something, so commences RCU softirq processing.                    |
-| #. CPU 0's softirq handler executes and is just about ready to report |
+| #. CPU 0's softirq handler executes and is just about ready to report |
 |    its quiescent state up the ``rcu_node`` tree.                      |
-| #. But CPU 1 beats it to the punch, completing the current grace      |
+| #. But CPU 1 beats it to the punch, completing the current grace      |
 |    period and starting a new one.                                     |
-| #. CPU 0 now reports its quiescent state for the wrong grace period.  |
+| #. CPU 0 now reports its quiescent state for the wrong grace period.  |
 |    That grace period might now end before the RCU read-side critical  |
 |    section. If that happens, disaster will ensue.                     |
 |                                                                       |
@@ -515,18 +515,18 @@ removes itself from the ``->blkd_tasks`` list, then that task must
 advance the pointer to the next task on the list, or set the pointer to
 ``NULL`` if there are no subsequent tasks on the list.
 
-For example, suppose that tasks T1, T2, and T3 are all hard-affinitied
-to the largest-numbered CPU in the system. Then if task T1 blocked in an
+For example, suppose that tasks T1, T2, and T3 are all hard-affinitied
+to the largest-numbered CPU in the system. Then if task T1 blocked in an
 RCU read-side critical section, then an expedited grace period started,
-then task T2 blocked in an RCU read-side critical section, then a normal
-grace period started, and finally task 3 blocked in an RCU read-side
+then task T2 blocked in an RCU read-side critical section, then a normal
+grace period started, and finally task 3 blocked in an RCU read-side
 critical section, then the state of the last leaf ``rcu_node``
 structure's blocked-task list would be as shown below:
 
 .. kernel-figure:: blkd_task.svg
 
-Task T1 is blocking both grace periods, task T2 is blocking only the
-normal grace period, and task T3 is blocking neither grace period. Note
+Task T1 is blocking both grace periods, task T2 is blocking only the
+normal grace period, and task T3 is blocking neither grace period. Note
 that these tasks will not remove themselves from this list immediately
 upon resuming execution. They will instead remain on the list until they
 execute the outermost ``rcu_read_unlock()`` that ends their RCU
@@ -611,8 +611,8 @@ expressions as follows:
    66 #endif
 
 The maximum number of levels in the ``rcu_node`` structure is currently
-limited to four, as specified by lines 21-24 and the structure of the
-subsequent “if” statement. For 32-bit systems, this allows
+limited to four, as specified by lines 21-24 and the structure of the
+subsequent "if" statement. For 32-bit systems, this allows
 16*32*32*32=524,288 CPUs, which should be sufficient for the next few
 years at least. For 64-bit systems, 16*64*64*64=4,194,304 CPUs is
 allowed, which should see us through the next decade or so. This
@@ -638,9 +638,9 @@ fields. The number of CPUs per leaf ``rcu_node`` structure is therefore
 limited to 16 given the default value of ``CONFIG_RCU_FANOUT_LEAF``. If
 ``CONFIG_RCU_FANOUT_LEAF`` is unspecified, the value selected is based
 on the word size of the system, just as for ``CONFIG_RCU_FANOUT``.
-Lines 11-19 perform this computation.
+Lines 11-19 perform this computation.
 
-Lines 21-24 compute the maximum number of CPUs supported by a
+Lines 21-24 compute the maximum number of CPUs supported by a
 single-level (which contains a single ``rcu_node`` structure),
 two-level, three-level, and four-level ``rcu_node`` tree, respectively,
 given the fanout specified by ``RCU_FANOUT`` and ``RCU_FANOUT_LEAF``.
@@ -649,18 +649,18 @@ These numbers of CPUs are retained in the ``RCU_FANOUT_1``,
 variables, respectively.
 
 These variables are used to control the C-preprocessor ``#if`` statement
-spanning lines 26-66 that computes the number of ``rcu_node`` structures
+spanning lines 26-66 that computes the number of ``rcu_node`` structures
 required for each level of the tree, as well as the number of levels
 required. The number of levels is placed in the ``NUM_RCU_LVLS``
-C-preprocessor variable by lines 27, 35, 44, and 54. The number of
+C-preprocessor variable by lines 27, 35, 44, and 54. The number of
 ``rcu_node`` structures for the topmost level of the tree is always
 exactly one, and this value is unconditionally placed into
-``NUM_RCU_LVL_0`` by lines 28, 36, 45, and 55. The rest of the levels
+``NUM_RCU_LVL_0`` by lines 28, 36, 45, and 55. The rest of the levels
 (if any) of the ``rcu_node`` tree are computed by dividing the maximum
 number of CPUs by the fanout supported by the number of levels from the
 current level down, rounding up. This computation is performed by
-lines 37, 46-47, and 56-58. Lines 31-33, 40-42, 50-52, and 62-63 create
-initializers for lockdep lock-class names. Finally, lines 64-66 produce
+lines 37, 46-47, and 56-58. Lines 31-33, 40-42, 50-52, and 62-63 create
+initializers for lockdep lock-class names. Finally, lines 64-66 produce
 an error if the maximum number of CPUs is too large for the specified
 fanout.
 
@@ -716,13 +716,13 @@ In this figure, the ``->head`` pointer references the first RCU callback
 in the list. The ``->tails[RCU_DONE_TAIL]`` array element references the
 ``->head`` pointer itself, indicating that none of the callbacks is
 ready to invoke. The ``->tails[RCU_WAIT_TAIL]`` array element references
-callback CB 2's ``->next`` pointer, which indicates that CB 1 and CB 2
+callback CB 2's ``->next`` pointer, which indicates that CB 1 and CB 2
 are both waiting on the current grace period, give or take possible
 disagreements about exactly which grace period is the current one. The
 ``->tails[RCU_NEXT_READY_TAIL]`` array element references the same RCU
 callback that ``->tails[RCU_WAIT_TAIL]`` does, which indicates that
 there are no callbacks waiting on the next RCU grace period. The
-``->tails[RCU_NEXT_TAIL]`` array element references CB 4's ``->next``
+``->tails[RCU_NEXT_TAIL]`` array element references CB 4's ``->next``
 pointer, indicating that all the remaining RCU callbacks have not yet
 been assigned to an RCU grace period. Note that the
 ``->tails[RCU_NEXT_TAIL]`` array element always references the last RCU
@@ -1031,7 +1031,7 @@ field to record the offset of the ``rcu_head`` structure within the
 enclosing RCU-protected data structure.
 
 Both of these fields are used internally by RCU. From the viewpoint of
-RCU users, this structure is an opaque “cookie”.
+RCU users, this structure is an opaque "cookie".
 
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
index 6f89cf1e567d..742921a7532b 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
@@ -304,8 +304,8 @@ representing the elements of the ``->exp_wq[]`` array.
 
 .. kernel-figure:: Funnel0.svg
 
-The next diagram shows the situation after the arrival of Task A and
-Task B at the leftmost and rightmost leaf ``rcu_node`` structures,
+The next diagram shows the situation after the arrival of Task A and
+Task B at the leftmost and rightmost leaf ``rcu_node`` structures,
 respectively. The current value of the ``rcu_state`` structure's
 ``->expedited_sequence`` field is zero, so adding three and clearing the
 bottom bit results in the value two, which both tasks record in the
@@ -313,13 +313,13 @@ bottom bit results in the value two, which both tasks record in the
 
 .. kernel-figure:: Funnel1.svg
 
-Each of Tasks A and B will move up to the root ``rcu_node`` structure.
-Suppose that Task A wins, recording its desired grace-period sequence
+Each of Tasks A and B will move up to the root ``rcu_node`` structure.
+Suppose that Task A wins, recording its desired grace-period sequence
 number and resulting in the state shown below:
 
 .. kernel-figure:: Funnel2.svg
 
-Task A now advances to initiate a new grace period, while Task B moves
+Task A now advances to initiate a new grace period, while Task B moves
 up to the root ``rcu_node`` structure, and, seeing that its desired
 sequence number is already recorded, blocks on ``->exp_wq[1]``.
 
@@ -340,7 +340,7 @@ sequence number is already recorded, blocks on ``->exp_wq[1]``.
 | ``->exp_wq[1]``.                                                      |
 +-----------------------------------------------------------------------+
 
-If Tasks C and D also arrive at this point, they will compute the same
+If Tasks C and D also arrive at this point, they will compute the same
 desired grace-period sequence number, and see that both leaf
 ``rcu_node`` structures already have that value recorded. They will
 therefore block on their respective ``rcu_node`` structures'
@@ -348,52 +348,52 @@ therefore block on their respective ``rcu_node`` structures'
 
 .. kernel-figure:: Funnel3.svg
 
-Task A now acquires the ``rcu_state`` structure's ``->exp_mutex`` and
+Task A now acquires the ``rcu_state`` structure's ``->exp_mutex`` and
 initiates the grace period, which increments ``->expedited_sequence``.
-Therefore, if Tasks E and F arrive, they will compute a desired sequence
+Therefore, if Tasks E and F arrive, they will compute a desired sequence
 number of 4 and will record this value as shown below:
 
 .. kernel-figure:: Funnel4.svg
 
-Tasks E and F will propagate up the ``rcu_node`` combining tree, with
-Task F blocking on the root ``rcu_node`` structure and Task E wait for
-Task A to finish so that it can start the next grace period. The
+Tasks E and F will propagate up the ``rcu_node`` combining tree, with
+Task F blocking on the root ``rcu_node`` structure and Task E wait for
+Task A to finish so that it can start the next grace period. The
 resulting state is as shown below:
 
 .. kernel-figure:: Funnel5.svg
 
-Once the grace period completes, Task A starts waking up the tasks
+Once the grace period completes, Task A starts waking up the tasks
 waiting for this grace period to complete, increments the
 ``->expedited_sequence``, acquires the ``->exp_wake_mutex`` and then
 releases the ``->exp_mutex``. This results in the following state:
 
 .. kernel-figure:: Funnel6.svg
 
-Task E can then acquire ``->exp_mutex`` and increment
-``->expedited_sequence`` to the value three. If new tasks G and H arrive
+Task E can then acquire ``->exp_mutex`` and increment
+``->expedited_sequence`` to the value three. If new tasks G and H arrive
 and moves up the combining tree at the same time, the state will be as
 follows:
 
 .. kernel-figure:: Funnel7.svg
 
 Note that three of the root ``rcu_node`` structure's waitqueues are now
-occupied. However, at some point, Task A will wake up the tasks blocked
+occupied. However, at some point, Task A will wake up the tasks blocked
 on the ``->exp_wq`` waitqueues, resulting in the following state:
 
 .. kernel-figure:: Funnel8.svg
 
-Execution will continue with Tasks E and H completing their grace
+Execution will continue with Tasks E and H completing their grace
 periods and carrying out their wakeups.
 
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
 +-----------------------------------------------------------------------+
-| What happens if Task A takes so long to do its wakeups that Task E's  |
+| What happens if Task A takes so long to do its wakeups that Task E's  |
 | grace period completes?                                               |
 +-----------------------------------------------------------------------+
 | **Answer**:                                                           |
 +-----------------------------------------------------------------------+
-| Then Task E will block on the ``->exp_wake_mutex``, which will also   |
+| Then Task E will block on the ``->exp_wake_mutex``, which will also   |
 | prevent it from releasing ``->exp_mutex``, which in turn will prevent |
 | the next grace period from starting. This last is important in        |
 | preventing overflow of the ``->exp_wq[]`` array.                      |
@@ -464,8 +464,8 @@ code need not worry about POSIX signals. Unfortunately, it has the
 corresponding disadvantage that workqueues cannot be used until they are
 initialized, which does not happen until some time after the scheduler
 spawns the first task. Given that there are parts of the kernel that
-really do want to execute grace periods during this mid-boot “dead
-zone”, expedited grace periods must do something else during thie time.
+really do want to execute grace periods during this mid-boot "dead
+zone", expedited grace periods must do something else during thie time.
 
 What they do is to fall back to the old practice of requiring that the
 requesting task drive the expedited grace period, as was the case before
diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index a648b423ba0e..d76c6bfdc659 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -215,7 +215,7 @@ newly arrived RCU callbacks against future grace periods:
    43 }
 
 But the only part of ``rcu_prepare_for_idle()`` that really matters for
-this discussion are lines 37–39. We will therefore abbreviate this
+this discussion are lines 37-39. We will therefore abbreviate this
 function as follows:
 
 .. kernel-figure:: rcu_node-lock.svg
@@ -418,7 +418,7 @@ wait on.
 | It is indeed not necessary for the grace period to wait on such a     |
 | critical section. However, it is permissible to wait on it. And it is |
 | furthermore important to wait on it, as this lazy approach is far     |
-| more scalable than a “big bang” all-at-once grace-period start could  |
+| more scalable than a "big bang" all-at-once grace-period start could  |
 | possibly be.                                                          |
 +-----------------------------------------------------------------------+
 
@@ -448,7 +448,7 @@ proceeds upwards from that point, and the ``rcu_node`` ``->lock``
 guarantees that the first CPU's quiescent state happens before the
 remainder of the second CPU's traversal. Applying this line of thought
 repeatedly shows that all CPUs' quiescent states happen before the last
-CPU traverses through the root ``rcu_node`` structure, the “last CPU”
+CPU traverses through the root ``rcu_node`` structure, the "last CPU"
 being the one that clears the last bit in the root ``rcu_node``
 structure's ``->qsmask`` field.
 
@@ -501,8 +501,8 @@ Forcing Quiescent States
 
 As noted above, idle and offline CPUs cannot report their own quiescent
 states, and therefore the grace-period kernel thread must do the
-reporting on their behalf. This process is called “forcing quiescent
-states”, it is repeated every few jiffies, and its ordering effects are
+reporting on their behalf. This process is called "forcing quiescent
+states", it is repeated every few jiffies, and its ordering effects are
 shown below:
 
 .. kernel-figure:: TreeRCU-gp-fqs.svg
diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 38a39476fc24..a3493b34f3dd 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -4,7 +4,7 @@ A Tour Through RCU's Requirements
 
 Copyright IBM Corporation, 2015
 
-Author: Paul E. McKenney
+Author: Paul E. McKenney
 
 The initial version of this document appeared in the
 `LWN <https://lwn.net/>`_ on those articles:
@@ -66,7 +66,7 @@ Grace-Period Guarantee
 
 RCU's grace-period guarantee is unusual in being premeditated: Jack
 Slingwine and I had this guarantee firmly in mind when we started work
-on RCU (then called “rclock”) in the early 1990s. That said, the past
+on RCU (then called "rclock") in the early 1990s. That said, the past
 two decades of experience with RCU have produced a much more detailed
 understanding of this guarantee.
 
@@ -102,7 +102,7 @@ overhead to readers, for example:
       15   WRITE_ONCE(y, 1);
       16 }
 
-Because the synchronize_rcu() on line 14 waits for all pre-existing
+Because the synchronize_rcu() on line 14 waits for all pre-existing
 readers, any instance of thread0() that loads a value of zero from
 ``x`` must complete before thread1() stores to ``y``, so that
 instance must also load a value of zero from ``y``. Similarly, any
@@ -178,7 +178,7 @@ little or no synchronization overhead in do_something_dlm().
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
 +-----------------------------------------------------------------------+
-| Why is the synchronize_rcu() on line 28 needed?                       |
+| Why is the synchronize_rcu() on line 28 needed?                       |
 +-----------------------------------------------------------------------+
 | **Answer**:                                                           |
 +-----------------------------------------------------------------------+
@@ -244,7 +244,7 @@ their rights to reorder this code as follows:
       16 }
 
 If an RCU reader fetches ``gp`` just after ``add_gp_buggy_optimized``
-executes line 11, it will see garbage in the ``->a`` and ``->b`` fields.
+executes line 11, it will see garbage in the ``->a`` and ``->b`` fields.
 And this is but one of many ways in which compiler and hardware
 optimizations could cause trouble. Therefore, we clearly need some way
 to prevent the compiler and the CPU from reordering in this manner,
@@ -279,11 +279,11 @@ shows an example of insertion:
       15   return true;
       16 }
 
-The rcu_assign_pointer() on line 13 is conceptually equivalent to a
+The rcu_assign_pointer() on line 13 is conceptually equivalent to a
 simple assignment statement, but also guarantees that its assignment
-will happen after the two assignments in lines 11 and 12, similar to the
+will happen after the two assignments in lines 11 and 12, similar to the
 C11 ``memory_order_release`` store operation. It also prevents any
-number of “interesting” compiler optimizations, for example, the use of
+number of "interesting" compiler optimizations, for example, the use of
 ``gp`` as a scratch location immediately preceding the assignment.
 
 +-----------------------------------------------------------------------+
@@ -410,11 +410,11 @@ This process is implemented by remove_gp_synchronous():
       15   return true;
       16 }
 
-This function is straightforward, with line 13 waiting for a grace
-period before line 14 frees the old data element. This waiting ensures
-that readers will reach line 7 of do_something_gp() before the data
+This function is straightforward, with line 13 waiting for a grace
+period before line 14 frees the old data element. This waiting ensures
+that readers will reach line 7 of do_something_gp() before the data
 element referenced by ``p`` is freed. The rcu_access_pointer() on
-line 6 is similar to rcu_dereference(), except that:
+line 6 is similar to rcu_dereference(), except that:
 
 #. The value returned by rcu_access_pointer() cannot be
    dereferenced. If you want to access the value pointed to as well as
@@ -488,25 +488,25 @@ systems with more than one CPU:
    section ends and the time that synchronize_rcu() returns. Without
    this guarantee, a pre-existing RCU read-side critical section might
    hold a reference to the newly removed ``struct foo`` after the
-   kfree() on line 14 of remove_gp_synchronous().
+   kfree() on line 14 of remove_gp_synchronous().
 #. Each CPU that has an RCU read-side critical section that ends after
    synchronize_rcu() returns is guaranteed to execute a full memory
    barrier between the time that synchronize_rcu() begins and the
    time that the RCU read-side critical section begins. Without this
    guarantee, a later RCU read-side critical section running after the
-   kfree() on line 14 of remove_gp_synchronous() might later run
+   kfree() on line 14 of remove_gp_synchronous() might later run
    do_something_gp() and find the newly deleted ``struct foo``.
 #. If the task invoking synchronize_rcu() remains on a given CPU,
    then that CPU is guaranteed to execute a full memory barrier sometime
    during the execution of synchronize_rcu(). This guarantee ensures
-   that the kfree() on line 14 of remove_gp_synchronous() really
-   does execute after the removal on line 11.
+   that the kfree() on line 14 of remove_gp_synchronous() really
+   does execute after the removal on line 11.
 #. If the task invoking synchronize_rcu() migrates among a group of
    CPUs during that invocation, then each of the CPUs in that group is
    guaranteed to execute a full memory barrier sometime during the
    execution of synchronize_rcu(). This guarantee also ensures that
-   the kfree() on line 14 of remove_gp_synchronous() really does
-   execute after the removal on line 11, but also in the case where the
+   the kfree() on line 14 of remove_gp_synchronous() really does
+   execute after the removal on line 11, but also in the case where the
    thread executing the synchronize_rcu() migrates in the meantime.
 
 +-----------------------------------------------------------------------+
@@ -525,8 +525,8 @@ systems with more than one CPU:
 | In other words, a given instance of synchronize_rcu() can avoid       |
 | waiting on a given RCU read-side critical section only if it can      |
 | prove that synchronize_rcu() started first.                           |
-| A related question is “When rcu_read_lock() doesn't generate any      |
-| code, why does it matter how it relates to a grace period?” The       |
+| A related question is "When rcu_read_lock() doesn't generate any      |
+| code, why does it matter how it relates to a grace period?" The       |
 | answer is that it is not the relationship of rcu_read_lock()          |
 | itself that is important, but rather the relationship of the code     |
 | within the enclosed RCU read-side critical section to the code        |
@@ -538,7 +538,7 @@ systems with more than one CPU:
 | of any access following the grace period.                             |
 |                                                                       |
 | As of late 2016, mathematical models of RCU take this viewpoint, for  |
-| example, see slides 62 and 63 of the `2016 LinuxCon                   |
+| example, see slides 62 and 63 of the `2016 LinuxCon                   |
 | EU <http://www2.rdrop.com/users/paulmck/scalability/paper/LinuxMM.201 |
 | 6.10.04c.LCE.pdf>`__                                                  |
 | presentation.                                                         |
@@ -584,9 +584,9 @@ systems with more than one CPU:
 |                                                                       |
 | And similarly, without a memory barrier between the beginning of the  |
 | grace period and the beginning of the RCU read-side critical section, |
-| CPU 1 might end up accessing the freelist.                            |
+| CPU 1 might end up accessing the freelist.                            |
 |                                                                       |
-| The “as if” rule of course applies, so that any implementation that   |
+| The "as if" rule of course applies, so that any implementation that   |
 | acts as if the appropriate memory barriers were in place is a correct |
 | implementation. That said, it is much easier to fool yourself into    |
 | believing that you have adhered to the as-if rule than it is to       |
@@ -1002,7 +1002,7 @@ RCU implementation must abide by them. They therefore bear repeating:
    ECC errors, NMIs, and other hardware events. Although a delay of more
    than about 20 seconds can result in splats, the RCU implementation is
    obligated to use algorithms that can tolerate extremely long delays,
-   but where “extremely long” is not long enough to allow wrap-around
+   but where "extremely long" is not long enough to allow wrap-around
    when incrementing a 64-bit counter.
 #. Both the compiler and the CPU can reorder memory accesses. Where it
    matters, RCU must use compiler directives and memory-barrier
@@ -1169,7 +1169,7 @@ Energy efficiency is a critical component of performance today, and
 Linux-kernel RCU implementations must therefore avoid unnecessarily
 awakening idle CPUs. I cannot claim that this requirement was
 premeditated. In fact, I learned of it during a telephone conversation
-in which I was given “frank and open” feedback on the importance of
+in which I was given "frank and open" feedback on the importance of
 energy efficiency in battery-powered systems and on specific
 energy-efficiency shortcomings of the Linux-kernel RCU implementation.
 In my experience, the battery-powered embedded community will consider
@@ -1234,7 +1234,7 @@ requirements: A storm of synchronize_rcu_expedited() invocations on
 4096 CPUs should at least make reasonable forward progress. In return
 for its shorter latencies, synchronize_rcu_expedited() is permitted
 to impose modest degradation of real-time latency on non-idle online
-CPUs. Here, “modest” means roughly the same latency degradation as a
+CPUs. Here, "modest" means roughly the same latency degradation as a
 scheduling-clock interrupt.
 
 There are a number of situations where even
@@ -1274,8 +1274,8 @@ be used in place of synchronize_rcu() as follows:
       28 }
 
 A definition of ``struct foo`` is finally needed, and appears on
-lines 1-5. The function remove_gp_cb() is passed to call_rcu()
-on line 25, and will be invoked after the end of a subsequent grace
+lines 1-5. The function remove_gp_cb() is passed to call_rcu()
+on line 25, and will be invoked after the end of a subsequent grace
 period. This gets the same effect as remove_gp_synchronous(), but
 without forcing the updater to wait for a grace period to elapse. The
 call_rcu() function may be used in a number of situations where
@@ -1294,23 +1294,23 @@ threads or (in the Linux kernel) workqueues.
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
 +-----------------------------------------------------------------------+
-| Why does line 19 use rcu_access_pointer()? After all,                 |
-| call_rcu() on line 25 stores into the structure, which would          |
+| Why does line 19 use rcu_access_pointer()? After all,                 |
+| call_rcu() on line 25 stores into the structure, which would          |
 | interact badly with concurrent insertions. Doesn't this mean that     |
 | rcu_dereference() is required?                                        |
 +-----------------------------------------------------------------------+
 | **Answer**:                                                           |
 +-----------------------------------------------------------------------+
-| Presumably the ``->gp_lock`` acquired on line 18 excludes any         |
+| Presumably the ``->gp_lock`` acquired on line 18 excludes any         |
 | changes, including any insertions that rcu_dereference() would        |
 | protect against. Therefore, any insertions will be delayed until      |
-| after ``->gp_lock`` is released on line 25, which in turn means that  |
+| after ``->gp_lock`` is released on line 25, which in turn means that  |
 | rcu_access_pointer() suffices.                                        |
 +-----------------------------------------------------------------------+
 
 However, all that remove_gp_cb() is doing is invoking kfree() on
 the data element. This is a common idiom, and is supported by
-kfree_rcu(), which allows “fire and forget” operation as shown
+kfree_rcu(), which allows "fire and forget" operation as shown
 below:
 
    ::
@@ -1396,8 +1396,8 @@ may be used for this purpose, as shown below:
       18   return true;
       19 }
 
-On line 14, get_state_synchronize_rcu() obtains a “cookie” from RCU,
-then line 15 carries out other tasks, and finally, line 16 returns
+On line 14, get_state_synchronize_rcu() obtains a "cookie" from RCU,
+then line 15 carries out other tasks, and finally, line 16 returns
 immediately if a grace period has elapsed in the meantime, but otherwise
 waits as required. The need for ``get_state_synchronize_rcu`` and
 cond_synchronize_rcu() has appeared quite recently, so it is too
@@ -1420,9 +1420,9 @@ example, an infinite loop in an RCU read-side critical section must by
 definition prevent later grace periods from ever completing. For a more
 involved example, consider a 64-CPU system built with
 ``CONFIG_RCU_NOCB_CPU=y`` and booted with ``rcu_nocbs=1-63``, where
-CPUs 1 through 63 spin in tight loops that invoke call_rcu(). Even
+CPUs 1 through 63 spin in tight loops that invoke call_rcu(). Even
 if these tight loops also contain calls to cond_resched() (thus
-allowing grace periods to complete), CPU 0 simply will not be able to
+allowing grace periods to complete), CPU 0 simply will not be able to
 invoke callbacks as fast as the other 63 CPUs can register them, at
 least not until the system runs out of memory. In both of these
 examples, the Spiderman principle applies: With great power comes great
@@ -1433,7 +1433,7 @@ callbacks.
 RCU takes the following steps to encourage timely completion of grace
 periods:
 
-#. If a grace period fails to complete within 100 milliseconds, RCU
+#. If a grace period fails to complete within 100 milliseconds, RCU
    causes future invocations of cond_resched() on the holdout CPUs
    to provide an RCU quiescent state. RCU also causes those CPUs'
    need_resched() invocations to return ``true``, but only after the
@@ -1442,12 +1442,12 @@ periods:
    indefinitely in the kernel without scheduling-clock interrupts, which
    defeats the above need_resched() strategem. RCU will therefore
    invoke resched_cpu() on any ``nohz_full`` CPUs still holding out
-   after 109 milliseconds.
+   after 109 milliseconds.
 #. In kernels built with ``CONFIG_RCU_BOOST=y``, if a given task that
    has been preempted within an RCU read-side critical section is
-   holding out for more than 500 milliseconds, RCU will resort to
+   holding out for more than 500 milliseconds, RCU will resort to
    priority boosting.
-#. If a CPU is still holding out 10 seconds into the grace period, RCU
+#. If a CPU is still holding out 10 seconds into the grace period, RCU
    will invoke resched_cpu() on it regardless of its ``nohz_full``
    state.
 
@@ -1579,7 +1579,7 @@ period.
 Software-Engineering Requirements
 ---------------------------------
 
-Between Murphy's Law and “To err is human”, it is necessary to guard
+Between Murphy's Law and "To err is human", it is necessary to guard
 against mishaps and misuse:
 
 #. It is all too easy to forget to use rcu_read_lock() everywhere
@@ -1626,7 +1626,7 @@ against mishaps and misuse:
    `patch <https://lore.kernel.org/r/20100319013024.GA28456@Krystal>`__.
 #. An infinite loop in an RCU read-side critical section will eventually
    trigger an RCU CPU stall warning splat, with the duration of
-   “eventually” being controlled by the ``RCU_CPU_STALL_TIMEOUT``
+   "eventually" being controlled by the ``RCU_CPU_STALL_TIMEOUT``
    ``Kconfig`` option, or, alternatively, by the
    ``rcupdate.rcu_cpu_stall_timeout`` boot/sysfs parameter. However, RCU
    is not obligated to produce this splat unless there is a grace period
@@ -1704,7 +1704,7 @@ Configuration
 
 RCU's goal is automatic configuration, so that almost nobody needs to
 worry about RCU's ``Kconfig`` options. And for almost all users, RCU
-does in fact work well “out of the box.”
+does in fact work well "out of the box."
 
 However, there are specialized use cases that are handled by kernel boot
 parameters and ``Kconfig`` options. Unfortunately, the ``Kconfig``
@@ -1733,7 +1733,7 @@ listings.
 
 RCU must therefore wait for a given CPU to actually come online before
 it can allow itself to believe that the CPU actually exists. The
-resulting “ghost CPUs” (which are never going to come online) cause a
+resulting "ghost CPUs" (which are never going to come online) cause a
 number of `interesting
 complications <https://paulmck.livejournal.com/37494.html>`__.
 
@@ -1789,7 +1789,7 @@ normally.
 | **Answer**:                                                           |
 +-----------------------------------------------------------------------+
 | Very carefully!                                                       |
-| During the “dead zone” between the time that the scheduler spawns the |
+| During the "dead zone" between the time that the scheduler spawns the |
 | first task and the time that all of RCU's kthreads have been spawned, |
 | all synchronous grace periods are handled by the expedited            |
 | grace-period mechanism. At runtime, this expedited mechanism relies   |
@@ -1824,7 +1824,7 @@ Some Linux-kernel architectures can enter an interrupt handler from
 non-idle process context, and then just never leave it, instead
 stealthily transitioning back to process context. This trick is
 sometimes used to invoke system calls from inside the kernel. These
-“half-interrupts” mean that RCU has to be very careful about how it
+"half-interrupts" mean that RCU has to be very careful about how it
 counts interrupt nesting levels. I learned of this requirement the hard
 way during a rewrite of RCU's dyntick-idle code.
 
@@ -1921,7 +1921,7 @@ and go. It is of course illegal to use any RCU API member from an
 offline CPU, with the exception of `SRCU <Sleepable RCU_>`__ read-side
 critical sections. This requirement was present from day one in
 DYNIX/ptx, but on the other hand, the Linux kernel's CPU-hotplug
-implementation is “interesting.”
+implementation is "interesting."
 
 The Linux-kernel CPU-hotplug implementation has notifiers that are used
 to allow the various kernel subsystems (including RCU) to respond
@@ -2268,7 +2268,7 @@ remain zero during all phases of grace-period processing, and that bit
 happens to map to the bottom bit of the ``rcu_head`` structure's
 ``->next`` field. RCU makes this guarantee as long as call_rcu() is
 used to post the callback, as opposed to kfree_rcu() or some future
-“lazy” variant of call_rcu() that might one day be created for
+"lazy" variant of call_rcu() that might one day be created for
 energy-efficiency purposes.
 
 That said, there are limits. RCU requires that the ``rcu_head``
@@ -2281,7 +2281,7 @@ architecture provides only two-byte alignment, and thus acts as
 alignment's least common denominator.
 
 The reason for reserving the bottom bit of pointers to ``rcu_head``
-structures is to leave the door open to “lazy” callbacks whose
+structures is to leave the door open to "lazy" callbacks whose
 invocations can safely be deferred. Deferring invocation could
 potentially have energy-efficiency benefits, but only if the rate of
 non-lazy callbacks decreases significantly for some important workload.
@@ -2354,8 +2354,8 @@ which in practice also means that RCU must have an aggressive
 stress-test suite. This stress-test suite is called ``rcutorture``.
 
 Although the need for ``rcutorture`` was no surprise, the current
-immense popularity of the Linux kernel is posing interesting—and perhaps
-unprecedented—validation challenges. To see this, keep in mind that
+immense popularity of the Linux kernel is posing interesting-and perhaps
+unprecedented-validation challenges. To see this, keep in mind that
 there are well over one billion instances of the Linux kernel running
 today, given Android smartphones, Linux-powered televisions, and
 servers. This number can be expected to increase sharply with the advent
@@ -2399,7 +2399,7 @@ single flavor. The read-side API remains, and continues to disable
 softirq and to be accounted for by lockdep. Much of the material in this
 section is therefore strictly historical in nature.
 
-The softirq-disable (AKA “bottom-half”, hence the “_bh” abbreviations)
+The softirq-disable (AKA "bottom-half", hence the "_bh" abbreviations)
 flavor of RCU, or *RCU-bh*, was developed by Dipankar Sarma to provide a
 flavor of RCU that could withstand the network-based denial-of-service
 attacks researched by Robert Olsson. These attacks placed so much
@@ -2458,7 +2458,7 @@ effect of also waiting for all pre-existing interrupt and NMI handlers.
 However, there are legitimate preemptible-RCU implementations that do
 not have this property, given that any point in the code outside of an
 RCU read-side critical section can be a quiescent state. Therefore,
-*RCU-sched* was created, which follows “classic” RCU in that an
+*RCU-sched* was created, which follows "classic" RCU in that an
 RCU-sched grace period waits for pre-existing interrupt and NMI
 handlers. In kernels built with ``CONFIG_PREEMPTION=n``, the RCU and
 RCU-sched APIs have identical implementations, while kernels built with
@@ -2490,8 +2490,8 @@ and local_irq_restore(), and so on.
 Sleepable RCU
 ~~~~~~~~~~~~~
 
-For well over a decade, someone saying “I need to block within an RCU
-read-side critical section” was a reliable indication that this someone
+For well over a decade, someone saying "I need to block within an RCU
+read-side critical section" was a reliable indication that this someone
 did not understand RCU. After all, if you are always blocking in an RCU
 read-side critical section, you can probably afford to use a
 higher-overhead synchronization mechanism. However, that changed with
@@ -2507,7 +2507,7 @@ this structure must be passed in to each SRCU function, for example,
 structure. The key benefit of these domains is that a slow SRCU reader
 in one domain does not delay an SRCU grace period in some other domain.
 That said, one consequence of these domains is that read-side code must
-pass a “cookie” from srcu_read_lock() to srcu_read_unlock(), for
+pass a "cookie" from srcu_read_lock() to srcu_read_unlock(), for
 example, as follows:
 
    ::
@@ -2536,9 +2536,9 @@ period to elapse. For example, this results in a self-deadlock:
        5 synchronize_srcu(&ss);
        6 srcu_read_unlock(&ss, idx);
 
-However, if line 5 acquired a mutex that was held across a
+However, if line 5 acquired a mutex that was held across a
 synchronize_srcu() for domain ``ss``, deadlock would still be
-possible. Furthermore, if line 5 acquired a mutex that was held across a
+possible. Furthermore, if line 5 acquired a mutex that was held across a
 synchronize_srcu() for some other domain ``ss1``, and if an
 ``ss1``-domain SRCU read-side critical section acquired another mutex
 that was held across as ``ss``-domain synchronize_srcu(), deadlock
@@ -2557,7 +2557,7 @@ memory barrier.
 Also unlike other RCU flavors, synchronize_srcu() may **not** be
 invoked from CPU-hotplug notifiers, due to the fact that SRCU grace
 periods make use of timers and the possibility of timers being
-temporarily “stranded” on the outgoing CPU. This stranding of timers
+temporarily "stranded" on the outgoing CPU. This stranding of timers
 means that timers posted to the outgoing CPU will not fire until late in
 the CPU-hotplug process. The problem is that if a notifier is waiting on
 an SRCU grace period, that grace period is waiting on a timer, and that
@@ -2573,7 +2573,7 @@ period has the side effect of expediting all prior grace periods that
 have not yet completed. (But please note that this is a property of the
 current implementation, not necessarily of future implementations.) In
 addition, if SRCU has been idle for longer than the interval specified
-by the ``srcutree.exp_holdoff`` kernel boot parameter (25 microseconds
+by the ``srcutree.exp_holdoff`` kernel boot parameter (25 microseconds
 by default), and if a synchronize_srcu() invocation ends this idle
 period, that invocation will be automatically expedited.
 
@@ -2619,7 +2619,7 @@ from the cache, an SRCU grace period will be very likely to have elapsed.
 Tasks RCU
 ~~~~~~~~~
 
-Some forms of tracing use “trampolines” to handle the binary rewriting
+Some forms of tracing use "trampolines" to handle the binary rewriting
 required to install different types of probes. It would be good to be
 able to free old trampolines, which sounds like a job for some form of
 RCU. However, because it is necessary to be able to install a trace
@@ -2687,7 +2687,7 @@ your architecture should also benefit from the
 number of CPUs in a socket, NUMA node, or whatever. If the number of
 CPUs is too large, use a fraction of the number of CPUs. If the number
 of CPUs is a large prime number, well, that certainly is an
-“interesting” architectural choice! More flexible arrangements might be
+"interesting" architectural choice! More flexible arrangements might be
 considered, but only if ``rcutree.rcu_fanout_leaf`` has proven
 inadequate, and only if the inadequacy has been demonstrated by a
 carefully run and realistic system-level workload.
-- 
2.30.2

