Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF85042405F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbhJFOti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239047AbhJFOtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:49:35 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AF7C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 07:47:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k7so9506354wrd.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iaPDGFDXlBzajv88h+tMAL1sMQfhj6LEIZT5x3IDzr0=;
        b=T3PR6JXg6Wn8WiTrKJSBX3xMc2ueX8a2a8ZKdsJRFYWnLdwmAF88qLkCiqEYywAty9
         EhF7xxERYSIDe7gKR/5oy/Zxfm7B5+NdHIxghE4Hi9gOqCXKCWCQs+erp2YO8aZmyrDk
         5PT3hoTs35ILQ+DGuFSl0wDoxiYIYPxfBpz/OpVsXULIQsLbWaPhYTRPUVAy/i0J+/+2
         vamcOf7vAk7p1qDoLY0iMgBciDQw8DPpTQ/eR578pYjbhoZg8o4sLz8graRKn/wxQa+V
         bOj7zO9VjAVMqMrlzx4lvd1G9+cSVJ9C2pwAfkSLNkXfE+0enypjMZxGdN20bGTpPJFN
         //Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iaPDGFDXlBzajv88h+tMAL1sMQfhj6LEIZT5x3IDzr0=;
        b=kJz+5AErlVVlBYNTHVdSgfHT2usvy1MVnLXOElnJ0CUCN9g9aqO8M4eesscFlxNeLg
         rlUuH+OtYERhaLsktUiLG318VA6yBAcgp4wW1OlxfZC8V4bn5yvLriY29lhEuqXbd626
         0jFeVRqP9E55r6FmvPNAtm2r2CJFbOvsrBYaksh5lRBarIH3URtyxw3UH7Ld6vmu3KED
         ElKvyag+0lxTqIbsU3ZLl4XvE+obu8Icb8Ldk6EURlJrBZ3SW2vK69Ow0QOwVvl+UImr
         H7BAlfETJue6TXaervjPLSFO0GHKY7LXOFu/ZveVBgekLbCPyeQsxBvLoVwNu4fbgOo2
         OeeQ==
X-Gm-Message-State: AOAM5332ZtDTAJ1F0xaEBvFGxoeMibl1+wcPPe45Y3SKmZSRdag+pgvo
        hb7s9QVvDXLw5O0xDyTtHS7Crg==
X-Google-Smtp-Source: ABdhPJwKlzlQGWh2njqPZoqo5KMi7Ud5HKXYNeOjUwaG8MmpNjuZlFTns6wpyOvbWglw3MPQvrtWZQ==
X-Received: by 2002:adf:ab46:: with SMTP id r6mr6393996wrc.71.1633531661551;
        Wed, 06 Oct 2021 07:47:41 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id z18sm14589340wro.25.2021.10.06.07.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 07:47:41 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srini@kernel.org
Cc:     linux-kernel@vger.kernel.org, qiangqing.zhang@nxp.com,
        linux-imx@nxp.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] nvmem: core: add nvmem cell post processing callback
Date:   Wed,  6 Oct 2021 15:47:28 +0100
Message-Id: <20211006144729.15268-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211006144729.15268-1-srinivas.kandagatla@linaro.org>
References: <20211006144729.15268-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some NVMEM providers have certain nvmem cells encoded, which requires
post processing before actually using it.

For example mac-address is stored in either in ascii or delimited or reverse-order.

Having a post-process callback hook to provider drivers would enable them to
do this vendor specific post processing before nvmem consumers see it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 9 +++++++++
 include/linux/nvmem-provider.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9da4e8f42d86..108960aa49ab 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -38,6 +38,7 @@ struct nvmem_device {
 	unsigned int		nkeepout;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
+	nvmem_cell_post_process_t cell_post_process;
 	struct gpio_desc	*wp_gpio;
 	void *priv;
 };
@@ -798,6 +799,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->type = config->type;
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
+	nvmem->cell_post_process = config->cell_post_process;
 	nvmem->keepout = config->keepout;
 	nvmem->nkeepout = config->nkeepout;
 	if (config->of_node)
@@ -1441,6 +1443,13 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 	if (cell->bit_offset || cell->nbits)
 		nvmem_shift_read_buffer_in_place(cell, buf);
 
+	if (nvmem->cell_post_process) {
+		rc = nvmem->cell_post_process(nvmem->priv, id,
+					      cell->offset, buf, cell->bytes);
+		if (rc)
+			return rc;
+	}
+
 	if (len)
 		*len = cell->bytes;
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 104505e9028f..98efb7b5660d 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -19,6 +19,9 @@ typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 				void *val, size_t bytes);
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
 				 void *val, size_t bytes);
+/* used for vendor specific post processing of cell data */
+typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, unsigned int offset,
+					  void *buf, size_t bytes);
 
 enum nvmem_type {
 	NVMEM_TYPE_UNKNOWN = 0,
@@ -62,6 +65,7 @@ struct nvmem_keepout {
  * @no_of_node:	Device should not use the parent's of_node even if it's !NULL.
  * @reg_read:	Callback to read data.
  * @reg_write:	Callback to write data.
+ * @cell_post_process:	Callback for vendor specific post processing of cell data
  * @size:	Device size.
  * @word_size:	Minimum read/write access granularity.
  * @stride:	Minimum read/write access stride.
@@ -92,6 +96,7 @@ struct nvmem_config {
 	bool			no_of_node;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
+	nvmem_cell_post_process_t cell_post_process;
 	int	size;
 	int	word_size;
 	int	stride;
-- 
2.21.0

