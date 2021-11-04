Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6921E445806
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhKDRMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231892AbhKDRMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:12:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 220E8610D0;
        Thu,  4 Nov 2021 17:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636045809;
        bh=egqtheCrOc4Nhq+t1XkMmUjX+oN8kuZb9A54/IlRvAE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cek96AeozwVM25ibU4jAyvxtmck3vPwyHbkoW5C9RwwWmADYwZlOnUV30RF654R55
         BhJDWIedZl3i2VMlQ6Yb0XAwJuAGwdOQTnY1OW8YKLz/W8RxxOUBV0Q1htQsao4WFL
         WUjP4s+16XNuvhvp8RV+4Nimrn08Jka01TOYObZutW5St6lpfjPROcBv1OXggrCgsZ
         qkesKAYkuNlIW4xu/qAx/dHtMf9K8Y9iDpltyRdcjOfkEf50gDXRiA4Q+HKibuB2Oy
         HTDDSQ92Ofc5ENI7MXFj0dpW5OCNcVTFZeo2P0FS0DN1L0zik2MzYu8GDAyIfKsTnr
         ySG5Oy9fVon5Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1B2DF609B8;
        Thu,  4 Nov 2021 17:10:09 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver changes for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYPa1fcok+OPjFI/@kroah.com>
References: <YYPa1fcok+OPjFI/@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYPa1fcok+OPjFI/@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.16-rc1
X-PR-Tracked-Commit-Id: 536de747bc48262225889a533db6650731ab25d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c904c66ed4e86c31ac7c033b64274cebed04e0e
Message-Id: <163604580910.24234.12945886770444072380.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Nov 2021 17:10:09 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Nov 2021 14:06:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c904c66ed4e86c31ac7c033b64274cebed04e0e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
