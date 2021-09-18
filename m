Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48737410873
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 21:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239274AbhIRTyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 15:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235773AbhIRTyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 15:54:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C914F61051;
        Sat, 18 Sep 2021 19:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631994760;
        bh=sJWh4sELQQDFCDIDh31hUZkUf0NMiCnlV+7TDM/72A4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uKyGzIs8XxKqjyRVeXmBsAQ/UDkk4OUQvGUcqbzabuL+gX+6ljrZ0JhlPQggZQ0Y1
         zXscwxaNlOpJyWY4XS/ZwVbn5uT+ebBMpB7VPk/njYrFZxywvzqYBfs//ocVHmbXtF
         sj0fr14Z/NLyqcxMYtjbXxv78tf/WWuFsdpw005AfKoP28PAbvW3S3auPhGkvjvAbX
         iZQaW/FjJj7vKfzt7kpkD++MqxMKwBMeaBZ/en3JjuFqgOAZgi21QftWL/ph6eHo6u
         l3l/tealWZp9iwAdRsZwqmcEKlp2kR5+3kxODMjjfjKWLJkQ3e4F1Eo2RHsljPzgTY
         8H+k6I/Ojk38A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B653360A00;
        Sat, 18 Sep 2021 19:52:40 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v5.15, take 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YUUS0/i5AqSmmbGA@robh.at.kernel.org>
References: <YUUS0/i5AqSmmbGA@robh.at.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YUUS0/i5AqSmmbGA@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.15-2
X-PR-Tracked-Commit-Id: 55c21d57eafb7b379bb7b3e93baf9ca2695895b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1a88690cea3872f83a1004b1a08a39879715fa1
Message-Id: <163199476068.362.15094810576369939155.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Sep 2021 19:52:40 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Sep 2021 17:12:35 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.15-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1a88690cea3872f83a1004b1a08a39879715fa1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
