Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C7432440A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbhBXSsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:48:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234761AbhBXSrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:47:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8701064F0F;
        Wed, 24 Feb 2021 18:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614192394;
        bh=tFeyr5rkGKHjhfGoWYcCEuWrrPaOmpfGpUdPujLiX0g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cIY94Hjv1SBv0MPrfpJOqdnnoFKrAWVYQ/T448oJtRgdjffCOBTuZsad2y/+SBSXL
         cr4AUZlrJ0AxmRnYQbYtT/QlcUAH55C8hM2zB28tQq7uxpCyKoXMEVqccqSA/guyx2
         TFuOm4UJrjBiPYn0BpN9+HbElTI+0syE0bX3Ye0gur0VQPRIbbc3JIk1OZiejy832S
         Ca25xWygjK+mAaVS2uHGQDfAtLv533fx9NXTu5U3b9ZAerUo2Z09HNqf7I9xaOMnND
         z6obTvSSB2Xmkhar1HMK0GhJPqnKEgCY+m6XtNwWEDV7/FSYzaI8uGsz63iKiH5sZB
         QMvPgzkpB6gfQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 82DB160176;
        Wed, 24 Feb 2021 18:46:34 +0000 (UTC)
Subject: Re: [GIT PULL] libnvdimm + device-dax for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4i1-mwp8B0Y_hR44rGh9qUPuDiZeiUFJ_TJzvPoENa-pQ@mail.gmail.com>
References: <CAPcyv4i1-mwp8B0Y_hR44rGh9qUPuDiZeiUFJ_TJzvPoENa-pQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4i1-mwp8B0Y_hR44rGh9qUPuDiZeiUFJ_TJzvPoENa-pQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.12
X-PR-Tracked-Commit-Id: 64ffe84320745ea836555ad207ebfb0e896b6167
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb9f08548873b4ffa9f1b3f96c37fd85b9a2f8db
Message-Id: <161419239453.20610.6936263777642654365.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Feb 2021 18:46:34 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 Feb 2021 18:47:38 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb9f08548873b4ffa9f1b3f96c37fd85b9a2f8db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
