Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC8B38D6D5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 20:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhEVSKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 14:10:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:34983 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230497AbhEVSKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 14:10:40 -0400
IronPort-SDR: IR5WWRbz0YyswAPBrim0LMrU3ewppPGsXgl/dxBPrZsEiow1VUzLCWQB19tHcudaGzhrMX8AOp
 PnUuwhvD58Vg==
X-IronPort-AV: E=McAfee;i="6200,9189,9992"; a="199757877"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="199757877"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2021 11:09:15 -0700
IronPort-SDR: o+MZoMyZvIFtr494Y0mXlxoRsTGIiVUYeu7LQaXzDcpjXzXsgWk9UI8nzvnn2G5tydhmClSGQf
 +PgVMhZPdoAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441735037"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2021 11:09:13 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lkW3l-0000M9-1j; Sat, 22 May 2021 18:09:13 +0000
Date:   Sun, 23 May 2021 02:09:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Geoffrey D. Bennett" <g@b4.vu>
Cc:     kbuild-all@lists.01.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Joe Perches <joe@perches.com>,
        Alexander Tsoy <alexander@tsoy.me>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH sound] ALSA: usb-audio: scarlett2:
 snd_scarlett_gen2_controls_create() can be static
Message-ID: <20210522180900.GA83915@f59a3af2f1d9>
References: <202105230212.9rlkrDHb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105230212.9rlkrDHb-lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/usb/mixer_scarlett_gen2.c:2000:5: warning: symbol 'snd_scarlett_gen2_controls_create' was not declared. Should it be static?

Fixes: 265d1a90e4fb ("ALSA: usb-audio: scarlett2: Improve driver startup messages")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 mixer_scarlett_gen2.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 3ad8f61a2095f..4caf379d5b991 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -1997,8 +1997,8 @@ static int scarlett2_mixer_status_create(struct usb_mixer_interface *mixer)
 	return usb_submit_urb(mixer->urb, GFP_KERNEL);
 }
 
-int snd_scarlett_gen2_controls_create(struct usb_mixer_interface *mixer,
-				      const struct scarlett2_device_info *info)
+static int snd_scarlett_gen2_controls_create(struct usb_mixer_interface *mixer,
+					     const struct scarlett2_device_info *info)
 {
 	int err;
 
