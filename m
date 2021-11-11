Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480B744DE56
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 00:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhKKXMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 18:12:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234528AbhKKXMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 18:12:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 79A4F61264;
        Thu, 11 Nov 2021 23:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636672159;
        bh=Cqw53G4Xk/UW4Qotg5ASvC0BkLdLhxr2lVJo66vsdBk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RssrOGzqEU1Qu5clGy9s27YXcueWheb6VIjYDb0zUeIkCyhLg+u2bEYM+vD1d5UE9
         cq/2xRXn3kA9afO5FUpKB5K7vPts310zpdA6aQbocCmK4d682tRNCJZKr0DyplIAkv
         zKuKAWaqfZUGEmQDUmBASMAVqH3EsmneYXe6zTMBdctZ4a/hKUW7Sod5v9bfp44fJt
         qRXW+MYSMsW7KUfbyqQ2UeFLi61Z9y18RQvJqMuVNgVOpx3nesGkPNYGal7QtKE9zg
         NNU+q6boMx5cnfvyDNVqOrAOBLx32egV7QJlf+a4Ej8Gwn22+g0HEVT1yRw8KtCsvv
         J0SHRaaX7k62A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 72C98608FE;
        Thu, 11 Nov 2021 23:09:19 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYzinMsJuzruCN+4@kroah.com>
References: <YYzinMsJuzruCN+4@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYzinMsJuzruCN+4@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16-rc1
X-PR-Tracked-Commit-Id: e1959faf085b004e6c3afaaaa743381f00e7c015
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5625207d83f6c42b1e66004002404c3eb9f2a682
Message-Id: <163667215946.13198.16664226383751174509.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Nov 2021 23:09:19 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Nov 2021 10:30:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5625207d83f6c42b1e66004002404c3eb9f2a682

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
