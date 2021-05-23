Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FA138D828
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 03:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhEWCAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 22:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhEWCAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 22:00:37 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE43C06138A
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 18:59:11 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id u18-20020a05622a14d2b029022c2829ba03so367516qtx.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 18:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gkLitXCysUfPWd1vthRlHismljQQpCoyX2uioWTbGjo=;
        b=KjZuLOik6YzwXXxa1/EGmSJC68v+G+P4alXalcix6F2kB8rJTil1Qa1OY1SD6fA2A9
         YHgN0IwOakQ3mZ+1deUHzZG05SPQ8w1OdAcEog0BTVDPtECfM/Do6Yd+qi/M0LrD8vsv
         vOLXON93oX3l4pGDqvMBFWRJqXW/VRA1XFNzAQ1jdJFrcQJFnHapK1U3ihVLRsXOsZSX
         USXC7EwSA1y+FW7+Am2aoUUh9N8c0cXZtz8sove1zpo1df0ftsuCK9H5Gsqy87RynH9r
         QcUILM/HIp2IIbCRm1Q/s+P9Izl+mBCZcmdSJ+MNn10RY2HlA8LapBv58D51ZRv6aPsX
         EpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gkLitXCysUfPWd1vthRlHismljQQpCoyX2uioWTbGjo=;
        b=nrcZj7dvekvGAB0A8LBo34nxawKlDLgtVADGOs4Ow73g6FZ3OuBNNpAQN9ZJmMor2U
         ZeVbP5vrDQCJJfwIMuPM8Cgqt6e8MXYVJpMvbRzi0aRSCUeI9iGAU90qlRQoTCPvrN5U
         SFSyoRxljtMpZ1teq6NLqxi69wBfWn3WMhKMozSDgfGT6x7HLcnMBVANlVzr/TbESDQd
         b71IAyW2caFURUCX8EzqCc4CUEGnHQGBT7nKrKCMdkHhGuWEZb+0qDzi+uGKayHCEsVB
         QyzJ6plnCc/iqe5xxWFVCVj6m6kH5jvy2v/rDiw+pbNMFkj2HSsZtbSj1KbsWkKfgLkm
         WCrQ==
X-Gm-Message-State: AOAM530Sr8tnPC6xD9D0D6tWTxVmrEFoXGYfb7pgmAcEXUmk67JU30YO
        +K+xZoWvVt0wtnKg8vya7HBhGS6wKj/K
X-Google-Smtp-Source: ABdhPJxU6qBBICdn+ZuNNsyj44M2wrpMAmLYiIJ80G8W/9X4uKYj4Qnyq+6HybDfxKhjZ/tNXmzJy6uusDXt
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:7015:3f20:3a0c:ecc2])
 (user=kyletso job=sendgmr) by 2002:a05:6214:288:: with SMTP id
 l8mr21751315qvv.21.1621735150088; Sat, 22 May 2021 18:59:10 -0700 (PDT)
Date:   Sun, 23 May 2021 09:58:53 +0800
Message-Id: <20210523015855.1785484-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v2 0/2] Fix some VDM AMS handling
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
-----------------
usb: typec: tcpm: Properly interrupt VDM AMS
- fix the bug reported by "kernel test robot <lkp@intel.com>"
- add Reviewed-by: tag from Guenter

usb: typec: tcpm: Respond Not_Supported if no snk_vdo
- no changes in code
- add Reviewed-by: tag from Guenter

v1 cover letter:
----------------
usb: typec: tcpm: Properly interrupt VDM AMS                                                        
- If VDM AMS is interrupted by Messages other than VDM, the current VDM                             
  AMS should be finished before handling the just arrived request. I add                            
  intercept code in the beginning of the handler of the three types of                              
  requests (control/data/extended) to ensure that the AMS is finished                               
  first.                                                                                            
                                                                                                    
usb: typec: tcpm: Respond Not_Supported if no snk_vdo                                               
- The snk_vdo is for the responses to incoming VDM Discover Identity. If                            
  there is no data in snk_vdo, it means that the port doesn't even                                  
  support it. According to PD3 Spec "Table 6-64 Response to an incoming                             
  VDM", the port should send Not_Supported Message as the response. For                             
  PD2 cases, it is defined in PD2 Spec "Table 6-41 Applicability of                                 
  Structured VDM Commands - Note 3" that the port should "Ignore" the                               
  command.

Kyle Tso (2):
  usb: typec: tcpm: Properly interrupt VDM AMS
  usb: typec: tcpm: Respond Not_Supported if no snk_vdo

 drivers/usb/typec/tcpm/tcpm.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

-- 
2.31.1.818.g46aad6cb9e-goog

