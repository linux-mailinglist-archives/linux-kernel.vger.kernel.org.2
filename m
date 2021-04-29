Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F6036EF32
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbhD2RxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:53:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241057AbhD2RxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:53:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2E1AB61405;
        Thu, 29 Apr 2021 17:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619718733;
        bh=sapYgk/AYVJ7hOQneAgX426A8AKArryYLfD/iem75tY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IrzrtzjAtDIh86Xi1go2EDXN66KU9vTD5IT+LuTOt0X7x4uv68wKeaixm3iNa+MPy
         emj6NLLfO6r9Xx4lTzo5PIibMHqqVA3YqALrF5J3GfP/I9Noyi29P7HpVliqcRpqXn
         PJ0I2BKZgvMm7FDPThqkRyVXZYjxnq6E82Pgv+UBDu+jhlW2oJrftU4eMZwd/lhoQ0
         YShxAQqYmKv/TsnBURz58k+4JHrMIAxO00MpoAkXz+Z13eryidBJfABYSgP1OysDFV
         cD3QQI2TBZiqQ2puUeGQN4lk0bemTTvTc0BuD4xeGutnjX6D6XiynO037r4qJsVkFB
         rGXL4zrko4AZA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 28D2F60A36;
        Thu, 29 Apr 2021 17:52:13 +0000 (UTC)
Subject: Re: [GIT PULL] GFS2 changes for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210429103445.846975-1-agruenba@redhat.com>
References: <20210429103445.846975-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210429103445.846975-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.13
X-PR-Tracked-Commit-Id: e5966cf20f0c7e40fd8c208ba1614e1a35a8deee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2c80837e27e67e91ad93f41f0849be28b808b14
Message-Id: <161971873316.11214.7996386584154973395.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Apr 2021 17:52:13 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 29 Apr 2021 12:34:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2c80837e27e67e91ad93f41f0849be28b808b14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
