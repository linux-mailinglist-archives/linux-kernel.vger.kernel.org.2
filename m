Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645C6327F04
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbhCANH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbhCANHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:07:04 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8DEC061756;
        Mon,  1 Mar 2021 05:06:01 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id e2so12122250ljo.7;
        Mon, 01 Mar 2021 05:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SCMa5vfTZFElxh1bdw64qo8P8ZQLLOyAHkrJsHGKLpk=;
        b=LCiSraXUAnIUJifWrHzf0hcUUwXrY8nvntoChz0SptM9g9bAlWC6Y6/JBVdL/AyTDW
         IqQSXNFuGHtbf79jVnPecI+GjS1gghrS2oKLLsnoyvU8d0FqkfmKeEgiQfnHXk1KwlMV
         CD+tNttfOhuFRuQRMae1gDv8zSnEIYYW717taZpeyHlRBY0msFGogK/9kGsC56dyw2+L
         gfdfOTg34zX5bdeO1GJWfMTieycrMOFZtus0bkghlEO8L3/WjmBcvwN/C5xa/EL3lpdH
         8UkPXdgLWGlIFz+WkCIh6L7OXb6aH4jgc1Yx4eY48WWE+6KU4C76Bi7OfCzCysxe+uDK
         OeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SCMa5vfTZFElxh1bdw64qo8P8ZQLLOyAHkrJsHGKLpk=;
        b=Exzw4Vjjp7tbJWzXXqmUlTlSuQHrPTIrVrICxRtyI8pdICO7DfiQGdK9FCVV4EdLOu
         R/Jh767JRwHzMifr0RuPYumEpkHkHHGLmimV/B2dNZn3CIcozgzZ2j4X9DxE3RZnZ/v0
         XzMsabT6a63pfgZSDIDOwDSIqfdE6ijNFAne0iAjIsgmV4I1RGphNDFjCiyew4Sfa5Pb
         uwvwRygTWydSlhaUgKYHR38JqH8KnPdldA5+BLM/MSDenJPxQWSPmkrCcsOBcaRR/r0y
         MKR6In0wSApIdePk2gGVqRAQSsJzk9P/eIhF9A+YZDG5lNnw06ZC8XSlMBUG3WHnT9T4
         y1wQ==
X-Gm-Message-State: AOAM533hph9/zUFEkSldZ146a1leEI3C8zYduj2hl9n0XLlkYP3SVc3n
        XadK9oSZ+K995z6pKnsNPo0=
X-Google-Smtp-Source: ABdhPJzuA0/nnPV0OSY3uEsWuP1T6MJPoETn0P7XTJby/+PFmHWdg028snwgo4PfAaCGSrC0feIG0Q==
X-Received: by 2002:a2e:8157:: with SMTP id t23mr9357067ljg.125.1614603960111;
        Mon, 01 Mar 2021 05:06:00 -0800 (PST)
Received: from localhost (crossness-hoof.volia.net. [93.72.107.198])
        by smtp.gmail.com with ESMTPSA id o1sm2297904lfq.22.2021.03.01.05.05.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 Mar 2021 05:05:59 -0800 (PST)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     gschmottlach@gmail.com, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] usb: audio-v2: add ability to define feature unit descriptor
Date:   Mon,  1 Mar 2021 15:05:40 +0200
Message-Id: <1614603943-11668-6-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to UAC1 spec, UAC2 feature unit descriptor
has variable size.

Current audio-v2 feature unit descriptor structure
is used for parsing descriptors, but can't be used
to define your own descriptor.

Add a new macro similar to what audio v1 already has.

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 include/linux/usb/audio-v2.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/usb/audio-v2.h b/include/linux/usb/audio-v2.h
index ead8c9a..8fc2abd 100644
--- a/include/linux/usb/audio-v2.h
+++ b/include/linux/usb/audio-v2.h
@@ -156,6 +156,20 @@ struct uac2_feature_unit_descriptor {
 	__u8 bmaControls[]; /* variable length */
 } __attribute__((packed));
 
+#define UAC2_DT_FEATURE_UNIT_SIZE(ch)		(6 + ((ch) + 1) * 4)
+
+/* As above, but more useful for defining your own descriptors: */
+#define DECLARE_UAC2_FEATURE_UNIT_DESCRIPTOR(ch)		\
+struct uac2_feature_unit_descriptor_##ch {			\
+	__u8  bLength;						\
+	__u8  bDescriptorType;					\
+	__u8  bDescriptorSubtype;				\
+	__u8  bUnitID;						\
+	__u8  bSourceID;					\
+	__le32 bmaControls[ch + 1];				\
+	__u8  iFeature;						\
+} __packed
+
 /* 4.7.2.10 Effect Unit Descriptor */
 
 struct uac2_effect_unit_descriptor {
-- 
1.9.1

