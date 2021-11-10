Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C22644C37B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 15:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhKJPA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 10:00:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232186AbhKJPA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:00:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D38C061051;
        Wed, 10 Nov 2021 14:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636556291;
        bh=fw+Zpq/8rESaWuNrOG7CTMK0NdhcJtmFcuhY8rFZdzM=;
        h=From:To:Cc:Subject:Date:From;
        b=ujL2bBJsMbbymOU7V6lleIUDhCcUxcefUeyjX4IX/mG75xpMQ+qKyEXqLnY+ZgTEg
         i+0HAKGS05Ff/KxKGPTZw4n+1Zxo1MGQ5C8KII8uDvUDcyA8vadTHcwowYqVTQ9DRP
         mnF2xPRDAXtPghAQ0rRDHP14v/fpfoGIn4XjRbQLhPCDvNzVFLkuyasOwFgq71UJSd
         AtX6vw+mq7aXU9uIAeESGndAqA4hTQCzE40VajvVdif+RiEpPlaKVSDUoqFTJ0nU6W
         fbTWC1IFVQv7kjcExdK6URBxIWxUb4MGMr4aD/mCAONSWxFuHr5Kb+Uy0J3aaohYad
         9rSBGriaaoF8A==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 0/2] DAMON fixes
Date:   Wed, 10 Nov 2021 14:57:56 +0000
Message-Id: <20211110145758.16558-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes bugs in DAMON.  Those cannot cleanly applied on
v5.15.y.  I will back-port these on v5.15.y and post later once these
are merged in the mainline.

SeongJae Park (2):
  mm/damon/dbgfs: Use '__GFP_NOWARN' for user-specified size buffer
    allocation
  mm/damon/dbgfs: Fix missed use of damon_dbgfs_lock

 mm/damon/dbgfs.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
2.17.1

