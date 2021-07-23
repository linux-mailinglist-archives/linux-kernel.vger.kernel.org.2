Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C4A3D3E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 19:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhGWQnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230126AbhGWQnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:43:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AC35860E8F;
        Fri, 23 Jul 2021 17:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627061014;
        bh=AypiiTmw1uh7hr2hG4yvPeGano+1htfUfDNwQBuxj0o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pPHyzbzS0Cb3dqfYMCpl2TqSWGEFOHmPAuk8PpZb2tdMMxvY9kuGAtkTYU+A/PrzZ
         13L3w3b0fYft7iaXBTT64EsnWgQ8mtx+gbmYKlFtM0FC4EPVkQ5pcoQdPYNw0z/AHC
         ByDRtYzj+vkEDj+FTIGLBB4QLdRJt8hlY/s5F/S1w4eoTPsGYUHKClugScgxLPRLyc
         CqMgNSYg9iewp0uZHW4F1jY4AGrKJrlNAJ3uauF/dqa5TQ7Lx7Axo/QpyUIW8owWCm
         Z4JIHKIyVsQg+u11oeVu8BHi6CluePbTPMTZXZQEXZ3ztOVPhmrqb+XFv4wJz9I3TR
         f7kWRxRiJeq3w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A183E60721;
        Fri, 23 Jul 2021 17:23:34 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 5.14-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YPrX98Lqa1xH8uH7@kroah.com>
References: <YPrX98Lqa1xH8uH7@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YPrX98Lqa1xH8uH7@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.14-rc3
X-PR-Tracked-Commit-Id: 1d1b97d5e7636d72890a5bdd0b40e980e54b2d34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74738c556db6c7f780a8b98340937e55b72c896a
Message-Id: <162706101465.5428.9921481195595622083.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jul 2021 17:23:34 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Jul 2021 16:53:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.14-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74738c556db6c7f780a8b98340937e55b72c896a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
