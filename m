Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89E03A489A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhFKS1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhFKS1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:27:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B5B69613C6;
        Fri, 11 Jun 2021 18:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623435938;
        bh=DrtR+q2XaxkTZbWLGHy9oTkkJR1OAmhxqmfWf4jGRxk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QUyHCkC5hlFyzPvZW8lRU+UHxaN0RipVf4CUIJz2+7ypTIM2UIunWXss6Asfp66gf
         0lwaBD64qEEwrb8FP2mswiXOGVeONg5BhyYsNnEWHpjT0Xt9ww04w4faw5K0/hmo4d
         9sPstR0cKB1a5zKCqvV2muparE+h1uFCxtE+jh4JRqrtsBTpkFTolGeF1ZcucDv8Bq
         BnYB3Z0LOZAFZPuLxfkIzlVuWwPAx2vooe50It5o8Fv1G4tz8n/s2Bc97rZF3QD1pO
         1unZjG4T5J2jsucFVQsiHfrp3z5eRZUXftIN/52xu+eOdcCr/aSWMzWj9pa/b4P1ou
         G+Ot9cChEzjKQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A2F1260A0C;
        Fri, 11 Jun 2021 18:25:38 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fix for 5.13, take 3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210611172320.GA1154861@robh.at.kernel.org>
References: <20210611172320.GA1154861@robh.at.kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210611172320.GA1154861@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.13-3
X-PR-Tracked-Commit-Id: 8929ef8d4dfd53a05913e22561784ece5f6419c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 929d931f2b40d7c24587818cf6c1f7a6473c363f
Message-Id: <162343593860.23611.537828192437825863.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Jun 2021 18:25:38 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Jun 2021 11:23:20 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.13-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/929d931f2b40d7c24587818cf6c1f7a6473c363f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
