Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D714633FC4F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 01:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhCRAjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 20:39:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:30063 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhCRAj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 20:39:29 -0400
IronPort-SDR: j9kl66DO316J5/JgbLkp53HzLSgc/iI9gijlZHOJ4UrGBGq0emhmPZVg04477CBxbr/X5o+wZM
 aHiOJVD2JTNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="168850816"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="168850816"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 17:39:29 -0700
IronPort-SDR: BfE3Ug96GgZtPWeF0DnvpSDHd7zOFJijzE2oMUrPshS3rJvXdLfExlP247dIugOHn9a1gN+zsX
 Jl/P1JDFnSdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="389039160"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 17 Mar 2021 17:39:26 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lMghB-0000vt-J0; Thu, 18 Mar 2021 00:39:25 +0000
Date:   Thu, 18 Mar 2021 08:38:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Parshuram Thombare <pthombar@cadence.com>, robert.foss@linaro.org,
        robh+dt@kernel.org, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        narmstrong@baylibre.com, Parshuram Thombare <pthombar@cadence.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [RFC PATCH] drm: bridge: cdns-mhdp8546: cdns_mhdp_hdcp_set_lc() can
 be static
Message-ID: <20210318003851.GA86692@e53ce6e6f9c2>
References: <1615997158-16737-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615997158-16737-1-git-send-email-pthombar@cadence.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 cdns-mhdp8546-hdcp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
index c4bcacd23ee32..7757c272c49f6 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
@@ -499,7 +499,7 @@ static void cdns_mhdp_hdcp_prop_work(struct work_struct *work)
 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
 }
 
-int cdns_mhdp_hdcp_set_lc(struct cdns_mhdp_device *mhdp, u8 *val)
+static int cdns_mhdp_hdcp_set_lc(struct cdns_mhdp_device *mhdp, u8 *val)
 {
 	int ret;
 
@@ -512,7 +512,7 @@ int cdns_mhdp_hdcp_set_lc(struct cdns_mhdp_device *mhdp, u8 *val)
 	return ret;
 }
 
-int
+static int
 cdns_mhdp_hdcp_set_public_key_params(struct cdns_mhdp_device *mhdp,
 				     struct cdns_hdcp_tx_public_key_param *val)
 {
