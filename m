Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E00345F524
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 20:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbhKZTY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 14:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbhKZTW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 14:22:57 -0500
X-Greylist: delayed 379 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Nov 2021 10:41:41 PST
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E04C08EB1E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 10:41:41 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1ED79B82865
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 18:35:17 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 9A4F06024A;
        Fri, 26 Nov 2021 18:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637951715;
        bh=MRHkwg5wdPehjmIE0/twNralXsSblTJ+VD1q/7aWW8M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g+s+5LhjhaeSQap6+PziGN2Olb3uGxx7MF+N8cQak5jZcCS2WvistYlavu6UMWRFA
         DHRzTPiAbw7wDoF53Lipg5bQ0z1pioKLnErHZDUu4TXJJ90OSvic52MkUVPdVLlYAV
         qIdsPMmDiRn3H0fAnv2w0XT33HltziwsZDoG10Mw43c4klgK61FSSHabIEwZWY9Q1I
         0bwXrPDxYKSzXD3MO2RS8KH62/89ojqVr5HLKCxn2SCvvuuaPLeHo4OhBWFPFUNFJf
         sCHeEuzVLDXq1repJynCBsJj93OeulaUYqdYEsntKqyxx3tATb6f0wpjELyy48AwKw
         zX0prIG2VrhxQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 943D6609D5;
        Fri, 26 Nov 2021 18:35:15 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fix for 5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YaD6J4/erxgzssrB@kroah.com>
References: <YaD6J4/erxgzssrB@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YaD6J4/erxgzssrB@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.16-rc3
X-PR-Tracked-Commit-Id: c21a80ca0684ec2910344d72556c816cb8940c01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bff7d7e8c487b9b0ceab70b43b781f1d45f55eb
Message-Id: <163795171560.22939.8151541832685789274.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Nov 2021 18:35:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Nov 2021 16:15:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.16-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bff7d7e8c487b9b0ceab70b43b781f1d45f55eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
