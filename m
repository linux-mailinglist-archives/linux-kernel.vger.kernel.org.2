Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473993C289B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhGIRo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:44:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230185AbhGIRoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:44:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 11625613CA;
        Fri,  9 Jul 2021 17:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625852500;
        bh=HMjoup3QJmViBUshHyxqOCKugInk17QcT2upaR2x/MU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gZa8kT0Xu/nP89WVzw+cUSyeEpJERqauPt4H9oNWoVaIj8Ibq3jwkxa7w+dnl3yj7
         +sLTgnGn4bu2yo3EvsUCze02blDiXwTiI4LQjZSBfQWPvWxB3yPLwTCH3uuBD317ws
         C+TjIGZaujK+5jgwRg4AkhgBl2UKZIr+5+OZYyyzEfWgNlqjjUVe1CdriRkhyhS3af
         emwQ4jQLNgg3PcbGbShcCb2eaCjX8wIzAD00/l3xcLkq51Z0d6I4BQMorT4ckxJyJA
         6wLE/G384MQ9K18wI5xPjVgNgWZ6F3OFQf6dhgt0ulzcFL3G9IXg5CqZEqhjawKunw
         13kf1f81oFciw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0B4CA609F6;
        Fri,  9 Jul 2021 17:41:40 +0000 (UTC)
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOYHejl3CgABOnhP@google.com>
References: <YOYHejl3CgABOnhP@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <YOYHejl3CgABOnhP@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.14-rc1
X-PR-Tracked-Commit-Id: 28607bf3aa6f9762b32dc7f1ed0488823c0651b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 227c4d507c71acb7bece298a98d83e5b44433f62
Message-Id: <162585250004.25269.13552956569503185512.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jul 2021 17:41:40 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 7 Jul 2021 12:58:50 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/227c4d507c71acb7bece298a98d83e5b44433f62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
