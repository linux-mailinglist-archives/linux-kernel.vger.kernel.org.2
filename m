Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DA734E633
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhC3LOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhC3LNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:13:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04281C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r12so24217025ejr.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRs0gL7BVY1Q2W1XNEP/SMm5GsjRvhz4eiapy4iDOmA=;
        b=FddqcqAyb8dU8UGQuqF0Ofgq9o9PW9ghclSk9x1+0JvknSfJz7wYZ/yDEHUrJcm9WO
         qfQhAjTSkUkCJc/9ZoF/1bBTWatpA8p+AOPu8u+8fSRG4Ud+ZyuMhvLB3YzvUk1rsmJD
         PgegQW7cwGFHDqa2u8trvuD3YVDs6nY2KLdFoVkkPoQ9YpkYQSRjlWRl/OzaiuUVnn4/
         c+wuowBdZEaKJGSnUdPbwZrYenckiteYoAjP6Q2vmjjd8gIm7VXAD5LUyfAQ6iQosKkj
         wfnPPkERerjMnvKJXrLGBw9zy0hpReyO66GiRBzWTq0XCCc2/wmDDUpd9Z7kA9b/QolV
         noxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRs0gL7BVY1Q2W1XNEP/SMm5GsjRvhz4eiapy4iDOmA=;
        b=Wr0cqE2/8w95zvV6D0lUnkgHRM61bC/e6WvW/TWVvXik4n5BFWs6bqi3PMjyvzDK8F
         pnkvKdr6BoLbgswJAXpb3maRLehF2KXdao2mgIs2IgybEH1iEjBSQvMhZqyYJa7Xfrzo
         6jPwcqzzjIGtWrBAEQHJXh0BAaGjG6JsY7o031kpuGZCg7iFqc/V+JemIpCVz/f2OXYZ
         VXSBDJTWvH1fyKAPffXdA4NadJqx1d7EhfNtKLMKH5KL5+DiSBuRRrRlNC439Y4Aw6Hm
         BVqUkFRANH+w9bPZ8xyqTESWCNk6DAUY6z7kSLOyJmejr0xSc8fmslrJ9AyBuyuCB55s
         nUrA==
X-Gm-Message-State: AOAM532XDK3/KcpU/TkSYE8Uu+vk2v2QZ19sYC3O71t39nt8qn7buSNz
        Y1ruurgNcb+htM/Qn+La8jTXoQ==
X-Google-Smtp-Source: ABdhPJyUPxqYj8ek0kxIqE5nQSC/sZ6aURD+pSPZOqqUfsH0I8sit4//Sf5aY4orjl5y2pbjOBE5+w==
X-Received: by 2002:a17:906:2dda:: with SMTP id h26mr32560430eji.163.1617102823687;
        Tue, 30 Mar 2021 04:13:43 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r19sm10961308edp.52.2021.03.30.04.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 04:13:43 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/10] nvmem: core: Add functions to make number reading easy
Date:   Tue, 30 Mar 2021 12:12:37 +0100
Message-Id: <20210330111241.19401-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
References: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

Sometimes the clients of nvmem just want to get a number out of
nvmem. They don't want to think about exactly how many bytes the nvmem
cell took up. They just want the number. Let's make it easy.

In general this concept is useful because nvmem space is precious and
usually the fewest bits are allocated that will hold a given value on
a given system. However, even though small numbers might be fine on
one system that doesn't mean that logically the number couldn't be
bigger. Imagine nvmem containing a max frequency for a component. On
one system perhaps that fits in 16 bits. On another system it might
fit in 32 bits. The code reading this number doesn't care--it just
wants the number.

We'll provide two functions: nvmem_cell_read_variable_le_u32() and
nvmem_cell_read_variable_le_u64().

Comparing these to the existing functions like nvmem_cell_read_u32():
* These new functions have no problems if the value was stored in
  nvmem in fewer bytes. It's OK to use these function as long as the
  value stored will fit in 32-bits (or 64-bits).
* These functions avoid problems that the earlier APIs had with bit
  offsets. For instance, you can't use nvmem_cell_read_u32() to read a
  value has nbits=32 and bit_offset=4 because the nvmem cell must be
  at least 5 bytes big to hold this value. The new API accounts for
  this and works fine.
* These functions make it very explicit that they assume that the
  number was stored in little endian format. The old functions made
  this assumption whenever bit_offset was non-zero (see
  nvmem_shift_read_buffer_in_place()) but didn't whenever the
  bit_offset was zero.

NOTE: it's assumed that we don't need an 8-bit or 16-bit version of
this function. The 32-bit version of the function can be used to read
8-bit or 16-bit data.

At the moment, I'm only adding the "unsigned" versions of these
functions, but if it ends up being useful someone could add a "signed"
version that did 2's complement sign extension.

At the moment, I'm only adding the "little endian" versions of these
functions. Adding the "big endian" version would require adding "big
endian" support to nvmem_shift_read_buffer_in_place().

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 95 ++++++++++++++++++++++++++++++++++
 include/linux/nvmem-consumer.h |  4 ++
 2 files changed, 99 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index a5ab1e0c74cf..635e3131eb5f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1606,6 +1606,101 @@ int nvmem_cell_read_u64(struct device *dev, const char *cell_id, u64 *val)
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_read_u64);
 
+static void *nvmem_cell_read_variable_common(struct device *dev,
+					     const char *cell_id,
+					     size_t max_len, size_t *len)
+{
+	struct nvmem_cell *cell;
+	int nbits;
+	void *buf;
+
+	cell = nvmem_cell_get(dev, cell_id);
+	if (IS_ERR(cell))
+		return cell;
+
+	nbits = cell->nbits;
+	buf = nvmem_cell_read(cell, len);
+	nvmem_cell_put(cell);
+	if (IS_ERR(buf))
+		return buf;
+
+	/*
+	 * If nbits is set then nvmem_cell_read() can significantly exaggerate
+	 * the length of the real data. Throw away the extra junk.
+	 */
+	if (nbits)
+		*len = DIV_ROUND_UP(nbits, 8);
+
+	if (*len > max_len) {
+		kfree(buf);
+		return ERR_PTR(-ERANGE);
+	}
+
+	return buf;
+}
+
+/**
+ * nvmem_cell_read_variable_le_u32() - Read up to 32-bits of data as a little endian number.
+ *
+ * @dev: Device that requests the nvmem cell.
+ * @cell_id: Name of nvmem cell to read.
+ * @val: pointer to output value.
+ *
+ * Return: 0 on success or negative errno.
+ */
+int nvmem_cell_read_variable_le_u32(struct device *dev, const char *cell_id,
+				    u32 *val)
+{
+	size_t len;
+	u8 *buf;
+	int i;
+
+	buf = nvmem_cell_read_variable_common(dev, cell_id, sizeof(*val), &len);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	/* Copy w/ implicit endian conversion */
+	*val = 0;
+	for (i = 0; i < len; i++)
+		*val |= buf[i] << (8 * i);
+
+	kfree(buf);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvmem_cell_read_variable_le_u32);
+
+/**
+ * nvmem_cell_read_variable_le_u64() - Read up to 64-bits of data as a little endian number.
+ *
+ * @dev: Device that requests the nvmem cell.
+ * @cell_id: Name of nvmem cell to read.
+ * @val: pointer to output value.
+ *
+ * Return: 0 on success or negative errno.
+ */
+int nvmem_cell_read_variable_le_u64(struct device *dev, const char *cell_id,
+				    u64 *val)
+{
+	size_t len;
+	u8 *buf;
+	int i;
+
+	buf = nvmem_cell_read_variable_common(dev, cell_id, sizeof(*val), &len);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	/* Copy w/ implicit endian conversion */
+	*val = 0;
+	for (i = 0; i < len; i++)
+		*val |= buf[i] << (8 * i);
+
+	kfree(buf);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvmem_cell_read_variable_le_u64);
+
 /**
  * nvmem_device_cell_read() - Read a given nvmem device and cell
  *
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 052293f4cbdb..923dada24eb4 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -65,6 +65,10 @@ int nvmem_cell_read_u8(struct device *dev, const char *cell_id, u8 *val);
 int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val);
 int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val);
 int nvmem_cell_read_u64(struct device *dev, const char *cell_id, u64 *val);
+int nvmem_cell_read_variable_le_u32(struct device *dev, const char *cell_id,
+				    u32 *val);
+int nvmem_cell_read_variable_le_u64(struct device *dev, const char *cell_id,
+				    u64 *val);
 
 /* direct nvmem device read/write interface */
 struct nvmem_device *nvmem_device_get(struct device *dev, const char *name);
-- 
2.21.0

