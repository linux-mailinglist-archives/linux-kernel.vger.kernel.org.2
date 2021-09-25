Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3084183C6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 19:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhIYRt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 13:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhIYRt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 13:49:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7F775610A3;
        Sat, 25 Sep 2021 17:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632592072;
        bh=gmo1v8Wy4/DJa4Wgt28p9hms4zB7DsfpGgJh4AR1Ppc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PEkSRNXMFH/VbUyf+31SgJJs/AjEsTOlk4AEyzR1VfQ76ajkqfUu29aMLCC4PzwmS
         0BJn6NS5J7HMn1j9U3DQWfoZy1L3ryjEjQzxbjrd5BwBV5QTNhXfkkRGfkuqXLPuRD
         HMHG8Xw0CXoMTOJOyF7v+b9igTZI7o9INLXAPvCY0+T4xI3QOs+kc0+/13mpnjNRxl
         hKABBntNq8hOsSR+lT49ei45yUFJWCuPJM7S+Q6eHcEjTvU+rwgfjb1dvl52ePMBNI
         U2X38cl66NfGCrbHU5iZ6ZvA9Zo/noH5osgSeWzIr0XjccM/rSeV7zlqrHta7EMHvE
         A89uCdyFCVv+Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 70A6360976;
        Sat, 25 Sep 2021 17:47:52 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YU8uYP1TwVMTvh52@kroah.com>
References: <YU8uYP1TwVMTvh52@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <YU8uYP1TwVMTvh52@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.15-rc3
X-PR-Tracked-Commit-Id: 0292dbd7bd779b878942c3977507459f8a3e4e78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c4e969c38434546322097e41d8bfe7376347460
Message-Id: <163259207240.4008.2958318846992436457.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Sep 2021 17:47:52 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Sep 2021 16:12:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c4e969c38434546322097e41d8bfe7376347460

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
