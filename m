Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2ED434FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhJTQSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231248AbhJTQSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:18:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 73F6D6138F;
        Wed, 20 Oct 2021 16:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634746563;
        bh=B6LpxsobwLUaEE2NCbHxc3KNeotDBo3xuBC3ZTuRrjg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lbw5ruMuEnfOBUGhV2MpdRoQVWaSDmc781s0yllefqKEVOQQRdpkw+ZO7FcHR59ah
         bZb9flsjPp2NSfWvrXc8VOrixaLFd1UgYJXfe/fWHqDPoqT0mOMzd3ROh2eK08GoHF
         8UUG3vo49L4j7s8LaGWhEtf7ORuhxSzxJA6xR1cF74B2s+4kBGF1hTLgTF91vmvGjC
         MDSW5HFx6jJfifIksfbvKkHp5FzE5KGTX2/FAkvwicFNrTOa6H+/m+sI5ulhWwjsTL
         wxDom6OYsmqr0v0iVWl05m4t1CcgvxAPbGT9GWC3m6QhfO1ehwZCA4sRHfYOlaZXC7
         tXthTNJhAaW1w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 67391609D7;
        Wed, 20 Oct 2021 16:16:03 +0000 (UTC)
Subject: Re: [GIT PULL] Audit fixes for v5.15 (#1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhSfwi2NhS4HtmqjfrnQcK+YjaH1xm5XdAZ=MUcE78oCRA@mail.gmail.com>
References: <CAHC9VhSfwi2NhS4HtmqjfrnQcK+YjaH1xm5XdAZ=MUcE78oCRA@mail.gmail.com>
X-PR-Tracked-List-Id: Linux Audit Discussion <linux-audit.redhat.com>
X-PR-Tracked-Message-Id: <CAHC9VhSfwi2NhS4HtmqjfrnQcK+YjaH1xm5XdAZ=MUcE78oCRA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20211019
X-PR-Tracked-Commit-Id: 6e3ee990c90494561921c756481d0e2125d8b895
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6da52dead8f59fcf81e19ad3937d903a9b87e1de
Message-Id: <163474656336.19537.14120629558019584320.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Oct 2021 16:16:03 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 19 Oct 2021 21:42:57 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20211019

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6da52dead8f59fcf81e19ad3937d903a9b87e1de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
