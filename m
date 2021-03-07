Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D535330286
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 16:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhCGPSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 10:18:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231700AbhCGPSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 10:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615130303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hpOIohiqtQVCBBLhP65zCevaj+cVWLKqGokojSmTLAg=;
        b=XXGSsd7RlScBgOPu5/zw+29fnfKz1QYYDEjh45Zrxdhc9yhtFIXCKb7+pUnYXG+5nPmTNG
        1FgE2VgYblLZ5cEqRGnHqJL+lao+zPfcACoboGrOr6MYteSAoBlSeo6e313hSKQgdoOveg
        eDcI1bfiyELYuQDuROyroSNW2tXj9o8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-gM2Il1E3P52STFI3cndV2w-1; Sun, 07 Mar 2021 10:18:19 -0500
X-MC-Unique: gM2Il1E3P52STFI3cndV2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 051B9107465C;
        Sun,  7 Mar 2021 15:18:17 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-90.ams2.redhat.com [10.36.112.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0265C60BF1;
        Sun,  7 Mar 2021 15:18:13 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v4 resend 00/13] MFD/extcon/ASoC: Rework arizona codec jack-detect support
Date:   Sun,  7 Mar 2021 16:17:54 +0100
Message-Id: <20210307151807.35201-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here is v4 of my series to rework the arizona codec jack-detect support
to use the snd_soc_jack helpers instead of direct extcon reporting.

As discussed before here is a resend rebased on 5.12-rc2, making sure that
all patches this depends on are in place.

Lee, can you pick-up patches 1-6 through the MFD tree and then send a
pull-req to Mark so that Mark can merge the Asoc parts throught the ASoC
tree ?

Patches 2-6 touch drivers/extcon, these all have an Ack from Chanwoo Choi
for merging these through the MFD tree.

Here is some more generic info on this series from the previous
cover-letter:

This is done by reworking the extcon driver into an arizona-jackdet
library and then modifying the codec drivers to use that directly,
replacing the old separate extcon child-devices and extcon-driver.

This brings the arizona-codec jack-detect handling inline with how
all other ASoC codec driver do this. This was developed and tested on
a Lenovo Yoga Tablet 1051L with a WM5102 codec.

This was also tested by Charles Keepax, one of the Cirrus Codec folks.

Regards,

Hans


Hans de Goede (13):
  mfd: arizona: Drop arizona-extcon cells
  extcon: arizona: Fix some issues when HPDET IRQ fires after the jack
    has been unplugged
  extcon: arizona: Fix various races on driver unbind
  extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol")
    call
  extcon: arizona: Always use pm_runtime_get_sync() when we need the
    device to be awake
  ASoC/extcon: arizona: Move arizona jack code to
    sound/soc/codecs/arizona-jack.c
  ASoC: arizona-jack: Move jack-detect variables to struct arizona_priv
  ASoC: arizona-jack: Use arizona->dev for runtime-pm
  ASoC: arizona-jack: convert into a helper library for codec drivers
  ASoC: arizona-jack: Use snd_soc_jack to report jack events
  ASoC: arizona-jack: Cleanup logging
  ASoC: arizona: Make the wm5102, wm5110, wm8997 and wm8998 drivers use
    the new jack library
  ASoC: Intel: bytcr_wm5102: Add jack detect support

 MAINTAINERS                                   |   3 +-
 drivers/extcon/Kconfig                        |   8 -
 drivers/extcon/Makefile                       |   1 -
 drivers/mfd/arizona-core.c                    |  20 -
 sound/soc/codecs/Makefile                     |   2 +-
 .../soc/codecs/arizona-jack.c                 | 577 +++++++-----------
 sound/soc/codecs/arizona.h                    |  44 ++
 sound/soc/codecs/wm5102.c                     |  12 +-
 sound/soc/codecs/wm5110.c                     |  12 +-
 sound/soc/codecs/wm8997.c                     |  14 +-
 sound/soc/codecs/wm8998.c                     |   9 +
 sound/soc/intel/boards/bytcr_wm5102.c         |  28 +-
 12 files changed, 325 insertions(+), 405 deletions(-)
 rename drivers/extcon/extcon-arizona.c => sound/soc/codecs/arizona-jack.c (76%)

-- 
2.30.1

