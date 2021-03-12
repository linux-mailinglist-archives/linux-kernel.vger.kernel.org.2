Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CF93399CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 23:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbhCLWnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 17:43:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235499AbhCLWnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 17:43:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E8A164F12;
        Fri, 12 Mar 2021 22:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615589023;
        bh=vRsyjYAc06/w7+bJVqYXFD1dEr+bqMQbHAgSifRcWws=;
        h=Subject:From:To:Date:From;
        b=gv1V2aTBK8aU5gIGB9+GXrn24qG3sNSCaCcfqSiEBGFk0yV6kypuUQ9iggROF+FNF
         fS3wywEsap1u3bT/kghlsUM4zWfVwx1Ae9eKBkmt5X7/+c3xKj3i25QuBdA2073qCD
         KJeT51WzxRnYJ04Af3QHtLMbo9WAYD9+TtO+X32xVv5QFtU2wTfikSf34JGYoS5rfs
         4W0kfkLAUj1KI1Qu2XYTdsV4qGReJJbnH7P0iDVISXB8G5OAV1YWUos+UXplxRX9fY
         8xvSRFdgQiS/XqGhXb5laiRhmGrlys2n/jLyfO4nlAlqz5zcSL9ZDRM1h/rJPOB8wn
         5GQD5MrqOAxrA==
Message-ID: <41dbfa16aeaf441ec49268372263183edeff2e94.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.180-rt73
From:   Tom Zanussi <zanussi@kernel.org>
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
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Date:   Fri, 12 Mar 2021 16:43:41 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.180-rt73 stable release.

This release is just an update to the new stable 4.19.180
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: fffa72a0bb5b707d7b437cfdbce1a84bae419f2e

Or to build 4.19.180-rt73 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.180.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.180-rt73.patch.xz

Enjoy!

   Tom

