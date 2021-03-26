Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FCC34B211
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhCZWRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:17:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:43717 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhCZWQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:16:34 -0400
IronPort-SDR: vvsGgLycsq5QPQlcjbArUc6b/X0w1EuzpAjaY8dJdLqM8981sEK1U60KXiUOCv28wUyrkszw6X
 DCvI/wmoDfrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="252579024"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="252579024"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:16:33 -0700
IronPort-SDR: VrBQ5RydJYa95h5hXNQ6W2fvs/JPydJ8TBEvDJmHisNAVp9algNDI/Lb8CPvPqVTuN1gEjyb7c
 IC5nm3Cvdwsg==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="416713332"
Received: from schine-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.213.191.61])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 15:16:33 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 0/2] ASoC: remove cppchecks warnings on lm49453 and da732x
Date:   Fri, 26 Mar 2021 17:16:17 -0500
Message-Id: <20210326221619.949961-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are the last two patches in the cleanups, this time I am not
sure what the code does and what the proper fix might be. Feedback
welcome.

Pierre-Louis Bossart (2):
  ASoC: lm49453: fix useless assignment before return
  ASoC: da732x: simplify code

 sound/soc/codecs/da732x.c  | 17 ++++++-----------
 sound/soc/codecs/da732x.h  | 12 ++++--------
 sound/soc/codecs/lm49453.c |  2 --
 3 files changed, 10 insertions(+), 21 deletions(-)

-- 
2.25.1

