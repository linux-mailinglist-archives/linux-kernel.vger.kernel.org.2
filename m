Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF30359B92
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbhDIKNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbhDIKE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:04:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5029CC0613B0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 03:02:00 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a7so7763061eju.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 03:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qyN5LFR2nEodijnWpjK7DR8Nq7Cto+oql9ELFRPhWbo=;
        b=Ea9Gp1FLIBBtrlA/horz3pR12EPmSpmpIO0zpXekNYcqh4Bsr1KgsTF+Z8DzwGipZw
         nSXDau9NS7lRrYb2kYwaNM3vTO6cHxwoRXiYXYPUTNkpPnnlvguwB+8VjF7r3u7aWo+u
         PHt4mqhgw/4g4PiGyfVbh5LLwUqxolnuJUarluR2RtMbvSCI38FwTfAcK1PpDQ36RvNP
         n4pXGeWrk3FBgdDDeB/ojTfcVXvY+52WrhX+DyPy3HzVAWjvD5ibVwyLiqRbVjV6aEp0
         Dam4Gn+GIVVSOi/ARDZCqgNERuxw8JeWJpMG420wvYlmiTjD+za1j79WCSiF4TneTwFx
         StiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qyN5LFR2nEodijnWpjK7DR8Nq7Cto+oql9ELFRPhWbo=;
        b=lR5pZMHlKbhh4iKzSdQNwVPfsSCN1V9fKeByvnJDHJ8bqtnBVyBkf9brhS2Zb42NP8
         DZNVrCbbngCYn3XFLkbgUk0pxmNGgknqetkTA0yM5DQuLit9RCcegcj9FmlHTacWgwSG
         AHQEg71Wv6495VVQ8fMNmiV3GrGTeZUZLptVsNdR5DxCaTxFeK33zaTKPhFBKriKg2ba
         WlGEUTN2K0oml2azMvWHh2KI0QLBz27FQR9Ntgx3qCZowMljZMPi2o4BqfRKiB3d0MEn
         k6ouX5Jbvb12DRSSdOTW2k0ssn5IZYSafJ51pWLsZADoGD9pV4oqj+wcPYVxlLFcccCV
         LzAQ==
X-Gm-Message-State: AOAM5312OibuK58olDhJASbvw2JTMJtL7lC9HmExAhjF4eEjws85AQnT
        XLjZKYFTXEbMdzBnMr3VgSE=
X-Google-Smtp-Source: ABdhPJzUMNKm2oAb+WWYPjFI/2w+e81ENH2PvTYBxJ3SSc7nhFel0qAYAGYKvzabA3wjgi+fZQH0DQ==
X-Received: by 2002:a17:906:148a:: with SMTP id x10mr15573555ejc.92.1617962519091;
        Fri, 09 Apr 2021 03:01:59 -0700 (PDT)
Received: from agape ([5.171.72.173])
        by smtp.gmail.com with ESMTPSA id hd8sm962405ejc.92.2021.04.09.03.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 03:01:58 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 07/11] staging: rtl8723bs: remove unused cur_network variable in rtw_dbg_port() in os_dep/ioctl_linux.c
Date:   Fri,  9 Apr 2021 12:01:35 +0200
Message-Id: <6aed13408f912b6c36a19a5e91e17b1126fc6247.1617962215.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617962215.git.fabioaiuto83@gmail.com>
References: <cover.1617962215.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused variable. Fix W=1 compiler warning:

drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:
In function ‘rtw_dbg_port’:
drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2447:23:
warning: unused variable ‘cur_network’ [-Wunused-variable]
  struct wlan_network *cur_network = &(pmlmepriv->cur_network);

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index ae74623bf1a1..2f215e5e28b0 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2444,7 +2444,6 @@ static int rtw_dbg_port(struct net_device *dev,
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_network *cur_network = &(pmlmepriv->cur_network);
 
 	pdata = (u32 *)&wrqu->data;
 
-- 
2.20.1

