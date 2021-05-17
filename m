Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB1B386BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244509AbhEQUx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237148AbhEQUxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621284757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=76uFxF6tDNi0nKdQA2asyMgYE2LMBW+B8Yl0fD6nlcE=;
        b=fyRIuh3ahTn8oEy2UVj5RbaNGk7vDmjuf6i6L/EqKbO2p1WrHMVBmzXF/AN6KD88GXstDn
        TXS9ARz48cT6SCGhTmW7sqTeD8fK7vF7UIcztrsMCpfq055P1wqebBIgZ5lggmamG3v0Gh
        nHD/lnv+CENoZBBqxpULC2UqH6/Lux4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-q9LCuA6uPKm67tcXZ5D3NQ-1; Mon, 17 May 2021 16:52:36 -0400
X-MC-Unique: q9LCuA6uPKm67tcXZ5D3NQ-1
Received: by mail-qt1-f199.google.com with SMTP id j12-20020ac8550c0000b02901dae492d1f2so6097799qtq.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=76uFxF6tDNi0nKdQA2asyMgYE2LMBW+B8Yl0fD6nlcE=;
        b=YLDUvTmIYGUgnUZu9U1Yc5mTT8DCKwT2JiQzTI3gFYBNpiPtrgZ0j+1lP+Yd1gKWQK
         A2JnmqV2MQbUNRAQTOOVSNdymOmegbL7iEAOX4lVtM4vvyOPkFjGBTz04EOGlMsknSYO
         u9DDqF3ra45S1uFx0pyh6lhaUCutURDwbz6q5KRrV+ItgyERCVA5pYVx+369+y0OQRSY
         VvNDGSwOM4gL9kciELM2gs9rcH6SHnItnNW+R6ytw8wLKwZ2wnQMKDiZtQ9xmGK33x7r
         stSodsUBH/kGGFnTlpTxldq14dDGJaarhoT+R0sEaG/BuAMRpgp0CsXeNYV1WPRTy1Oa
         R6Kg==
X-Gm-Message-State: AOAM532vaSjaUYSvOLy87R2w6nJ4tpMUQ2tqLZMcoZYuu6W+GihXRqhk
        lbaoHfCeqlaqSoNMi8QzlRSL0PqU7Jq4ex/Si9iYJ0GzQGLEDfjeRO/BISwt/k6ZPwD0KpyCcld
        33pKTxg1XrkZUt7XJveDgn3L/
X-Received: by 2002:a05:6214:6f1:: with SMTP id bk17mr1774860qvb.37.1621284755704;
        Mon, 17 May 2021 13:52:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxS9/fVzT+mCCgEItgc7xkN4bp5oRWkMsPDBBsnWCAFRzegq9r1DPFcBWA1wUkCG1o1cJ77sA==
X-Received: by 2002:a05:6214:6f1:: with SMTP id bk17mr1774849qvb.37.1621284755564;
        Mon, 17 May 2021 13:52:35 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t11sm11341683qkm.123.2021.05.17.13.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 13:52:35 -0700 (PDT)
From:   trix@redhat.com
To:     gregkh@linuxfoundation.org, masahiroy@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] USB: select WWAN_CORE for USB_WDM
Date:   Mon, 17 May 2021 13:52:31 -0700
Message-Id: <20210517205231.1850314-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Link is failing with
cdc-wdm.c: undefined reference to `wwan_port_get_drvdata'

Add a select of WWAN_CORE to USB_WDM configury similar to
what is done for drivers/net/mhi_wwan_ctrl.c

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/usb/class/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/class/Kconfig b/drivers/usb/class/Kconfig
index d3f5162bd67ef..e5714fddf1642 100644
--- a/drivers/usb/class/Kconfig
+++ b/drivers/usb/class/Kconfig
@@ -30,6 +30,7 @@ config USB_PRINTER
 
 config USB_WDM
 	tristate "USB Wireless Device Management support"
+	select WWAN_CORE
 	help
 	  This driver supports the WMC Device Management functionality
 	  of cell phones compliant to the CDC WMC specification. You can use
-- 
2.26.3

