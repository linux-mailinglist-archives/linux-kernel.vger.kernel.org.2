Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD67A32F787
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 02:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhCFBgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 20:36:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:46230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhCFBfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 20:35:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3ED8864FEA;
        Sat,  6 Mar 2021 01:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614994547;
        bh=02lREtERCNkftMYeaaKe8pb4ZBZj6QSJvLjZq02GKHg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JJe4S+TB3z57wQoeIFfccWqGR+tzy3sRY3FEoMDJUXDbXwKKt+xkqDbP9jWJ6FMKu
         uVwRZvutQCAl7AjkC+mwF3LzJzHKdGKWyqOsyvROcW80QbJCAp5MOnF12xWrNIvigl
         Kmspa8ndHYdb3Uol39mjbXnvWlf6Cgn1hMM1IE609fjkgh4Nk3liplT9ZF9jWdUWu1
         sY56JJGk9+xyAzCfb6PsoIgw9iwqQo07ff8IBs3YIJ8CE+CovRyV2Hf9ikc8omR9TQ
         BRZ+aAapCmnY95FmJPQnWRRzFKYRzARhBkvN7B2NFoim76qqN5rpqVf/xPm/m2BXrU
         CvCnk0RzYnnfg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 348A760A13;
        Sat,  6 Mar 2021 01:35:47 +0000 (UTC)
Subject: Re: [GIT PULL] gcc-plugins fixes for v5.12-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202103051512.624654ABB8@keescook>
References: <202103051512.624654ABB8@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202103051512.624654ABB8@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.12-rc2
X-PR-Tracked-Commit-Id: 5477edcacaacb8af8169450180a1d3bd0dfb9c99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de5bd6c54b200aee3157d3eb1ff2808c18b43c09
Message-Id: <161499454720.11799.5396301124235987198.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Mar 2021 01:35:47 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Kees Cook <keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Mar 2021 15:14:44 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de5bd6c54b200aee3157d3eb1ff2808c18b43c09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
