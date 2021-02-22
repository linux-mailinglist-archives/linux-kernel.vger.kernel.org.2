Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A9B321EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhBVSPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:15:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232001AbhBVSNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:13:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C77FD64F02;
        Mon, 22 Feb 2021 18:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614017520;
        bh=4xeKzHa5Q/ZD9MENNHHnqyfzFBUSrAjnTwFrj1tjBnU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ANzxqQhPxVk91KTYWNLfvThyB3KbyHcXmLfezDKFHv1KMZIueAlQQSUcVh6HYG3/B
         84tKt34NBv83QC+vzD44oFugIdyWDgl1mlYHJ9h6izKIhP+xibyEjqTaAQNJR60O1I
         3Bp0qqFIkVCzoF7zj8QlKTFIubtUTcNTDCiJqx+0i9D8u82g4eyg5E9hJIcNFkzGlP
         4tZRY7aBFTmC98BMV+Vzesy1AdPImQhEpd+L/faYqZV/+M1SkQbv9yFQqonZ5UWXfW
         4TgA0IEN7eyHo4qMbvcuX6WN0UDt5WNGS/3pjcwyOk63C2v3EixOwmyU+bet1KPdDk
         ipfF4gznJyAtw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C2E2F60963;
        Mon, 22 Feb 2021 18:12:00 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210222173541.GA1677515@robh.at.kernel.org>
References: <20210222173541.GA1677515@robh.at.kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210222173541.GA1677515@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.12
X-PR-Tracked-Commit-Id: cb8be8b4b27f6eea88268d6991175df1a27e557e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a99163e9e708d5d773b7de6da952fcddc341f977
Message-Id: <161401752079.943.713445746324603541.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:12:00 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 11:35:41 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a99163e9e708d5d773b7de6da952fcddc341f977

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
