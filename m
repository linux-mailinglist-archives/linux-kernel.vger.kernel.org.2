Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBC834BEE1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 22:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhC1UZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 16:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231366AbhC1UZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 16:25:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BF9E161951;
        Sun, 28 Mar 2021 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616963123;
        bh=zVOIv0XoFa0lOb94n/TY4NMT6JOjEyckLbrkK0z/0SY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SE5JgAYRE28YZwjBkcP0Mxy9FkxZfGPhcCyOqwqYdS7a/oOFqchm1gtBWV81GWAKT
         Dybn12Mt5WixxfrfLppnJRvufLKvW3sT/NY01KnZiuPhM8F1anA/Wft2FV3cXtz2zv
         2hLoxcbsH3J05xZzNekY0aZZWN2+l92sWFdO10IDGESjyl1qayhi9kpJQQvDyTGRVr
         kew9HRuMNiKcY2hjEUbc7D1x3ivEG5KfdGapNvbdb+++vzIbv9nTyDC3u5kcLVYtv2
         y5yJYv6WtZ8so/g09USU6nvE6dMk3f9jR9syCKXnupiHARjwzdQA090GK5OCaCKQSe
         C996Ekrn0y7Gw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A6E3D609EA;
        Sun, 28 Mar 2021 20:25:23 +0000 (UTC)
Subject: Re: [GIT PULL] auxdisplay for v5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210328165118.GA23099@kernel.org>
References: <20210328165118.GA23099@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210328165118.GA23099@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.12-rc6
X-PR-Tracked-Commit-Id: 701454bce906241ba7f50e2773881560d6404d29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3fef15f872eec8292d4e53e307c1d17530fb16ba
Message-Id: <161696312361.20511.6275426186371922347.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Mar 2021 20:25:23 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Mar 2021 18:51:51 +0200:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3fef15f872eec8292d4e53e307c1d17530fb16ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
