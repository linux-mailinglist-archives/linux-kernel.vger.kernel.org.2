Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCDE372FC5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 20:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhEDSbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 14:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231926AbhEDSbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 14:31:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 62DA5613DC;
        Tue,  4 May 2021 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620153007;
        bh=4MA8+3281a+DAt6DJlZCUtFOBn/VW5k4P09P8KzXyqQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MGKzhq4wEVOKtQUSiMijZBMVPT/vPHIaMdHl/pUxjxbmDO8GDpQqx9lY+DGFy6xCO
         Bny4nfM4cGpvCNlJTfqhG4ktOJCe8o0ZQV/fmp4DggH0DFqIjaG08c0GtJ9vEQV8DP
         rPJakjLiATNtgeCvN+czEkWCIBKIxvWyTEyb/6nssT5sr9cOrqfSkVte4I2FNrKl6a
         qW8UC9deOmFtzuOjOPEw6/uOtX0pGNes/8DqAfyovGJuZZ0NDraAc4iC7SGd9HEjjd
         1qRt+wmhU19gffnlKfGo6PJ18LIl6/UPA22UBFYRzkUe39QBR8jWKCZcPGYOO95rEs
         vjks04V6BoU6g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5C5E460987;
        Tue,  4 May 2021 18:30:07 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YJD+n2zT+BOA7ar8@infradead.org>
References: <YJD+n2zT+BOA7ar8@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YJD+n2zT+BOA7ar8@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.13
X-PR-Tracked-Commit-Id: a7f3d3d3600c8ed119eb0d2483de0062ce2e3707
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 954b7207059cc4004f2e18f49c335304b1c6d64a
Message-Id: <162015300737.4220.11662487020833432644.pr-tracker-bot@kernel.org>
Date:   Tue, 04 May 2021 18:30:07 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 May 2021 09:58:23 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/954b7207059cc4004f2e18f49c335304b1c6d64a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
