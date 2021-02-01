Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6B230AA4B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhBAOvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhBAOlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:41:37 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961D2C061223
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:40:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f16so12847147wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZQZ2+RpbHKZWQO23K1r/ewrXGBIiSW5L8ZHxuWPrs8=;
        b=xmgCh16HvTuwSIDl5iaFrhej4lliLPb1/BAdCNM/4oGwvBx0dXS74eJ/pTA2+zLcKF
         YeGTByROdLeXKb8VBwPsQNK47AZB2dFO8HW9a270MFO9IEsEkkOY7S9YrC7YRLNoLGv4
         vnAAWpgX7ie714uBfKY1FzVEbgP1Az2DlMsVLzA2d0MuTmclo4A3D3MucgxrK8yXZ0cS
         0IT8ZbUp6D4pfkV9A1Bst3Oed1rx/MfN2RzzUdjP7KXf9+letuhvsGaLUPF97DhIePEl
         GMMON83O4v2QPudunlw7MkvT9u4t5DQaXDd/ivJcTFPkkTo5L8bbloek5K4Mhxb1lW+V
         SzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZQZ2+RpbHKZWQO23K1r/ewrXGBIiSW5L8ZHxuWPrs8=;
        b=OsE4UZU9LWpt9cmqyAmjfzVzkIPFAeMGEKwBhF/0Lowwe4Prd1uXxeuPODJ2Ndv0Vg
         lbEMEO9DAoEDWzPtGHvRnb48dAXNQ/RJZsvAuVW43W9AGAG8IMH50G4aAqG0Izt8dTlf
         8ZTVQDatG1/G0wnKAW9XkY9DOmsi0LEsmtnGIXU3GYo9Kwu8MDEX1aILOCWcd5jSvLYC
         4KFj4bM2BtIh+EdEUbv9v5VJChuItOfaA7EE/Jr8tp9X0AzK77MxAisXhmAw98vpS1IZ
         RUmz6gmKHxSNXvOS5O38r49U9XERAO6Ih1Wx/Iau1Wf0lf17dDqM9hLD57sNm0Nq0C/i
         uJyA==
X-Gm-Message-State: AOAM533cvyjir3zBA33TtSu0aflfMlHYv3UFUVdWx8dfogyx6mwDI3hY
        c11vWlaQyo+lSMSN9lDGg1Vr9g==
X-Google-Smtp-Source: ABdhPJwZ0G6ijrnEYSz7NgxKOh/BkCcPUmv/6NSvL43tf/tSWGXYgq+H2fprAKcMsJcJ7tFRP9DRzw==
X-Received: by 2002:a1c:bcd4:: with SMTP id m203mr15142721wmf.120.1612190400345;
        Mon, 01 Feb 2021 06:40:00 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:59 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 15/20] ata: pata_cs5520: Add a couple of missing param descriptions
Date:   Mon,  1 Feb 2021 14:39:35 +0000
Message-Id: <20210201143940.2070919-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_cs5520.c:61: warning: Function parameter or member 'pio' not described in 'cs5520_set_timings'
 drivers/ata/pata_cs5520.c:257: warning: Function parameter or member 'mesg' not described in 'cs5520_pci_device_suspend'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_cs5520.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 9052148b306d9..d09d432d3c442 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -52,6 +52,7 @@ static const struct pio_clocks cs5520_pio_clocks[]={
  *	cs5520_set_timings	-	program PIO timings
  *	@ap: ATA port
  *	@adev: ATA device
+ *	@pio: PIO ID
  *
  *	Program the PIO mode timings for the controller according to the pio
  *	clocking table.
@@ -246,6 +247,7 @@ static int cs5520_reinit_one(struct pci_dev *pdev)
 /**
  *	cs5520_pci_device_suspend	-	device suspend
  *	@pdev: PCI device
+ *	@mesg: PM event message
  *
  *	We have to cut and waste bits from the standard method because
  *	the 5520 is a bit odd and not just a pure ATA device. As a result
-- 
2.25.1

