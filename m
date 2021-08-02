Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0535B3DE1ED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhHBVw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhHBVw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:52:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731B2C06175F;
        Mon,  2 Aug 2021 14:52:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l18so23067763wrv.5;
        Mon, 02 Aug 2021 14:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=eDoAPGDEbsFfyX+R0VBDU7kfFHDQdI+lx7QTEMxsDzY=;
        b=iFFs17ngxRsfMIIwqEUA6YubX14D+6duum7bYyFftYJah2vgCAcsy/5D4lJO5H5J9s
         O8by1TvlQXhrIwqZKIWSQf6x4gWaHnYz/ZyIRai+isdNWbbD8vqH7fF0sVlzQmR2FJit
         TdZph/ugaXsABN9x0YujsKc1NKyRywP2IrvoIKBXcMoJFPgzYHml8hsTKcJYXM75mjrp
         Wh6AczDbUR2Wrk+Y+OsCrmoi9OKiWkhUk/aaq3XzIvOM6Z8qFKSEyfx2UAeGkycxHdVN
         MuDX+HCYFhXDpux6d34MPUY3QHcQgGtOWxDtj00RigWyziIwVvM4n37zaRemCUwMGQhN
         gdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=eDoAPGDEbsFfyX+R0VBDU7kfFHDQdI+lx7QTEMxsDzY=;
        b=d7JJBitaTBKHB3xUCyCk3zccXLdHh7G7eoJe2AFB5XGLtqNU+IjSUJPVFqsx+6ihi2
         96GJhuJuVZv7wWtNOOQbYo3VTfRmBPu7WrjuvRhSve34iid2E41t2JnnI1FzVLBEnwe/
         6HfdzxcWst2M91xsADxmJ3O5WemGuADfsymJhcSPSvBQChiM1s7RPN2t4j6mAZiF0Uok
         T9/WUrLd5KB7x9FwOK+YzQYWtWZc6uwEEgoyvd0NPgJvSvc6aeiABNn+Mu9dOiIvxVj0
         CJXEVyIIv3o8qNYO4NoOEFW4v+5RH3pq9iwOUbZlYBzQqw+qGncMNOBQYYSEY28yvTlH
         uBMQ==
X-Gm-Message-State: AOAM530Uowpm5Z62v7p/zTXOhDCynylNJMmzMnKXG38lNh2/n1xqF4O0
        AywIrazbdZIN39KhU6yQiBk=
X-Google-Smtp-Source: ABdhPJwvCQbRvDlr3KqFjqnkW0VabiAQTrHqlLAmLkWgkolMAnb/PcC2PPlNynsV0baQG5qmd/sq+Q==
X-Received: by 2002:adf:e90e:: with SMTP id f14mr19461799wrm.191.1627941136030;
        Mon, 02 Aug 2021 14:52:16 -0700 (PDT)
Received: from pc ([196.235.140.151])
        by smtp.gmail.com with ESMTPSA id l5sm14186292wrc.90.2021.08.02.14.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:52:15 -0700 (PDT)
Date:   Mon, 2 Aug 2021 22:52:12 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] usb: chipidea: get lock before calling
 usb_[disable|enable]_autosuspend()
Message-ID: <20210802215212.GA1350820@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the documentation of usb_[disable|enable]_autosuspend(), the
caller must hold udev's device lock.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/usb/chipidea/otg_fsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
index 6ed4b00dba96..2d4174250432 100644
--- a/drivers/usb/chipidea/otg_fsm.c
+++ b/drivers/usb/chipidea/otg_fsm.c
@@ -518,12 +518,14 @@ static void ci_otg_loc_sof(struct otg_fsm *fsm, int on)
 	if (!udev)
 		return;
 
+	usb_lock_device(udev);
 	if (on) {
 		usb_disable_autosuspend(udev);
 	} else {
 		pm_runtime_set_autosuspend_delay(&udev->dev, 0);
 		usb_enable_autosuspend(udev);
 	}
+	usb_unlock_device(udev);
 }
 
 /*
-- 
2.25.1

