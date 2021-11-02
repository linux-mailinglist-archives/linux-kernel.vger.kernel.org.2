Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633804424EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 01:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhKBAxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 20:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232100AbhKBAxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 20:53:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 12D306109D;
        Tue,  2 Nov 2021 00:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635814269;
        bh=itzvnPaNRN7pHKx0p9dxSKU4iRopG/eOat8/tfHBXDc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zq7OQ5Eovlw+5okFTv8Cff8Ey72eIJBnb2dQG8uJdC8C5ZIW0iwqSZdoP+qdCazAi
         94MVxdvCoZooqAOw6Dhw3AOkNCHI22yVYM1OwFdUhGL8EusF3Ns492CCxTTZMfhOrw
         IcQSl6XO1g253ijVEOSr6eLbHh97C3TbGmXaFDQCz0wSPj1feSl8150kRbtzNAod42
         jYjM6NeQUzrw2puplfTpd+eAkG+WD1BqYHVFDLmsWsdqZKsG+FHy4zSKQaGZ92Lz4F
         oatKY3uZrBPDybOR1w5iw+vuI3ES3bb7RTxSqSc9EwRjem+OLPXejyJPyHlUtwXhAE
         aSokSWzCHr7Qw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0C69160A0F;
        Tue,  2 Nov 2021 00:51:09 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp updates for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202111010938.243DED4@keescook>
References: <202111010938.243DED4@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202111010938.243DED4@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.16-rc1
X-PR-Tracked-Commit-Id: d9bbdbf324cda23aa44873f505be77ed4b61d79c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5a9e006059e7ac1af3df57d6d7c53e385da5deb
Message-Id: <163581426904.14115.15371811525127876559.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 00:51:09 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Waiman Long <longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 09:44:50 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5a9e006059e7ac1af3df57d6d7c53e385da5deb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
