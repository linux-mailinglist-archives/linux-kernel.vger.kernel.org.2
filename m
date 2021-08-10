Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50C63E86B9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbhHJXv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbhHJXvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:51:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C07C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:50:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f5so325236wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zmKg5cWLfDtvNzY5XeqvzfTrFB2tK46TS12T4izJ2U4=;
        b=YU6vMGyzdAW0zY//9R+zdy84wWj2rlcQlmnrxAFGLblTkt/MF/JEpEmhNaBHwuE0Xq
         bPUDHVdKZEABL2BES6koYjiCeztZ4GuvsbqlVky6Z4SXhU8Cg+RNnfKr6fWbalsv9x+7
         aNxZnbTxMv8BFPvMT23NhZyD/1VJWWhtMUgoyjwW0MPh6ayrocXwn3geZucThBtkaZiC
         fcU1nUldaHkGCXVPLKooo7awZWl0Qw1GNg6GelnGFHf2eXuqoQ4QGvwWEdl5aneDdOd2
         G5WIcM7He1a34d9nrgmnNRY3EQg0n//0+ifBj5xecFgbbUiuT1r+zkvmoY5oEn5xn7AL
         A0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zmKg5cWLfDtvNzY5XeqvzfTrFB2tK46TS12T4izJ2U4=;
        b=M4vd4mPDb3hHuQkSoWFAb85v84Yn9qttvbQUcdwhWpCDqTbL1OSYnsMeAYX7hP7pFq
         w0bQ6aa0DFiQnitQ5NNr3JK+M4/CJcEFmAqWzxGvkMjgqIXhJaJ5p/rgQl/xLjR7varb
         SYvaw0e/RbddAc0wexCcDKOOi1M1LN2nyb88qUk5Cs8x9H1cqrNFyYo0oWIiF23N19jG
         SkmEVRB0a+VoNZrcP5mn/HGHKwr7xqTkCbXrhAUw3qdf3Jgqre/G7HCu/M8A4W1k/eCT
         UL8kk4n6/VVKhDTV770jMWXG13gqa9UHJXx43SQiySXC1aCug3HnSw9lgjkD4AazsIsh
         KiZg==
X-Gm-Message-State: AOAM530IJhx3Ujdh29LbYWfPHjAUHVY6j0M873wN1Qh0dl8dt3XUVm2k
        nwSeqNV9CZgJufuSYSWfP7BnGA==
X-Google-Smtp-Source: ABdhPJy++88X6RefFjSFaTiHAugqJQyK54WiO5LmcuQi9pFNoQUK85w8BesRw4NmgX31jfOra6XCYw==
X-Received: by 2002:a05:6000:1106:: with SMTP id z6mr34105222wrw.296.1628639450642;
        Tue, 10 Aug 2021 16:50:50 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id p14sm13881220wro.3.2021.08.10.16.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 16:50:50 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] staging: r8188eu: remove unused oid_null_function function
Date:   Wed, 11 Aug 2021 00:50:41 +0100
Message-Id: <20210810235047.177883-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810235047.177883-1-phil@philpotter.co.uk>
References: <20210810235047.177883-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused oid_null_function function from include/rtw_ioctl.h

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/rtw_ioctl.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_ioctl.h b/drivers/staging/r8188eu/include/rtw_ioctl.h
index 7ebc52f008a0..a36bd7313755 100644
--- a/drivers/staging/r8188eu/include/rtw_ioctl.h
+++ b/drivers/staging/r8188eu/include/rtw_ioctl.h
@@ -76,12 +76,6 @@ struct oid_obj_priv {
 	int (*oidfuns)(struct oid_par_priv *poid_par_priv);
 };
 
-#if defined(_RTW_MP_IOCTL_C_)
-static int oid_null_function(struct oid_par_priv *poid_par_priv) {
-	return NDIS_STATUS_SUCCESS;
-}
-#endif
-
 extern struct iw_handler_def  rtw_handlers_def;
 
 int drv_query_info(struct  net_device *miniportadaptercontext, NDIS_OID oid,
-- 
2.31.1

