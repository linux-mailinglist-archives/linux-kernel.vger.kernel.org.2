Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7968B44B33A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 20:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhKITe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 14:34:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230245AbhKITe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 14:34:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D7DAF61350;
        Tue,  9 Nov 2021 19:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636486300;
        bh=/Bxb1ItdVeACpN0IK1g8DCwertzUoQKfvRatD6rG9+Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZXSRZHN3JVN4mfDsv5fWJnIUKnLk+tvslctv8wB1gPO0QlUx+YR6hOSNdzIWwNrLC
         0mHK5o+vocUqNRmtv1AQDncbmefHvaSJlv52kRpnpYeQEPFdYnNJioFBEgWW1VcAxd
         fTyg6P+prqDUm3KZ0quVGGrsaPywGK8GZW4VYnifzazlcOaKURhT9BupQgblMPT03r
         jekXMSHqwNpcqdsjiKlgapFXnjGUAXg4KSjQEZB2JphLxIzIdbsW+BTzWfxDj53NK4
         acpEqHSEsAXRGYJnbKrWcUFVYRQk6ejbVbJuCClHMro1WtOdKyzI0Scp5fhNzjHJ6M
         v2ccR6iZtHo2Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D1CE660A3C;
        Tue,  9 Nov 2021 19:31:40 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYp9TAVLFsxqfVx7@infradead.org>
References: <YYp9TAVLFsxqfVx7@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YYp9TAVLFsxqfVx7@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.16
X-PR-Tracked-Commit-Id: 9fbd8dc19aa57ec8fe92606043199919527cd9be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 372594985c786b40108a5201ca3192223d6c0c40
Message-Id: <163648630085.13393.4121089110456251047.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Nov 2021 19:31:40 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Nov 2021 14:53:16 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/372594985c786b40108a5201ca3192223d6c0c40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
