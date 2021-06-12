Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90303A505D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 21:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhFLTjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 15:39:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhFLTjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 15:39:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3EDBE61184;
        Sat, 12 Jun 2021 19:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623526662;
        bh=2flocaY4QoLSPBJ2c7xD9rs6vZXHtSB7Zsu/Z7JbU/Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JtbQ70KNHlqI38ovSBtWqm0h4wyVhDuro37K/6vkZ+Ka4EeU6JKki78jQg9A/cfLv
         qsm0KIHFv+VTLJ2n+xTILeru9NW1mQc3rQW2C7slmROM0iq2lZoeeLCQJ/sFQGW4Pp
         6wvRx1VRpV1YchPPqoXEv3d25R/sHrEOqIkm8WU8QOdDdITDPRiBfcAHHnT34D++ai
         +fbWYCRScOgK5RG2dfOO+akoXhljVAIpHu8NgcuypIeEUNH0dpFbaf34QQv9gNyKYY
         aUcykeOGP0qDHDgwLp7G/xs47vt/h5ndQxWNtki+/LlanhA6wYXnzD3gVn+yBytudU
         l/ZFOMIs6UhxQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2C01D608FE;
        Sat, 12 Jun 2021 19:37:42 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YMTYj8wXW1/FXK/v@kroah.com>
References: <YMTYj8wXW1/FXK/v@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YMTYj8wXW1/FXK/v@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.13-rc6
X-PR-Tracked-Commit-Id: 3df4fce739e2b263120f528c5e0fe6b2f8937b5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1dfa2e77bbd5053d11f8f3f8987b4503badafb09
Message-Id: <162352666212.18796.13968475415033211811.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Jun 2021 19:37:42 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Jun 2021 17:53:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.13-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1dfa2e77bbd5053d11f8f3f8987b4503badafb09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
