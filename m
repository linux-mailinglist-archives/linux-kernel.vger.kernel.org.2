Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2527634474D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhCVOdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhCVOcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:32:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16ADC061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r12so21648485ejr.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L10f41YFPSYuLZ2Qn/bqjPBEJJpbB3QUZrKXGhgQjLM=;
        b=SsH5PpjaNiAR5wZ3sW4D3h0vSMAIljyr4ysm68wvsC74YowdUhSMbM3b9l+F0HvmBc
         7HqaBPFNF/khVg/luG3nn4rxKj8tkTwy7frZw/qAnWO8jcxz9oZSEScuWGZGYREn4bqI
         ZW5M28IQ6jygp14eBvbIQOt2d4U5sEg8XJuA+H0qqvtu/+t1ETuzqAaSk+oph4NAnxS8
         mZGjE7CUwVYyRlzjEjRdZooxA0A6duEQsvbDTZs4LZCB4hLUXtB99QTf4f1tm0+Jx/c0
         kqxfu+w0Hk08OqjB+8iIty9iYAJdkksC+tdGwtm4Hzm3cxD9Ki0/NM1W44CBRG1r9uyK
         0LJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L10f41YFPSYuLZ2Qn/bqjPBEJJpbB3QUZrKXGhgQjLM=;
        b=mrH/oG67Sd/iP2IxGPYmCxX87Lhxzw0Mg/GS0Lct5f3xAN23o/5TE6Z8fz3hSI+gAz
         1fDuG9SF4S/y2N982QpgOAaGs6TTTulPJ7a4Bwt9sjkYf55zX6B/elJ2jwiWnFCWFMrk
         nEJ/vEIeoy3W83O4Ynl1KZj9MjTLGv0c3YzJSPX895+7xNiprWXeJp1UP6bZaE68zr9h
         N4pFvVjCof2+B92xhvwbJkb/kZRMBUXlmuK39nSOWfeHwCk5ofVd15Ea/WdqiCHbOZSj
         2tj84ZLF+jOo0P92TQfDt66CpIoskztX0nj9WlE/FuNsqskSGvQJh5FC2+f3D7b9W/21
         twdw==
X-Gm-Message-State: AOAM5329afUeLgXyJc0yvF52pibYVSBRS6ss1kMRE35G2jVQX8e2/IFV
        cdByYm7+Nta4ixb7QO5JeM1XzEXx5EuNtw==
X-Google-Smtp-Source: ABdhPJwLX9eIrea6pppO4av3ofC1dO2zQ7JoOEF9bqD+/3Kzuv7hlpqINE1FQI2rGzomfOxXzTHmmQ==
X-Received: by 2002:a17:906:d94:: with SMTP id m20mr19171558eji.511.1616423552688;
        Mon, 22 Mar 2021 07:32:32 -0700 (PDT)
Received: from agape ([151.57.176.11])
        by smtp.gmail.com with ESMTPSA id bx2sm11728567edb.80.2021.03.22.07.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:32:32 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 09/11] staging: rtl8723bs: move function prototypes out of os_dep/int_fs.c
Date:   Mon, 22 Mar 2021 15:31:47 +0100
Message-Id: <9e1a40b86fb716d89bb12e5e3dfbe567a21fda6c.1616422773.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616422773.git.fabioaiuto83@gmail.com>
References: <cover.1616422773.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch issues:

WARNING: externs should be avoided in .c files
196: FILE: drivers/staging/rtl8723bs/os_dep/os_intfs.c:196:
+int _netdev_open(struct net_device *pnetdev);
--
WARNING: externs should be avoided in .c files
197: FILE: drivers/staging/rtl8723bs/os_dep/os_intfs.c:197:
+int netdev_open(struct net_device *pnetdev);

moved function prototypes in include/osdep_intf.h

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/osdep_intf.h | 3 +++
 drivers/staging/rtl8723bs/os_dep/os_intfs.c    | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/osdep_intf.h b/drivers/staging/rtl8723bs/include/osdep_intf.h
index 5ad85416c598..dc279ceb1469 100644
--- a/drivers/staging/rtl8723bs/include/osdep_intf.h
+++ b/drivers/staging/rtl8723bs/include/osdep_intf.h
@@ -69,4 +69,7 @@ void rtw_ndev_destructor(struct net_device *ndev);
 int rtw_suspend_common(struct adapter *padapter);
 int rtw_resume_common(struct adapter *padapter);
 
+int _netdev_open(struct net_device *pnetdev);
+int netdev_open(struct net_device *pnetdev);
+
 #endif	/* _OSDEP_INTF_H_ */
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 9ae7d46fb501..3713c62a477c 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -193,8 +193,6 @@ MODULE_PARM_DESC(rtw_tx_pwr_lmt_enable, "0:Disable, 1:Enable, 2: Depend on efuse
 module_param(rtw_tx_pwr_by_rate, int, 0644);
 MODULE_PARM_DESC(rtw_tx_pwr_by_rate, "0:Disable, 1:Enable, 2: Depend on efuse");
 
-int _netdev_open(struct net_device *pnetdev);
-int netdev_open(struct net_device *pnetdev);
 static int netdev_close(struct net_device *pnetdev);
 
 static void loadparam(struct adapter *padapter, struct net_device *pnetdev)
-- 
2.20.1

