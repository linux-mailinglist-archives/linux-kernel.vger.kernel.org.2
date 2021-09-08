Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CDF4041C9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 01:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbhIHXcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 19:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234742AbhIHXcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:32:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 794876044F;
        Wed,  8 Sep 2021 23:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631143904;
        bh=3Azri9URETVbjHfVCK3+IYMzbBlJxRKKjVeRzZYWWGs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G2L5hw2reCpzh61h7Jo2RfvuEFv8RZfZSnPUUMuaUCb3zYeJMteptX1JhSUkWAEcx
         0WTg223ygek3scXjyEdhVGkqzXdB5j6CleAcFVEDAldXfFo+pY9n7C6EMuHacpOq2D
         LJJgqZHKnO46/E9sW60fd9AA1zpXsK++qhUVCizK/llfNVWN02DATTkPRB75wHh2DT
         8HUWcxCdZiRSJSIoEBPzAtdo+XyCiV375sg/SAbIfQQ7CRmXluB1QpP76qwdedxh0u
         89M1DF0va3FGewVv9snRfYrsqIKPbX2KPQpsGBF2a1sqhymC+SiZyynJNkamDlHMJ3
         4knGwLq5hJjLw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6795C60A24;
        Wed,  8 Sep 2021 23:31:44 +0000 (UTC)
Subject: Re: [GIT PULL] More documentation changes for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ilzaq0ze.fsf@meer.lwn.net>
References: <87ilzaq0ze.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ilzaq0ze.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.15-2
X-PR-Tracked-Commit-Id: 7c5c18bdb656057cb76fabfa1a74b793ac49da35
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f4b9289bad354b606190a4cd54d5222b4e41d98
Message-Id: <163114390436.13056.3844635275419991590.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Sep 2021 23:31:44 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 08 Sep 2021 14:13:57 -0600:

> git://git.lwn.net/linux.git tags/docs-5.15-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f4b9289bad354b606190a4cd54d5222b4e41d98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
