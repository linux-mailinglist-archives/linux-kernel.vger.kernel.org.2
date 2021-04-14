Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE5B35FA9D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353038AbhDNSPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352536AbhDNSMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:47 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CCDC06138F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id d21so4717695edv.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r1wO3iDdDqMfyYacSY7a+W7LGniemZmarQ01JRnrRic=;
        b=gbdr4W8RUQTZKCM7TQ5BxltTeff0/2jaixIaQZLqa/cHxXp+LSC/wMqNL6I0GC8cKX
         2S/BCDgpj4GswaxBvK8QWZLwLO70a+XUh4cfxESxXasRpsx2r4HjB4hy8PrkhMSu+K/9
         K/BaimGYhw6UPbiVglkrCsE5SOvMJE25snVMKREsvPoM5b7dZZwM5HNRLEp+O6+8+kgW
         zsYyBSioSMXcAhWd6uRNKViBAFeGI1sEXYuXsmTsSNqQGlCgyNGCg74Bc0cE03R47itg
         6VAdI2lXwbZv2HoWbk9yjRAgWL/1G2g/GADNlrFxPcvWhLwLm6SsEw+IYq/9JZNNKA7u
         cTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r1wO3iDdDqMfyYacSY7a+W7LGniemZmarQ01JRnrRic=;
        b=Eok6VBfncONhoHAKyUdPcleDFC7BkGkA+XbunU7xZh/7B8AuiUtKZ42caP26hlK6/q
         exfdiElzwnGD7D715ucuo6U49qm+k6HPtffjLIoixWSMCCsqNQKsxj7RE49Q8amxujSO
         grPy0bTDfrcTDZFIfzGpTLTIuz6TqfWdnUG3Dl93moTWqZkUlPfRoNojg7z39pD3+nMA
         H4r3VpW1PyFPEvI9/mfQ5770iAzWXmhLM/8YzJ+DMNFHFd85LFXWaALqNb6RXI1SjSiS
         premiqrIOItP4jtEoV9y2L+kqCHmXY1EDuZxd5ZxIRWXp0VoqoboTl232yjQZDzRoVHv
         H3OA==
X-Gm-Message-State: AOAM531PGBXC6y5kf3M5rrXy1v/8j4AMckpt06d2QNGRxp+x/oHUhKAz
        OZ4ssm3u8IUDfUmQqiIw6E/cgw==
X-Google-Smtp-Source: ABdhPJzCdaAxZa/y0BlHGUMRRGSRTpV0/R7v8qypn8irX9EFs8BoHOJ6AwuTL/1wpcOqmxuAUCU9Nw==
X-Received: by 2002:aa7:d4cc:: with SMTP id t12mr156173edr.261.1618423944794;
        Wed, 14 Apr 2021 11:12:24 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Anders Blomdell <anders.blomdell@control.lth.se>,
        linux-staging@lists.linux.dev
Subject: [PATCH 48/57] staging: comedi: drivers: jr3_pci: Remove set but unused variable 'min_full_scale'
Date:   Wed, 14 Apr 2021 19:11:20 +0100
Message-Id: <20210414181129.1628598-49-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
 drivers/staging/comedi/drivers/jr3_pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/drivers/jr3_pci.c b/drivers/staging/comedi/drivers/jr3_pci.c
index 7a02c4fa3cda8..afa2f8d5c8c0c 100644
--- a/drivers/staging/comedi/drivers/jr3_pci.c
+++ b/drivers/staging/comedi/drivers/jr3_pci.c
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
2.27.0

