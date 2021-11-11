Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0707A44DE58
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 00:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhKKXMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 18:12:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234535AbhKKXMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 18:12:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id CC36D619F7;
        Thu, 11 Nov 2021 23:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636672159;
        bh=JIp06xRnTTpCgdfPWhT6sltgOA1KfMmKSUGJRKN3mU0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ne2JH+HT2YQWCCg71Fu7ZeuxEzAZCELx2cQ/iokehF4VqLrsm3n3PjimlUNmfKtTs
         ynTZa3V8EMQ2oofp2vHZsnopdHYUviZIxVI9gR8kWWXe7FeHjGDFmDi7KMfx8la7JX
         gC89bJt16mxO4tk+GeWMlOddhF7VMLhjYzsm75Pzvc03VcV0DzTo0rnD3i7fW5G93C
         s0oMc+NaO9wTva8jPtizSzF+rZd9gcA9AkXmmBADn6wx85SULnIDojCnLKRioi7Ulf
         ZsH/0+dF6TCFEQW0lUl5YkaGOho0EtVkcjGdcVnGImc4dTby1dEeUax/QnWl1HiYs6
         0bFCs8R9BIW5w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C6A0A60726;
        Thu, 11 Nov 2021 23:09:19 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fix for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYzjLtQQPqaJcShN@kroah.com>
References: <YYzjLtQQPqaJcShN@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYzjLtQQPqaJcShN@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.16-rc1
X-PR-Tracked-Commit-Id: a4119be4370eea352df0dad294488e60e67321cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c55a04176cba5a2de085461438b65e1c46541ef3
Message-Id: <163667215980.13198.18416694437266822503.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Nov 2021 23:09:19 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Nov 2021 10:32:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c55a04176cba5a2de085461438b65e1c46541ef3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
