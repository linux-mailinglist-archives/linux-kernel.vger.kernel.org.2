Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45759397344
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 14:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhFAMdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 08:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbhFAMdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 08:33:43 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1AEC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 05:32:02 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 124-20020a6306820000b029021ff5a7c55dso4414740pgg.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 05:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=drCxOP/I1jA8Da+u3+2uzmod+ICaJYsNyklqlTlDlts=;
        b=FNyV5XI1bh2DPOxM8gS5lGhx04YcgDbs+qowxZeG9gLmoJzrp8W972bOSjU30fQcK3
         b6Q1Fnx2znwIrtdb0Y1yLiVg4/rf++rgcxPAInsJ9yirtAHBM2pHsEHdGorJdy3xtUSR
         tiyenVRaihJ13NYt+xEDfw9qzPOtr0jrQhduqdiIYHBPC5gGTqjnhg/maz1Za8ywqML7
         a+VsRT+hWwsXxBk4wv3F5K3qOhu6hjLikePbtRdAZQsaXc6224F807XBBJlzrxDa0FU4
         nfyzSdTqR9lCyVGR8LSlo6iuCQ1dGc+qIthkNdoYZJ57/649/HB/9/I6rQ0ZMJOKetDE
         rvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=drCxOP/I1jA8Da+u3+2uzmod+ICaJYsNyklqlTlDlts=;
        b=lbXfSlG15hcGHA8XoliRMrFjBUMeLiIGNkeQue8WkrEYkaR8VZo3UPcU4QPedyVqov
         dxQ785Hcy35bHXW4rop9IShtgamoEUCQOrWbloNKF/A0wLCBX8gX/HUBZOrV/YrGgqnH
         HmYwwfDVz7SaH8TrdKchMbtumesnZ4gvk+XwjtMo7dy4M2xXXiHRN++GCzkupG0F6owi
         5vx9us6dSQEUOOH1fhAxC92s3/T3DkBcDx+05aLkWdhziVsmb59kF4hx1sRcXWPtm0vo
         hd0Zug20XuiOJ5oRDzOfbR0Tx83+jvd0D7BU8qX9NGpOXa8YEAQVEV4agclfKno1sKL5
         1CFQ==
X-Gm-Message-State: AOAM531vEQrojqZ0NkUyn9Cft075ftGI6kp7OCDYZVEMmV5q7aADCXXa
        +g9tkvKosgj/3m8TkIxg+WDrWhpGcD7/
X-Google-Smtp-Source: ABdhPJw9vm9PUDRmbhrY1Kx2POtAWlrjJLJAOOyehLnE59JDtED2G5evbB0yBV1fZG1RVvfkF0ttQqU+0/qC
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:c9e8:9a17:9774:bcd3])
 (user=kyletso job=sendgmr) by 2002:a17:902:bc46:b029:106:c097:88bd with SMTP
 id t6-20020a170902bc46b0290106c09788bdmr6202603plz.81.1622550721904; Tue, 01
 Jun 2021 05:32:01 -0700 (PDT)
Date:   Tue,  1 Jun 2021 20:31:47 +0800
Message-Id: <20210601123151.3441914-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v3 0/4] Add the support of SVDM Version 2.0 VDOs
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a patch on top of the v2 patches. They are not related but I put
them together to avoid the conflict. No change in v2 patches.

usb: typec: tcpm: Fix misuses of AMS invocation
- This patch is to fix the misuse of tcpm_ams_start in tcpm_pd_svdm.

=== v2 cover letter

Got the Ack by Heikki so I re-examined the patches and found a *stupid*
bug in the patch "usb: typec: tcpm: Introduce snk_vdo_v1 for SVDM
version 1.0" that I separate the "for loop" into two parts, which is not
only necessary but also redundant.

Changes since v1:
usb: typec: tcpm: Correct the responses in SVDM Version 2.0 DFP
- no code change
- add Acked-by tag

dt-bindings: connector: Add PD rev 2.0 VDO definition
- no code change

usb: typec: tcpm: Introduce snk_vdo_v1 for SVDM version 1.0
- merge the assignment to array element 1 into the for loop. No semantic
  code logic change.
- add Acked-by tag


=== v1 cover letter

The patches are primarily for the responses to the Discover Identity
command. This part was changed a lot from PD rev2.0 to PD rev3.0 (now
it's rev3.1 :D). e.g. DFP can respond to Discover Identity command with
ACK in PD rev3.x and the Product Type VDOs are quite different. Given
that tcpm.c moved on to PD rev3.x and PD rev2.0 is still supported, some
changes need to be made to support both PD rev3.x and rev2.0.

usb: typec: tcpm: Correct the responses in SVDM Version 2.0 DFP
- This patch is to unblock the responder ACK to Discover Identity if the
  port is DFP and the SVDM version is 2.0

dt-bindings: connector: Add PD rev 2.0 VDO definition
- similar changes to Commit 2a1673f0f1de ("usb: pd: Reland VDO
  definitions of PD2.0")
  https://lore.kernel.org/linux-usb/20210204005036.1555294-1-kyletso@google.com/
- add a new property sink-vdos-v1 to store the PD rev2.0 VDOs

usb: typec: tcpm: Introduce snk_vdo_v1 for SVDM version 1.0
- populate the legacy VDOs from fwnode
- send these data if the port partner is SVDM Version 1.0

===

Kyle Tso (4):
  usb: typec: tcpm: Correct the responses in SVDM Version 2.0 DFP
  dt-bindings: connector: Add PD rev 2.0 VDO definition
  usb: typec: tcpm: Introduce snk_vdo_v1 for SVDM version 1.0
  usb: typec: tcpm: Fix misuses of AMS invocation

 .../bindings/connector/usb-connector.yaml     | 15 ++++
 drivers/usb/typec/tcpm/tcpm.c                 | 63 +++++++++++------
 include/dt-bindings/usb/pd.h                  | 69 ++++++++++++++++++-
 3 files changed, 123 insertions(+), 24 deletions(-)

-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

