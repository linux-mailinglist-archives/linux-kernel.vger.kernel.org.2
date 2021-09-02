Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E6D3FE779
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 04:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhIBCPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 22:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232868AbhIBCPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 22:15:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D64D2610CD;
        Thu,  2 Sep 2021 02:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630548850;
        bh=DF+xp+9s+qBRNYXIGMSsJo6LylcupwDLkd55fi7nr04=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UQW0sa2/eB53yH6cyFsDjjbiILk60GtcdUnZqwakRXgEnUqQpYuDR4t2NVmpa+Dci
         Ma+bwo3Yp+i7vQGddCW8RAV0P/JEbegQNwi6pdDtQzB1z7G08tdizHRMJDjMro8KcO
         01wXpMW9XRBo+C114rb0vQ4kenVPy5wBd8Qw5DEjQyEsgJ1X/lZqI5A5giHKSkr9XO
         eO2LRIOS5YT2164Gym5K6dLzPInLzTCzVl+1ORcTYFXq2gtfVpWmxIc3q+VE5Lc70q
         G74IhV3qC893Zg6h1ENMyfjGTOLiXp3UYLD9+8fRM3nBkIGowSSAro7aSCFrohO3bN
         wBk0rDzWc6uGA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D04D060965;
        Thu,  2 Sep 2021 02:14:10 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87czpt76fd.fsf@meer.lwn.net>
References: <87czpt76fd.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87czpt76fd.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.15
X-PR-Tracked-Commit-Id: 37397b092e7f4b520a257aaafe83f868cd3d5e27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ac6d90867a4de2e12117e755dbd76e08d88697f
Message-Id: <163054885084.9778.414549171989425111.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 02:14:10 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 13:36:22 -0600:

> git://git.lwn.net/linux.git tags/docs-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ac6d90867a4de2e12117e755dbd76e08d88697f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
