Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DECA41FD8E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 20:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbhJBSJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 14:09:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233679AbhJBSJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 14:09:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 176A961B3C;
        Sat,  2 Oct 2021 18:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633198064;
        bh=FEuVabHw3h87FeojjKDBvBuj4KbIfv9zMG9gJORFh0A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TWdnulKRfZJ1YaLWQGh5vu+tnSkqvEivBnJVQ/GnaEFw64cE5heRYnLnRCl5uxmIS
         L4RLFtjYY+nGOQFSTqyc0b7SqsUku/q0qkDLcl+Rrj4uPT4deGXA0QjKZn90AtxEi+
         wy+vI3ZG0QJITptJC1x+hNAZww+k9nrMhnsWrDJJKz+B9FbfUJuKqTgNUabDFHMByu
         +ACv9HJYXVU5IDXPIv2Als6VCA2vGkrXe4DC421t/0Uc8Uze05RpLHRDbA3+B00YQU
         lwXzWH/LEVb5yYHjmeqGsapJLqWqxBcgGOCw+EjXU2EZVobdbjx0GTWCP99fcdAekh
         WQ9ZANXYvg+vA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0CF23609D6;
        Sat,  2 Oct 2021 18:07:44 +0000 (UTC)
Subject: Re: [GIT PULL] nvdimm fixes for v5.15-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4iEHttW7fDzaKYdAr2t4w3YJQ7t7QtadO0bZKDWPuK0Ag@mail.gmail.com>
References: <CAPcyv4iEHttW7fDzaKYdAr2t4w3YJQ7t7QtadO0bZKDWPuK0Ag@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4iEHttW7fDzaKYdAr2t4w3YJQ7t7QtadO0bZKDWPuK0Ag@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.15-rc4
X-PR-Tracked-Commit-Id: d55174cccac2e4c2a58ff68b6b573fc0836f73bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f05c643743a43b42e7603a520ad052e5218f4e53
Message-Id: <163319806399.17549.15745657730170751522.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Oct 2021 18:07:43 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Oct 2021 18:19:12 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.15-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f05c643743a43b42e7603a520ad052e5218f4e53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
