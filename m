Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9008E3FF52D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345890AbhIBU4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:56:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243628AbhIBU43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:56:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 93B1D60FDA;
        Thu,  2 Sep 2021 20:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630616130;
        bh=9bCyJt4q4WkQQYzK17ImhZDjey0BKJ4ZveEh5mjn0fA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nYH/5RvxMH+9Z5irZO/M+TtdBEy0Ue82ONwUZ4TFKBiE7j3FlOxolKIdcbTq/jYN9
         eQ3I9fEJUSbcPMngd9Dch+fHDkiq7HhKhdjM0F9D9xjaG4+3Lu49DU/Jo87kmBiAfR
         ymkb8iMoO5RbOo7OT6JXSLKKWBmE0QCIvTBj2CQ+TXcvqccgmyifVvdgoK9NFyM6rU
         DDDNFvGsPfWEq+FYJSYYa0tlaFG3qsPxQx79vvPGp58lBDrhOwKlAd17T7vujShR1V
         HeESewiEWXp403fBZThrqAXby0ze6r4zdCALfSZbgfiqL9WHFGQh27s5kR4Kq5NGnK
         emvr5LWljWNpQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8D94B609D9;
        Thu,  2 Sep 2021 20:55:30 +0000 (UTC)
Subject: Re: [PULL 0/7] xtensa updates for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210902145136.21967-1-jcmvbkbc@gmail.com>
References: <20210902145136.21967-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210902145136.21967-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20210902
X-PR-Tracked-Commit-Id: 7b7cec477fc3cd42ce565dfc3e53f144504fc95c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5d6d2633c1b6b2b4599f658f8abe7eb1358cc77
Message-Id: <163061613057.4397.12515861420304160059.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 20:55:30 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  2 Sep 2021 07:51:36 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20210902

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5d6d2633c1b6b2b4599f658f8abe7eb1358cc77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
