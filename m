Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB96410DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 01:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhISX5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 19:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbhISXzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 19:55:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671A7C0613C1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h17so54024321edj.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktm/yZReSCWv5NkITk4sdfOLi4wFSyG0BAFOLT+GU08=;
        b=jqEAaMbueBa5q2pHXR8mOKvhRYDzEd2LCXE8BC7IGCmq8YJPiGF0BI8eQ2Y6N5i/xa
         A2Fn2u56IgDpeRq3WhbbXouRmsRmNWtLErvsqcisiv38NQqLntCoNKOu7aXh9E6oEBah
         Zw+SJMKPep48x1hbXc+VAFs07pWCvmepIvBcA2zgkOhhLXMgED//0bE+q2q7X92noDRH
         giyQXOjl+DM+Zpkk5SciSSj9Xv12DrbD1mTqbdzN6bJzlv9yrZkJsBg/1PDS/LCzXxKH
         LQAKx3ScQE7jCVqJWujYCMP9O0Wfbju+RGcpEKbWkzS0HkmHYWDet/8RiDeEgCXZMOii
         mXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktm/yZReSCWv5NkITk4sdfOLi4wFSyG0BAFOLT+GU08=;
        b=vdLCkvasGjREPURzjWcFKtChS6qV0AmI09SJyk2dKJsyDcm5sBHt/reNrNyc9Cizgh
         j55g5rdbdw38lWucilOlCSLwtjaxLDzs5j+LoONsIlwJyGHuk6vi6YltFAAvBE9sxe4O
         52F+kQCLqOdG+UQgS/0nE0YKDe03x2iFVUjH/YXVzEVKde4L5KZ5Ev6Vvc3SEECtZEkx
         z0mmDXxz1Y0ULp77S9SQJ+DVyDwFRTCVgqlzPypxBo49h01Up/3IgDGLUpETvfjPevFp
         930WGXhFk4h2cOgcG7UX08Da8YrCO0exVjRHiIt0kRE7MbCXf82OM0sUugy9egtzqiSj
         YG9w==
X-Gm-Message-State: AOAM530AMM8z0e0Buk8bD7l8dOPKvkzwSMJKAIFEkX7w+0atsZHd1IbD
        IqlOlSq3zsDxe6LYgL1vnnI=
X-Google-Smtp-Source: ABdhPJwtlVJRCgnubUXnFE8+omzMaTh9OHMdLkAk0NXqbO9fjJgUpspRD53oGCgnstA1mrsDxTQ6Xw==
X-Received: by 2002:aa7:d5c3:: with SMTP id d3mr26119351eds.151.1632095654060;
        Sun, 19 Sep 2021 16:54:14 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id e11sm5353636ejm.41.2021.09.19.16.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 16:54:13 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v8 09/19] staging: r8188eu: remove unnecessary braces in usbctrl_vendorreq()
Date:   Mon, 20 Sep 2021 01:53:46 +0200
Message-Id: <20210919235356.4151-10-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919235356.4151-1-fmdefrancesco@gmail.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary braces in usbctrl_vendorreq().

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 3ca2959f4bcd..a270cb4249b5 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -72,9 +72,8 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
 			} else {
 				/* status != len && status >= 0 */
 				if (status > 0) {
-					if (requesttype == REALTEK_USB_VENQT_READ) {
+					if (requesttype == REALTEK_USB_VENQT_READ)
 						memcpy(data, io_buf,  len);
-					}
 				}
 			}
 
-- 
2.33.0

