Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE043C6BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhGMIDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 04:03:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234095AbhGMIDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:03:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1E866120A;
        Tue, 13 Jul 2021 08:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626163241;
        bh=Hs4L7zyR4b4GxBhM2vCR+8+5J8MOomPSGY1D2RWhWtk=;
        h=From:To:Cc:Subject:Date:From;
        b=k9qX/e9/aNmqhA0vJlaG86UM5k7FCgqoM3mviMYQ4ThKgZnuPtW4ov5rZe9a8jDsJ
         X/os0IyqN+3ZxFk0ZmAqJKGw8vHBkZyJi9Fwm3KkuCzMDAwiYGrsuyA8sf9gGvKLoW
         A17gS/pcmo/DQAkHQZ8KxMWXp7UG2M5Q1rwEJgYPOtgvCqbIAe3xTzBxVCoyMmCU13
         fr/tOyKk6LK/BxhxnyiypQNPaqH8tVK8JPEMZab4UelMMxrMcPuMau/JrbBih8lFni
         ttOTVhmcPufmRFhJisjgBkFIiilso/AZmZxDtCDRVGcbVHjY3rr/oS9+1UrWdGEsV8
         190UQtRutnCtQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/2] mm: remove pfn_valid_within() and CONFIG_HOLES_IN_ZONE
Date:   Tue, 13 Jul 2021 11:00:33 +0300
Message-Id: <20210713080035.7464-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

After recent updates to freeing unused parts of the memory map, no
architecture can have holes in the memory map within a pageblock. This
makes pfn_valid_within() check and CONFIG_HOLES_IN_ZONE configuration
option redundant.

The first patch removes them both in a mechanical way and the second patch
simplifies memory_hotplug::test_pages_in_a_zone() that had
pfn_valid_within() surrounded by more logic than simple if.

Mike Rapoport (2):
  mm: remove pfn_valid_within() and CONFIG_HOLES_IN_ZONE
  mm: memory_hotplug: cleanup after removal of pfn_valid_within()

 drivers/base/node.c    |  2 --
 include/linux/mmzone.h | 12 ------------
 mm/Kconfig             |  3 ---
 mm/compaction.c        | 20 +++++++-------------
 mm/memory_hotplug.c    | 13 +++----------
 mm/page_alloc.c        | 24 ++----------------------
 mm/page_isolation.c    |  7 +------
 mm/page_owner.c        | 14 +-------------
 8 files changed, 14 insertions(+), 81 deletions(-)


base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.28.0

