Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA6343FA19
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 11:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhJ2JoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 05:44:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:50887 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231273AbhJ2JoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 05:44:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="229359929"
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; 
   d="scan'208";a="229359929"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 02:41:38 -0700
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; 
   d="scan'208";a="498845412"
Received: from rdutta-mobl3.gar.corp.intel.com (HELO lkp-bingo.ccr.corp.intel.com) ([10.255.31.247])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 02:41:34 -0700
From:   Li Zhijian <zhijianx.li@intel.com>
To:     dave@stgolabs.net, joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        rostedt@goodmis.org, rcu@vger.kernel.org
Cc:     philip.li@intel.com, lizhijian@cn.fujitsu.com,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Li Zhijian <zhijianx.li@intel.com>
Subject: [PATCH 0/6] minor fixes and cleanups in rcuscale and torture tests
Date:   Fri, 29 Oct 2021 17:40:23 +0800
Message-Id: <20211029094029.22501-1-zhijianx.li@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- we added '\n' to the macros directly like what torture does, see
include/linux/torture.h
- SCFTORTOUT is unused any more, remove it
- follow up https://lkml.org/lkml/2021/10/24/439, covert all other residuals


Li Zhijian (6):
  refscale: add missing '\n' to flush message out
  scftorture: add missing '\n' to flush message out
  scftorture: Remove unused SCFTORTOUT
  scftorture: always log error message
  rcuscale: alwaly log error message
  locktorture,rcutorture,torture: always log error message

 include/linux/torture.h      |  9 ++-------
 kernel/locking/locktorture.c |  4 ++--
 kernel/rcu/rcuscale.c        | 14 +++++++-------
 kernel/rcu/rcutorture.c      |  8 ++++----
 kernel/rcu/refscale.c        | 11 +++++++----
 kernel/scftorture.c          | 16 ++++++----------
 kernel/torture.c             |  4 ++--
 7 files changed, 30 insertions(+), 36 deletions(-)

-- 
2.32.0

