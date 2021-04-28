Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D68F36D018
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 02:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbhD1A5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 20:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhD1A5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 20:57:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B302861029;
        Wed, 28 Apr 2021 00:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619571400;
        bh=HZ7DZLKT36j38pjeGea1Kmh+RuWiTCVsIBo4m9p41pI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tJDKj6BizTY1gl9jrfBkkNNK0fkbCKoLqIsZkCtzGgo1RIE09Qr4gLHtR/pUzVBwW
         5wUN0A3ZYm6eHDFbF05gpDohFuCzemys8hsRr9B3YOkUy5PBThJf6vj7O5rGo+rife
         Trn0GI0vUG/GG9Wf4z7aTDH3lOjQ/pfE+3XBCbIXVDObfNKd+H5VK74m0MzP3pYJ0H
         uxoR0p7jQTQVrEpuAvAZKQPIx078nOQ4q2tyWNFcLuDJ1Zx3V7qHpwV9shpdJ1jikQ
         dK4K5hbFTtlzekqUBPqF1zQggZrD/H3PdbF6WNK7dQLE+MIlaWcs0csFa5Pi91bYR0
         eXGez74EOrsoQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A79EE60A24;
        Wed, 28 Apr 2021 00:56:40 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.13 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIgVewka8KeZn5F9@osiris.fritz.box>
References: <YIgVewka8KeZn5F9@osiris.fritz.box>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIgVewka8KeZn5F9@osiris.fritz.box>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.13-1
X-PR-Tracked-Commit-Id: 6f3353c2d2b3eb4de52e9704cb962712033db181
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6daa755f813e6aa0bcc97e352666e072b1baac25
Message-Id: <161957140062.22806.14487702478556896084.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 00:56:40 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Apr 2021 15:45:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.13-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6daa755f813e6aa0bcc97e352666e072b1baac25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
