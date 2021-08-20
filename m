Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CAF3F3500
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 22:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbhHTUKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 16:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239539AbhHTUJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 16:09:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 81FAE61164;
        Fri, 20 Aug 2021 20:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629490159;
        bh=UESAVHHByRL8GRF+VuG4vfPxKkx84wJav/Z+xCf8oxM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bevgo92AY/xrcDMvKRXug6GrbQvrVFZhLhE6AXIIqvgfbMoKB8V+306Rwm43ObuRb
         R5GfrBsFIWkCXr2i7VARUKRXfD8O3T+hYzZ9Xw49gCvXqwObCL+8oJaxtkEbpS6LnY
         eY7KCPbdGrh9ZxkSJxlIya7qsI/Pv6V18p3bpnnbTquKlbrhrUfnNJaeNoHFSQjmDK
         V+OjDg2bDHRjDFsNIWGCXtcfaoqbuEh13KceMILF2s13E0Tnsb8sNsxVhZiI4R7Yb2
         wdFIHL5ZTHY1cd8nfTkFCeLVbZxuGpV6PWGbxFol4v0Drui4QR8autfso91qwDwrCr
         TlGJsinPDcaSg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7C3CE60A21;
        Fri, 20 Aug 2021 20:09:19 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.14-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YR9fopoKjkg2o2V1@8bytes.org>
References: <YR9fopoKjkg2o2V1@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YR9fopoKjkg2o2V1@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.14-rc6
X-PR-Tracked-Commit-Id: 8798d36411196da86e70b994725349c16c1119f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7d184d37ecc99f87fc8e531c788f69084f8a95f
Message-Id: <162949015950.21370.1226491799201947929.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Aug 2021 20:09:19 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Aug 2021 09:54:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.14-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7d184d37ecc99f87fc8e531c788f69084f8a95f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
