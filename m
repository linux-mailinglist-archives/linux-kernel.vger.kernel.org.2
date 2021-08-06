Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DF93E3180
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 00:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245439AbhHFWGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 18:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230454AbhHFWGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 18:06:51 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49F036101C;
        Fri,  6 Aug 2021 22:06:34 +0000 (UTC)
Date:   Fri, 6 Aug 2021 18:06:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [ANNOUNCE] 5.10.56-rt48
Message-ID: <20210806180627.48f8ee43@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 5.10.56-rt48 stable release.


This release is just an update to the new stable 5.10.56 version
and no RT specific changes have been made.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 0c75ad69fa347cc1b4f2cbb6b455626bb5d6d1a1


Or to build 5.10.56-rt48 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.56.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.56-rt48.patch.xz




Enjoy,

-- Steve

