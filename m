Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E2B36B82C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbhDZRjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237042AbhDZRjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:39:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1C23D61178;
        Mon, 26 Apr 2021 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619458702;
        bh=PtlODbPh3PuHnpj+UdajR1dM0oHGNOeDsD5V/w5p7j8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FQty+8fpRbNNandKyonEmXUNEw3hNIP0chi1rVbNDQ63mMOGMqspHts9uS4WFVAJ9
         meW1HIK7IJSzMxwKpRbwMmg78F1ffVqXV45SlIexwglKUtkEA5+PnJWoOCuJKn1LUH
         53Q05ST/uUuwfjV+S7LcWzvB8cITV8UYNwxFljOMliHjn3FJRMjVY+qnBuWT+tGFNp
         Y/6/NfHSo9KFH2gdNvWnc4FRPaYBUvcOuYeJqdhdYa8bzuJnF7SUREJjTTC8ok9+sZ
         gpiRAoSViDbn+CdSGLS7nW3RwFG0EHEjZtkAdIKBPXxioRO2P2p0tdOs1Q+pR1/w4T
         6ZJy6GkXgsafA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 161E7609B0;
        Mon, 26 Apr 2021 17:38:22 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210426142710.GA10892@arm.com>
References: <20210426142710.GA10892@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210426142710.GA10892@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: a27a8816568964fcef62a3ae5f9d2228ec1ebc68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31a24ae89c92d5533c049046a76c6a2d649efb72
Message-Id: <161945870208.23425.13058610930150962201.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 17:38:22 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 15:27:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31a24ae89c92d5533c049046a76c6a2d649efb72

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
