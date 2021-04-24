Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C3D36A06D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbhDXJGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbhDXJEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D835C06134E
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x5so384906wrv.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B1aC/KYysf2u98efPHVNtXofbiGurQZJ94vgGaYPVJg=;
        b=IEpn+rUgo/JgvRuVTTWPxI8iRJ2UDFAkqucjjaT/kfQxpMuLPuBFa/mZkp6Aql6TUR
         7c/T45mAZ7YPwiHQB77KhzUOnPudzM5yhtTKTD67EEwVinbs1rL2l19bpnh4ZgYSzixs
         3iTLp2E8qodBog5v9b393jo7ZucU+hONm7008+/monL1M7RhBkB1K2sigzajCzkDb7uS
         HepQnKpz0CR2Vfi9i4iY2wQs8CSAscT19eFJGaQIZriqtu6KEj/3BOSxBwkA6Tn/pjAe
         dp/Gd8TOV1+PtZdiaMEKax6h5ZVn42TVkcEGEJy660q9G+fAd74VVOPDGg2VyXEYX4Yn
         zPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B1aC/KYysf2u98efPHVNtXofbiGurQZJ94vgGaYPVJg=;
        b=nXniuRvFInC1iy8kTe4SvCIK1BjbDwtS98nzEWE5p11xZhSNN7BixyYcG/82inoq9X
         OL+Yz37io+OxNWrrsIeK9jtz3aQtA9JuhFPkU/XRLQt8KXboNNMqEjxUylZJzbgDTBtR
         PA8mYG67CGGCxEK5y15mLU9tT18LDz9foo7T1yHgQOYaDnfgvsf/ajO4U1G4QggTD5rB
         GMIhDFfnhBgbmWk3jRXronhNqtZXysE82YLbHRXPJc+5CDrinprXZ0YZ/JBp5lo5oZB0
         pTUoYeUH8bC/+HDa2r/VBxq/XX8GB+kc5A97l66J7AyAtE5IE2xU9AC8nYF2azRUgFb4
         fq4Q==
X-Gm-Message-State: AOAM532S9X4k7N0IlXztVUTY4kL3fcOQnPWBJnp63jy8RESbGmlyQYU3
        qDIU/O7lWfxTFrE+dxlcMahB1jzfff6g3A==
X-Google-Smtp-Source: ABdhPJyrXMWqG4Zvj0jQ/tYhT9XOh+t/a+VU1Ie6ZHv4OBTaq7GECNDzydjhTYtIux1x+NKpz6SWWg==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr9853223wrs.7.1619255031081;
        Sat, 24 Apr 2021 02:03:51 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id t206sm10198617wmb.11.2021.04.24.02.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:50 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 45/50] staging: rtl8723bs: remove commented out macro definition
Date:   Sat, 24 Apr 2021 11:02:28 +0200
Message-Id: <2b56922e8e4c5fde6e594a9bbeb888bf7717015d.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented out debug macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 1a52200e525c..cde4b1d6a4b7 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-/* define _module_efuse_			BIT(27) */
 #define	_module_rtl8192c_xmit_c_ BIT(28)
 #define _module_hal_xmit_c_	BIT(28)
 #define _module_efuse_			BIT(29)
-- 
2.20.1

