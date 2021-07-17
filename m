Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4403CC065
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 02:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhGQA5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 20:57:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhGQA5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 20:57:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 36DDC60FEB;
        Sat, 17 Jul 2021 00:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626483261;
        bh=rT7z4qXQI95MMxDm/jVUIqDDtqgPW/hOs8uQllILBD8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e74nPs1pn7gPvTYcptCjOA655b/devnvMBc/PNc0bWsdUooX9qpJGI4Hud1+WEVJ9
         wUyyadoZZoRd6ZrXwvocdZhKAvx/OqLylRXrKEiNGYpRIeLrlSUy7go9mbB+YOQsjq
         VpgqUzxkFpHcfxjU+OQQPrBl6zBC19zlw5Rqkf0yxuAcGcj4ezUAc70H29sQgZY+T8
         BB17PWa28u/Lh5AbvdBVe2fhlsKnzEq2PhWNMLpXRD7fLr78nRT6gnHZAqfV7WGxvt
         9eLKw57lg/eO0HDRD6n1eIEkcvYIJHGL7q2vYAHNqn+kUKdvoFsmLcM7lgjY6x6IJf
         kIrQQpSthVXww==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 23B36609A3;
        Sat, 17 Jul 2021 00:54:21 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fixes for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87fsweds6l.fsf@meer.lwn.net>
References: <87fsweds6l.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87fsweds6l.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.14-2
X-PR-Tracked-Commit-Id: 530c4374e21ae750c5fa5aa67b36a97635ddb379
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 872f8edeb6bdadc9fd8c832f1a295610ad664a07
Message-Id: <162648326108.29849.10236660856203016217.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Jul 2021 00:54:21 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Jul 2021 12:33:54 -0600:

> git://git.lwn.net/linux.git tags/docs-5.14-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/872f8edeb6bdadc9fd8c832f1a295610ad664a07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
