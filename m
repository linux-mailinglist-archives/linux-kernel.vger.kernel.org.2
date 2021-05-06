Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224A737588A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhEFQg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235556AbhEFQgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:36:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 329F761132;
        Thu,  6 May 2021 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620318927;
        bh=8cAOdvUqhQfHXYwCEXdKdzPlgP1mmd/p5EceFdHrfnc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XwzEX+0j3jv7srbwXouFXkhtqllDG6/HUdmriaehQDoz3ISIPMUL7zBZphSpVDx6k
         zay/e/K9xKwNB9AIcbMFLu62H5h/hjPpHEHqsj+iTGauDLjmPY2z98CxU4hx3gWxKs
         NZiXQxyW8SeEWUkwej1COJdJUMsXJBL358z1hWYM02meayD+vgHEJ4zJIuptlKUyxl
         l3uq0nHiWVs7Ty1TwzG4vtL8FRqdM/EKLaDCWKj3lWCAZhSR1pTO+Vqbq29O1YyS8g
         k87y8ne32CGe2ViKxZ2eT6c1Za6HCz9P60Ce8raHqzMFS0MvtNDd6Tz7YzXdXrmhWp
         ho5mOrm28v27Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 28C1C609AC;
        Thu,  6 May 2021 16:35:27 +0000 (UTC)
Subject: Re: [GIT PULL] hexagon changes for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a81e116ba3d64aab8d379703bedcf032@codeaurora.org>
References: <a81e116ba3d64aab8d379703bedcf032@codeaurora.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a81e116ba3d64aab8d379703bedcf032@codeaurora.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/bcain/linux tags/hexagon-5.13-0
X-PR-Tracked-Commit-Id: f1f99adf05f2138ff2646d756d4674e302e8d02d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e5948e57e4381c770931be2c070f3bb894a1a52
Message-Id: <162031892716.29346.17799405488750985218.pr-tracker-bot@kernel.org>
Date:   Thu, 06 May 2021 16:35:27 +0000
To:     bcain@codeaurora.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hexagon <linux-hexagon@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        sidneym@codeaurora.org,
        'clang-built-linux' <clang-built-linux@googlegroups.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 05 May 2021 16:09:59 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/bcain/linux tags/hexagon-5.13-0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e5948e57e4381c770931be2c070f3bb894a1a52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
