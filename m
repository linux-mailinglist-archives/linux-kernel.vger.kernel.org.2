Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139B1359B81
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhDIKMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbhDIKEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:04:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C7FC0613EF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 03:01:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u17so7753675ejk.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ngUBXQ+i2ihUjkp8gUBGkSrTyqifWX3PDUJCypzPc0w=;
        b=Xbfqbt76xPH1FnU2D64FvAPPybhnDiLrEROlO6EXEQU0/oUxfczf4ycy2jtKCVF4SU
         SxWP4UT6xmXN+xOJHfC9NxMt5a6v3n9VEkjLcMmy6rU9YUxZayFG4ro//4jhXzrOmKAy
         SDSU/3DhRBAb+IiBC2tWyDZtKHxSAXE9rixn+LEkGgmtLNitTU2brIJTpaYMu148fmqS
         cAKrJBbPFcTtXlOkxP+WV3Inc2v0fnNW05GEGpVd2EpPRmvwOg/DHb7c8yYvVcY3b6IW
         7C5uVQdHH6E0fDlG8+lK3/X5fGyA4vOCeiDO42kAncWsG/KmN+hSAYz8c5b1ThyIC/V3
         Tigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ngUBXQ+i2ihUjkp8gUBGkSrTyqifWX3PDUJCypzPc0w=;
        b=H2WGVWH5T7WLe1la76acWrr02715KkgXgAT5RcgGL45rVIbzWaqIx8ZZ13APs35WnR
         oEkYQ+Ak3l0M+KOlD9RcpzU3ZWyWcsdNDEf8hw2hdHhRVYqeqEFKwe3nJA4c8+uPc/m8
         RYOsEBMRjDsjdLxEjkIdWKmNUacPcDGnFC4t8ghhiV6PpTCYEoc1wdLNGUywCW7uYh1v
         j4cfMCU6+jHLDLzogp6N8bcM95ieooc8uYH1N6nU8R/be/e8thTDa5NZ69HwW53JrzNL
         MKvPHu1C9HDfne5o79RyjrQAEWWkHQD4v/pvOCbTIk9HTG0tQjNbfZojONr5IIVeNY2t
         H2cg==
X-Gm-Message-State: AOAM532SYqaUQFRy/svyA1KxYYSgWf01ZxFKjTLp/qYbGsnIzxtTAkQQ
        YTcHLzfGSVASTfjwrHX55e8=
X-Google-Smtp-Source: ABdhPJxz+geRV3quPOam8q21bWpQTXEtg+WTnrNmL6afjLhtjGw9A5w3oXKQvYvsqGJvTt2Rs7qvjA==
X-Received: by 2002:a17:906:af13:: with SMTP id lx19mr5961318ejb.508.1617962510731;
        Fri, 09 Apr 2021 03:01:50 -0700 (PDT)
Received: from agape ([5.171.72.173])
        by smtp.gmail.com with ESMTPSA id f21sm1128688edq.55.2021.04.09.03.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 03:01:50 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 02/11] staging: rtl8723bs: remove unused variable and empty for cycles left unused in os_dep/ioctl_linux.c
Date:   Fri,  9 Apr 2021 12:01:30 +0200
Message-Id: <fb1e8ea3cfeda1af27ab1a9393140e144b5cb4b5.1617962215.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617962215.git.fabioaiuto83@gmail.com>
References: <cover.1617962215.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following kernel test robot warnings:

drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2573:33:
warning: variable ‘preorder_ctrl’ set but
	not used [-Wunused-but-set-variable]
       struct recv_reorder_ctrl *preorder_ctrl;
                                 ^~~~~~~~~~~~~
remove also empty for cycle left unused and counter variable.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index a9820d813d8b..303a236fe8e6 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2568,9 +2568,8 @@ static int rtw_dbg_port(struct net_device *dev,
 					break;
 				case 0x09:
 					{
-						int i, j;
+						int i;
 						struct list_head	*plist, *phead;
-						struct recv_reorder_ctrl *preorder_ctrl;
 
 						spin_lock_bh(&pstapriv->sta_hash_lock);
 
@@ -2582,10 +2581,6 @@ static int rtw_dbg_port(struct net_device *dev,
 								psta = container_of(plist, struct sta_info, hash_list);
 
 								plist = get_next(plist);
-
-								if (extra_arg == psta->aid)
-									for (j = 0; j < 16; j++)
-										preorder_ctrl = &psta->recvreorder_ctrl[j];
 							}
 						}
 
-- 
2.20.1

