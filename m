Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD87E4565F1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 23:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhKRW7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 17:59:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232760AbhKRW7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:59:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4031D61526;
        Thu, 18 Nov 2021 22:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637276178;
        bh=i2HUUY1fwI5VVSu8KruFj5Pz6smY2kjOlpolDga4t0Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CseAM44kaZh3Jt/31YUxOwZjr42g4ogRPOUqFMoRK2gNRfQxABKEzuIaQHFOmiZqq
         TeKLyVRgEqPgOgD7rMqftiFjdtyZkpaavOJPED1r6YY+SicJR38UtUvebrV3paLAg7
         EbYKTZaGsY6tylm6ySDXCJuZPdMa8JRZLtPXEv/q5WABxide9V7+G5vNWXKjLcvPt/
         9Fo4nJ6aEqObSPuApPa55WsrGu5LcwyFpHw92VH/uAcuqZMAvyReZFoxOBcIKKYbXP
         f/hC9+D/3rmlfkDtoimu+ndpep+r4CCzcJdhvTKgIgrEUeN8WS67xUT2yP7gUFpnv8
         lqdsrJczdgnGg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3A759609CD;
        Thu, 18 Nov 2021 22:56:18 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.16-2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f5ff716f-ba1d-31b1-bad3-e1aadea02931@redhat.com>
References: <f5ff716f-ba1d-31b1-bad3-e1aadea02931@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <f5ff716f-ba1d-31b1-bad3-e1aadea02931@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.16-2
X-PR-Tracked-Commit-Id: d477a907cba317cfa58a8c89c09454d3fced1964
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1c2b55d84a609c9ede39138d055adcd26fc165f
Message-Id: <163727617823.9679.11004501176491381787.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Nov 2021 22:56:18 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Nov 2021 10:49:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.16-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1c2b55d84a609c9ede39138d055adcd26fc165f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
