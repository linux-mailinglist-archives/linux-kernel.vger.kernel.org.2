Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB073FF759
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 00:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347889AbhIBWnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 18:43:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347807AbhIBWno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 18:43:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 03B8A600EF;
        Thu,  2 Sep 2021 22:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630622566;
        bh=Ij2BodQpjK763oOaxFcq+p/ItAbZXDAe6sQbGJri1LI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cy+qDiOnLVAnQs6uzkEReoIZgJ1VK0ibOjnRC/9WuepTwERZYaRf9xCpQShMAfOLr
         R206MgmySfBx7nbFj19MU7nYn+7MBOaawGLfzs+lnZQ4pklLIiWCJunqaiy8D5aBsK
         Dx6dDuqm47no+jdueW3YFbW8jwos1xQqUh3xnYvWLV35tXgb0IveKykHM2sivy7u/i
         Oq4gnu0ac5KkX94vfPQt5+/I6463xpJ+rGrsndrclOQ4WAQXFVWnwhysq+FthN8pdX
         TKREGp9R5yMm9LxrBm3iblJp+76ahIk4TR3JQ0yb0wzL4KyuRFXgJsVIWgPVG9RWlX
         QYW9JhIAYB/Zw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F202260982;
        Thu,  2 Sep 2021 22:42:45 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY08XqC40=vNuRfOU97bXHFo+R69LQvKavPv_N0NoF2PkQ@mail.gmail.com>
References: <CABb+yY08XqC40=vNuRfOU97bXHFo+R69LQvKavPv_N0NoF2PkQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY08XqC40=vNuRfOU97bXHFo+R69LQvKavPv_N0NoF2PkQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.15
X-PR-Tracked-Commit-Id: 85dfdbfc13ea9614a2168ce4a7d2cd089d84cb64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a180eab0b564a9dc149beb0517136ef7129f1260
Message-Id: <163062256598.25965.14704737433211223296.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 22:42:45 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Sep 2021 09:50:55 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a180eab0b564a9dc149beb0517136ef7129f1260

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
