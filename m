Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B28544BA77
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 03:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhKJC4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 21:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhKJC4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 21:56:35 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A37C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 18:53:48 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id np3so341221pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 18:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ohzx1aIRfwFT26a19YtMARoAWIS8GAJtqILCOlSCnhk=;
        b=hqflX7QjNSookI+lB7vuKiiWNkEZv5tfqOnXRJHRP0PLWw4isB+0YDGOmGHqrlzJSS
         1tTJyI4dqYEY8iiHATwiG1brOyww6rOuHa5pKJy45UNGa3C5p8HxGAADQR7iejf0hzse
         qtJsSztn+JxSJqJ/Osl2Wu8h0J6UPJAZvqylBX5Z584XKGvu7ORIMp0IVhpNSppjMCmH
         Gi3H6tnAFMG/kDaU0RNBQKUlge7HbEENh0vUvmOYdfGWwrn1ZI1/A7QLVYpaq6H7wTPu
         XexD/izGLV7boBk05Rass/LO8VQX3iMsCGWR8tbkWQwsJEav4nkT6Pn7OxMijbTj2f0v
         MVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ohzx1aIRfwFT26a19YtMARoAWIS8GAJtqILCOlSCnhk=;
        b=xWwywjIOFU++cWsO0jSeqUn41QrtWrABGH062I3oCQjRkxvJ6oCmc5ODJ/L50G1lQ3
         5FDlFCsT3kI90DxuezKYLUV2tjWq8c9vatM0gBjDg5dk6KOQwhtVbSI75ttaqimgHl2g
         OshQnhUUGaNY8t5dbiEcim032k6hdIZ82Oe4fF5ouPsesuOH6QuFVws2QPPHF3BermGo
         lhTYQYYO3gyfpvPdiCmJLJdTuSXP/7A5UbRuJs2V7uKL9YfLJPm+sF2tNeQ/TwpjMj4P
         BGFbpOWx2J4CKzg7iz0EeudqevpAgptSjEpsQdVU05cu32ItqvCiaOD5iMTli99HO7UM
         fdyA==
X-Gm-Message-State: AOAM532ZjTki1QNo/ssWmbqfgmC47vA4+t6/jfO9YgN5XPIUg5HigckV
        TQm9mB6OJT3upsNK+X3MZd0=
X-Google-Smtp-Source: ABdhPJxsC5vxISr0KYKO6Q/N+yXgZPIMMnST5Weylcos+rGQYcDVFEeE5aBPAKqpfWBf9d5ebj375w==
X-Received: by 2002:a17:90b:1b04:: with SMTP id nu4mr13026823pjb.72.1636512827855;
        Tue, 09 Nov 2021 18:53:47 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b15sm5238190pfv.48.2021.11.09.18.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 18:53:47 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: yao.jing2@zte.com.cn
To:     johan@kernel.org
Cc:     cgel.zte@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, yao.jing2@zte.com.cn,
        zealci@zte.com.cn
Subject: [PATCH v3] most: usb: replace snprintf in show functions with sysfs_emit
Date:   Wed, 10 Nov 2021 02:53:41 +0000
Message-Id: <20211110025341.136194-1-yao.jing2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YYjy3QRXk/VL2Lze@hovoldconsulting.com>
References: <YYjy3QRXk/VL2Lze@hovoldconsulting.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Yao <yao.jing2@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING use scnprintf or sprintf

Use sysfs_emit instead of scnprintf, snprintf or sprintf makes more
sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
---

Changes since v2:
 - Revise the inappropriate Subject.

 drivers/most/most_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index acabb7715b42..73258b24fea7 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -831,7 +831,7 @@ static ssize_t value_show(struct device *dev, struct device_attribute *attr,
 	int err;
 
 	if (sysfs_streq(name, "arb_address"))
-		return snprintf(buf, PAGE_SIZE, "%04x\n", dci_obj->reg_addr);
+		return sysfs_emit(buf, "%04x\n", dci_obj->reg_addr);
 
 	if (sysfs_streq(name, "arb_value"))
 		reg_addr = dci_obj->reg_addr;
@@ -843,7 +843,7 @@ static ssize_t value_show(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	return snprintf(buf, PAGE_SIZE, "%04x\n", val);
+	return sysfs_emit(buf, "%04x\n", val);
 }
 
 static ssize_t value_store(struct device *dev, struct device_attribute *attr,
-- 
2.25.1

