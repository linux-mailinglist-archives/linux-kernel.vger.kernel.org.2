Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66FF4470D3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 22:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhKFV7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 17:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhKFV7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 17:59:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1713D611EE;
        Sat,  6 Nov 2021 21:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636235792;
        bh=0+9VPDS/w5MjVH3ZYnCdPS+tABvv4GNKRHMVUyBEWb0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=th9RRnVZ3Rl3NW2aUemm3chp7Ehy9mxjy8AHNjS4fmPFh2k0pwqxlx0I7RHmmIXIV
         AYBjqS2cy/oKSJrTFkTEcHnWfhK3sRx8pYqzV8kQhR1ZQB3+iskfh89JAr5DrotPsi
         zthnB7uEADr4kJWJ8nYKCZD48vvRNJEew4+z/kbqD9rnRYjeklP/DyGEQaV8J29Ezj
         zvRDtzt/+23FJwccV8fL/U/YnbEl3b+h+1/eIfplvWYrcK+BSYdFv89hwN9QS5euwv
         sE8UvB6Q/yXa/Blt5YUVREhvRzrdpNdHBX1ohTGOrhzHHQBSJCXVl/4jXwU612jO9O
         AAwT2wolxA18Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0FD0D609E7;
        Sat,  6 Nov 2021 21:56:32 +0000 (UTC)
Subject: Re: [PULL 00/10] xtensa updates for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211105191905.7979-1-jcmvbkbc@gmail.com>
References: <20211105191905.7979-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211105191905.7979-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20211105
X-PR-Tracked-Commit-Id: bd47cdb78997f83bd170c389ef59de9eec65976a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00f178e15095fbcf04db00486378a6fa416a125e
Message-Id: <163623579205.13044.7333437205093948543.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Nov 2021 21:56:32 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  5 Nov 2021 12:19:05 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20211105

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00f178e15095fbcf04db00486378a6fa416a125e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
