Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF75A37FC1A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 19:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhEMRI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 13:08:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229797AbhEMRIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 13:08:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7CE07613C5;
        Thu, 13 May 2021 17:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620925660;
        bh=8d8PeJo43YRpa6b1OJljzcPha+u0XaaZzInFVya+i3E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ia4dePC+JI4Of79qxlpSh4xKIv0sijeB1qsXPfIMtV22Qsz//GTKJoMFCjdN1GFkE
         XElWxYxsCZOEJ/NW/g8Mm6pe7dUe5nBxX7O02UsqNlDjmKjQsZFPtc4zZTSYJuXIy2
         haICfqKX2GRWKJ6d3WCF4/NDH17lqrwEJB4qkQXF2vlau32hrhjEsnxL5KZpfAonj7
         5bfYHlovHdWxi4/PrKxrIlPynniHPj5Kh/DrqpJYYx1VFGhI3cNmeB7heMNgMN93QA
         t4fVvUzJJvZiVVO0b8WMz4MtertNpxOcWnw+IiqvWvXGiNQWa+w2PN+MPvT0RUJGqO
         vvlnH+eXpBbYQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6C74160981;
        Thu, 13 May 2021 17:07:40 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v5.13-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210513150036.3199353-1-linux@roeck-us.net>
References: <20210513150036.3199353-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210513150036.3199353-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.13-rc2
X-PR-Tracked-Commit-Id: 3b5169c2eb81e822445469a077223f8eb0729a59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1e7c13a9b0c27c9440e00865a7c46b7a87767ee
Message-Id: <162092566038.19564.12212741980586723368.pr-tracker-bot@kernel.org>
Date:   Thu, 13 May 2021 17:07:40 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 May 2021 08:00:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1e7c13a9b0c27c9440e00865a7c46b7a87767ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
