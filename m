Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0033E31E5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 00:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245584AbhHFWsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 18:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243453AbhHFWsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 18:48:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69FDE610CB;
        Fri,  6 Aug 2021 22:47:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mC8d5-003GyY-2t; Fri, 06 Aug 2021 18:47:51 -0400
Message-ID: <20210806224723.958744677@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 06 Aug 2021 18:47:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH RT 0/2] Linux 5.10.56-rt49-rc1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 5.10.56-rt49-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 8/10/2021.

Enjoy,

-- Steve


To build 5.10.56-rt49-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.56.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.56-rt49-rc1.patch.xz

You can also build from 5.10.56-rt48 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10.56-rt48-rt49-rc1.patch.xz


Changes from 5.10.56-rt48:

---


Chao Qin (1):
      printk: Enhance the condition check of msleep in pr_flush()

Steven Rostedt (VMware) (1):
      Linux 5.10.56-rt49-rc1

----
 kernel/printk/printk.c | 4 +++-
 localversion-rt        | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)
