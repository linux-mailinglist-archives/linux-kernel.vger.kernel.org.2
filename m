Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A2F3770F7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 11:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhEHJgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 05:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhEHJgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 05:36:23 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2F5C061574;
        Sat,  8 May 2021 02:35:20 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id h20so6473457plr.4;
        Sat, 08 May 2021 02:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=FX/j0Ztt/gEytbCAzIAOMIA8c2STkFS60W5GrctADZ0=;
        b=aRtuQBkkgin36dLhQeDgkgypiyr77r245BIJf0c+m0dD5acphU65btaigq8MNf+DMe
         RWC3KVXuTIfJ8tN6wJ92UwDxmSScUGB2AFED3hCUoc0mD6CmKvtDqdFQ5vlcl/0cYjz/
         nN4loptDs4seeif1hHVCZ+HdjOnw8rWx1h10zSPRxeWY7XxkpY9dlOs2F3DiZtG7ou4o
         S6mZWOFgIudh2oK+PLw75IT7VrK+mj+m8MBBWqkI7qYNaVBGCYXpbmg6wxJdChoXUMlb
         sA8t/3G2xgIMpIUyYb0+i0Tjseh0lMrsQ8v/MUUtn3b6Qya+Ko0rBvG80ublRcdDNvfT
         6WVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FX/j0Ztt/gEytbCAzIAOMIA8c2STkFS60W5GrctADZ0=;
        b=iuqCtDvr1lNpyqfhlsZ0mWixtwF+e1S/R3f5oDPO1T4hsYYKKvMqXMKtsPoloOSsaZ
         1H88k6lVrmtBa11dPuA7fkHeLUR77DsFeu9RiF+mvNpw8FjWv3oOdx95Fsbm7VmPWNGL
         QCBC660G24WlkAso5TYj5SCOp8xt+fxGfmfldGBWYKG187Gs/02cOPMPnSaRJ4BgKfeN
         cRVdww1cUh0Ibw5O+jsrLtvPxr5JG7NP4vsraxMXGJe4OS0oVR+2DOMUiTmg/E4g/6NR
         X5c1O3igYXpV8gcSCqTyOAPJFD2zrfDVJt4iw5AkVJNslBKlzFGLKVWdMc4AJ5dBiD0N
         XIyQ==
X-Gm-Message-State: AOAM533VHQDgdVEM2+k7wE2kP5f8w7p7iLoDS2gPab2ZnPPlD4I6Vr67
        DvEXaaH+VWhenBpTeMqGHBU=
X-Google-Smtp-Source: ABdhPJw9x3lTLua9mbO5p8CUNLGtIVQZ7EM/1h8DQz3Ozf/SuovQ878t4AhVXB02CmjkgEhVw2heHg==
X-Received: by 2002:a17:90b:180c:: with SMTP id lw12mr15000169pjb.150.1620466519687;
        Sat, 08 May 2021 02:35:19 -0700 (PDT)
Received: from user ([2001:4490:4409:343e:147:9ab5:ff11:27f3])
        by smtp.gmail.com with ESMTPSA id q21sm6578315pfl.152.2021.05.08.02.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 02:35:19 -0700 (PDT)
Date:   Sat, 8 May 2021 15:05:12 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] usb: musb: Remove duplicate declaration of functions
Message-ID: <20210508093512.GA11194@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate declaration of below functions in musb_host.h
	musb_host_cleanup
	musb_host_tx
	musb_host_rx
	musb_root_disconnect

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/usb/musb/musb_host.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/musb/musb_host.h b/drivers/usb/musb/musb_host.h
index 32336571f05c..fe11645cf2b2 100644
--- a/drivers/usb/musb/musb_host.h
+++ b/drivers/usb/musb/musb_host.h
@@ -61,10 +61,6 @@ extern void musb_host_tx(struct musb *, u8);
 extern void musb_host_rx(struct musb *, u8);
 extern void musb_root_disconnect(struct musb *musb);
 extern void musb_host_free(struct musb *);
-extern void musb_host_cleanup(struct musb *);
-extern void musb_host_tx(struct musb *, u8);
-extern void musb_host_rx(struct musb *, u8);
-extern void musb_root_disconnect(struct musb *musb);
 extern void musb_host_resume_root_hub(struct musb *musb);
 extern void musb_host_poke_root_hub(struct musb *musb);
 extern int musb_port_suspend(struct musb *musb, bool do_suspend);
--
2.25.1

