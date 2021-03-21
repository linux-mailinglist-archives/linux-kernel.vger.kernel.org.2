Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4290F343422
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 19:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhCUSqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 14:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhCUSpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 14:45:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 778E36194F;
        Sun, 21 Mar 2021 18:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616352335;
        bh=OEQTga+nGS7SltST+KPbdm/pr7MfqaDhR0z7J9HoLNI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R4K13LR65OPtZS4SEAKprFR4ProAUBsX+Svh/FZR95ygFQmcHTEaGbT14k/K22Tgi
         le25qtlNiMnuC9NOiGNv8Q2W0o4ZI9CNMXbuYoMoUBAfpY5fr09p79Ri7tB/0dUaeH
         ES+KWTNabvVfOlPwCGz9/PpJTlSjH0N8FzlsKbRZbrCI1TGPl/Bqm1NS7ylTO22Z0A
         JUBiPbT6SgZpyRN1Lz1JV7QHOvMUiNSTJSx0BKJB3Z49UQfC8UtesXJCgI4uwmmjav
         MKvgSYPNjkH20+vaqWoruXUs0JY8haZJO1sf6YagabAeGSgqi2lB+oBg3PLd3lpNYW
         bOk+WIHXECIKA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6C63F60A6A;
        Sun, 21 Mar 2021 18:45:35 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.12-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210321110158.GA14211@zn.tnic>
References: <20210321110158.GA14211@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210321110158.GA14211@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.12-rc4
X-PR-Tracked-Commit-Id: dd926880da8dbbe409e709c1d3c1620729a94732
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e3ddf96e75983e4c404467fbb61b92d09333a1f
Message-Id: <161635233543.28302.6471859202104119473.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Mar 2021 18:45:35 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Mar 2021 12:01:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e3ddf96e75983e4c404467fbb61b92d09333a1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
