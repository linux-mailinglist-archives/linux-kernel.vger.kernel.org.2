Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C46310F9C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhBEQ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:28:56 -0500
Received: from mail.monom.org ([188.138.9.77]:60970 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233711AbhBEQ0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:26:38 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 2566150051D;
        Fri,  5 Feb 2021 19:08:02 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        PP_MIME_FAKE_ASCII_TEXT autolearn=no autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.99.195])
        by mail.monom.org (Postfix) with ESMTPSA id 779CD500182;
        Fri,  5 Feb 2021 19:08:01 +0100 (CET)
From:   Daniel Wagner <dwagner@suse.de>
Subject: [ANNOUNCE] 4.4.256-rt214
Date:   Fri, 05 Feb 2021 18:01:50 -0000
Message-ID: <161254811056.21075.10011878796120213544@beryllium>
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

I'm pleased to announce the 4.4.256-rt214 stable release.

This release is just an update to the new stable 4.4.256 version.

GregKH writes:

  As was pointed out to us stable kernel maintainers last week, the
  overflow of the .y release number was going to happen soon, and our
  proposed solution for it (use 16 bits instead of 8), turns out to be
  breaking a userspace-visable api.

  As we can’t really break this, I did a release of the 4.4.256 and
  4.9.256 releases today that contain nothing but a new version
  number. See the links for the full technical details if curious.

  Right now I’m asking that everyone who uses these older kernel
  releases to upgrade to this release, and do a full rebuild of their
  systems in order to see what might, or might not, break. If problems
  happen, please let us know on the stable@vger.kernel.org mailing list
  as soon as possible as I can only hold off on doing new stable
  releases for these branches for a single week only (i.e. February 12,
  2021).

  http://www.kroah.com/log/blog/2021/02/05/8-bits-are-enough-for-a-version-number-dot-dot-dot/

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: cddea11550f1a2f0e8dd1c517bae4b76603e55d2

Or to build 4.4.256-rt214 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.256.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.256-rt214.patch.xz


Enjoy!
Daniel
