Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FDD30C55D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbhBBQUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236134AbhBBQSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:18:25 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF39C06178C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:17:39 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z2so10582975pln.18
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=iwkSPDu8+GCJtZMCgGxCvy6RYjdYTFAwWafltAfL22E=;
        b=j+OrsPqfI2I28/iLg0WIy4Rb9Ckar70srGuUc4Zfskq71ped2Ij4JaNsEthFBNR4+U
         1QwMrVSz3FuYPFkp1xfG1qz+P6bm/GYAOTZ01sud30A3wimTYlHjDu5ALg/2tKCH4La3
         7OtKqdqrkgkSDlZZPhcM76stoIGT5zfRnonQ4bw0TYdYgoiVkNRJbgUTG95Eoi7WSzT/
         U/bFD25Gvk5twsbvMh/fMOF21dIgOIxmWtCoq3fRsNZTask9OZ1XCZT5LKhFT1fajTNa
         7OFpXPfvBBXa/BCE7Jzo0mAAH00KfbveVFo+BsolCw1YcIqXtYvdd4j4fWZSfX447tUF
         sNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=iwkSPDu8+GCJtZMCgGxCvy6RYjdYTFAwWafltAfL22E=;
        b=sSlHrjDMKd97Pju5ING4PaMDVz93KwCPUFpQ3AZV9Yi4GEqo87k4wNkCLSCgcNVDPp
         jets3ljEfuHhjdiXQTx18CMKdjRKC5T6YxiPeWk1NkkphOd8BnI3tV35FNDbIecDjNoL
         FbEllwgfMpduwYHlhZMk0SDaEUbVkPfTvNLkFuvefSnWaFkHO0xjZlTl1EjiV0/QRlXl
         FQX4udk+sPZquSeVorNDeZ6vVT/1bn+w9xnHZUzRbNqCrfICnb6W4G861iEUQkaB0lRr
         IGXPU2pB1nZl9dvg2hO22YXFQm97aALmIDmXhKE8d9Tz67ILkQYhxpx1NoHC3YhWBtWO
         7H5A==
X-Gm-Message-State: AOAM531/iLRcTASitDTO6IomRn/jFAJZf3fgpZI0QiJ02+K2phAcbR8w
        W/C7NZikyGVeXso1OMtOTRW2rwj7FjLD
X-Google-Smtp-Source: ABdhPJzyFdCQAvJN3cdQcHtYsB1Ey3cwtyGZMbsMNsjUiAZ4K6I8OxfTNzeaKP5quIUEzuh5JRLH6YYzt5XB
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:dd94:c753:a81d:c855])
 (user=kyletso job=sendgmr) by 2002:a62:75c1:0:b029:1b6:b71a:a369 with SMTP id
 q184-20020a6275c10000b02901b6b71aa369mr22323886pfc.27.1612282658846; Tue, 02
 Feb 2021 08:17:38 -0800 (PST)
Date:   Wed,  3 Feb 2021 00:17:25 +0800
Message-Id: <20210202161733.932215-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v5 0/8] common SVDM version and VDO from dt
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4 is here:
https://patchwork.kernel.org/project/linux-usb/cover/20210202093342.738691-1-kyletso@google.com/

Changes since v4:
=================
usb: pd: Make SVDM Version configurable in VDM header
- modified the code who uses VDO(), set the ver field to SVDM_VER_1_0

Kyle Tso (8):
  usb: typec: Manage SVDM version
  usb: pd: Update VDO definitions
  usb: pd: Make SVDM Version configurable in VDM header
  usb: typec: tcpm: Detemine common SVDM Version
  usb: typec: ucsi: Detemine common SVDM Version
  usb: typec: displayport: Fill the negotiated SVDM Version in the header
  dt-bindings: connector: Add SVDM VDO properties
  usb: typec: tcpm: Get Sink VDO from fwnode

 .../bindings/connector/usb-connector.yaml     |  11 +
 drivers/usb/typec/altmodes/displayport.c      |   8 +-
 drivers/usb/typec/class.c                     |  21 +-
 drivers/usb/typec/tcpm/tcpm.c                 |  61 +++-
 drivers/usb/typec/ucsi/displayport.c          |  12 +-
 drivers/usb/typec/ucsi/ucsi.c                 |   2 +
 include/dt-bindings/usb/pd.h                  | 311 ++++++++++++++++-
 include/linux/usb/pd_vdo.h                    | 315 ++++++++++++++----
 include/linux/usb/typec.h                     |  10 +
 9 files changed, 661 insertions(+), 90 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

