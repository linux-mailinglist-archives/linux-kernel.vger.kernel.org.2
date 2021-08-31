Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EBA3FC753
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhHaMfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 08:35:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbhHaMfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 08:35:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A8B26103E;
        Tue, 31 Aug 2021 12:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630413287;
        bh=ikTsyiaLjoVd0AzH4yqLXRx66TrfKvw0sdPD1KkUtis=;
        h=Date:From:To:Cc:Subject:From;
        b=iVQCjYMA8kmHu+YOS8CRhiyo+V5GpuOmO5iXMNcNDyKroR7p/EsZwJ4mdoELHmBeB
         6CwRnkCilAWspIOHfrMbdrtkwaIq1F5Lmxav2av9Jwi5JgUkLOmby6DtQ8k+PU0Cma
         EZNIFhErfN2d1VUhnVyZ4Ex97CwN0prl5D6i3Df4ptXOQv8BnTYNqs9aixQFxsEtux
         t9UZOmYD5kEpq3YKULziFnNBdL1i9UROWgbYP9tZNcpK87atA6usSjzr5TwHSA5c1Q
         b6fpjQswfMurV8fXPbTJtpMJA8ANb9LJbqCZvVxEjk+RPjuJSaak0hEmW1OPBgjIm8
         Sp0bDrf6Z4Kqw==
Date:   Tue, 31 Aug 2021 15:34:41 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock
Message-ID: <YS4h4R2dmpd2qDQ9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v5.15-rc1

for you to fetch changes up to e888fa7bb882a1f305526d8f49d7016a7bc5f5ca:

  memblock: Check memory add/cap ordering (2021-08-11 14:50:50 +0300)

----------------------------------------------------------------
memblock: robustness and debug improvements

* add check for memory add/cap ordering
* add missing debug code to memblock_add_node()

----------------------------------------------------------------
Geert Uytterhoeven (2):
      memblock: Add missing debug code to memblock_add_node()
      memblock: Check memory add/cap ordering

 mm/memblock.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
Sincerely yours,
Mike.
