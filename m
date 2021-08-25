Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998983F7C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 20:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbhHYS1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 14:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232629AbhHYS1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 14:27:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9984C60F25;
        Wed, 25 Aug 2021 18:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629916008;
        bh=ANN4V46l8dFFWFt9CeOgzLC/5h2/fEOhm3bswfUBk9w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fzAYkhYt5szdEUtynJ8+pot2oJSp7nJm+heqjcc3sO7PyjCm7ZhceEUX/8P4NoT61
         YQx2kZR8nbYcOOnd61Z9kuigLRez1nMVKlxBQX9ocuHz46fUi0o4NEkIsjzPgdfNJA
         spmgUkU05V1ZwRYDtKy+q0hBW5jrx6VJ5q1D15UgdNX8jS7btaeckzDrljuaZ7A5ND
         PtcRqxFHM/Wc63uLd+L5km0Q604+//Z8So4ZkI8oMe+hUsdNC1qyMNqZ+xDIjmGQc3
         1vYflD4Jvqmk9RA/CNxTAO9arG5cfXc605Y6O5hRGBhzXpIaeQor9R6Dl75Qq3apcp
         RrthQyIuCskHA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 86328609DB;
        Wed, 25 Aug 2021 18:26:48 +0000 (UTC)
Subject: Re: [GIT PULL] ucount fixes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <871r6ho9r7.fsf@disp2133>
References: <871r6ho9r7.fsf@disp2133>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <871r6ho9r7.fsf@disp2133>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-v5.14
X-PR-Tracked-Commit-Id: bbb6d0f3e1feb43d663af089c7dedb23be6a04fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62add98208f37ce02c0425f3858757472e3fcc2e
Message-Id: <162991600849.19589.11549849809443099281.pr-tracker-bot@kernel.org>
Date:   Wed, 25 Aug 2021 18:26:48 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>,
        "Ma, XinjianX" <xinjianx.ma@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 25 Aug 2021 09:54:20 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62add98208f37ce02c0425f3858757472e3fcc2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
