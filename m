Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010B136EF31
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbhD2RxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240928AbhD2Rw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:52:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8606B613FF;
        Thu, 29 Apr 2021 17:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619718732;
        bh=rVrix5cV826LFqa913uVBlTF2UANJfLtU1g7yx8z4rg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fLSjz3o222LdEIVIkwHiMce5OcI7hGdiMYxPbvnoXDTk3ogsIOIyYAX0u/p3AYD5X
         wJ05yO/wYJAE3543vyWuaEBdGnaOI1p9eYmxLskjEeMt5vM1Mn5hXXr5PvyIdRVwKU
         tNNwHw5uWMaLVulrTUTOFqJENxrL1zW+eINK75wlc8hyBpshg1O2RxEc/ibPCTcdDJ
         7qIRmes4TL4W3IMoO0z1WLBfgX8YrtRM0vxBas5knbpDaPpARUna81cuLFuwa7fLWO
         mTIRXOEnZ7uFGxTbe7p3z3NZI7IFM6BF7SzamuGlVYcLq6AQrJQWc8DZvbnpW2ZxyW
         8d2N1+ETYzcEw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8103160A23;
        Thu, 29 Apr 2021 17:52:12 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <003c01d73c02$81e6b2a0$85b417e0$@samsung.com>
References: <CGME20210428074549epcas1p33641467e86ad0d0e3915d8ba0b936f90@epcas1p3.samsung.com> <003c01d73c02$81e6b2a0$85b417e0$@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <003c01d73c02$81e6b2a0$85b417e0$@samsung.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.13-rc1
X-PR-Tracked-Commit-Id: c6e2f52e3051e8d898d38840104638ca8bbcdec2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ae8932c6a330790c6bf22a43a6960118c34dcb5
Message-Id: <161971873252.11214.11907511510146637214.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Apr 2021 17:52:12 +0000
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        'Sungjong Seo' <sj1557.seo@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Apr 2021 16:45:49 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ae8932c6a330790c6bf22a43a6960118c34dcb5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
