Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1489838886C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 09:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242088AbhESHqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 03:46:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:51685 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241103AbhESHqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 03:46:14 -0400
IronPort-SDR: f0HwfdK1S7HgCw2gHU6aU5tYaVLJeN9EEZrjJIw3ZGBRwjdBO9u8Nf6EbG8Kqpj2ZzzNxk3Ze4
 IVEk7zreRkOA==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200964062"
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="200964062"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 00:44:53 -0700
IronPort-SDR: HC0MYv4mxI7ZpSoxohzDyILf2E1CD53P4cAfpxzKBXW72LVaSqy6oh9F8KC3Rb4tqojp5E+azs
 ryVpis8UWPwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="411625019"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 19 May 2021 00:44:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] perf intel-pt: Fixes relating to transaction abort handling
Date:   Wed, 19 May 2021 10:45:12 +0300
Message-Id: <20210519074515.9262-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are 2 fixes for stable and a subsequent tiny tidy-up.

Adrian Hunter (3):
      perf intel-pt: Fix transaction abort handling
      perf intel-pt: Fix sample instruction bytes
      perf intel-pt: Remove redundant setting of ptq->insn_len

 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 6 +++++-
 tools/perf/util/intel-pt.c                          | 6 ++++--
 2 files changed, 9 insertions(+), 3 deletions(-)


Regards
Adrian
