Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD95A426F76
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 19:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbhJHRW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 13:22:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233610AbhJHRWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 13:22:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1011E60FD8;
        Fri,  8 Oct 2021 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633713626;
        bh=ZxgPAEGDD8zbiCV2CKqAL/NIx3JDlV6jSMR8+Npz4Pk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pGzZlIptBcFyhqwRdLtwR+708tiEPi7HMjBH9/sgaIFTYbyX33GQcEax7I56yT32e
         DbAbLdurg5mdA344qsEjDOX5/MMTRp+hSa1dveU1fV9XLvh3+oowRS8NIAi8GpSTzg
         H85MyN/G/kvR+WsVQHDy7hrTuyG+QQovaHuFV+3fMod5/tsCwFS5ySK4T5G07d96f6
         +UhFLkzxZzXTk886oXWt5xxq/phmTUZJ88DhiWjz8FSBibuneyRZVdGbneNt6gSEk0
         hGC17fUC71MuFQc/MPypdkcMEmwBlSku+8jqqtkn4m1ghva5P9loMG6CR0iAg6flS+
         iLUn0OvAkn5hw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 09F9460985;
        Fri,  8 Oct 2021 17:20:26 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 5.15-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YWBt6v3kWkjcJcp0@kroah.com>
References: <YWBt6v3kWkjcJcp0@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YWBt6v3kWkjcJcp0@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.15-rc5
X-PR-Tracked-Commit-Id: 58fc1daa4d2e9789b9ffc880907c961ea7c062cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 741668ef78320a2c1aacbfecea43ac884d989ec1
Message-Id: <163371362603.20952.10398357566457427977.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Oct 2021 17:20:26 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Oct 2021 18:12:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.15-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/741668ef78320a2c1aacbfecea43ac884d989ec1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
