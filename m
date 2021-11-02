Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D211D44259B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 03:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhKBCWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 22:22:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230324AbhKBCWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 22:22:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7B21260EBC;
        Tue,  2 Nov 2021 02:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635819609;
        bh=lj5qv0GyprYLCRZoJGeMxY2aUtyZGl1rD44pKSPbPO8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mDKnE4Qgc3iQoDg0LjlHJaY6l2qnRUE/1wzAJKFegA/TeIgG3aTctrjhdelUoCxbV
         u/eX/aRVAhumn+JrKvSuo90cJoJLjoSw9g4uUjTjxXFGb4CCivFCtTdDCZt4J+1GCI
         ezntGn9O2PBnJ0z8fVcH9ebc/9j1JpnQ0VcdVAvASR+gxusgVhCpu6E3XoxiBwZy6U
         0E9fNstDVDplMpvFErBZhEsar8p0TgS35ZqEE/xd10F6vMNA+FGgvIzLYZehMIl9HX
         zuPEomNh0Oph5VcqE8VpvAOEhDTnmwLLqGrcJaNyDOD14PvCv842vKg8tE/Ak96ZWJ
         R410PSX5JSknA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 74FC260A3C;
        Tue,  2 Nov 2021 02:20:09 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes and enhancements for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211101130435.GG4667@minyard.net>
References: <20211101130435.GG4667@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211101130435.GG4667@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.16-1
X-PR-Tracked-Commit-Id: f281d010b87454e72475b668ad66e34961f744e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 316b7eaa932d99e6421bee9a89e4f19aefddd88a
Message-Id: <163581960947.22980.3739390742478333185.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 02:20:09 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 08:04:35 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.16-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/316b7eaa932d99e6421bee9a89e4f19aefddd88a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
