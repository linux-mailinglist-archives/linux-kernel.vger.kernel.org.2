Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68B6340BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhCRR3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57455 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232298AbhCRR2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616088530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=n6wDmCtvuvdr1I+Uk1RgtYGiogg109EbzFFfEqq1Ydg=;
        b=hp1K8eo/Hzl1T6iVtEEPOJpnPETQM9rVlFsycbpuLhIbRcJY+JSJBQsceDF974Mh/LgyCs
        3RP9kT1lkTA8fp5Aio8DATvmRVbN2btgwuJCCPPrXjoEK8NHqJCPQqq9ATZXDTto2ALogr
        9c3ZLg5Ge9OyfMC/rum8ketpnPI2eC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-M3xiKL2FNVSiSkh4B0fkBQ-1; Thu, 18 Mar 2021 13:28:36 -0400
X-MC-Unique: M3xiKL2FNVSiSkh4B0fkBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 295971926DA0;
        Thu, 18 Mar 2021 17:28:35 +0000 (UTC)
Received: from llong.com (ovpn-119-86.rdu2.redhat.com [10.10.119.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B226B5D6A8;
        Thu, 18 Mar 2021 17:28:27 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip 0/5] locking/locktorture: Fix locktorture ww_mutex test problems
Date:   Thu, 18 Mar 2021 13:28:09 -0400
Message-Id: <20210318172814.4400-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up patch series for the previous patchset on fixing
locktorture ww_mutex test problem [1]. The first 3 patches of that
series were merged into tip. It turns out that the last one of the
three wasn't quite right. So this patch series revert the last patch.

The rests of the patch series fix the ww_mutex testing problem in
locktorture as well as removing the DEFINE_WW_MUTEX() macro from
include/linux/ww_mutex.h.

[1] https://lore.kernel.org/lkml/20210316153119.13802-1-longman@redhat.com/

Waiman Long (5):
  locking/ww_mutex: Revert "Treat ww_mutex_lock() like a trylock"
  locking/locktorture: Fix false positive circular locking splat in
    ww_mutex test
  locking/ww_mutex: Remove DEFINE_WW_MUTEX() macro
  locking/locktorture: Pass thread id to lock/unlock functions
  locking/locktorture: locking/locktorture: Fix incorrect use of
    ww_acquire_ctx in ww_mutex test

 include/linux/ww_mutex.h     |  17 +---
 kernel/locking/locktorture.c | 146 +++++++++++++++++++++++------------
 kernel/locking/mutex.c       |   5 +-
 3 files changed, 100 insertions(+), 68 deletions(-)

-- 
2.18.1

