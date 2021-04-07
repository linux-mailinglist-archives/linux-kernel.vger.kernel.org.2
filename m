Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C88357485
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355407AbhDGSsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235455AbhDGSsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:48:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C322261165;
        Wed,  7 Apr 2021 18:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617821315;
        bh=XNfsKf0GsS76i2cCjrrJlB/f8XcyulrkeHvCWb4O7ns=;
        h=From:To:Subject:Date:From;
        b=GWB3KSrGIpp3iFrqxP2FytmPWHS4X5B67N2lQrp6Tj7E6bcv0o5kvDVEYKQQV4CZi
         vZNxPQ7gtNiUJj8kjifAXpXzaASFjKZoLPX7f9dNzUyZiU+8QkF+CIGh6x4Nl77T6d
         uZ8FTWg6kKTuZGci9//8GSEvV9+rXF3pwYWf0iraUmVq1g8J5CNqGBe5IplQZfuEq4
         zZSusHWHT8Vo2L8xfP0/buNAehtuxOGldScWQ8sbCwT0MZTC6bOevOGSuV719PFQC1
         JwR1zC11R+M2MBvhMd3muzAk+QxIWKhYb5GDeh2GvW09dPXPGk+QfnBG3BmBqO0eMn
         4+20ZSNxpv0Vw==
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
Subject: [PATCH RT 0/2] Linux v5.4.109-rt56-rc1
Date:   Wed,  7 Apr 2021 13:48:31 -0500
Message-Id: <cover.1617821301.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Dear RT Folks,

This is the RT stable review cycle of patch 5.4.109-rt56-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2021-04-12.

To build 5.4.109-rt56-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.109.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.109-rt56-rc1.patch.xz

You can also build from 5.4.109-rt55 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.109-rt55-rt56-rc1.patch.xz


Enjoy,

-- Tom


Sebastian Andrzej Siewior (1):
  mm: slub: Don't resize the location tracking cache on PREEMPT_RT

Tom Zanussi (1):
  Linux 5.4.109-rt56-rc1

 localversion-rt | 2 +-
 mm/slub.c       | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.17.1

