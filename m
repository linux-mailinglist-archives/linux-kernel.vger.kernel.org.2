Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D0640D197
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 04:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhIPCSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 22:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbhIPCSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 22:18:40 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA26C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 19:17:21 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id w7so4663635pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 19:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3/sjmsh9eakhfmy60Q2gVdlY6aMelP0NlPu9C4Ba02A=;
        b=jhgyEmp0JY6JQ+9cdCm2kjrpTUW6sww95NsHtIAUJbHUxRDy0SGUJcKbEQ0UxzvvfZ
         Oybqa5xZS4uqEz7bgRofvWRPZ5DM6xPsTZIs6BdtSUnQX8SAwCm6iHGuqjIxgAi76+49
         9LZCWOFYMx0IdFKX/o8GjgUYwnVxCZ1y7JGPu/Yx9Ls51EIvwISoURx7pVG21EHy/NLQ
         WndOxVRbB/FPW2WpMEc+XvFF7ubwg4B885MBjcTTniTErNYp2dPTJ1S/pPhiKE4ohvfz
         3hKXONx2hvw8hZ71d5xM9AMyXo20Ac15JFceLeI9a9pkZstjv9bTQUn9TO2wtGVthG8E
         7dXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3/sjmsh9eakhfmy60Q2gVdlY6aMelP0NlPu9C4Ba02A=;
        b=i+nE27I4/EkaLBEAfbAytv2S7MZUHD41TIkOsbXU0yxpkcr78F/eww7Br1sWKNjUpL
         +i71PBt449ARWh44nRfq7QCtmQaUviCYrRsZx1hL5KBOOQEvkH731Dx6Snbj7OAP99u5
         QIjBHGzOR5AZvbaw7AI2pKxvSu8lslbeeMG9HyIzUWlP8dl95NLflpCVhTo1hXOxD0e7
         kxrV6ymNKsDpGHQr5j/JnLvBdGl+DUHRzVVM9oNgplvKq+IMpA8nhi5mPovYnTyikO8x
         H6dCTGf4ee7rwWL3cKIw/je4gScjHyJDqz+cITAGKfPAnuayrFaFPhiJqf7R2ceMz5wh
         kBzA==
X-Gm-Message-State: AOAM531tHXl2dCkFHcpEzJ7ld6w3M+0FIy3MRB+cMackHg6DTHfg6hz8
        iacPGbfYmj+2lwi/hVNORE8=
X-Google-Smtp-Source: ABdhPJx5nBuRk/IfAa4RASH9hWpALmfnLPZZcqRytph9ZFziTyeWgiadKfsWUUxWUpQL8+qhzdcP0w==
X-Received: by 2002:a05:6a00:2284:b0:43d:fc72:e565 with SMTP id f4-20020a056a00228400b0043dfc72e565mr2622712pfe.84.1631758640683;
        Wed, 15 Sep 2021 19:17:20 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y3sm1180586pge.44.2021.09.15.19.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 19:17:20 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] staging: r8188eu: Use kzalloc() instead of kmalloc()+memset()
Date:   Thu, 16 Sep 2021 02:16:58 +0000
Message-Id: <20210916021658.181216-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

This place can use kzalloc() directly instead of calling kmalloc() then
memset(). Replace them.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 92b8f2c..9c257c4 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -463,11 +463,10 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
-			pwep = kmalloc(wep_total_len, GFP_KERNEL);
+			pwep = kzalloc(wep_total_len, GFP_KERNEL);
 			if (!pwep)
 				goto exit;
 
-			memset(pwep, 0, wep_total_len);
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
 			if (wep_key_len == 13) {
-- 
1.8.3.1


