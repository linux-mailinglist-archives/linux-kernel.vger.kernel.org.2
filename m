Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492463E3F06
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 06:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhHIEdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 00:33:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58964 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhHIEda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 00:33:30 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1DEBD21D69;
        Mon,  9 Aug 2021 04:33:10 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FB9C13398;
        Mon,  9 Aug 2021 04:33:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SuyTFQSwEGEfDQAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 09 Aug 2021 04:33:08 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH -tip v2 0/7] perf/bench-futex: Misc updates
Date:   Sun,  8 Aug 2021 21:32:54 -0700
Message-Id: <20210809043301.66002-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1: https://lore.kernel.org/lkml/20210806013329.94627-1-dave@stgolabs.net/
- Addressed acme's comments in patch 1.
- Addeded more patches.
- Added more people to the Cc.

A few updates for the futex perf benchmarks.

Please consider for v5.15.

Thanks!

Davidlohr Bueso (7):
  perf/bench-futex: Group test parameters cleanup
  perf/bench-futex: Remove bogus backslash from comment
  perf/bench-futex: Factor out futex_flag
  perf/bench-futex: Add --mlockall parameter
  perf/bench-futex, requeue: Add --broadcast option
  perf/bench-futex, requeue: Robustify futex_wait() handling
  perf/bench-futex, requeue: Add --pi parameter

 tools/perf/bench/futex-hash.c          |  63 +++++-----
 tools/perf/bench/futex-lock-pi.c       |  61 +++++-----
 tools/perf/bench/futex-requeue.c       | 160 ++++++++++++++++++-------
 tools/perf/bench/futex-wake-parallel.c |  67 ++++++-----
 tools/perf/bench/futex-wake.c          |  66 +++++-----
 tools/perf/bench/futex.h               |  55 ++++++++-
 6 files changed, 318 insertions(+), 154 deletions(-)

--
2.26.2

