Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A285309D6A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 16:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbhAaPUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 10:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhAaPTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 10:19:36 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD86FC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 07:18:55 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id s17so9606009pgv.14
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 07:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=pWaLe0rxHbHoPOLQnEvoezPzhzm6i0a3yIHNzO6Spxk=;
        b=mDzEma259JaxNYPUJkK9uxCS0LAAZ9LXdKSP3LVU12Vi8V7H6sp0T7rSJv7hryYsJG
         rwNH94ZeWqUo9blERZI9sZBbyOvPMsCJTLmWAq0TB10TvkpQgpS1do0PXiaAdObX3uh0
         ykGTav9EiPmQRgEjySssbVR/VdXnw1pKv6y7Xi/OMrCRQaep1RAqszstj7zrcImUntBk
         oXVqIHptfuWhlTCm3FDLebHEXCRW5OCCA/ft8yTUUVT/1YO8J8n63MV9Kfc8SKIoB48e
         xQH/QJan5fT3xDlbTzKJr6jMTm/0lbBf4Qcc5p5GbM4wvqd/UDR7cvO70clPJa+pakTC
         SFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=pWaLe0rxHbHoPOLQnEvoezPzhzm6i0a3yIHNzO6Spxk=;
        b=csZ8+D+lvcB4MYySi/+PpX6LILmD7WfjStl+AKZ/zRRKk1wTd4lE+DOGsrL4lKzX18
         nFyybpKdMJzMOI58ZRKF4w3O/N1Em8cwy2+Zl+vrN7m8XRt2dDqSBv9YTDorEf3s5xVo
         JwJwJ/jNkHKc/6h7ir0APB2Y+fEOLNJNJMiPE4kEZ8ZczHy2wLfrwH4SST1fDupWojDy
         9+XBeTNo+tOfq2UQSd1S8kwLVzoUr6rs5kd9HMnulApiYUzmuhlaMTLUNrprGO3o5EH6
         nWy/kAzXzhwNcvxI7llzbbTOG/DiypMc3spsBzVIFRUHsWpBa1pcxLzmmmNzRXPf1P1J
         fSYg==
X-Gm-Message-State: AOAM532Na+6X+0hAcQhVDhpuHTgR/Jksp1KHGS1jdIUzPVQqji6KbzZ6
        xxBETLen5gEW94uO+yEp5R7bOyol/dW/
X-Google-Smtp-Source: ABdhPJywFKKoP2bv0t61mkd7QNeIMNNNaNVtp5gAUYkkOnYtoFhNJw0USKf/elBk7HmgEQqF2OBoi4neN7bE
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:5d70:9e45:7deb:72a7])
 (user=kyletso job=sendgmr) by 2002:a17:902:26a:b029:da:af47:77c7 with SMTP id
 97-20020a170902026ab02900daaf4777c7mr14027694plc.10.1612106335130; Sun, 31
 Jan 2021 07:18:55 -0800 (PST)
Date:   Sun, 31 Jan 2021 23:18:29 +0800
Message-Id: <20210131151832.215931-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 0/3] common SVDM version and VDO from dt
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

patch v1 is here:                                                               
https://lore.kernel.org/linux-devicetree/20210126084544.682641-1-kyletso@google.com/
                                                                                
Changes from v1:                                                                
=================                                                               
usb: typec: Determine common SVDM Versions                                      
- removed the "local" variables (svdm_version) in tcpm.c and                    
  (altmodes/ucsi)/displayport.c                                                 
- added a member "svdm_version" in struct typec_capabilities indicating         
  the default SVDM version of the port                                          
- added a member "common_svdm_ver" in struct typec_port indicating the          
  common SVDM version between the port and the partner                          
- implemented the get/set API of the common_svdm_ver in typec/class.c so        
  that clients can read/update the common SVDM version                          
- added more definitions of Product Type VDOs                                   
                                                                                
dt-bindings: connector: Add SVDM VDO properties                                 
- updated the dt-bindings documentations                                        
- added more definitions of Product Type VDOs                                   
                                                                                
usb: typec: tcpm: Get Sink VDO from fwnode                                      
- updated the commit message

Kyle Tso (3):
  usb: typec: Determine common SVDM Versions
  dt-bindings: connector: Add SVDM VDO properties
  usb: typec: tcpm: Get Sink VDO from fwnode

 .../bindings/connector/usb-connector.yaml     |  11 +
 drivers/usb/typec/altmodes/displayport.c      |   5 +-
 drivers/usb/typec/class.c                     |  21 +-
 drivers/usb/typec/tcpm/tcpm.c                 |  61 +++-
 drivers/usb/typec/ucsi/displayport.c          |  10 +-
 drivers/usb/typec/ucsi/ucsi.c                 |   2 +
 include/dt-bindings/usb/pd.h                  | 311 ++++++++++++++++-
 include/linux/usb/pd_vdo.h                    | 315 ++++++++++++++----
 include/linux/usb/typec.h                     |  10 +
 9 files changed, 656 insertions(+), 90 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

