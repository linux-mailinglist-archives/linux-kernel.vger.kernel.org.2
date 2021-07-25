Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D2D3D4F48
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 19:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhGYRJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 13:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231319AbhGYRJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 13:09:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 67DE6604DC;
        Sun, 25 Jul 2021 17:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627235389;
        bh=vO5/VEKNiWkPGhwlSK0+kw5ni8EWXUlbbYix/lxcegw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NoxR9yhEBcbSAeL4i8SepAlZn+Z6Yyq5bfXE+IfeKEg+gPgKLIy7vtsQtp9Gnj7nz
         qLJpM/KZikIib8/Hu16PkPGMh012f7pcjiGi2YJgw1MasqrNZqy6xTBQRkcndGzHmC
         Zm4+U9WVUzg8QRiWwjziP7WClIzeGI6IXVAIByXRceBanhGY/2SoXKkgOYr+SITVzP
         /4AMGw/U/jdyZ5X+su2TYk0i47IQBBy2ar+8a5wetiI/EFgVSDbPiExZQ/v+1JRo3R
         VTTZvmLrM4NnWjXbsiFLPaIew29xCUPSZ+3JysAdYcyFFvu8x59LIUi6UsXOMH2u35
         xbRx4Ku9lX8Kg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5DA0160972;
        Sun, 25 Jul 2021 17:49:49 +0000 (UTC)
Subject: Re: [GIT pull] timers/urgent for v5.14-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162720492432.8837.5867218068133681789.tglx@nanos>
References: <162720492071.8837.4047241618315201209.tglx@nanos> <162720492432.8837.5867218068133681789.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162720492432.8837.5867218068133681789.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-07-25
X-PR-Tracked-Commit-Id: ff5a6a3550cef4a272fee19520a13699343b6a47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12e9bd168c85b1e8a8ef2dd2cb34250f29656c71
Message-Id: <162723538937.30584.5472290099364827363.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Jul 2021 17:49:49 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Jul 2021 09:22:04 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-07-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12e9bd168c85b1e8a8ef2dd2cb34250f29656c71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
