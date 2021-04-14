Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9779935FAA5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353006AbhDNSQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352632AbhDNSM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:59 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06431C061344
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w3so32853302ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CQ6LsJ9IQJ+Yl6+6d08CWal5YHo2OCheSLf3tFDPUAQ=;
        b=Ze/rpY12JS5gY5CDBwu6rl7OzvQoiDMot5NY94XG+Zmxn39b+vrw4DKYfLoVqNspf3
         jKl0hulX0Ez0MJrS6zNSEFnsAb/aWpbO2a9mPblH5i5X355OsjumHqNPbuq8y7i4+S03
         KRT13qpbhKM+4Rtj3ek4XGjRMnGaNEd0WF/GFVn7D5vgr9XmlH8vR8C0tRKBM/kdcZ06
         3NtWhDE+9Gl6k/BjSkrt7r64mAX+M0VJHVkIiuSJDhrLJjMU0KUgExOC5MZoJ05ewdWr
         RtNV/WxGp8VlraCXjCySR1G2RLdRaHoTtk5qqCkkvUAWC5TIV0ONUTaYtwoGBQFuqvsU
         cOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQ6LsJ9IQJ+Yl6+6d08CWal5YHo2OCheSLf3tFDPUAQ=;
        b=XRzr2ROrorbhwQQZEbQQBwC6gmat3uaOnNzSOUNDqcp8ed4wwhWGxA6U0PsqZdjq2H
         ssUBNIa5Np1A7N3woxP0Ki2aj4xN4vWbbCMT4ZxjHjYQqWFpX6GSX37mCzjJTggpfM+B
         yQD70p0j+0yulMotSjsZvFmm9sw2eS5W1FvthCC02RwWAQb4CIknJRrjgjE8GC8GGsff
         p3inzbDRDjB35FYYC/H4Xy6ouiPfDrLRytkZio3xgwi/pzkMqADPko33l5YH5Do5afxa
         F0TInZOGFH/6/uwv3BIBuWMsJD19/CWrYZcmwVF7sTHEma2N3jLSXeLnlXGgIdireHmH
         1JKw==
X-Gm-Message-State: AOAM531w9of1WcIz49rp9aroSjtXjs8uIomnTLpQVRYrbDjo5GtZC3DE
        AVMw3XT9w9c/3yR+waqdINIO1w==
X-Google-Smtp-Source: ABdhPJzLyeqjXT0+oyS/9pM50oCEQQ1b44WHDM3TWBcp1BS3Hx3GiVnWiZo8cEPn0XFrAyPtwz20Zg==
X-Received: by 2002:a17:906:39c1:: with SMTP id i1mr147617eje.59.1618423953789;
        Wed, 14 Apr 2021 11:12:33 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 56/57] staging: comedi: drivers: comedi_isadma: Fix misspelling of 'dma_chan1'
Date:   Wed, 14 Apr 2021 19:11:28 +0100
Message-Id: <20210414181129.1628598-57-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/comedi/drivers/comedi_isadma.c:157: warning: Function parameter or member 'dma_chan1' not described in 'comedi_isadma_alloc'
 drivers/staging/comedi/drivers/comedi_isadma.c:157: warning: Excess function parameter 'dma_chan' description in 'comedi_isadma_alloc'

Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/comedi/drivers/comedi_isadma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/comedi_isadma.c b/drivers/staging/comedi/drivers/comedi_isadma.c
index c729094298c2f..479b58e209ba6 100644
--- a/drivers/staging/comedi/drivers/comedi_isadma.c
+++ b/drivers/staging/comedi/drivers/comedi_isadma.c
@@ -143,7 +143,7 @@ EXPORT_SYMBOL_GPL(comedi_isadma_set_mode);
  * comedi_isadma_alloc - allocate and initialize the ISA DMA
  * @dev:	comedi_device struct
  * @n_desc:	the number of cookies to allocate
- * @dma_chan:	DMA channel for the first cookie
+ * @dma_chan1:	DMA channel for the first cookie
  * @dma_chan2:	DMA channel for the second cookie
  * @maxsize:	the size of the buffer to allocate for each cookie
  * @dma_dir:	the DMA direction
-- 
2.27.0

