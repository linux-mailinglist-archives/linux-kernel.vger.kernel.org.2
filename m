Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106CC3A5063
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 21:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhFLTjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 15:39:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhFLTjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 15:39:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 90209611CA;
        Sat, 12 Jun 2021 19:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623526662;
        bh=GKYLo/sNdEikOkvVvmowMF/vZaE0zZXqST0IZpz/H1o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M8SO5bRnYk4IaSZ6gDkek8dgsJzyHu7MyzkgZn0Xeoo1mhWT+8x0IE0/By/prth2f
         HUF4LaDWUtbOXaNj1spmAb6Xs6CgjmN22EIEQj3WRpfdxzguuaWg385VXlnU81nO2M
         MsCIgV2ldp5CMpvoUQ3rPM+WvWoIj/EIAj+5coduVHa4cD71NiyTEEQzI9/3I12Ea4
         tNyVO40w9W3YlBtZKfQyaon63eszb5GiH8//F3qwSsy7IUzGx17yyKkboiN9ZAtqGo
         B6dT+DuiJF7Op0JYKB0Bl00jy0YTLPWrAA8BVyCyEfkHxTPblNWqbCV5VlmV7AExap
         rsRAqpJdzU/mQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8A88A60A49;
        Sat, 12 Jun 2021 19:37:42 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YMTY5JKo71X92y/S@kroah.com>
References: <YMTY5JKo71X92y/S@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YMTY5JKo71X92y/S@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.13-rc6
X-PR-Tracked-Commit-Id: 7c4363d3948535e6a9116a325b2fb56eab6b88ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43cb5d49a99b3ecd9fef9826899aac948c3048da
Message-Id: <162352666256.18796.5493327846133677612.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Jun 2021 19:37:42 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Jun 2021 17:55:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.13-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43cb5d49a99b3ecd9fef9826899aac948c3048da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
