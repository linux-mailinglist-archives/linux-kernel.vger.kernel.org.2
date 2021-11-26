Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD75C45F517
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 20:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhKZTVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 14:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbhKZTTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 14:19:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB2AC061A1A;
        Fri, 26 Nov 2021 10:41:30 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE18B6233B;
        Fri, 26 Nov 2021 18:35:15 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 727B1600CC;
        Fri, 26 Nov 2021 18:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637951715;
        bh=NwUL72wAmgp9QJYwcWzRjQb6WRhmvj7RlQ/A6hNL7fA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LYGLUaC7P+5x2Rm5+VVl3wO13lQze0HJz67vNed7dK6K47WIrEi+AxSs0Qh0NTGsy
         Kzc2bAl7fTTmOsb83oGFuNqHdgFKARMhtjo62YN26k3cPnVgIZEju1TQQ5yxKsKP7K
         zgA1TS5MTI7C7rs/URfECZna1cuyEhRes5MZz7G62sbaulpCZYWNWqMmBos7J0Il9L
         Ne78i1JFqVNNV9f6lG9tLQV0fo2yG7357h8mgBxSwDJRh09/XahqttaFiDSe+jt0bY
         Ylf58Vyh5+EQs6zHpQvF7w2zKnWeim11HWuxi0l4zc37pgBhaLEkpqizKaRJDh3Wxh
         EKJjk7YeztUtA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6D048609D5;
        Fri, 26 Nov 2021 18:35:15 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YaD577+IUWacSYBm@kroah.com>
References: <YaD577+IUWacSYBm@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YaD577+IUWacSYBm@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16-rc1
X-PR-Tracked-Commit-Id: a88db2ecc2d2c11aa8744be9817d6d249d001cca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba2cacc18cb1c2f1bdaf5a1ccae22d16ca6420a0
Message-Id: <163795171544.22939.15060198008605327852.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Nov 2021 18:35:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Nov 2021 16:14:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba2cacc18cb1c2f1bdaf5a1ccae22d16ca6420a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
