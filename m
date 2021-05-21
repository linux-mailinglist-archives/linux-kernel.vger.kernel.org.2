Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CD738CB1E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbhEUQgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:36:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237141AbhEUQgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:36:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D06A6613E3;
        Fri, 21 May 2021 16:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621614887;
        bh=pqJ6ku83Nmm15hq6mf++nEza/8GnxayfLX4erWJq3Yk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dN5352E/TWXXZtk/JPlfem/wM53I0K1888CITpDiZUjT3AsJGzProeGSOOHpO0ZEJ
         mKgSp1a0waRqM9x3r0HJiBEJ2Z3R4RC5MqntIqvXvHTw8DDk4E+n8e0Wew0lYA+AoU
         Fww/Us30PMiggPgT03/D77gw2t0SUhHa9Rw8QB4/UkgfBk3qy75CzMSh3FoNMVurbA
         3uSL5k3Hi9cnWSjSb+sLrnBg4gG5IvX+7SjqMjoplum3AlAwAM3atdWV23/zM2Jkbh
         uUgxOcvnNVk04SHc7rq4b/7MmFn57zlzD294vNWRQSOBy1/QwT/qfxuQIGw7YjOEcz
         JjTvzNgABRMdg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C98E3609E9;
        Fri, 21 May 2021 16:34:47 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC fixes for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YKdeZFKthTY31705@antec>
References: <YKdeZFKthTY31705@antec>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YKdeZFKthTY31705@antec>
X-PR-Tracked-Remote: git://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 8b549c18ae81dbc36fb11e4aa08b8378c599ca95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93bb533a340bde2065ecdd8694c8d1852537edd2
Message-Id: <162161488781.28405.4246977685057973940.pr-tracker-bot@kernel.org>
Date:   Fri, 21 May 2021 16:34:47 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 May 2021 16:16:52 +0900:

> git://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93bb533a340bde2065ecdd8694c8d1852537edd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
