Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF9D311190
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBESMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:12:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:26074 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233215AbhBESK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 13:10:27 -0500
IronPort-SDR: vJKumvLz/UU0rnx3c6sn1GpTL1NPWUj/Nio6qRPRdcxg+prcGy9M4uNiK4h0ZPB55PzOfsFl66
 w24vJFX8z62w==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="200493375"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="200493375"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 11:52:05 -0800
IronPort-SDR: 2wG+GUwyCmZCxlBs+Z4bhT8v1Jdljx2cjfoprBCaZQBhMd3moqntQ0K5LxTqPglht7NDfODBb3
 vp4SnneUdbNA==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="434580877"
Received: from glacier.sc.intel.com ([10.3.62.63])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 05 Feb 2021 11:52:05 -0800
From:   Rajmohan Mani <rajmohan.mani@intel.com>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        Rajmohan Mani <rajmohan.mani@intel.com>
Subject: [PATCH 0/2] Add support for Type-C mux events without port partners
Date:   Fri,  5 Feb 2021 11:51:11 -0800
Message-Id: <20210205195113.20277-1-rajmohan.mani@intel.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are cases, where support for Type-C mux events is needed, that
does not have port partners.
Enabling communication to a retimer connected to an USB4 port, when
no devices are attached, is a case that requires support for handling
Type-C mux events without port partners.

The following patches[1] are needed on top of the mainline kernel to be
able to verify these patches.

commit 8553a979fcd0 ("platform/chrome: cros_ec_typec: Send mux
		      configuration acknowledgment to EC")
commit ba8ce515454e ("platform/chrome: cros_ec_typec: Parameterize
		      cros_typec_cmds_supported()")
commit 156309096542 ("platform/chrome: cros_ec_typec: Register plug
		      altmodes")
commit f4edab68e101 ("platform/chrome: cros_ec_typec: Register SOP'
		      cable plug")
commit 599229763911 ("platform/chrome: cros_ec_typec: Set partner
		      num_altmodes")
commit 72d6e32bd85b ("platform/chrome: cros_ec_typec: Store cable plug
		      type")
commit 8b46a212ad11 ("platform/chrome: cros_ec_typec: Register cable")
commit c097f229b71e ("platform/chrome: cros_ec_typec: Rename discovery
		      struct")
commit 8fab2755191f ("platform/chrome: cros_ec_typec: Factor out PD
		      identity parsing")
commit a906f45d1480 ("platform/chrome: cros_ec_typec: Make disc_done
		      flag partner-only")

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/
linux.git/log/?h=cros-ec-typec-for-5.12

Rajmohan Mani (2):
  platform/chrome: cros_ec_typec: Skip port partner check in
    configure_mux()
  platform/chrome: cros_ec_types: Support disconnect events without
    partners

 drivers/platform/chrome/cros_ec_typec.c | 27 ++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

-- 
2.30.0

