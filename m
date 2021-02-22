Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1CF32200E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhBVTX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:23:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233037AbhBVTQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:16:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 69A3B64E5B;
        Mon, 22 Feb 2021 19:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614021127;
        bh=dCE7MIZ/jxOs5upDR+Q8fD/+avkJt8ZIf/jF82CoDsw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ou+drirUIA6V50spHCPcUPhj6utIEEuwFbjIu+djf2KXa155Cs3AJedAiPvNnUdel
         oqcmus31fh62HMMak/kQReL5vyZLlD1iGWOcccyKspdKcRLKOG20Ksiz9F+n7xdx7x
         Yy21RduLea/e0EsgqwKnbfSHEES+4pE7lKMRhTBXl7OUJUMIKIFbkFgNNZiTUUKqmY
         VxxzEhXHGr6DGM4z55z3PuFNdzwVpI+1auC7DgFbQeJoWtoh/W+CtG5+n7JtBf2cnd
         OenFnuSsCQP0+irIqiMAMd4famzNYHx/zh8K46VpkkX06UxcE3A3Qm238Z+avcJ1qJ
         6hKXd/A2om94A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 66138609CC;
        Mon, 22 Feb 2021 19:12:07 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit update for Linux 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <482cb3f4-2ede-0369-922b-dd326b100873@linuxfoundation.org>
References: <482cb3f4-2ede-0369-922b-dd326b100873@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <482cb3f4-2ede-0369-922b-dd326b100873@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.12-rc1
X-PR-Tracked-Commit-Id: 7af29141a31a2a2350589471c8979ff5f22fb9b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 783955f03de770e94a1200b8f719975f8768e76c
Message-Id: <161402112741.16114.6050367073001868288.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 19:12:07 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 17 Feb 2021 17:10:51 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/783955f03de770e94a1200b8f719975f8768e76c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
