Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C372A320E33
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 23:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhBUWFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 17:05:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230482AbhBUWDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 17:03:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A351064EEC;
        Sun, 21 Feb 2021 22:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613944923;
        bh=20e5Is5l60kZ7WsbByEcS9yionzbLIGQh7IixMavPhM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TAp6/rBiFGICaV08aP7OR4eguQEmePp6jpeeBF0W0TD61KDL7W82ie8EkuMGr2PFS
         k237YXv45RXHmVs/uknYUTavQHOEwbzVBfowDSh7YCu6sSmwY0rapDJKyM38rSgkmZ
         foy+WWkbYHmnelPJDZfgLctyw7K6nyAuwuYDCrUuH/UOtbpXYX3Vsc6QUteVnKyF8m
         xqN8zg+WhYZgs9n/YAImzFGsMzGY2p716yCnZ7oHPxykRP0giiZR6n/M83QrXQv01I
         R5D0XkBlv1tlhIEtoyc/Oz/DLPFG5gGi2Uw0tnRCQTQiD8aIKtqSsTwVYhRA2PXJb0
         v89k7h9kGvMeQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9EF8060192;
        Sun, 21 Feb 2021 22:02:03 +0000 (UTC)
Subject: Re: [GIT PULL] UML changes for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1264486228.14901.1613937741621.JavaMail.zimbra@nod.at>
References: <1264486228.14901.1613937741621.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1264486228.14901.1613937741621.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linux-5.12-rc1
X-PR-Tracked-Commit-Id: ddad5187fc2a12cb84c9d1ac8ecb816708a2986b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04471d3f18cb9a2155797c810670196c05dd9f78
Message-Id: <161394492364.8676.6439591258872206774.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 22:02:03 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Feb 2021 21:02:21 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linux-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04471d3f18cb9a2155797c810670196c05dd9f78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
