Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA3D378DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349509AbhEJMti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241889AbhEJLi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:38:59 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D828C061760
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 04:35:34 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y32so13059594pga.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 04:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wz6rpD52zl7+K2dd5/t2p4HjFSdc/LeLXvqpvIZcQ0o=;
        b=FO5UemEJ8pI/qUHyw04cZVpQtVp809X+rOJesPIR7nHgpdBF9j2ShCgsIUXmJ0gywm
         ungucMQfC+hET1jcdLWDlGJxl/r8lDv1hVbyZYwxJJIB/Iokul2g2wJDKmV7nBberdVd
         wWarHx7vSqBwdzYR/ADYyBwPBm2ByzPN8jzGbD7jmOlAGGdz7oEv1BGCuJQ+C/5aJADE
         oOSvgvo1OCHgQ1XBVypUubHQlw31Q444kIwMYwrSf0Oadfkure3aAkmdEbgX+VWWikjv
         dRljc78O2W65JCUa/TTRu7q+2mGKzi6SMbef6Ws69n3h7xpm8aPsYz/vCLIg4/zzCVfN
         lMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wz6rpD52zl7+K2dd5/t2p4HjFSdc/LeLXvqpvIZcQ0o=;
        b=Wpjb3sdAJ6DvM2Oc3ua/4vJVMcpQzwBo+PeqXLVFj9HuAsCjDUP3gd7/ABiEUvNdkt
         zqA2pSqaY+KFKgAtesDoXoqW6vSZHYO3pzW5fYM3nu88FdqHZACaEZ7XaUxIKgeDhbPM
         N0WAJcBUmtyTL6uSC3J8VdYBYiBbbj8H0c6bM02l3tG5Fm3thrMPArOmT8FGQsR14Lvr
         slyr3l9yrAYNyN93XBN4PjIYrK9utlq05DJYR9YkfQrIDC+7kAMKlrwUmef3XRSdfiJ0
         v1+qpeFQSwPLYkEMRafgt+m2oDVjA2ZnSFT94R1jJFbKUR0DU17Ec0ciwyl5PneY0PT1
         Ku9w==
X-Gm-Message-State: AOAM530YhWZAE7dJ+hIvuq2VLHO4yWRBrzj6QwnXCvxe4vApOUFGTxFF
        kBIeErzPZeI1+2DyOfrtdvpEvts4ea7mKg==
X-Google-Smtp-Source: ABdhPJzOjpk+TLqHWwStu3zSfOXZM5YnCKB6nOfvr+ZOZw6gKWH4Lat2NceBqTMKIPVj7oeo0w4bjg==
X-Received: by 2002:a62:1a4b:0:b029:24e:ba53:aaa4 with SMTP id a72-20020a621a4b0000b029024eba53aaa4mr25149188pfa.63.1620646533827;
        Mon, 10 May 2021 04:35:33 -0700 (PDT)
Received: from ojas ([122.177.206.92])
        by smtp.gmail.com with ESMTPSA id x26sm11069542pfm.134.2021.05.10.04.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 04:35:33 -0700 (PDT)
Date:   Mon, 10 May 2021 17:05:24 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, ojaswin98@gmail.com,
        gregkh@linuxfoundation.org, atulgopinathan@gmail.com,
        yashsri421@gmail.com
Subject: [PATCH 3/3] staging: rtl8192e: Fix whitespace around conditional
 statement
Message-ID: <b25f07b14c7e1f0d70d54b8723f786e33ffeb77a.1620642396.git.ojaswin98@gmail.com>
References: <cover.1620642396.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1620642396.git.ojaswin98@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl warnings:

- WARNING: suspect code indent for conditional statements (8, 17)
  FILE: ./rtl8192e/rtl8192e/rtl_dm.c:1735:

- WARNING: Statements should start on a tabstop
  FILE: ./rtl8192e/rtl8192e/rtl_dm.c:1736:

Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index e340be3ebb97..3d5f9dc5882b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1733,7 +1733,7 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 			priv->bcurrent_turbo_EDCA = true;
 		}
 	} else {
-		 if (priv->bcurrent_turbo_EDCA) {
+		if (priv->bcurrent_turbo_EDCA) {
 			u8 tmp = AC0_BE;
 
 			priv->rtllib->SetHwRegHandler(dev, HW_VAR_AC_PARAM,
-- 
2.25.1

