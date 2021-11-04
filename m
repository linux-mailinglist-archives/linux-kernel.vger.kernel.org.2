Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E460F445B79
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 22:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhKDVFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 17:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232314AbhKDVFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 17:05:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 86B126124A;
        Thu,  4 Nov 2021 21:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636059784;
        bh=Z5JAusZ646zO4MiuXqBHOmuq9OfTAi4oCy8n3QkxRLo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VCoLQykzQB1TqjL9iMELj/p842db6t+hipKq87kTmgGaaOou4ECBT2q2adb78uo6n
         xu9jyy4T4NdLQlvbAw6z1zCnaROUGA2Cm1Rj4NURpJGzznYzBNbUClbJYO4Y4HWhKg
         0giRXLkdEvzWvwnDbGG++h8hEyMLHXhyempfhXHiCJL5ZAACjftutdA5Lr4gnjuZfy
         F88JilJKudDq9czAAveSLnRYqPDiVA5f0gWI4ju3IuOpsPotSkU2+ddmlF0yD2kiav
         K6t03u47E2hP0omxgFhHRPH5+qiQanKz6RdDzFG2d+G1gl6hKs0bDorvARN9h5Dmrs
         C+heJHFvL9FFg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7BCA860173;
        Thu,  4 Nov 2021 21:03:04 +0000 (UTC)
Subject: Re: [GIT PULL] hsi changes for hsi-5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211104182920.tku5e6ri2qwz77er@earth.universe>
References: <20211104182920.tku5e6ri2qwz77er@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211104182920.tku5e6ri2qwz77er@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.16
X-PR-Tracked-Commit-Id: 4ef69e17eb567a3b276fcc3cb3452dcf89d8b063
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4439a1189f93d0ac1eaf0197db8e6b3e197d5c7
Message-Id: <163605978450.14865.12154811672280651735.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Nov 2021 21:03:04 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Nov 2021 19:29:20 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4439a1189f93d0ac1eaf0197db8e6b3e197d5c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
