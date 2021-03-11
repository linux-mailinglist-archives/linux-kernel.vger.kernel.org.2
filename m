Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53963336935
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhCKAti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:49:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:15447 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhCKAtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:49:16 -0500
IronPort-SDR: jA8VewDEwfBIr/rRQMsRys7XHBitrc83iK/RUXKX4BrPrNZxb4bZ9x9S+M393DlsV5kq1Sk6Ow
 P1DvGaM+XrvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="273629847"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="273629847"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 16:49:14 -0800
IronPort-SDR: hDjsuncF8llssoUHAl8uU/QMI4xyFcq7TAK8JfSQYqi+YH2A1WFKueuFGF3ERBxayd/b+aD6Ze
 W/XcEmU17a3A==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="370386779"
Received: from theer-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.101.109])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 16:49:13 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH 0/4] ASoC: mediatek: remove cppcheck warnings
Date:   Wed, 10 Mar 2021 18:49:00 -0600
Message-Id: <20210311004904.121205-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There should be no functionality change, this patchset only fixes
shadowed variables, prototypes and removes a useless assignment.

Pierre-Louis Bossart (4):
  ASoC: mediatek: mtk-btcvsd: remove useless assignment
  ASoC: mediatek: mt2701: align function prototype
  ASoC: mediatek: mt2701: rename shadowed array
  ASoC: mediatek: mt8173: rename local irq variable

 sound/soc/mediatek/common/mtk-btcvsd.c            | 2 +-
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h | 4 ++--
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c        | 4 ++--
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c        | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.25.1

