Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B663F42AC50
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbhJLSru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234164AbhJLSrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:47:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D48C360EE5;
        Tue, 12 Oct 2021 18:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634064345;
        bh=orsRu50ErWxWNwiueOzLYLnYY/S8RlhRFc5OzwRgRyc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HwHqVps/vnX507S7KI23ZGrjcm1pAPb2vylRgw/7u/2bkJXwuNd+PJhsI3zvRKTi5
         bJPk4h93ub1i+GiyXIE6wSX1xoQPGUSJPszY2mQnr4rW66A1UovVlDCB82e3WXiZ0c
         43r+jmj2s78QvgD4LdLMKYfqc31gZHjUyeRrIXC2PDqcvrlhv/EuNX63CPRVDhFpQQ
         0zsIdKl6ZO9DUgfHAzC0H5ZffQT1EpFM98G6DrK4WKz+S9hIy5hbij5u/wVGrbmIu7
         GGGEiA4P3XbfoR0O5PPHeEFVTqeyu/7hTr5DApb5ZqGwWZ4CV7fjCf+L2YU/XFkvxa
         mf1ay81ngsQTQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C0C5660965;
        Tue, 12 Oct 2021 18:45:45 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.15-3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <30dcf211-9359-dd17-dcee-cb688a7bfc71@redhat.com>
References: <30dcf211-9359-dd17-dcee-cb688a7bfc71@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <30dcf211-9359-dd17-dcee-cb688a7bfc71@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.15-3
X-PR-Tracked-Commit-Id: 7df227847ab562c42d318bceccebb0c911c87b04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed47291911d375f7d0bf63b9afb7516988305d94
Message-Id: <163406434573.24253.5411539614749816356.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Oct 2021 18:45:45 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Oct 2021 17:17:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.15-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed47291911d375f7d0bf63b9afb7516988305d94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
