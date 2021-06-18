Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312403ACEF2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbhFRPbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:31:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:7105 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235340AbhFRPaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:30:55 -0400
IronPort-SDR: 67WlYAPJP4ho//h9wMfSJCQCgeP7nAubHS7/2P159G2107jXYjEhu1rTm6xvltYRfLh6NDFlzj
 iZX0pRGuIQjw==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="228099632"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="228099632"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 08:27:37 -0700
IronPort-SDR: B8te9awkT5S8Nn5g+i9ahPgeJlu0Fk6PDEYeb0GWr9Z982uG5PyFJc32c8rrXw/KUEkCOMzytt
 sceeEWI6PiLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="405004794"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga006.jf.intel.com with ESMTP; 18 Jun 2021 08:27:30 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/3] Perf: Some fixes for Alder Lake and Sapphire Rapids
Date:   Fri, 18 Jun 2021 08:12:51 -0700
Message-Id: <1624029174-122219-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The patchset includes several fixes for a special configuration and
specific events on Alder Lake and Sapphire Rapids.

A single fix patch is easily buried in the numerous LKML emails. So I
put them together to attract more attention.

They are independent small fixes and can be reviewed/merged separately.

Kan Liang (3):
  perf/x86/intel: Fix fixed counter check warning for some Alder Lake
  perf/x86/intel: Add more events requires FRONTEND MSR on Sapphire Rapids
  perf/x86/intel: Fix instructions:ppp support in Sapphire Rapids

 arch/x86/events/intel/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

-- 
2.7.4

