Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2D642A22C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 12:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbhJLKdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 06:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbhJLKdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:33:12 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D8EC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 03:31:10 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 187so17231382pfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 03:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFRE6Bw9U0FK+/TVlHf7B4gQZar5gd2qmpobG4wuOnE=;
        b=cay2mDEnvb5Pw9txoCqgxuPX2/AbUYjjoDe0XpjcWPWq7YXi73UZbBZEVMTjF5TwWI
         +Fn728JjUq1aweq8Yt6KCEaPyC96DoTB2XKn1r47X/V4WPN5hoTmrV8oYNXGolg32xaJ
         pwOZegLtnl7QDuEG570DBYNuXv9Ja7CS3gS2bvMfXApMLjyyADRK/8SVft02GAKOJP2z
         S3RNv4Tu6b67s7c+PJj8FzfHkcIszlaqxQLjJQA8gAzAfYexu0QTsDomYMsxPh86ZF/D
         0nHw5feh42HDizIHVdE40U3yC/UIUbvGzMiLVv/7GtmgcF9CpsRFVsFz3U1yJZgkyd0m
         WmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFRE6Bw9U0FK+/TVlHf7B4gQZar5gd2qmpobG4wuOnE=;
        b=I3UmGWhOhCSFHNiRqG48VakIlfEFNU2I0bNvGBoWHjegrsEXQiPwN6rrgOu8mYCzAp
         BSc0KBh1xRWmd+1e1xw7rzmzrIE/vO8C3nn6k0Wc9LezCkV91HoKnXx2AeY7m4C1iGOv
         tM/SB7CUh6UPazPam+5YUfMya0H+6yfwjEL1A/GUfoPCZkiiqoa+QVciiQLAUb5rZvju
         mAEE3a4dB0JQyXcfbD9k1Z7cn9ioeHTwaGCp2r4WEzTc7O1sEYCI4cI9KoZ/JOZU43xp
         rQMGf4FV4GKNq0UtP6sgxQ1nf1TBhiy2f5bbLS5Zvwzz/nsbxKZl2wvS64QZKS4vZGK6
         6VnQ==
X-Gm-Message-State: AOAM532mB50FbspaAmx7gYDmFTNORc9rtRLN03uUk1yLVUtLA5owa6Uc
        PPXa1RIOLMjZfwVJdvDUoVLiAs7KG48Oqxrc
X-Google-Smtp-Source: ABdhPJyJoPR9zrjOwp3+6krQT3bbg0nGZvxo0E2E67Pxvjm0iSIZOkRBaCGGkC6Zh9oXyTqdpEcs/w==
X-Received: by 2002:a63:f30c:: with SMTP id l12mr22195219pgh.360.1634034670250;
        Tue, 12 Oct 2021 03:31:10 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id x13sm11207484pgt.80.2021.10.12.03.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 03:31:09 -0700 (PDT)
From:   davidcomponentone@gmail.com
To:     jdike@addtoit.com
Cc:     joe@perches.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes.berg@intel.com, davidcomponentone@gmail.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v3] Fix application of sizeof to pointer
Date:   Tue, 12 Oct 2021 18:30:54 +0800
Message-Id: <ba5d88fd5470e6c72bbb70a34068b9662a72d418.1634024019.git.davidcomponentone@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Yang <davidcomponentone@gmail.com>

The coccinelle check report:
"./arch/um/drivers/virt-pci.c:192:20-26:
ERROR: application of sizeof to pointer"
Using the "sizeof(buf->data)" to fix it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 arch/um/drivers/virt-pci.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index c08066633023..148fa7a15ee0 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -180,16 +180,14 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 	};
 	/* buf->data is maximum size - we may only use parts of it */
 	struct um_pci_message_buffer *buf;
-	u8 *data;
 	unsigned long ret = ~0ULL;
 
 	if (!dev)
 		return ~0ULL;
 
 	buf = get_cpu_var(um_pci_msg_bufs);
-	data = buf->data;
 
-	memset(data, 0xff, sizeof(data));
+	memset(buf->data, 0xff, sizeof(buf->data));
 
 	switch (size) {
 	case 1:
@@ -204,22 +202,22 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 		goto out;
 	}
 
-	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, data, 8))
+	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, buf->data, 8))
 		goto out;
 
 	switch (size) {
 	case 1:
-		ret = data[0];
+		ret = buf->data[0];
 		break;
 	case 2:
-		ret = le16_to_cpup((void *)data);
+		ret = le16_to_cpup((void *)buf->data);
 		break;
 	case 4:
-		ret = le32_to_cpup((void *)data);
+		ret = le32_to_cpup((void *)buf->data);
 		break;
 #ifdef CONFIG_64BIT
 	case 8:
-		ret = le64_to_cpup((void *)data);
+		ret = le64_to_cpup((void *)buf->data);
 		break;
 #endif
 	default:
-- 
2.30.2

