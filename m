Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B919134B79A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhC0OZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 10:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhC0OZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 10:25:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E23AC0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c8so8355467wrq.11
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WjJIP2mmOfuCNKbmP73PxrS477KUtYuiPk1joF4xAYA=;
        b=snLP2RnS+6FUfcvDLGrEENeHji9M6ibXacSDsWLc5IBbPW6RCxxK1Ap1LcxAZMVjWa
         11RqN6Cms97py7XO8yXbrLnd2H1cLqcItjNd1v4eNyubSVLqBPqPFbWPLNb1vlXtow8m
         GvDqDrHTBJZKI9KBimw+xsABkLGYLuEUONqwSU0SBoY07JSqvP9yEhsfaIusXCkvwBSC
         or4kWje6+lS0Ot1OOxOBIPmHWgOwx0xg7a40dH7odg6dpH0AlHwXbzEhSIMT+ZD16IoR
         x1+pSODmqsWyOJFJTdeX3ORZPg4jVm5thyq9bX1UjlsmN8O3Y10O7TgFeX73fdULEHST
         i68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WjJIP2mmOfuCNKbmP73PxrS477KUtYuiPk1joF4xAYA=;
        b=iD3dljVEnTTkDahRcJklonvfzW96dmUHdB7qdOtKD7kpjXQJD1oKsW8k78KvvFdJQJ
         hiG4HrA4zzal+xc2Kbv2SvZytt4Y/bYZC4P+cCk8pcB7hlXHXcgK6Y57DReVpWEiZZ2y
         QNy9VIAeVGd3Exkx8dkulpSR8f6b8hl+roboU1QcutxDcXw0ysIdOjCn8gJitbSVGgRr
         66LutgnmNvWlEL3dly4WZUEgCBwILkomnNFRtmO5zqV+apghaKim3Kc2MANr13WKWCZ7
         NjWsoxDf5Ws0qlUXSqT8Ovdn+WUHc18c/PQ943ZOq0xZs2+xKdE1o7QAHBs9XHUk6Kxe
         mM5Q==
X-Gm-Message-State: AOAM531yQdNIC3NDVkKq6y+D4AOLed79HBJRvQ3tGUPj+Vr3vkEQLSZN
        +YYWiqZbICxBZeX8ejeYKjs=
X-Google-Smtp-Source: ABdhPJwZkVeWI3myA8nHPwVLzD4EHHtxvJdJLDCzpPcyEXnTOusg5ZRaEkyIUTexSLU/1L8x5iISvA==
X-Received: by 2002:adf:f908:: with SMTP id b8mr19095662wrr.184.1616855106844;
        Sat, 27 Mar 2021 07:25:06 -0700 (PDT)
Received: from agape ([151.46.211.242])
        by smtp.gmail.com with ESMTPSA id j14sm18687830wrw.69.2021.03.27.07.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 07:25:06 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 12/20] staging: rtl8723bs: remove commented code line in os_dep/ioctl_linux.c
Date:   Sat, 27 Mar 2021 15:24:11 +0100
Message-Id: <ed9cab77a9a7dc1bcae4b6a42e16108e7833ac4b.1616854134.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616854134.git.fabioaiuto83@gmail.com>
References: <cover.1616854134.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented code line using obsolete definitions

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index eac98e455413..354441e6a667 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2618,7 +2618,6 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 		rtw_free_network_queue(padapter, true);
 
 		/*  the interface is being "disabled", we can do deeper IPS */
-		/* rereg_priv->old_ips_mode = rtw_get_ips_mode_req(&padapter->pwrctrlpriv); */
 		/* rtw_ips_mode_req(&padapter->pwrctrlpriv, IPS_NORMAL); */
 	}
 exit:
-- 
2.20.1

