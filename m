Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E943BC320
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 21:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhGET0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 15:26:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230033AbhGET0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 15:26:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id ADF876198B;
        Mon,  5 Jul 2021 19:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625513049;
        bh=N698MgDELmZWGtlW/gg7zE6t1qTtQxHD/HVSV4cGWoY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Yas/r3a1LIkAx9+vXilWRFOhPB2ce59JX3UU/AxIFevevT82d0X/LC1sSbw6qRofD
         wknWDHfY5D68GR+Va2AY8XnD1UHGxJ/TAQDn3oCYVWsVv7bwY6IQUh6wyFKK5WWb1P
         9v7+0nYNOSG3ecmIONjR5v4ce9iEmvutfSciAstBHxtfCL13Z72jQZ2va2TgiStyKV
         ATEMXUBPFdWHCUQ3owfgE969Juy6HPKOegt6765o2G05ndc0ooLUh2nW6mnhETB4yG
         3HPIHDPqoeRph3dCamyJWl8wmlYzMz2NRZ/fjdKm8I9wmQvtCc5hfEw1rbJneVapxU
         imYh95YmMsUIw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A8C2D60A4D;
        Mon,  5 Jul 2021 19:24:09 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOMWmKay/ETTkvkz@dell>
References: <YOMWmKay/ETTkvkz@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YOMWmKay/ETTkvkz@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.14
X-PR-Tracked-Commit-Id: 1181f2164135d770bdad297290b73d274787389b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f8b8e7dbd79086ad48fcff33de9399f3da66a69
Message-Id: <162551304968.9654.6652975783133238075.pr-tracker-bot@kernel.org>
Date:   Mon, 05 Jul 2021 19:24:09 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 5 Jul 2021 15:26:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f8b8e7dbd79086ad48fcff33de9399f3da66a69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
