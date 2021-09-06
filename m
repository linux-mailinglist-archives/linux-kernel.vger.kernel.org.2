Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7866A401F16
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 19:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243723AbhIFRQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 13:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234305AbhIFRQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 13:16:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 71C9460EE6;
        Mon,  6 Sep 2021 17:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630948513;
        bh=uqBaGn+ciW1wYKB70jbEfHkf/APOm+r/TQ7pbaOKOQc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MoCyLyAmSsXV6qkrYc9XUf/Z+sbjj2viNV4ZuTZR9OaJYD0GMU/Z8qr7UnJaHQpL8
         hdQ2Xgm6L1P9QybIH6dHtcogbsaSK9ptJI5S1U1qwYHMMLLrLi8O1B8/U7ElU1rfL2
         DcgDHxJ97+eF/R8qLq8e29knjIOnCNFzCFJnLEY9SI2g+Dq4eeVaTVm+5af9w5zWYB
         LHL+g+bbjC5Y3m5yVKnMwMBAHPvNN4RpU3Lw7XJ6zeTUa6kxkmYDsV8YcO/KiDxOnz
         okbjLCWVjhGlhAwbKWrRWB9b3+6lFKVx9X8kJaQGCLuLjuqHbWpI+TYPnvy5qo3e1i
         vt8C+KNWUok0w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 60949608FA;
        Mon,  6 Sep 2021 17:15:13 +0000 (UTC)
Subject: Re: [GIT PULL] CDROM maintainer update
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d5bb414c-e0e1-ff06-ab4d-f96f706be4b2@kernel.dk>
References: <d5bb414c-e0e1-ff06-ab4d-f96f706be4b2@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d5bb414c-e0e1-ff06-ab4d-f96f706be4b2@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/misc-5.15-2021-09-05
X-PR-Tracked-Commit-Id: 55d1308bdff7341b778e5cf36220616a0dd6ab8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03085b3d5a45a60061423ac4857f339c7cb260ff
Message-Id: <163094851333.9377.10105652881470931294.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Sep 2021 17:15:13 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Phillip Potter <phil@philpotter.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Sep 2021 13:00:31 -0600:

> git://git.kernel.dk/linux-block.git tags/misc-5.15-2021-09-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03085b3d5a45a60061423ac4857f339c7cb260ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
