Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D74C3C3648
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 21:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhGJTLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 15:11:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhGJTLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 15:11:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4562D61353;
        Sat, 10 Jul 2021 19:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625944125;
        bh=S3Zj5ganitsBkFOYVNt2gniu0QT9rVtBrKblLCIOQw0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pQJ2qPkCkUoMx+8lzMTSdEOMZuNnv/TK3s40ZIBOyEhlDEfDTzwquPJawmymmBjmv
         PrgRsna2TB8DaHlfMO9xX6/FYEOpnVIbwoHD7Gx7AfoqkOnBcqvyIQ11F9/ZJICa0t
         cDwb0CLanjIh2sTRy6OL/6shQV+XesFgHh039HAbwIe55rguBTkIfmlOPV2jMXbTgh
         pUDVeYk/Kh1VquNAYq3ncLfnq5QthpXPyGLl1mIHjIdyorfrLuBEm4MEfjlQnhRm0c
         goUR93gJklMYLJDcC9ChFrLi75C/fRLgASDaXMW9Hw3YeEvOUYVhV6aIgsjn0oHQ0y
         K89TuumhEYsOA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3FB3E60986;
        Sat, 10 Jul 2021 19:08:45 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOjdDda7QIQOmR74@piout.net>
References: <YOjdDda7QIQOmR74@piout.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YOjdDda7QIQOmR74@piout.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.14
X-PR-Tracked-Commit-Id: 3e5feb11a82945c88a1518fd2682ca8de66c37d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88bbd8a031b83d4a91f1f8f4c1ce8caa16dc0886
Message-Id: <162594412525.8052.14895591945637971336.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Jul 2021 19:08:45 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Jul 2021 01:34:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88bbd8a031b83d4a91f1f8f4c1ce8caa16dc0886

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
