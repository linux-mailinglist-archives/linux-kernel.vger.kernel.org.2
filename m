Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020AB30CA87
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbhBBSvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:51:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239009AbhBBStY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:49:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E1BF264E75;
        Tue,  2 Feb 2021 18:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612291721;
        bh=JKWLRTQOQVeeDLO8g4x1KSDglFHPOXkyY9zpP2u2lVY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cjWn92HOtwG8ykfkZmoQxRrR7lVcouLAgK43bkArnXFJ33DzmHmxwzqfyjhcvCP2R
         g7q0ftHd3OiTi8CZwBP+8dk6XyrYMwg0vGeuoH0pM7zmcPnTVcj3wdcliC9NYwvAkC
         9MaSfl9vBFwMgPajCtF0fHZBQdPyNhNc7TMUD9za1ufVfe7ODRyOPaspBVafx9or6n
         HxF/px6oBQrFV2mFWBDVnonPk44oTyU98EyqFlUFcqnL4Bp9TdReWravGb0g14LOsq
         f9eNW+2BgPXfTC46LivlgqjW+wrhb7sDgSjjhoQ5NpyYLuVU3qqsdfGsVV5ja8WC++
         Fj0iWjZd9NBHQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DC22D60987;
        Tue,  2 Feb 2021 18:48:41 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for 5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YBkahgjZ1hnpplH1@infradead.org>
References: <YBkahgjZ1hnpplH1@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YBkahgjZ1hnpplH1@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.11-1
X-PR-Tracked-Commit-Id: d17405d52bacd14fe7fdbb10c0434934ea496914
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d36ccd4bd07825775b512f654566d3e89e9cfd0
Message-Id: <161229172189.14515.6960556676521063526.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Feb 2021 18:48:41 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Feb 2021 10:25:26 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d36ccd4bd07825775b512f654566d3e89e9cfd0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
