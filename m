Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F31342F0C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 19:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCTSnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 14:43:21 -0400
Received: from mail.monom.org ([188.138.9.77]:50866 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhCTSmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 14:42:47 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 62EAE50035C;
        Sat, 20 Mar 2021 19:42:45 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.96.195])
        by mail.monom.org (Postfix) with ESMTPSA id 97B85500328;
        Sat, 20 Mar 2021 19:42:44 +0100 (CET)
From:   Daniel Wagner <dwagner@suse.de>
Subject: [ANNOUNCE] 4.4.262-rt219
Date:   Sat, 20 Mar 2021 16:25:35 -0000
Message-ID: <161625753552.20205.6230905513724868931@beryllium>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.4.262-rt219 stable release.

This is just an update to the latest stable release. No RT
specific changes.

I tried to fix the locking self failures I reported last time. As it
turns out the test setup was somehow broken. After redoing all the
test just using 'defconfig + kvmconfig + locking_selftest' all worked
fine. I also tested older v4.4-rt releases and there was no failures.

Furthermore, the cyclicdeadline fails again, which I probably a good
thing; I don't believe in self healing capabilities of the -rt patchset.
Anyway, I think my build/test setup was just broken.

Known issue:

  - locktorture reports a might_sleep warning for spin_locks test

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: d18d08f6afe25c27207d26a9811e23abf7ef36b8

Or to build 4.4.262-rt219 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.262.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.262-rt219.patch.xz

Enjoy!
Daniel
