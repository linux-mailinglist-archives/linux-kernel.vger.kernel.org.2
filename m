Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C228135FA69
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346600AbhDNSMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhDNSMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5069C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:38 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u21so32810527ejo.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WEiIs5zldwQSdjjTkKUv/mhQ3RM5FwCOCPjXSs5433Y=;
        b=fwT/uTndlASvYBIt5/5KCCO/xLT6H2Rn2t7JP+I+oiy22ey4KdbmgbWji51ZB3GyDk
         ajQ09kp/D+xSSKe70AMeNgZSVWQq3UVZV2q7j/Jr9qaYEE26oRn3Ljata6dJutw9hPM2
         9n0xwC9AqqXGDWwisrDyqN8oHr9BTIn69VYnEyIt+OBzCfIKUUJcpQiSCyA9EEe+DxxT
         4v2ZzQnnz5oOp90xUti0N9gtZsFQX8JC+7RKgxVRLJEngCodouV8IT3hjNNYp4jMDfF1
         YC2LLFytnHtIL74UgXh5kPBMCRthmHZbjrweU4g1ARQ9MJsiv74dgbv7hbCCv5hFD3Jc
         4QWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WEiIs5zldwQSdjjTkKUv/mhQ3RM5FwCOCPjXSs5433Y=;
        b=hd2Wf3EtfSGd1vjgSPU+4pIa1Afk0L5ykvmHLir7rV1G7+wNGxWvhMfAOmZp+qJAjm
         4WNUdtTRR8wBEZU4jQKDnnBqg/PynDMV3Kvl7SAFoHKS9L/R5s1US5mCWfvo4PHhN2n2
         u2AkPDdjAEVn6IEmOH+x16gkp9Cl68yhQAE8tdak7q4AUkjGLwb/HQcRK9R+Wl0o76Pw
         IkBx/fpFMKklKGracRFfdL1lqBgYpA3KRC6VEqp22kVZOz8jc5rbTTzCaWyUriKNnaG/
         AnBr95DaOCwyXI1S3emUrO++0qX+aUIYybkRDKZz8R83KYGO5lXav5A+pS/soOAUHBud
         8dbg==
X-Gm-Message-State: AOAM530rGVuhwpkZik21qOYkzz0mTkRtvtubgsCI1wXTe9eLoFk9wgoh
        8NU9VAEdhs1+TB5hSvQKMfnWoA==
X-Google-Smtp-Source: ABdhPJyB9jWZKykG6LKsjtIm1j4xpGTK73yjBzcWI12qePyGRIZ9y67xaS2oTYaiG/ZDw+fVGhWQiQ==
X-Received: by 2002:a17:907:6282:: with SMTP id nd2mr137503ejc.173.1618423897629;
        Wed, 14 Apr 2021 11:11:37 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:11:37 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David A. Schleef" <ds@schleef.org>, linux-staging@lists.linux.dev
Subject: [PATCH 03/57] staging: comedi_8254: Fix descriptions for 'i8254' and 'iobase'
Date:   Wed, 14 Apr 2021 19:10:35 +0100
Message-Id: <20210414181129.1628598-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/comedi/drivers/comedi_8254.c:561: warning: Function parameter or member 'i8254' not described in 'comedi_8254_subdevice_init'
 drivers/staging/comedi/drivers/comedi_8254.c:620: warning: Function parameter or member 'iobase' not described in 'comedi_8254_init'
 drivers/staging/comedi/drivers/comedi_8254.c:620: warning: Excess function parameter 'mmio' description in 'comedi_8254_init'

Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David A. Schleef" <ds@schleef.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/comedi/drivers/comedi_8254.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/comedi_8254.c b/drivers/staging/comedi/drivers/comedi_8254.c
index d1d509e9add94..4bf5daa9e8855 100644
--- a/drivers/staging/comedi/drivers/comedi_8254.c
+++ b/drivers/staging/comedi/drivers/comedi_8254.c
@@ -555,6 +555,7 @@ static int comedi_8254_insn_config(struct comedi_device *dev,
 /**
  * comedi_8254_subdevice_init - initialize a comedi_subdevice for the 8254 timer
  * @s:		comedi_subdevice struct
+ * @i8254:	comedi_8254 struct
  */
 void comedi_8254_subdevice_init(struct comedi_subdevice *s,
 				struct comedi_8254 *i8254)
@@ -607,7 +608,7 @@ static struct comedi_8254 *__i8254_init(unsigned long iobase,
 
 /**
  * comedi_8254_init - allocate and initialize the 8254 device for pio access
- * @mmio:	port I/O base address
+ * @iobase:	port I/O base address
  * @osc_base:	base time of the counter in ns
  *		OPTIONAL - only used by comedi_8254_cascade_ns_to_timer()
  * @iosize:	I/O register size
-- 
2.27.0

