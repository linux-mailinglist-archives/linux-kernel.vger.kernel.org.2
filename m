Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1E43B6833
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 20:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbhF1STx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 14:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234953AbhF1STu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 14:19:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 58F5B61C7E;
        Mon, 28 Jun 2021 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624904244;
        bh=ENQMv6xtYlmihj7U5QssLzAnySObEY/l291Py75655s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sofHHvy9mRgDJptRyCloJZZoVXuI6WxEsy+4qv5a23b15WHzVvvlUH/kcqdJdmC51
         nrMQ4HsxH0EKktSwoMfrDeVDYg0hG7l8mjM/begq6pevqwzBbrK9IUv44Gw8qGOPHC
         YvLsN8uDyMLea3JE0/Kbw4YpDxf5Ol1qKOUzKyRjXM+O0l6hBXWqTeKuzqIoBJdyt3
         ZChwFl+bssZPxxuEdov1lAqVRzDBPqgqBKI5I7A8LLadz3lMfA6UDGrpJGmu8pxMIc
         r34wHPNybzniRJnF7KUoxz4EmtqyMInygY86MXlKXmjBOpW01L/zkAvcxovP45787G
         4e2IxKLZGk0gw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4BA9060BFB;
        Mon, 28 Jun 2021 18:17:24 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210628145501.EC10F60C3E@mail.kernel.org>
References: <20210628145501.EC10F60C3E@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210628145501.EC10F60C3E@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.14
X-PR-Tracked-Commit-Id: 7fb593cbd88cf4df01c096d4dc320f027dfa2560
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c10383b3fb10286dfeac7754ca964ec992f6fe78
Message-Id: <162490424430.3852.5102901338636363203.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 18:17:24 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 15:54:23 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c10383b3fb10286dfeac7754ca964ec992f6fe78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
