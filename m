Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD46D3269FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 23:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhBZWZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 17:25:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhBZWZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 17:25:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2C4F764F17;
        Fri, 26 Feb 2021 22:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614378256;
        bh=JgTnQbtD4JFxeMKljzCUrIEaZf7ZvFJBNU5GLQawZAE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Jtw3KeghhjHNPjmKiEE59/aWLC2AzL9LfF4yZAmzk+/BJ/SirxHHIQvMThkjckA9R
         nMsl+iZWwu3wHlcGYy7ybcto4Onf5gHkyNFKZHx9PjWbqFklpjWIsEjkLbELAXglgq
         +uf9+yXN4e50x/8ke9a+uUo7I+VE1kzbbBTvriPHnLkwIXJDtqOr7fS6OIqhEESbjM
         09SyS9c8E+DBfqpK1uqtZeBOyLvbvwmYd80YYEDVztpqyfS87Jjuqb1hzrWhYbSqTR
         Y2DcaZwbwCHafVtN0mP4H+ozt5NgTrWgUAXXNsDpnA9kNQ+fzSG/X7Me1mrM9XBApr
         HLFumcetL4Bjg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 25DD560A0E;
        Fri, 26 Feb 2021 22:24:16 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210226215619.GC365039@lianli.shorne-pla.net>
References: <20210226215619.GC365039@lianli.shorne-pla.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210226215619.GC365039@lianli.shorne-pla.net>
X-PR-Tracked-Remote: git@github.com:openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 8f722f67452f4b28cd8d7acf1658daa5796437c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3905af5be36b9aa9f17657a02eeb2a08e939c13
Message-Id: <161437825614.23821.17989905886733438519.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Feb 2021 22:24:16 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Feb 2021 06:56:19 +0900:

> git@github.com:openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3905af5be36b9aa9f17657a02eeb2a08e939c13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
