Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8821A3B8A84
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 00:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhF3Wgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 18:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232704AbhF3Wgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 18:36:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 721CB61476;
        Wed, 30 Jun 2021 22:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625092444;
        bh=HmlqTSQq8R641GK+kKrN9WRAW3fhtge0awf+RfKUlNo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OlQRVaTaiLVYzHbv73AKH0dQjR99xBIhvaWWoE0kRQdZl779mkbpml+TYXJl8ZlYL
         nqMRmZB3PlQFzfK7ZKVpRlbw2NZpZPkoP5zWkAQgrBweZ0ZMJcJ4yXEzDBVhhyzTfV
         q3OtWMgorc/oys9wuYWaYcX6MsIihjXCTcfBe0dw+zGK2Ya2DgVFGXFVm2MoOMqA/9
         hWPLl6lcsMljdYCYzrVJIiaoON++8ApF5LkstjzmMV4RPyyvXFbX3vbv6UlMyfp2nS
         z88V6NyyrFVRTOCSdPtb8xIbuSDL7pJPJlEMW9VuxGXbFNK3Dr9fqoIzqmWvCbHISH
         VoU1u6Vy2LsHw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6CFC2609D8;
        Wed, 30 Jun 2021 22:34:04 +0000 (UTC)
Subject: Re: [GIT PULL] Audit patches for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRu2eydfdx4kYTzLC37pzi=RBpgJM0PCCyw_=XHRSvvrg@mail.gmail.com>
References: <CAHC9VhRu2eydfdx4kYTzLC37pzi=RBpgJM0PCCyw_=XHRSvvrg@mail.gmail.com>
X-PR-Tracked-List-Id: Linux Audit Discussion <linux-audit.redhat.com>
X-PR-Tracked-Message-Id: <CAHC9VhRu2eydfdx4kYTzLC37pzi=RBpgJM0PCCyw_=XHRSvvrg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20210629
X-PR-Tracked-Commit-Id: 0ecc617858fce305bedcf735eb18a46cb7e9921f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 290fe0fa6f5a1a3374dfd03fe0eda6c43d53e6cf
Message-Id: <162509244443.2480.12336737632620565259.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 22:34:04 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 18:41:46 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20210629

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/290fe0fa6f5a1a3374dfd03fe0eda6c43d53e6cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
