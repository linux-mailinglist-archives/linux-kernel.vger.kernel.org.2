Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA29D3A72EB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhFOATl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:19:41 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:46939 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhFOAT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:19:27 -0400
Received: by mail-qk1-f178.google.com with SMTP id f70so25101513qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=otZvd52HgbyL3fi1OkvvEviekwVNI9M+TtY2lQEoSdI=;
        b=srFWfh1cArrRbPRwJGzPbOB3pkZRAHirYSCmGCggQiMl9pgTOuIE0tCNslOp6fq9eo
         e8T6n8+Ck6WmK1vxAwOfRbWNTLtt4APiyiWzKpanBHtS0K4CqMRTlp+pyQLktMEX8sY2
         yxxkwONlNUA44r/8X+/rLSiFTEx89FTrr2nnxNTxmmwoDzs4vIPyQ7n5cxxHj8vi8d2S
         TMV4qRQGuPodw4ErfjDJfrvwjpSA4D7rZs9myfxcFMvk/BJ/kGR86R8nIMeL5RmFewL0
         uu8VHWWdppS4Yi23tBcD0S+B9FxdoHbWN+JzEhEwekZ5ngTZF7m9NFzzqGTgP5xSkhOJ
         B1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=otZvd52HgbyL3fi1OkvvEviekwVNI9M+TtY2lQEoSdI=;
        b=MISGOpaXJa+OKJR+uIFkhY2JFy7iQMHPlyu+4qzB17aoFCcaAwcRh/HzVW8kKjct4b
         WrQRrQ7fvWl8LTJ5kQKx+keeGYfxmOoSf57038SQlA1fMuWm7ZIYMF0a2kZZ6ZjbGiQT
         mRr0rkswOGNZ8nwGBBRgV99hPUZ0GHM9NFLgX5CjD17Axl3rF9NqubZAK0XJU0kiEtP4
         N+q2ZxKp56d9uC0CYrXHHepbplm/yxNr9pmzOkmB+yO4+qdfPMBx+EggdcfORoUVeApr
         5n/3q09JQFjAHBKexEXaygYQoD1qMbaxYPxnzRgo2Gp/hypKoHasT76XSGudTXIDKZAl
         px5Q==
X-Gm-Message-State: AOAM532kJPNfBOVRBk80UfiqBdydcmhDR72N7MZ6ZVrJVqQvAwx6XSTM
        1L6n68un3jpc8KEJuWbQGpMFiA==
X-Google-Smtp-Source: ABdhPJws9+4DF2dtY9n57QhUg+asmpahuJDxMb0W5+XUR0EkQzlIGuZvvMYfuM1OQnzEySpQ4PH5hw==
X-Received: by 2002:a05:620a:2118:: with SMTP id l24mr11231441qkl.153.1623716172079;
        Mon, 14 Jun 2021 17:16:12 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:16:11 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 17/28] staging: rtl8188eu: remove all DBG_88E calls from hal/hal_intf.c
Date:   Tue, 15 Jun 2021 01:14:56 +0100
Message-Id: <20210615001507.1171-18-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from hal/hal_intf.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/hal_intf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_intf.c b/drivers/staging/rtl8188eu/hal/hal_intf.c
index 9585dffc63a3..60cfd31e855a 100644
--- a/drivers/staging/rtl8188eu/hal/hal_intf.c
+++ b/drivers/staging/rtl8188eu/hal/hal_intf.c
@@ -23,7 +23,6 @@ uint rtw_hal_init(struct adapter *adapt)
 			rtw_hal_notch_filter(adapt, 1);
 	} else {
 		adapt->hw_init_completed = false;
-		DBG_88E("%s: hal__init fail\n", __func__);
 	}
 
 	RT_TRACE(_module_hal_init_c_, _drv_err_,
@@ -40,8 +39,6 @@ uint rtw_hal_deinit(struct adapter *adapt)
 
 	if (status == _SUCCESS)
 		adapt->hw_init_completed = false;
-	else
-		DBG_88E("\n %s: hal_init fail\n", __func__);
 
 	return status;
 }
-- 
2.30.2

