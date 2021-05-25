Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728B338FA16
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 07:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhEYFsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 01:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhEYFsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 01:48:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0681FC06138E
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 22:46:47 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1llPtm-0000Aq-0J; Tue, 25 May 2021 07:46:38 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1llPtk-0002PG-20; Tue, 25 May 2021 07:46:36 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org
Subject: [PATCH v6 0/4] add z1 and z2 channels support for resistive-adc-touch driver
Date:   Tue, 25 May 2021 07:46:30 +0200
Message-Id: <20210525054634.9134-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes v6:
- drop other DT changes
- add more Reviewed-by tags
- remove redundant GRTS_CH_NONE check

changes v5:
- fix validate for other DT examples.
- add Reviewed-by: Rob Herring <robh@kernel.org> to some of the patches

changes v4:
- resistive-adc-touch: remove unused variable

changes v3:
- yaml: fix validation for channel names
- yaml: add nodename validation

changes v2:
- add yaml conversion patch to this series
- reword commit message for the last patch
- fix possible overflow on the buffer dispatcher

Oleksij Rempel (4):
  dt-bindings: touchscreen: Convert resistive-adc-touch binding to json
    schema
  dt-bindings: touchscreen: add touchscreen-x/y-plate-ohms property
  dt-bindings: touchscreen: resistive-adc-touch: add support for z1 and
    z2 channels
  Input: resistive-adc-touch: add support for z1 and z2 channels

 .../input/touchscreen/resistive-adc-touch.txt |  33 -----
 .../touchscreen/resistive-adc-touch.yaml      |  86 +++++++++++
 .../input/touchscreen/touchscreen.yaml        |   6 +
 .../input/touchscreen/resistive-adc-touch.c   | 140 ++++++++++++++++--
 4 files changed, 218 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.yaml

-- 
2.29.2

