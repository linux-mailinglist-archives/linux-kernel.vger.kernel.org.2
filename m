Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550C3402B81
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbhIGPQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344997AbhIGPQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:16:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34E696101C;
        Tue,  7 Sep 2021 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631027731;
        bh=8QnHFxSyXpstvtUXbpEY0AICopW7vmj1G2qcEkEYBkE=;
        h=From:To:Subject:Date:From;
        b=YXykw6pPC2bLkNhey01eknLbDFOtnbRbUTRLhBPZEboMp2oR2EQxMjgKGwRbKKF4i
         10n+rKD3Ldxg/ckMfe5++2Q/TExQoN9SIW9TjAZhkuok284OEx6/5V4yZQjKt8/Wn3
         BlkBxKOgNuT9Qvo00Fe/gFMv6YDYMrRpUbo3yg7Tzl3dR0x/ud0hY3YUGvI8m87juW
         YrmlT44TgrD0nBIiCrIruLdf4DOK5/L+kEforWWDZoXncbBjjs2QWRfqwIhqhu1cqs
         GrlYW4T/pviTiayFL5BjNmOgsNqx3Kxqnr3k2SNwdIrBRse2B09+srBOn+TKVPzwqx
         kDlQNdgY22uOg==
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 0/3] Linux v5.4.143-rt64-rc2
Date:   Tue,  7 Sep 2021 10:15:26 -0500
Message-Id: <cover.1631027711.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Dear RT Folks,

This is the RT stable review cycle of patch 5.4.143-rt64-rc2.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2021-09-10.

To build 5.4.143-rt64-rc2 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.143.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.143-rt64-rc2.patch.xz

You can also build from 5.4.143-rt63 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.143-rt63-rt64-rc2.patch.xz


Enjoy,

-- Tom


Andrew Halaney (1):
  locking/rwsem-rt: Remove might_sleep() in __up_read()

Gregor Beck (1):
  fscache: fix initialisation of cookie hash table raw spinlocks

Tom Zanussi (1):
  Linux 5.4.143-rt64-rc2

 fs/fscache/cookie.c       | 2 +-
 kernel/locking/rwsem-rt.c | 1 -
 localversion-rt           | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

-- 
2.17.1

