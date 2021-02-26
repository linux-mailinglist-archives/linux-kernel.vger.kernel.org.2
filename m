Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C649B3269FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 23:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhBZWZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 17:25:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230045AbhBZWZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 17:25:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8C1EE64F03;
        Fri, 26 Feb 2021 22:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614378255;
        bh=cSSG2qWCbnieRWZ0Chso2jZis+Npw/j2IfpNSStOIdE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Opmf7AwlPI1IpNL8nkSy1jFWFf69Tz2OemUW4nHtz+DtqNvrmdm+RiShrZZTtos34
         Vwayvl4bBg1ruBuLY9IemlsMjLRJAAnYwT28F3FAIXUkCQjimM1Cx6Xw6LOhLmQMXp
         r9aokWGAqhu3Nkh/5fo6yhBbL0VI6sWc2mUkkmhp6HYXOjCbJRjZm7xi46UDHafrqm
         dGS9ihk+J4e7yv5XdOgoWk9ThFEddGLNtpUqv024/DqBaZ5MiZrnPMrITcRJ1IYNuE
         xKgMPPCJCJ/Yrgm4kY+CTN67oiI4CahRsdrJJe/c56CGYfca30VfhzBfWnq5PlCyDL
         r4R75O1MY2YNg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 856AB60A0E;
        Fri, 26 Feb 2021 22:24:15 +0000 (UTC)
Subject: Re: [GIT PULL] pcmcia updates for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YDiMJTK8eXxxCfSP@light.dominikbrodowski.net>
References: <YDiMJTK8eXxxCfSP@light.dominikbrodowski.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YDiMJTK8eXxxCfSP@light.dominikbrodowski.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next
X-PR-Tracked-Commit-Id: 4ce6b242b78d355ba899f1b16c6bfcd43df155a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 360db2b422f16305e5b8523b4b730521fbc8fb5d
Message-Id: <161437825553.23821.10858122452568698576.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Feb 2021 22:24:15 +0000
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Feb 2021 06:50:29 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/360db2b422f16305e5b8523b4b730521fbc8fb5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
