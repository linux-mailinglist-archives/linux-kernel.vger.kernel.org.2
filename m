Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205963397ED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhCLUDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:03:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234571AbhCLUDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:03:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E5C9364F9E;
        Fri, 12 Mar 2021 20:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615579413;
        bh=ZG04rjuLPIUzhESGH5wWkiSY3KcFk+0C4xOYWLA6QmI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rTPVuViHTQyagMqeJfUnP6OzwHK36+AVo7trk0zrZYCzE1wqHMk2v1VLfKCOY3B1l
         d3+mW7QyzbbC0k5kUXHGH0PABN9UL7fjrYBcKimyJIu5wATgXCCMHcHoUbZrb835bm
         CwaJHwcsiIa3G00nO5/fgWRLuW1OUa37OgAVmqHrLCtxhmBSUq2dJx1J5twcbOm10e
         S3QYzK+bf8tpkAREpc6rj95z94YcOyYMrwF2Aoop8xrgWztWMb2hPXa/e7oBxaZOD2
         KdRN9RPXJhviNFsyxM6klY/gFO52fJkLa0d89vi4Qo0VUu4Y5gK7+Law3GMmvQBzqN
         bFmzn0DrKDL+Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E0FD9609E7;
        Fri, 12 Mar 2021 20:03:33 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes for 5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210312161919.1595228-1-agruenba@redhat.com>
References: <20210312161919.1595228-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210312161919.1595228-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.12-rc2-fixes
X-PR-Tracked-Commit-Id: 0efc4976e3da40b09c592b21f722022d8f12a16b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b77b5fdd052e7ee61b35164abb10e8433d3160e8
Message-Id: <161557941391.10515.7785016079454080132.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Mar 2021 20:03:33 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Mar 2021 17:19:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.12-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b77b5fdd052e7ee61b35164abb10e8433d3160e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
