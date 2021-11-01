Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0858441F47
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 18:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhKARb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 13:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhKARbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 13:31:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 969D760EBB;
        Mon,  1 Nov 2021 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635787730;
        bh=+5P76ORn15fkZ7MtqcyxYHX1IanWXRWaJB2mC0o1EjI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r6lS4iYgq+HRkhvx+0Ru94Wn8l0G5GmnDVCabwWtTvBNxfhBpKqGFfa9wlYxIYRWU
         9i+qJfNHVzhsTtFKMunG5PQzEiu240G4VsgWgtILtisqwNao+JEIzbfQfH5aIy4Idy
         cAzhYeYo1O0kfCr44d+UBU6UxMrxKk8Ophx0xKSPQMt+vT+QiLYbvE6NMy+t1q0aO3
         1oXPizovMrGZxuu8+eTeDfUU+DfufeYzKbDLu/bCdu0IvgpnyacGR4jG8qEADfHx2L
         RgxuFWhXczQPjgtNlH3LPv6U5/ODaQWsYlkz/Kl82edAZz7WfzNJPooJJb9TWlg2oH
         rLxebZCHg4l4Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8F05E609B9;
        Mon,  1 Nov 2021 17:28:50 +0000 (UTC)
Subject: Re: [GIT PULL] CDROM updates for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9170ad88-1150-1a34-9979-669054d6d2f9@kernel.dk>
References: <9170ad88-1150-1a34-9979-669054d6d2f9@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9170ad88-1150-1a34-9979-669054d6d2f9@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.16/cdrom-2021-10-29
X-PR-Tracked-Commit-Id: bbc3925cf696422492ebdaba386e61450fa2294c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 737f1cd8a8e80fe3243662f04d4d66829facc71a
Message-Id: <163578773057.18307.6642739354203150781.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 17:28:50 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 Oct 2021 13:42:02 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.16/cdrom-2021-10-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/737f1cd8a8e80fe3243662f04d4d66829facc71a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
