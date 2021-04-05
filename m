Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D04354786
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 22:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbhDEUVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 16:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235001AbhDEUVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 16:21:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 214EE613BD;
        Mon,  5 Apr 2021 20:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617654064;
        bh=J+GNteQBXB/c2j6S8i/IGMMbohx7VMZ0cl5FpQsu30c=;
        h=Subject:From:To:Date:From;
        b=OkUQIQ+dO30UiMLOsVd4Yu6uwkVazvFT15hX2+qn5cIjHZYuToqUsgxFIrfG0kveL
         4tnIsez7VnSajvz7LShaoMxxq4uJi5Mmwcjlis7tR+T4izsqbtdI5PmG5MGmsY3SBl
         jAiJiCBJ9sum5iFrtWBNFYoFiwIpHi1IiOr/s0dcs9f5lKt0pVQOiZkxWVDZ59FKVb
         KtllRVQTDsUITVGOEE8B1YAP2r1CtA96L3ie9DZ0iUg5GjcbFeGiZYdumwIKZ/Kcvo
         auWCeaIUKwYxDDFNsePItJCmumz57UTHmpJecFDPkOa5u9EP/7OqZkfDHMTy+Pc4hP
         rnnYT+BqucyTw==
Message-ID: <f266bc436a38b656e1ed8ca744528511b042dd1d.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.109-rt55
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
        Tom Zanussi <zanussi@kernel.org>
Date:   Mon, 05 Apr 2021 15:21:01 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.109-rt55 stable release.

This release is just an update to the new stable 5.4.109
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 209aee2366649eebf5b3881f73199cc78d4700f3

Or to build 5.4.109-rt55 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.109.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.109-rt55.patch.xz

Enjoy!

   Tom

