Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF423BC39E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 23:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhGEV1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 17:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhGEV1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 17:27:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 30E7661985;
        Mon,  5 Jul 2021 21:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625520304;
        bh=ASXc1IQiZkgWc5L7qccU92fl42cImi1euHaOnepkbyE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MciShCF+1SH07MvHnUWtGPr+hu3xIoNoCQDUUVRa9V+pKr65W/5BcccqKcKJAaX92
         rYZTyoP8RMcykboIOs8eitdlG53ZLFcsn+Gz5CRCqkOffWe5lVqDdDMRRDJITsZM/D
         MztDzQHutmtqvFHmuov46TeWaLaHJuyhGceyK7v2WTFyjL8MRkD6v+jHnSv8H4r38c
         5UqjyGpaYk7fNGh/v+v5+eNWVZ7xOWWH67sJyTC8BTQKT+M8xosienLigMYDz0Ok2k
         Coi9NUSGiNsrzfei8PXIoe7PiAiVq8fCdicqr9y84ibLMA50yQ6yAWEM/AS2+jM1Yo
         I4R+0FRNRwHdQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1D13D60A4D;
        Mon,  5 Jul 2021 21:25:04 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt driver changes for 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOM9yTZZsEicMW3f@kroah.com>
References: <YOM9yTZZsEicMW3f@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <YOM9yTZZsEicMW3f@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.14-rc1
X-PR-Tracked-Commit-Id: 7756f1d6369e61d1cc47d6e51619d1e1d1681a2e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79160a603bdb51916226caf4a6616cc4e1c58a58
Message-Id: <162552030405.6675.1261054931935515577.pr-tracker-bot@kernel.org>
Date:   Mon, 05 Jul 2021 21:25:04 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 5 Jul 2021 19:13:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79160a603bdb51916226caf4a6616cc4e1c58a58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
