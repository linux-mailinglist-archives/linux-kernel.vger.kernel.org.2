Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E92F3D7E29
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 20:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhG0S6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 14:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhG0S6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 14:58:09 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02142C061760;
        Tue, 27 Jul 2021 11:58:09 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h11so17174626ljo.12;
        Tue, 27 Jul 2021 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CQXN6JBdm9Q1P062FplZTT9i94VpM/Awhs7t6wRes/M=;
        b=cDkwPv/KS7gsBubTfTnzWlPHDXMLUwCVYEoIrK9mtmw2iBkVQeE80dB5Zuxo49V4B6
         3Tmbq54vlV7ie2fMhjKTg/sKaAth0UBMYsKhjmPxfZc1MKIEa6/MncsJedvvjF80pE8l
         mTFQibi3bpgUHgZHyEyotCNCZqFIr+Jazbn7/1B/DdF42HyDtaoeR6zUIsSSYLM8uI4X
         rDJ6DLdHZH7x6DYCjnNM2CHp+kDbbdelOI0bkG8NNjRIlpfjJmtrowpV/pCUDzjbFs9n
         tjJlstG3zc9L3q4GSpx29KbO+bF9PLu/9HdHHcungAgMvseYcbexXSK4ZUJ61yiiTTCp
         JYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CQXN6JBdm9Q1P062FplZTT9i94VpM/Awhs7t6wRes/M=;
        b=cSn+h1RkXPpPm/rwqt8Qc881HBHgoGXvuiKx64eCn1/gztHV/4qlGcitPG9JOXuVOn
         1XabxwGc/4RcWg6QuPj1lCWvH2hVxgnOzVDkCqlFjQG9dRkyOcVt+tsGpq0iva4L2Utp
         XReRwnw1S3Ljw7VMleXtO1KBkC1sokrfwGAJEVdZ46oB5T2CyRs0gad9w158JRnCIhjy
         mVqx8myVD3TDl4lChXKE/BJCDEpfMlQYtq7zuIQqBZmVlEBXtTq8JQIsrfqVRh9BhlVm
         LgeM388C/kMlqVWvMVZfiAq0vHEs8vtVtea5vj+3fvsiZBevE06uiKL2mP4nKcpZpcm2
         oL6Q==
X-Gm-Message-State: AOAM532IhOyu6tbcILS86W7LOGcZRuVooIeAOJf4hReb84njpa8mY4Vy
        3+ZLdMqUXlPNdBxBOicM904=
X-Google-Smtp-Source: ABdhPJxcK/GiqNxoe6GsqwBgQYD+doZ/8DqjUyr3G8GRvnn8m6pqODcLccQCEXo0w/FMTCWxmbDAmQ==
X-Received: by 2002:a2e:545d:: with SMTP id y29mr16583219ljd.469.1627412287318;
        Tue, 27 Jul 2021 11:58:07 -0700 (PDT)
Received: from localhost.localdomain (broadband-95-84-198-152.ip.moscow.rt.ru. [95.84.198.152])
        by smtp.gmail.com with ESMTPSA id u9sm361768lfc.278.2021.07.27.11.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 11:58:06 -0700 (PDT)
From:   Maxim Devaev <mdevaev@gmail.com>
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, sandeen@redhat.com, mdevaev@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: f_hid: idle uses the highest byte for duration
Date:   Tue, 27 Jul 2021 21:58:00 +0300
Message-Id: <20210727185800.43796-1-mdevaev@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SET_IDLE value must be shifted 8 bits to the right to get duration.
This confirmed by USBCV test.

Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
---
 drivers/usb/gadget/function/f_hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 8d50c8b12..bb476e121 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -573,7 +573,7 @@ static int hidg_setup(struct usb_function *f,
 		  | HID_REQ_SET_IDLE):
 		VDBG(cdev, "set_idle\n");
 		length = 0;
-		hidg->idle = value;
+		hidg->idle = value >> 8;
 		goto respond;
 		break;
 
-- 
2.32.0

