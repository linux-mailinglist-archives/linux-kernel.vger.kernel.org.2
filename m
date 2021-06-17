Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F163AB1E9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhFQLIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhFQLHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:07:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16972C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:05:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d11so3914799wrm.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vUFn8vVyODrswNQB/UdSBDPFH88/MOPHHSA7kAmhlUc=;
        b=YVPz/AgKRT5m6CJ7rOCMPDWcZv3JwMHNmlgpJ8uHxHjHxO207ioU8MpX73i5hr8gZh
         d8924gGz2boMuHQ5jIc0orcPLNVFgTRT93yz9iVppJ+noJV/QPF5CXRuXBfLiokXKPi9
         pVxulBYemzM7Fl0qx+ac8y2ANLy6MwiC2k9XC6Bw35ZaMsApvKn4rx65ZHpdZoERsAl3
         YvAExUroguCFxZVHKTQcBFCQKhZX2oPLyhuPO2vp394Ov/zhFJLpHaJ3LlLR9aZNbsF4
         RUxYFj45RGsYQ6zf4A3GLxB5umykTLp5yi0lWqdpASwbe+TEKvjQPaRNSnlM1vM+3J73
         J7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUFn8vVyODrswNQB/UdSBDPFH88/MOPHHSA7kAmhlUc=;
        b=de8TFvWryhAGm4nmsEiCLVJi4bm3lVcloBhkhVtjyueKO/IEukXT6z+ubkFCo8Tx1B
         dt2L+BrziWUnT1VHlCDgkg+1ua/+rtcj6OAt1XkZHoXHemKRNycCx0mG5/J1+nmNKIUR
         NrEbV+Tw+cmLqlHW48tHBoRQkGndf5B1vKtc8hz2f3bFUBJp1LGy5oTdQpYl3CzY0HIH
         mXIqRuIHOO/gHCxujv445tXZdpzNlvZP2omUiSveCy/cLe1bGQdTTlCDWTOMEQat4jrB
         6ghwAJRbtSIioJVspfoCXHZU6pwrQcouzfwIvqIHPw2uf7fpZnP3A/pUy51z925SvSOw
         EOKg==
X-Gm-Message-State: AOAM5325iMEyfLph4B9W8BH6+NhN2D0G4pOrCUv5tu+KtNpqq2VGf+Z3
        wS0gLBGbDI2YeoBkJUuvOh/L5Q==
X-Google-Smtp-Source: ABdhPJydInITVN/efLeuHtC42CzSmNJy7NWStiFE09zDfgUsoVOqaFXdyneCQUQSI9ZBpC/jr1/X/w==
X-Received: by 2002:a05:6000:1889:: with SMTP id a9mr5032421wri.288.1623927940675;
        Thu, 17 Jun 2021 04:05:40 -0700 (PDT)
Received: from dell.default ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id v18sm5249487wrb.10.2021.06.17.04.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:05:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 8/8] bus: fsl-mc: mc-io: Correct misdocumentation of 'dpmcp_dev' param
Date:   Thu, 17 Jun 2021 12:05:00 +0100
Message-Id: <20210617110500.15907-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617110500.15907-1-lee.jones@linaro.org>
References: <20210617110500.15907-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/bus/fsl-mc/mc-io.c:70: warning: Function parameter or member 'dpmcp_dev' not described in 'fsl_create_mc_io'

Cc: Stuart Yoder <stuyoder@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/mc-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
index 9af6b05b89d6f..95b10a6cf3073 100644
--- a/drivers/bus/fsl-mc/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -55,7 +55,7 @@ static void fsl_mc_io_unset_dpmcp(struct fsl_mc_io *mc_io)
  * @dev: device to be associated with the MC I/O object
  * @mc_portal_phys_addr: physical address of the MC portal to use
  * @mc_portal_size: size in bytes of the MC portal
- * @dpmcp-dev: Pointer to the DPMCP object associated with this MC I/O
+ * @dpmcp_dev: Pointer to the DPMCP object associated with this MC I/O
  * object or NULL if none.
  * @flags: flags for the new MC I/O object
  * @new_mc_io: Area to return pointer to newly created MC I/O object
-- 
2.32.0

