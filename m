Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B2744CE4D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 01:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhKKA2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 19:28:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229781AbhKKA2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 19:28:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8E0C46124D;
        Thu, 11 Nov 2021 00:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636590358;
        bh=RvcmTypCGJuVmMbF9obKN+aMwiS7ZjEEck1lH72/gQE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rfhRB5j9N6AJiom8BXhHp5q8f9aFubmBpdYmwWhYknISmP641xfjKhnZ0qDdeJWfN
         BK0XD+5zuMH319dN1uNJEJTRQ6aOwEjlElZ9ievWw9+POrnABy0UKxl8Q5uS4wKeA9
         BD8YVzB8iuMEn68EkKaoDDei0+8LVOa6igB1OyMmObQyWeKqfw1FYpZFbY/9RzfF0X
         xinFzV88FMEQVPDXD3V9YATWERPCx3q10Hbk7Mw2YnUsdd1ao80HyCSnsVX2vYUkRG
         4h1gLyPzDuD23EoDGZC0DzLjBp448/oZ2Xrbzrzy58tcpiA5eHu3UY/KbRhpzEsAdL
         T7dCxCp1DBZhg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 785756008E;
        Thu, 11 Nov 2021 00:25:58 +0000 (UTC)
Subject: Re: [GIT PULL] pidfd updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211110145222.1967514-1-brauner@kernel.org>
References: <20211110145222.1967514-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211110145222.1967514-1-brauner@kernel.org>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/pidfd.v5.16
X-PR-Tracked-Commit-Id: ee9955d61a0a770152f9c3af470bd1689f034c74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6752de1aebee8e73ee9cc31263407fdf0e29c274
Message-Id: <163659035843.13025.14339337110736659683.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Nov 2021 00:25:58 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Nov 2021 15:52:23 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/pidfd.v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6752de1aebee8e73ee9cc31263407fdf0e29c274

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
