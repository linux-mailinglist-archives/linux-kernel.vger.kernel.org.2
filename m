Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4333FCE29
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbhHaUHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:07:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232191AbhHaUHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:07:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 89AA56108E;
        Tue, 31 Aug 2021 20:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630440396;
        bh=3nlogqbX/Ckl9PZ7pV1FDIzGFssnOemYOn4f0fk5xUQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=m+GmztaPR+vhPtjcYZy5dGnSSerJgaJe8xFdTzV8hohaR+3P/+wuut0mn3Qy3wS3A
         RBri8nIU6BikiHa2Rk3dPzqfvYsxTimMI5EbLvZLMVxqcGeKvePhC6aInH7Yu1ctv+
         akQ4tlvCkMqVLYfRmKFJrPkbrdk0S+xObGKrRfi+9k65sZuUUmPYzP6Uqt8W5CsbN6
         qYqkkocuDJyJUxEMJDuCLF3RU0zggH69dZKHvqGfNimew5DqN+1zzb8yRyfIaevC4i
         F4Dfx2iGziRwP0FqWcV+Bc2EmpmYRNsXRByaWux71bAEquJ4lvtsp3AAA7hAejhvd9
         ZCpwKncLFWn+A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 854D56097A;
        Tue, 31 Aug 2021 20:06:36 +0000 (UTC)
Subject: Re: [GIT PULL] Audit patches for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRwfin0DgQ3VOLcQfmxbZLLi8TExA4hStR0vCODktRJfw@mail.gmail.com>
References: <CAHC9VhRwfin0DgQ3VOLcQfmxbZLLi8TExA4hStR0vCODktRJfw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRwfin0DgQ3VOLcQfmxbZLLi8TExA4hStR0vCODktRJfw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20210830
X-PR-Tracked-Commit-Id: 67d69e9d1a6c889d98951c1d74b19332ce0565af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e0cd9525ca7ab8ba87135d85b10596e61b10e63
Message-Id: <163044039653.15638.393318083618875784.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 20:06:36 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 12:46:55 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20210830

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e0cd9525ca7ab8ba87135d85b10596e61b10e63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
