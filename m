Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E68B363147
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 19:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbhDQRCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 13:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236568AbhDQRCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 13:02:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 083AF610C7;
        Sat, 17 Apr 2021 17:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618678925;
        bh=5OLfU/Eg46A4P3CBcJoqaOXMQvnzXGCgOe26Z5lYtws=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Lx6I9k8wC/rFu4cAfPGkDcg4m0i89GDk70U7maTnFlVhyKmaXY1fPaIO34+8fGX/i
         Bmea8OLoIDCJ/3PQRjLXcbZTphSD/W9YgP4QoANYsBdYflLAXuMXllUZaUgUFAtvAq
         QIQOijHO4slrOkOUh5Zn5IfDsYVZpkGRuAS0dLE4x6tnsl3ch5RI5AQFjEBy8umvc0
         3N0ExhXYGPD9PY6TzSiBd242fPxxcVBZ5YkxrajG+wAWFgc0COGlDggT+DiWIO9Gnm
         0opHRRAtNmlGgPYsrnnUzpU13VCZPWnCrjt6F6NL6xzUxnaALH81jynIiTUjp//p0Z
         RmrBGBTsyJf/g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E851360986;
        Sat, 17 Apr 2021 17:02:04 +0000 (UTC)
Subject: Re: [GIT PULL] cxl fixes for v5.12-rc8 / final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4imrTM21eU+3ippyLcmHAo5V8_MtmyL49Z01-L1pg6HQQ@mail.gmail.com>
References: <CAPcyv4imrTM21eU+3ippyLcmHAo5V8_MtmyL49Z01-L1pg6HQQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4imrTM21eU+3ippyLcmHAo5V8_MtmyL49Z01-L1pg6HQQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-for-5.12-rc8
X-PR-Tracked-Commit-Id: fae8817ae804a682c6823ad1672438f39fc46c28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c22677407243d63df3aee1bb2f6d9aa12c01a24
Message-Id: <161867892489.3103.7111455499538323212.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Apr 2021 17:02:04 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Apr 2021 20:10:09 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-for-5.12-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c22677407243d63df3aee1bb2f6d9aa12c01a24

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
