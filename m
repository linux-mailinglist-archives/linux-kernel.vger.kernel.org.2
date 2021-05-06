Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C00375888
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbhEFQg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235248AbhEFQgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:36:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1910161107;
        Thu,  6 May 2021 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620318927;
        bh=huJtbCV1Gi0bWntZkvHCoREaR8vwHWIMpnUVhx07qoo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CsXiaGbxKx/vuxzbudC1ge1gdvG4hCoKpnGoTm726Nf/IU0LZQ2GLj6tEFUq+cQ4E
         eDbww85wlWvPKqM4h3ouF16JWEb2LXH+1u5Rr1NdTyhw/fQH2kNYdcALrFHpPX6dhU
         kADEGjroJmwrQeE3TXlTJXDhgU6rvNr9sXE5jykGDcf2UosEsimszm5bM9YYPXgGQQ
         B8TwQGEkggjbk1R6SbVUEh9YX34eWG+mMXuvu2HDCYho8Vzj9U1l0CzIRyieQtZx4a
         VPwS7xvjK/REPfdDl2nAk+ThyAgQltl2LxksJ7eJREh1GXBSrQN5O+FRYbADGBX4Li
         d5XAwzrrb0Maw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 03E8D60A0C;
        Thu,  6 May 2021 16:35:27 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fixes for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87pmy4khx5.fsf@meer.lwn.net>
References: <87pmy4khx5.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87pmy4khx5.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.13-2
X-PR-Tracked-Commit-Id: 7fc4607899e87259bb751ccdbe53628aa467ec22
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3f53e8adfda814730c341ee39ce015a0abf69aa
Message-Id: <162031892695.29346.1585570848371067971.pr-tracker-bot@kernel.org>
Date:   Thu, 06 May 2021 16:35:26 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 05 May 2021 15:08:22 -0600:

> git://git.lwn.net/linux.git tags/docs-5.13-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3f53e8adfda814730c341ee39ce015a0abf69aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
