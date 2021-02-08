Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C018313D9D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhBHSen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:34:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232605AbhBHQTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:19:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 900E064EA1;
        Mon,  8 Feb 2021 16:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612801114;
        bh=q8Wz1u2c1qWDv9pAcYBZRdY6dda4M4xtYNaWJPa0vZw=;
        h=Subject:From:To:Date:From;
        b=ovGCywDoEmpLqnQolMQPpYTcXz93pDS6OA0tt/SBHSC1oBXdsr3UD7kM0EL2ZYvLs
         wtTAI2Vq6WYBtenhPJ8TSOagFtSdwNtbo5JsBJi73CAhgQprvqVyHniTvNaOkMvW6x
         tXzG17n+T1rc3gL0lgO/UVzAd857ldoqdHJqNzug8Q/FLpoSzLctLT81q/H8Pt59Q/
         B2XTSkXd1q51PyQ1H/hWEQHSOVfVLIi2+WpkkA34SWzMjYsPzKJrgVdpQOfN0/l4DA
         QwbndfNkO/RJovNLh/Ppbb1VrNVKfN63TRZo68MtumojLrtTofdYPjRBQ5ZpTMCT64
         GqRxFpHxCFm6w==
Message-ID: <78a65c1c8cc1b6fbc739a91a5dfdd84be795ed1a.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.173-rt72
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
Date:   Mon, 08 Feb 2021 10:18:32 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.173-rt72 stable release.

This release is just an update to the new stable 4.19.173
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 0f716c5aef71ce6891b78818ba2a8a59d95ac053

Or to build 4.19.173-rt72 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.173.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.173-rt72.patch.xz

Enjoy!

   Tom

