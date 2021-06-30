Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613EB3B8888
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhF3Shi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233488AbhF3Sh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:37:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BE7CC61427;
        Wed, 30 Jun 2021 18:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625078098;
        bh=a/8NMfE7ol9Tv6wXZ8c6TjOijUkX++Vuzo2czSRbAQQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TsuApKlpgqjbmlgKleHfBi3Jpa8YLFmhHMSj4S4K1zZHlVjhu1VHXgCltih9ykRTM
         sm6uKssPlWtyDCY5o9LNYpQg7AZr95+/ZDjQUj16AZSg2+B7Qnv7kAyDdt1KmvvR6v
         SF0viIlTYfXbvfioUa7u1fcAzdSGGvqnNnUEhXNruYAQlA/FvNcCWw4d/pCyX+7s+s
         1CG2xPs3CUXMj70iwEI+pQkKz/O11aaFWY5VdLoEWTQU8QRWz1NnDia+9+IhU23GJS
         Y2ef0UQS+a3vDe424SX4LGSF+YKIU1+jyDCwh6txDNlBIXoDsIZnvgv9I9oKLgY2vo
         1RCjfNx+mcvJg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B898060A17;
        Wed, 30 Jun 2021 18:34:58 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.14-1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c2fbb9bc-4443-ac00-d4b7-5b2305100545@redhat.com>
References: <c2fbb9bc-4443-ac00-d4b7-5b2305100545@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c2fbb9bc-4443-ac00-d4b7-5b2305100545@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.14-1
X-PR-Tracked-Commit-Id: 0e695c3f7f66c66e0a1da90cc5378198a656d494
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 776ba3ad659e4955079f57f8d859e7994ea35076
Message-Id: <162507809874.10377.12793851950961653241.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 18:34:58 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 14:51:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.14-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/776ba3ad659e4955079f57f8d859e7994ea35076

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
