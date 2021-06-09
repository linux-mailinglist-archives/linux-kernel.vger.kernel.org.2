Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B823B3A15C8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhFINiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235485AbhFINiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:38:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9784E6101A;
        Wed,  9 Jun 2021 13:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623245818;
        bh=6fmOCtWMIQ8U3T64X0/kcwrng7XoZZcmbhy8x4YefrY=;
        h=Date:From:To:Cc:Subject:From;
        b=fChaQePngQbk4Nj9N0F0EQ9xMr1xwMwT609pff6BQ59rA3cv/+azpDIiiZuEsVDCT
         yGy8Vth+hI/o7d87rMA7SgksL9G+kc8Xc1z3YpbSTJKrl26pHaYa65JQNhBnxnNSIg
         VWG4xM3zKhTUsVUALY2ySdYvGTTPijcO3xUUfuGnrleJiYBuntHwBlZv/GRUdNJgda
         /20OtBYStW1gGSSzlSL3khg7Smw0ed4U+N0pdH6mIJJov/94DKx7EUJnP/lOMaenmg
         8Mqn9gNz3m0TmmorqIU1YFHagaGe/6i2ctkcMFrYU1/SqkdvVx4TYIa8IzYL9qBrgk
         TbwlHk4N7jhpA==
Date:   Wed, 9 Jun 2021 15:36:14 +0200
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clang-format for v5.13-rc6
Message-ID: <20210609133614.GA4132@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here comes the usual update for `clang-format`.

Cheers,
Miguel

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.13-rc6

for you to fetch changes up to 4792f9dd12936ec35deced665ae3a4ca8fe98729:

  clang-format: Update with the latest for_each macro list (2021-05-12 23:32:39 +0200)

----------------------------------------------------------------
The usual update for `clang-format`.

----------------------------------------------------------------
Miguel Ojeda (1):
      clang-format: Update with the latest for_each macro list

 .clang-format | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)
