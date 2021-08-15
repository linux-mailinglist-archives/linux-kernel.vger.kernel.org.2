Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4053ECA5C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 19:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhHORBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 13:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231295AbhHORBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 13:01:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 774D860C40;
        Sun, 15 Aug 2021 17:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629046833;
        bh=LWofAuKgdrrv7tvkrVcI9fizKdir0cMFEtvUqwVIIx4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=c6/WvWhxLqrOAUP3nqScBhI2mlDicd69OYWsQr+JujBzSM4bMDO8vIGypX0ByA310
         v3wbvRbHgMsBO3k4J5fQWe2GJNiMLL0OXEkjU0L+eLcK49edQ575no6VeiwHV30BOD
         g7Uedr4LoCNwNME4Xnbdse7iKj9Rvmnqjj9CgU5PaxC8VT5JLhIWjj0PaeFnVmAC8D
         We2CRietVwStAzvKNb6H1tpwLyW85PQw/a18a/a+bqBsukRzPRU9gylT5Vu2aO9UDe
         VeL3D/PiCQQ3cDOd6wo9VSQpkkebIcV12qOXH3xcUwazSIBO/UveasFsQ93gmDkXPc
         GEsoprt/a6Ngg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6CA1D60A69;
        Sun, 15 Aug 2021 17:00:33 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.14-5 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87tujqlvpo.fsf@mpe.ellerman.id.au>
References: <87tujqlvpo.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87tujqlvpo.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.14-5
X-PR-Tracked-Commit-Id: cbc06f051c524dcfe52ef0d1f30647828e226d30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ecf93431963a95c0f475921101bedc0dd62ec96d
Message-Id: <162904683343.11260.6565674688445410753.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Aug 2021 17:00:33 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@csgroup.eu, clg@kaod.org, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        pulehui@huawei.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Aug 2021 22:48:51 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.14-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ecf93431963a95c0f475921101bedc0dd62ec96d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
