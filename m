Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCF232218C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 22:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhBVVgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 16:36:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230379AbhBVVfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:35:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 220CD64E41;
        Mon, 22 Feb 2021 21:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614029713;
        bh=46c62Tgo+N4TujipKngvwP9B0xv3Hwg7Mltut0LszQ4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j6AH+aC9FJbbCObT61AU5iVfHojdvrT/RHxG3e5qxcKMDSED1/6P1V14MgRSnfHuK
         T7455RtZ5PdPTOcsNoJ2rU8UKDsjd1gxaIq3DSSkji29gGkfLWArAh4CieB7849Z6Y
         alwue4XDtUYae/A4QGjdHQntxFN5NhWrzybynrU7GZXPEinIas4MAt1rIIvJTKCUxV
         XX3XJO1eoNvYsWpxk1ZHVv7bX4D/vDpkLZEtu07iP+K+eDOLUx9fU9i3T+7JjwYtWT
         27A89JEtrPAsEuMfTk6WUFg6Kb5l/GYhTVuDH0DpHtLOogTvPiXM9gvBa770iGOJsK
         NllBFHL+By35A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0DF49609CC;
        Mon, 22 Feb 2021 21:35:13 +0000 (UTC)
Subject: Re: [GIT PULL] memblock: remove return value of memblock_free_all()
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210209094327.GB242749@kernel.org>
References: <20210209094327.GB242749@kernel.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20210209094327.GB242749@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v5.12-rc1
X-PR-Tracked-Commit-Id: 097d43d8570457c1af9b09fab15412697b177f35
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b7028edf939f6ab3bb7465937b33dd714020fa8
Message-Id: <161402971298.2768.13885496643058009034.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 21:35:12 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daeseok Youn <daeseok.youn@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Feb 2021 11:43:27 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b7028edf939f6ab3bb7465937b33dd714020fa8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
