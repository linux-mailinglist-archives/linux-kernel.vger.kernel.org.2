Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E81394D35
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 18:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhE2Quv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 12:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229820AbhE2Qum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 12:50:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 896F161107;
        Sat, 29 May 2021 16:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622306945;
        bh=cbl+BgPhLQQ3LwgO2anA8kGzLI1pRoHWOfirf+bV1EQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N+hh1YUWcSPTS5uS7oPkuPDE9a7cWVBXIzwcYqSNvEt8/MQvfgJy2TvRzQiplS+92
         BB5ckd8/9DRdiVJRd4JmEVjNebFXsO7E0+2RfKxo6tZaONRCfGRAxHuQiP+1Bo0YmV
         C201pOYgMNe8q7jJ1ERsZNVcM05V5wnbUsKmI61HFA/igWfucZC62oWSellTTVuIMp
         mAkllmTBcvhUrXi+vB3WMa96tlxSXuFuLx+GvtPwMuGxs4a/qEsGnG646vc1AHcJHF
         zahBF/8rpRbEICAGnymk6Z1i+2HwSCTB2RGultkxoHiez8oMZGD2Bb49tvE1G+BgZ4
         y4EDHg0sSeGYg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7D49F60A6C;
        Sat, 29 May 2021 16:49:05 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YLJPW4hAf5CAbXwh@kroah.com>
References: <YLJPW4hAf5CAbXwh@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YLJPW4hAf5CAbXwh@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.13-rc4
X-PR-Tracked-Commit-Id: bbf0a94744edfeee298e4a9ab6fd694d639a5cdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f956cb99b938fbf0f8262ba335d505b1ffd02c4e
Message-Id: <162230694550.3322.16579827508534584404.pr-tracker-bot@kernel.org>
Date:   Sat, 29 May 2021 16:49:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 May 2021 16:27:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f956cb99b938fbf0f8262ba335d505b1ffd02c4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
