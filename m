Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7585F33AAA2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 06:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCOFDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 01:03:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:59712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhCOFCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 01:02:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F201EAD73;
        Mon, 15 Mar 2021 05:02:48 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH -tip 0/2] futex: Two pi fixes
Date:   Sun, 14 Mar 2021 22:02:22 -0700
Message-Id: <20210315050224.107056-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some unrelated fixlets found via code inspection. Please consider for v5.13.

Thanks!

Davidlohr Bueso (2):
  futex: Fix irq mismatch in exit_pi_state_list()
  futex: Leave the pi lock stealer in a consistent state upon successful
    fault

 kernel/futex.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
2.26.2

