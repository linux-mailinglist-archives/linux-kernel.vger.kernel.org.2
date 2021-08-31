Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EE63FCF49
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 23:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241409AbhHaVth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 17:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240867AbhHaVte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 17:49:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2DCA76103D;
        Tue, 31 Aug 2021 21:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630446518;
        bh=ROGyCSEnS0EwPih0AVc0zvSTxAsHupBcnNjAxTQi3F0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Acz8bj3/P21NE0E3EescdwpZXiToPKLNZv+kYUBEGyyJeIwuefjMFZPE1N/DFYt20
         SO14zdMaLFHOGOQZbZHD1WOd8z87zxTHS0zrOJ6p6ioA+cE7dDMXy0nzoTviJrW3zw
         fIhh6pkBkU5e1EGXYYCl2qxkHpNcQoOy837rd1VastP/tStsF8dTR9kQqRyDWMGULI
         VUetgGtRaGJVxPs3vaIfUMwAgvLpzRNutfXvru3L7VhwHKC9LVy1VOnicNIo3E3dWK
         qQhTYFoTl4HoZGCenK7yIMDtMIpSrjJiW8NylcHRaswZ9SkxohBVabkav3ch6B1mUw
         DAkYv9YWLyfSQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 294A660A6F;
        Tue, 31 Aug 2021 21:48:38 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210830212608.2704628-1-linux@roeck-us.net>
References: <20210830212608.2704628-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210830212608.2704628-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.15
X-PR-Tracked-Commit-Id: 0e35f63f7f4eebd268ec236fd1bbf4e561ce8de5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7c1bbcf0c315c56cd970642214aa1df3d8cf61d
Message-Id: <163044651816.1462.15402559517805456286.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 21:48:38 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 14:26:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7c1bbcf0c315c56cd970642214aa1df3d8cf61d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
