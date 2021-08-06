Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FFA3E210B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 03:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243115AbhHFBdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 21:33:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48016 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbhHFBdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 21:33:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0C63D1FD53;
        Fri,  6 Aug 2021 01:33:34 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D88C413DD1;
        Fri,  6 Aug 2021 01:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n+EmJ2yRDGFiBgAAMHmgww
        (envelope-from <dave@stgolabs.net>); Fri, 06 Aug 2021 01:33:32 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH -tip 0/3] perf/bench-futex: Misc updates
Date:   Thu,  5 Aug 2021 18:33:26 -0700
Message-Id: <20210806013329.94627-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A couple of updates for the futex perf benchmarks.

Please consider for v5.15.

Thanks!

Davidlohr Bueso (3):
  perf/bench-futex: Group test parameters cleanup
  perf/bench-futex: Add --mlockall parameter
  perf/bench-futex, requeue: Add --pi parameter

 tools/perf/bench/futex-hash.c          |  77 ++++++++-----
 tools/perf/bench/futex-lock-pi.c       |  75 ++++++++-----
 tools/perf/bench/futex-requeue.c       | 148 ++++++++++++++++++-------
 tools/perf/bench/futex-wake-parallel.c |  78 ++++++++-----
 tools/perf/bench/futex-wake.c          |  77 ++++++++-----
 tools/perf/bench/futex.h               |  40 ++++++-
 6 files changed, 346 insertions(+), 149 deletions(-)

-- 
2.26.2

