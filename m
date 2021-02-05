Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10BC31039F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 04:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhBEDfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 22:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhBEDfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 22:35:03 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DD2C06178A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 19:34:23 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 78so1877363ybn.14
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 19:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=OrUeWv6axP6B3bDAlVwgBLZ4U02f8MvfgaV9eohQ9FQ=;
        b=Qiwm5plVh04WeCC3iq8iT23aScDU2aQ05Pp3jII52KGXXxGBafCEcg4O+ozaDQR6iu
         n0ysQbHh0ahgJncd6zcomqYyhFbSOfNfb9CoGbMEePWxk28Bpv1O2COD8SVWs+pE/pXS
         3NN5P+nkd8phHdmb5UuZtMl3c8cj+E8fNcCEM0vZGEzT27wj3mbvbPwSQYvFU8gA0RqS
         THvqbtpl0GKZtLykY++6fTSmF0b3NrD4JUxkUSsuboea/lnOD4ILx6ebYrX/QYugx/5Z
         JyfhiSS6aGE/fuwRDaOMlRJUGbpCifebNaaVu9uR4Q1wPRqWVWTtuynhTvkPvyTa8WPN
         /SlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=OrUeWv6axP6B3bDAlVwgBLZ4U02f8MvfgaV9eohQ9FQ=;
        b=WTYeETu528h4d10/Q9GvERC4Fu8/2H8tcYUOseLEoZP5J1VFCRkoKzkiAKfVmipJhj
         FXTOR77+hNoG2OVxQ4rHLk6D4Vsuh9Sx2Ob9xeMGJRpYY/EBJzTNFEkGSdDv6aDsOFMI
         xcyMye06jwTAZLt3u2D3sWd8U79HDWP6e4p9bZ61KCpnDaiovkS8TRNkazw3n5E8lWgx
         k2BRLDQIbwSubJwDHA2ITjxGayStP9qzq6c+FisYWULCxvbd3EP3ysKQE3ObZpgqnAJW
         /I884IOQ/roB2lIGn6lKxN+/YZHT1yunZC3yzw/2DEu+LhIm8Lx3X/Q7Bu0rgm52rVOX
         +FOQ==
X-Gm-Message-State: AOAM531HJPr4sH2uZLL/l8wk0VPMkM6RU2Iy+BPAALojVYqpcXJzyWd2
        yogAkqKiTthKkEr3IwHEvISHv4vvmMQS
X-Google-Smtp-Source: ABdhPJzYef0pvSKKdaJVJ1Xtoy04P4W0X+TaqeBE/NiPggoRBq5yLm2fXUKPLe0spPO+/+6+NYpErjTMaD+o
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:dd94:c753:a81d:c855])
 (user=kyletso job=sendgmr) by 2002:a25:73d6:: with SMTP id
 o205mr998040ybc.38.1612496062357; Thu, 04 Feb 2021 19:34:22 -0800 (PST)
Date:   Fri,  5 Feb 2021 11:34:08 +0800
Message-Id: <20210205033415.3320439-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v6 0/7] common SVDM version and VDO from dt
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

v5 is here:
https://patchwork.kernel.org/project/linux-usb/cover/20210202161733.932215-1-kyletso@google.com/

Changes since v5:
=================
usb: typec: Manage SVDM version
- !! most changes are from Heikki
- location of the negotiated SVDM version is changed. Now the variable
  resides in typec_partner
- The setter and getter functions were modified according to the above
  changes
- the default SVDM version is stored upon calling to
  typec_register_partner

usb: pd: Make SVDM Version configurable in VDM header
- no change

usb: typec: tcpm: Determine common SVDM Version
- follow the changes of "usb: typec: Manage SVDM version"
- remove the "reset to default". Now the default SVDM version will be
  set when calling to typec_register_partner

usb: typec: ucsi: Determine common SVDM Version
- follow the changes of "usb: typec: Manage SVDM version"
- remove the "reset to default". Now the default SVDM version will be
  set when calling to typec_register_partner

usb: typec: displayport: Fill the negotiated SVDM Version in the header
- follow the changes of "usb: typec: Manage SVDM version"

dt-bindings: connector: Add SVDM VDO properties
- no change

usb: typec: tcpm: Get Sink VDO from fwnode
- no change

Kyle Tso (7):
  usb: typec: Manage SVDM version
  usb: pd: Make SVDM Version configurable in VDM header
  usb: typec: tcpm: Determine common SVDM Version
  usb: typec: ucsi: Determine common SVDM Version
  usb: typec: displayport: Fill the negotiated SVDM Version in the header
  dt-bindings: connector: Add SVDM VDO properties
  usb: typec: tcpm: Get Sink VDO from fwnode

 .../bindings/connector/usb-connector.yaml     |  11 +
 drivers/usb/typec/altmodes/displayport.c      |  17 +-
 drivers/usb/typec/class.c                     |  43 +++
 drivers/usb/typec/tcpm/tcpm.c                 |  85 ++++-
 drivers/usb/typec/ucsi/displayport.c          |  32 +-
 drivers/usb/typec/ucsi/ucsi.c                 |   1 +
 include/dt-bindings/usb/pd.h                  | 311 +++++++++++++++++-
 include/linux/usb/pd_vdo.h                    |   7 +-
 include/linux/usb/typec.h                     |  12 +
 include/linux/usb/typec_altmode.h             |  10 +
 10 files changed, 509 insertions(+), 20 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

