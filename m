Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E49314A2A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 09:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhBIIVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 03:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhBIIVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:21:04 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32F5C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 00:20:24 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id lw17so1143987pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 00:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=596OWezZMkcevprA9Uk985roAtQRKWhP5585LyNlU4s=;
        b=KHoDvfwQ2Nh5+4EwcSLaEdbAqt2rgSuCLdS4zBR/oV5ez7/s4tXXs2DKbGwBzecgAa
         nyKvmVQESgvFlG2w/Nz3sdFRCYIQ+/X2lcJfjf37UYVGmDVIPN/BhIO9nW/pjLuJoBbO
         P3jFWuvGp/vDqIKrlXHE0Fb4BPOByrpcynDrcqhpJDWh+fvmcuzjj0EzLE2O0F8nc0sF
         g3Y1lLoNZ6oWsQutM3D5bigYJ1KFMQr54cA3vGWy/6CyW85Bvq0+lCJCVckS0OlAgTxz
         sDSxwLvyXBARH8jHs3Eo0/GeWUMgBrWX8qPftyItFQvMgOnG6ev+DfhMnv+h4X4U66X7
         WTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=596OWezZMkcevprA9Uk985roAtQRKWhP5585LyNlU4s=;
        b=Wpn7OD1hwTxfXrQYL46SXxRxukpBVAR/X9+pWSeHL6PIBScr4HPuTENNoeTCe51nu5
         Pr3QdC+aK5fGUnULwl/CUfWbrAlw0+CUGFe5DrBTvxgrF6odgUF+S/1WQekEvT00V/v3
         d9Ybs3FFgP3Lcsh82yE20OZS1vcSckn82lkPQQznxgA3DF7IunD6HA+T/C+DXYA35knf
         0t6d/a4tMWusYq/akiuZ7+/0GPA2vDqtzbdVrhTP0oTFTmqtBFiILuf00mKKSTDPUmOr
         o9EZBGF4Pr+/2tNJqAeCUxpdB3Dyy3sL/LNM8wSKT6cpZ0rTTnfAdu72NKBrkmYi5SHi
         HTeA==
X-Gm-Message-State: AOAM5332A2t01ClKoXXa6X+Jb2FYKwv0BN+RpmKB9NAxrnaf5DNNEkNB
        CUzz8BDPveY8tHPKPDCsNSA=
X-Google-Smtp-Source: ABdhPJxQyLnB5JUtmB7xe878gee/f22fA72SwYGW1vLnrEGUzCIilIC3R7AqlqktabSjpHS1pH50uA==
X-Received: by 2002:a17:90a:7025:: with SMTP id f34mr2951380pjk.116.1612858824327;
        Tue, 09 Feb 2021 00:20:24 -0800 (PST)
Received: from localhost.localdomain ([106.198.21.213])
        by smtp.gmail.com with ESMTPSA id y16sm22011002pfb.83.2021.02.09.00.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 00:20:23 -0800 (PST)
From:   Atul Gopinathan <leoatul12@gmail.com>
To:     mchehab+huawei@kernel.org
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Atul Gopinathan <leoatul12@gmail.com>
Subject: [PATCH v2 2/2] staging: hikey9xx: make phy_ops struct const
Date:   Tue,  9 Feb 2021 13:49:36 +0530
Message-Id: <20210209081935.3084-2-leoatul12@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210209081935.3084-1-leoatul12@gmail.com>
References: <20210209081935.3084-1-leoatul12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following type of checkpatch warning:
"WARNING: struct phy_ops should normally be const"

Signed-off-by: Atul Gopinathan <leoatul12@gmail.com>
---
 drivers/staging/hikey9xx/phy-hi3670-usb3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/phy-hi3670-usb3.c b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
index 8918f3665f8e..e7e579ce0302 100644
--- a/drivers/staging/hikey9xx/phy-hi3670-usb3.c
+++ b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
@@ -585,7 +585,7 @@ static int hi3670_phy_exit(struct phy *phy)
 	return ret;
 }
 
-static struct phy_ops hi3670_phy_ops = {
+static const struct phy_ops hi3670_phy_ops = {
 	.init		= hi3670_phy_init,
 	.exit		= hi3670_phy_exit,
 	.owner		= THIS_MODULE,
-- 
2.27.0

