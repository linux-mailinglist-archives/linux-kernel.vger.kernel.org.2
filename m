Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9555C382009
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 18:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhEPQqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 12:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231246AbhEPQqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 12:46:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B451A610CA;
        Sun, 16 May 2021 16:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621183509;
        bh=4FKIJRZigr3MmLKiP7lAxUR2d8nC79R8APeyi0lOsz0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sGHPtMJYH59AGTjqnQWE23IiNWId05Sv8rBZMN0T0EhGyXNMgq+Y0cOC9UotDFGcC
         45uMBbw116dGMMmhoHl7EiTQ3MNbkFx7p65oTsEqI3x1/ZNypKZizvwBFrskC0eT/4
         u1LUN0LQiTyV2OEgPQTL/OCrCFrf2beprmBYj7S/pKIZ21C+KXYfI0/ZG0nDFKIzls
         hs+Dx4mObHsEsfkMktTO3Mi/364PHPvRww632YxZDn6JTrnNkPsXS8m2yvLUlj6yLB
         fkHiExVCgQ4jF8H5dvEf2AA1Ue3Wlb1ouapii6SsrA7tXYeeMLJFpaQUYn7w2NBlE6
         yEV1fqQzJ5ikg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A15C960A23;
        Sun, 16 May 2021 16:45:09 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.13-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210516063020.3349-1-jgross@suse.com>
References: <20210516063020.3349-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210516063020.3349-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.13b-rc2-tag
X-PR-Tracked-Commit-Id: 97729b653de52ba98e08732dd8855586e37a3a31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f44e58bb1905ada4910f26676d2ea22a35545276
Message-Id: <162118350959.14702.2339566205360958922.pr-tracker-bot@kernel.org>
Date:   Sun, 16 May 2021 16:45:09 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 May 2021 08:30:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.13b-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f44e58bb1905ada4910f26676d2ea22a35545276

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
