Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367F938AF7A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243391AbhETNBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243511AbhETNAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:00:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB4CC07E5F0
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:25:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n2so17550316wrm.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z07GdkBe9eIVIrPcp5F5TqABOA/nGZ8K3dUhAPpDc9Y=;
        b=K+hUVHSRgJeo2EBiTpYthKEutxBQbbC4ebDBdOvXnjJMITppIq6c5ja5k5a0x79uXd
         QVMSEUxv4E+v+b9oTU1sHW5d5OnDkqGeO0VITY26zRem802gxGy88RbuTAjbUSOxSA23
         YqyH6+evCzX9eZTRCScvtP02eojbSqozBrdOsh+r8Cpz+I+27GiSgfP5V+dBVI75osXd
         Gpuq7ZRdviva6t4OoJ8W9pqXfbAEP0PUQLcti4cvgAi0D9baz+UVcISkUSG7TysQv7YE
         n9WEcvdSar2iuxg73Ixgwz672yesQLrKwWu3kChdzFdCmDm7bQau9SD1ADKii1EkbIEs
         LO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z07GdkBe9eIVIrPcp5F5TqABOA/nGZ8K3dUhAPpDc9Y=;
        b=D8gG/9ou4eNt3QlcW3l3LLOv4G70D+JGVptCOV3c9b1ce/UZ5yeWjKevsYNeRGa4YO
         wCie7oogHokB/wFenGJoIqpWn232kaZeJbWgMO0G/usOaECMayBrKWqX1iRTgaxtvP1E
         Sbysqaw7LwiGy9q/9JMOEP/l9alsJFmgPle1XrdEfBJfco/BUg9H1q+R7GiOAO+UvhUF
         fEdIZyCy0QKKVT46YzG469ofll4OV+9Anfc9QLcm/Z6XgGK4+WGgc/RNzKFDV5R/NIxB
         gby+9L5mz9x888fOQ0qPksaib3V2tUDv/+d9xjA0o3KIM2ez4thLRMISzrrCWYQQ/YbR
         XL1w==
X-Gm-Message-State: AOAM531g0YOmXRGezgsH7KeDwNI/5qnBTouukdGyI/9iG/sDodbOEzUM
        EtUJmrrVQhC+D/IlObqUuTuV1g==
X-Google-Smtp-Source: ABdhPJyZjzJUcN/fRmxz0rjZRg79nZlnDT6ljiRWB+m+2P1+yTlHF1LBWwZqdwdOBqiQAwWHD4wHrQ==
X-Received: by 2002:a5d:6d04:: with SMTP id e4mr3128064wrq.344.1621513548401;
        Thu, 20 May 2021 05:25:48 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id i11sm3205643wrq.26.2021.05.20.05.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:25:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Anders Blomdell <anders.blomdell@control.lth.se>,
        linux-staging@lists.linux.dev
Subject: [PATCH 2/6] comedi: drivers: jr3_pci: Remove set but unused variable 'min_full_scale'
Date:   Thu, 20 May 2021 13:25:34 +0100
Message-Id: <20210520122538.3470259-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520122538.3470259-1-lee.jones@linaro.org>
References: <20210520122538.3470259-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/comedi/drivers/jr3_pci.c: In function ‘jr3_pci_poll_subdevice’:
 drivers/staging/comedi/drivers/jr3_pci.c:507:22: warning: variable ‘min_full_scale’ set but not used [-Wunused-but-set-variable]

Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/comedi/drivers/jr3_pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
index 7a02c4fa3cda8..afa2f8d5c8c0c 100644
--- a/drivers/comedi/drivers/jr3_pci.c
+++ b/drivers/comedi/drivers/jr3_pci.c
@@ -504,10 +504,9 @@ jr3_pci_poll_subdevice(struct comedi_subdevice *s)
 			result = poll_delay_min_max(20, 100);
 		} else {
 			/* Set full scale */
-			struct six_axis_t min_full_scale;
 			struct six_axis_t max_full_scale;
 
-			min_full_scale = get_min_full_scales(sensor);
+			get_min_full_scales(sensor);
 			max_full_scale = get_max_full_scales(sensor);
 			set_full_scales(sensor, max_full_scale);
 
-- 
2.31.1

