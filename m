Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B16F3223E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 02:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhBWBxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 20:53:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:41140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231247AbhBWBxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 20:53:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2F1146148E;
        Tue, 23 Feb 2021 01:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614045192;
        bh=pRmEpLjajmmHuaju5BIP93Di3WDshUvnOMolUZnC7/A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hv2DxIyPPLEg0P+U3j5vzxdG+4cLdgo/+35RZqASuCGDbajoD5ttb7TiK89lYioiv
         ty8qP1t9458iD1h6TO7Gs/+4m7oKgpnGwv90KX2nAQTuvZ0pDVYd0IIZM76B8C6Rya
         qyeTjzsdNYBNu1BlsaFup8I7tJvU8FphlC2deOlZorlvc6kJ2jkGCdNkouM1iSFHLV
         N6tgTZqTvpNMv3sISOl7X3SjvyEKc+MXvvcJv/JZiVACsXdYqhBVIdSJ7eEweTbH4f
         ANJdOU2605oxES+ykOAu4XzFRwfPBKmpefx9eS8Rei1BoA1sV8KLkCO7f4uRVY/SrU
         6Qd3pMgnoD6Ag==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1A1DE609D1;
        Tue, 23 Feb 2021 01:53:12 +0000 (UTC)
Subject: Re: [PULL] topic/kcmp-kconfig
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YDNrq+mpwta0f0vt@phenom.ffwll.local>
References: <YDNrq+mpwta0f0vt@phenom.ffwll.local>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <YDNrq+mpwta0f0vt@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/topic/kcmp-kconfig-2021-02-22
X-PR-Tracked-Commit-Id: bfe3911a91047557eb0e620f95a370aee6a248c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b5f9254e4f4375ac845cb17f1732037dd8adeeb
Message-Id: <161404519204.2827.13463630697238081806.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 01:53:12 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, Kees Cook <keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 10:37:27 +0100:

> git://anongit.freedesktop.org/drm/drm tags/topic/kcmp-kconfig-2021-02-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b5f9254e4f4375ac845cb17f1732037dd8adeeb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
