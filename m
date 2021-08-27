Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FE03F921D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 03:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242721AbhH0Bsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 21:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240945AbhH0Bsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 21:48:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 83D6860F6C;
        Fri, 27 Aug 2021 01:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630028874;
        bh=WhbmAcvh3+HeycYOhenzKGRz6ZKmnti0uAbIkx2a3JY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Nle+hiYF368kaIul99eU3XGqP2AoGHg2k3D6HVBFh4XHbCTYrlEDlXhgRhXl8BC9W
         JHrMqAKeItFbG1fGJakjghAgqPM2jiObPUmhVmtx+LYW/Iu8ojlrt+GpG37oj0N9wW
         ZjIXAkF8orzPU41sE40rd5MEghSV0/uzz4jX/xhVYPyJVNXwdG+ZLbWxmvMCrio0NM
         6JYDLTBlcd6gn8AzhKK2+vvhLZGvy8qAsgQAHRW/Ic6W3U14ZqrYMg0iZKZMxMtcUO
         5EWA8oXytggo5uUptFAxrG13RAwlA9LYftfNzzZqm1UayjRp6RGqx40OeG/A7fEO97
         3o2OpjyXjqCwA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 70E9260972;
        Fri, 27 Aug 2021 01:47:54 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.14-rc8/final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tysyOYAeKLF0o2FU-9dmjzosykd61Of7hzbYjBZ4homyQ@mail.gmail.com>
References: <CAPM=9tysyOYAeKLF0o2FU-9dmjzosykd61Of7hzbYjBZ4homyQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tysyOYAeKLF0o2FU-9dmjzosykd61Of7hzbYjBZ4homyQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-08-27
X-PR-Tracked-Commit-Id: 9fe4f5a24fdac99c484daf29eded9c6685fa2020
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77dd11439b86e3f7990e4c0c9e0b67dca82750ba
Message-Id: <163002887440.11585.2343757918839479257.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Aug 2021 01:47:54 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Aug 2021 11:33:10 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-08-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77dd11439b86e3f7990e4c0c9e0b67dca82750ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
