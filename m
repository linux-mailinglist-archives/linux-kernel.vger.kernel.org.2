Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA8438AF70
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbhETNAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243516AbhETNAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:00:00 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F62C07E5EF
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:25:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c14so15683580wrx.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q0C+y7HOfSg/6tgxS7HJNLZy6uehQaI3fIiA1xOsmw8=;
        b=EK5UiuJJcjQQR3bHsXev1MOW/juVA6ocYp8BJrkzIcxa0qhd6HL136HUsZGgJkw186
         et1seY37AEl9JKcpQtC2unmPbHSWVFpWnJwREQlArIcLycJ9s3+ETovvxG0WrDYBtTXD
         f42w2nBL9s17nvIpySDBtNLdOsxlROt0sUBoRCueHgxNqPlXRGPT3WsdPcu0Suyf/jij
         sfd8htNEjZ7c93q9JE+b9SjhiNNHucEMTJaDrWNHPj2aSoKUn1nBXyku6iflwlc87yVG
         6ZCRuQf6Lw/G32n79EhGEvrbxlsqPn6dGvsRXlXCTEmZ1MVoqIT0gV1q9BLIik97sEml
         5DTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q0C+y7HOfSg/6tgxS7HJNLZy6uehQaI3fIiA1xOsmw8=;
        b=L/iroQrKiemUdAXHcXLjDRloVCKDD0Nz0A42cKGJfoDJC/HeYeRy4VEsaX7M2MwdfY
         RQ1gGGzWKfsqU38krZrgCDgme5ud1c17Uqr4td2EySwlxhGOypPwJ4UtqrfWF4Lrod4g
         Iw/6bN3DK0Y7zgD2AJHrYpDsZeaxIP7K8KsKOfJxP2I0DYbyEmhutOIK/RAWq0wf2S68
         Z23zQEIFVmxgqvRpyKSQzli6BudYLL0qLZE905AOiJG8v7x3YQ5OKjwuQ4bR8J3Mz0Iw
         7TZ2ck6Eto0JUnAUR7XOtuuFwZwj7Th1ry7Ei8RjXslXJ2zTEM0XzxH7xD7PU16y/xZ/
         6N/w==
X-Gm-Message-State: AOAM532O9p60cdToxnoCkIR6Xb7D663HOQJxYuQXi/h6Kif7v+HbOcbI
        w4/UQwsxbvQEtlbycbo7ZoCV9870PioJYg==
X-Google-Smtp-Source: ABdhPJxQEE80mbLz8n2ne+LzLhW0Y2jI1/+Lp7TCBgF57VR2JCx+aj4e86MZO8U/+nHx+2YK2UZPtw==
X-Received: by 2002:a5d:4f03:: with SMTP id c3mr4010026wru.158.1621513547499;
        Thu, 20 May 2021 05:25:47 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id i11sm3205643wrq.26.2021.05.20.05.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:25:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David A. Schleef" <ds@schleef.org>, linux-staging@lists.linux.dev
Subject: [PATCH 1/6] comedi: comedi_8254: Fix descriptions for 'i8254' and 'iobase'
Date:   Thu, 20 May 2021 13:25:33 +0100
Message-Id: <20210520122538.3470259-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520122538.3470259-1-lee.jones@linaro.org>
References: <20210520122538.3470259-1-lee.jones@linaro.org>
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
 drivers/comedi/drivers/comedi_8254.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/comedi_8254.c b/drivers/comedi/drivers/comedi_8254.c
index d1d509e9add94..4bf5daa9e8855 100644
--- a/drivers/comedi/drivers/comedi_8254.c
+++ b/drivers/comedi/drivers/comedi_8254.c
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
2.31.1

