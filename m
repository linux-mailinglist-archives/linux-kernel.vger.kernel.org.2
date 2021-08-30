Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545743FBF10
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbhH3Wkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 18:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238773AbhH3WkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 18:40:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2965E61039;
        Mon, 30 Aug 2021 22:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630363169;
        bh=6nkb8DVdsRAGDjk0QmbH+QfEK0dru7CeXHGKReRLXJ4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DYHntDaKVedmlsfEED9tmA5wmjzHmKAfjhUz+9jh1NHLSAV9YmNpj/rq0G0cZfDKp
         6XWnr+UsFW3uXuKSTCDHwjjxnVyysQTYgQCnNN4CwngvfQZ+a5/jhWH1Lqei99xAYB
         Ql5ffxhv2BaidcpEVrViuPofrJug8wbyec3T4xG2rvtITGAFeiU8KEDeKIVhSCwfPA
         ssI0OEnYZh7ddNaFCnfKTOw1QIZunDxNJcYoT4szn94AMlTXnemMlK7t2erWppLeDe
         OBw7fsSCAIBeXVtZ7Giv7nZrq1aN3EYyzp5KqJOjY2Dvd46vLvjl7onnu90u/O1ww+
         neXmDbtTiS3PQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 233ED60A5A;
        Mon, 30 Aug 2021 22:39:29 +0000 (UTC)
Subject: Re: [GIT pull] x86/irq for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163031993864.58256.5249475492261910047.tglx@xen13.tec.linutronix.de>
References: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de> <163031993864.58256.5249475492261910047.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163031993864.58256.5249475492261910047.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-2021-08-30
X-PR-Tracked-Commit-Id: 34739a2809e1e5d54d41d93cfc6b074e8d781ee2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccd8ec4a3f9a5d3d97766231b04e7321dcc2df1e
Message-Id: <163036316913.23007.12541244416498670928.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 22:39:29 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 12:44:49 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-2021-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccd8ec4a3f9a5d3d97766231b04e7321dcc2df1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
