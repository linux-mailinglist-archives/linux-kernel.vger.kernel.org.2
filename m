Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7793A33D79A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbhCPPdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238059AbhCPPdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:33:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B329DC061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:33:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso1706938wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oJWAVqxGMjHMFdENUlaqR+GUs9koSOvHosCFoEJ2b9Y=;
        b=DDnOft4AONKTvCp72MmHeurGgLkQ5QPNI7Px8jvJKtu2gnzNN+4+NRsAyio8ZMu2SR
         QFWqiqk57Dh6HxfloA6WyG0NuCECMToFIuGztBLAyIe1VdgOlA9FSf1Uo4zyWm3glDwD
         lRWGVX4a2JMhW+AguiGrDVdFDeMpmkmzDW8B+QiJL08KLYJcjIgrvlDMMQ6bFG9ym6ry
         bixeYX7Q3h8DsCpoqGa8h/DeVqGM2pnXff6vwcTaeZ1wgxF8SUrVmTNNWYrlPcmlj9+e
         CkTNhrEwBrgMjquOPKCKufoCZbVGUvITM8AMFx/0coA6GXyn8qSCsO4/spSIqXENDhz5
         bE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oJWAVqxGMjHMFdENUlaqR+GUs9koSOvHosCFoEJ2b9Y=;
        b=jFadNSmSYSuBA8quZy3GqYDuBjrKvP3FOpDwKDyJPHTjxjr1v6dyC1PXBet5hFjHXV
         qDnn7DLp2SUEJbFcl0q7NRMk7fzRW4YG3DSzO40jCB4r5HUPChgl5zwCL0ItpgHoBm+O
         gK+3kd0rEe/SK0d7iW3HiQFPSthCOutUZ92T3zAmBWPJe95O85GVqHHNHjPg+jUR56P8
         w3ddSUC8GRa5LQkOM55021flLgVJGpzfogcwyq/oXNTwi42PMOJJEW3mMfkOFS6NDV0b
         WF+XmMdZb6EpGSMyP6pOJotSLdwXlh8Diz0dvC0FBjTWMRDVdt4pSiu+n1tLUbztGzwQ
         7AiQ==
X-Gm-Message-State: AOAM531OZ+5kwXio1LyPon4DUI00JnZIFaXhzJ3QmMNxryQcYH26KhpZ
        /tXG1TR/Xg3dsa0kVd/OUMI=
X-Google-Smtp-Source: ABdhPJxluN9D9kHW8U6CoBmwKy3bve+Pe6x1Xzoe0dFtFayn5GMIDfP/91/5acMbRohz3zccDppHmg==
X-Received: by 2002:a1c:7fc9:: with SMTP id a192mr203454wmd.15.1615908783497;
        Tue, 16 Mar 2021 08:33:03 -0700 (PDT)
Received: from agape.jhs ([5.171.72.71])
        by smtp.gmail.com with ESMTPSA id h25sm3949902wml.32.2021.03.16.08.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:33:03 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:33:00 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_R871X_TEST
Message-ID: <108837d49bfc158ba9ffa21a06c31a9a0e7fba97.1615907632.git.fabioaiuto83@gmail.com>
References: <cover.1615907632.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615907632.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused
CONFIG_R871X_TEST

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/osdep_intf.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/osdep_intf.h b/drivers/staging/rtl8723bs/include/osdep_intf.h
index aa4337686183..5ad85416c598 100644
--- a/drivers/staging/rtl8723bs/include/osdep_intf.h
+++ b/drivers/staging/rtl8723bs/include/osdep_intf.h
@@ -35,12 +35,6 @@ The protection mechanism is through the pending queue.
 	struct mutex ioctl_mutex;
 };
 
-
-#ifdef CONFIG_R871X_TEST
-int rtw_start_pseudo_adhoc(struct adapter *padapter);
-int rtw_stop_pseudo_adhoc(struct adapter *padapter);
-#endif
-
 struct dvobj_priv *devobj_init(void);
 void devobj_deinit(struct dvobj_priv *pdvobj);
 
-- 
2.20.1

