Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8558C3B8AD4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 01:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhF3XQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 19:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232788AbhF3XQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 19:16:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6D00B613A9;
        Wed, 30 Jun 2021 23:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625094860;
        bh=l6g/POHpndAcH7V0vKojli5qWJw2M3glZGXZDJp2gXg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UOdnWFFVJoo2GLkqN11TubP6efqVb4yHuIS3sEH0P5O5/n9Y5OhFhEkJwGizunhbd
         5ljccZ9OB4aGa4ehGkNioUUDwK5+aP9P/sa+RQ/clqFhiCzCsYbpjxFgNIoGdZequ3
         cOCz09T8H+N8ogWU97CPNdogu1zl2F5vpAcN+WC8f7KI8+8wB5gBSBfWYMF+3h+1hX
         8zFbX9qHhcQZSoCbc6VNj2isAEZduqBOeX2Tz/KquhAtt4zZ7dZEaUlR64dQEV0aWV
         6Pb7rzAfJVInChHrhb+KQBN8CXOphUp6RtfnTkEKFb9OuGW4rNeFbrQDy0Iz8OosPt
         6ptStLuZp93Wg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 63267609B2;
        Wed, 30 Jun 2021 23:14:20 +0000 (UTC)
Subject: Re: [GIT PULL] arch/microblaze patches for 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e566b945-2fd0-bff0-b291-e7538bafc3fc@monstr.eu>
References: <e566b945-2fd0-bff0-b291-e7538bafc3fc@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e566b945-2fd0-bff0-b291-e7538bafc3fc@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.14
X-PR-Tracked-Commit-Id: 14a832498c23cf480243222189066a8006182b9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4cc74c9382d8b02181cfdc6d29ee5bc7a1f7d02
Message-Id: <162509486039.23001.17712682774020279940.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 23:14:20 +0000
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 16:29:56 +0200:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4cc74c9382d8b02181cfdc6d29ee5bc7a1f7d02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
