Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFD840F80C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhIQMl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhIQMl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:41:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56CE9610C9;
        Fri, 17 Sep 2021 12:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631882404;
        bh=N7x/pZ+Idx4FDBB36mXNOaNZYaMxR9L+4/ApMVnUuig=;
        h=From:To:Cc:Subject:Date:From;
        b=rDepe45dRQWINPb0zH11OGx4dZ1sGSktQMc+mui/yUcg9plpZ7i572od1JKRwXG0s
         obcNsBA5R02ThJ/4s2oLFkxoBqwI0Xg5jVzK92VlxLNYiTWovCOqPGbBgog4aXCwrP
         Kbx81ORXo5HM2d67EHPvgRIQnPIOjc0TR3vsVrxRC/EEXzbALytq84k7mjGYHFtgXp
         pO/5/N+EGZnjo2d0qo2/HceoffJbigv3Re8x8cLQ4rjnIcCrB6A0bz37ty7URWLPpL
         hk7OdOI6f3CpT0dFbTsp5Q6OjqoxQdx97/1sSJfdaK1NKGGTzxZE7fcw38u08X8Fjv
         RwNz7hABc0hIw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, sj@kernel.org, linux-damon@amazon.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] mm, mm/damon: Trivial fixes
Date:   Fri, 17 Sep 2021 12:39:53 +0000
Message-Id: <20210917123958.3819-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes trivial nits in mm documentation and DAMON.

SeongJae Park (5):
  Documentation/vm: Move user guides to admin-guide/mm/
  MAINTAINERS: Update SeongJae's email address
  docs/vm/damon: Remove broken reference
  include/linux/damon.h: Fix kernel-doc comments for 'damon_callback'
  mm/damon/core: Print kdamond start log in debug mode only

 Documentation/admin-guide/mm/index.rst        |  2 ++
 .../{vm => admin-guide/mm}/swap_numa.rst      |  0
 .../{vm => admin-guide/mm}/zswap.rst          |  0
 Documentation/vm/damon/index.rst              |  1 -
 Documentation/vm/index.rst                    | 26 ++++---------------
 MAINTAINERS                                   |  2 +-
 include/linux/damon.h                         |  6 ++---
 mm/damon/core.c                               |  2 +-
 8 files changed, 12 insertions(+), 27 deletions(-)
 rename Documentation/{vm => admin-guide/mm}/swap_numa.rst (100%)
 rename Documentation/{vm => admin-guide/mm}/zswap.rst (100%)

-- 
2.17.1

