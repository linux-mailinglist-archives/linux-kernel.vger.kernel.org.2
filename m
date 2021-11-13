Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F9C44F570
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 22:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbhKMVWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 16:22:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:53018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236073AbhKMVW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 16:22:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id AF46560D07;
        Sat, 13 Nov 2021 21:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636838374;
        bh=AdAFjr2E1kgk10DpWSrMO9FTB/U9IdpE79E0Onj7Txk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jcPmXPbeIAHOQnIfWOXnt14kFSGqfmUMzM/6iL29/Kcutjx3hb5h/IrI0HiLIef15
         +mZFks48WM8q7Zt6Iru9OBlfNQL80Fy3I7Buj1qjuUume4m1k08C5J3Kepvri/Oywc
         UK1vi7wbI8hQNcPSffd4rBu3cI76fyQuUUEp2xBdAsWZPTw0ZNi1dqrJKgZbX9wdCj
         TfubwdP72uZMhjw0fHsZD0IsxqrersYQPnDB15zR4+Uh8UguXNwYKB5jwHaqb76Zk1
         uwbUhog4ak13fkUKMZem5AvtggUQroTcXTub58c3no4dm1HZxHmVpMXGNCiPLibwjn
         Rtb/u8Y7U5CEQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A857A608FE;
        Sat, 13 Nov 2021 21:19:34 +0000 (UTC)
Subject: Re: [GIT PULL] virtio-mem changes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211110163754.27528-1-david@redhat.com>
References: <20211110163754.27528-1-david@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211110163754.27528-1-david@redhat.com>
X-PR-Tracked-Remote: https://github.com/davidhildenbrand/linux.git tags/virtio-mem-for-5.16
X-PR-Tracked-Commit-Id: 61082ad6a6e1f999eef7e7e90046486c87933b1e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccfff0a2bd2a30de130b5623d242ddecd0272bc2
Message-Id: <163683837468.5975.7292928272412230367.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Nov 2021 21:19:34 +0000
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        virtualization@lists.linux-foundation.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Nov 2021 17:37:54 +0100:

> https://github.com/davidhildenbrand/linux.git tags/virtio-mem-for-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccfff0a2bd2a30de130b5623d242ddecd0272bc2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
