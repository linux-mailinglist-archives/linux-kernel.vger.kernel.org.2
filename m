Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693AB3A1F97
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhFIWB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:01:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230161AbhFIWBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:01:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 013D7613E3;
        Wed,  9 Jun 2021 21:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623275967;
        bh=eENaJ85Vult5mJ0uZ0nX/42XsEP8XJ0w0bnVHpUExEE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DABjj9wvnUY9jnRRzLHA6UCaAZNmZ+YDhDLijjSI2STT0mBSDitghKiT7jOv/5mfm
         yD+Tw5c432SFUcgZLR5ymQ7UvBOwBi72iqxDAqOBs/xjbH1GAdYppK2uvIRsnXF4mX
         r9iYvE9IIq4ahlvzfmKbS/O4aFA5lwcsoUJHpxii7JH4Opljm+c+e8alG7xOcrTAGG
         P+1mP/VPPXq+ug3FQ5DMAVq13XcBV5nMu1pX9NLszmxlxg+mo3zbssg0gsBCVv6RH1
         HL5+MD6rgZgC487I75DvoViswzFPB7H4weyWHzMu4DQOrmkSkXUTfbYb0NKiQ5Vt1e
         PwqJJnEE33A/A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EEF0A609D2;
        Wed,  9 Jun 2021 21:59:26 +0000 (UTC)
Subject: Re: [GIT PULL] clang-format for v5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210609133614.GA4132@kernel.org>
References: <20210609133614.GA4132@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210609133614.GA4132@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.13-rc6
X-PR-Tracked-Commit-Id: 4792f9dd12936ec35deced665ae3a4ca8fe98729
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a25b088c4ffae97033483064ee4a1075a049bc04
Message-Id: <162327596697.6358.9886837512543385193.pr-tracker-bot@kernel.org>
Date:   Wed, 09 Jun 2021 21:59:26 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 9 Jun 2021 15:36:14 +0200:

> https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.13-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a25b088c4ffae97033483064ee4a1075a049bc04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
