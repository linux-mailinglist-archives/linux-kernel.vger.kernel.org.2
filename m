Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0486C314C0A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhBIJqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:46:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:55498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230344AbhBIJoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:44:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4048E64E75;
        Tue,  9 Feb 2021 09:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612863819;
        bh=oh3MNBFvWoTgc9uprY3RLY+GycR1AMzvmGgWCOk5SnM=;
        h=Date:From:To:Cc:Subject:From;
        b=BxfOGLMHbxSWyflbIMeLkaLUVOJAoPwwHNw37IHrkO5YHuE7usCkQpab2rqwtTQ4w
         pCOKRThPORNLArnlaez96/BUmqs5GFWivHoVaxDF75BjJsjZntN1J7+wTQSIiaW7j7
         UDxquSvpIUgt5bYpils7pi0RCHuTJZlzp2qmIRnaYvDKDeYfHLxZyv+TEsB0dnuoDC
         WNlgh1dLpGtTjq/gQsnDTieZveDEaxeqslvMtLOxTKyN/CYQoibcFb8NzSNKRo8jVH
         Cgmhq2nsnxrqo9+XgX67OkKl6iCJ9x0LKwxtbhxE/tnN9s7kKK2LXqe5ih1e5KpA9Y
         EvK9xTlxODzjQ==
Date:   Tue, 9 Feb 2021 11:43:27 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daeseok Youn <daeseok.youn@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock: remove return value of memblock_free_all()
Message-ID: <20210209094327.GB242749@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This a small cleanup in memblock for 5.12 merge window.

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v5.12-rc1

for you to fetch changes up to 097d43d8570457c1af9b09fab15412697b177f35:

  mm: memblock: remove return value of memblock_free_all() (2021-01-14 15:29:11 +0200)

----------------------------------------------------------------
memblock: remove return value of memblock_free_all()

memblock_free_all() returns the total count of freed pages and its callers
used this value to update totalram_pages. This update is now anyway a part
of memblock_free_all() and its callers no longer check the return value, so
make memblock_free_all() void.

----------------------------------------------------------------
Daeseok Youn (1):
      mm: memblock: remove return value of memblock_free_all()

 include/linux/memblock.h | 2 +-
 mm/memblock.c            | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
Sincerely yours,
Mike.
