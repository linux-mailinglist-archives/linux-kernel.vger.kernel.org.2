Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5080C347F91
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbhCXRfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbhCXReb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:34:31 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CEBC06178A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:26 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id jy13so34221823ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QyPG1WEqZFTBuDaWcANV4HkcWu30kB5AaRBOC44dMcU=;
        b=x34RZDCkoRcSFIBBxVgvp+zHfS6nJJrdmtFvrYSb1iqICIoh6VlPMSgqm1epY4jDhD
         QvZgdgquPJPb6Ry6SqX2sDNO//7WzUnOwXU41yX2Xbp7vI7bCmyC6UKbsgniS3hkiDwe
         2DZRVPfs0FMdC31pWIKDHB8mOm6/GWeQ+jyknqeIT5fNY1vqtHLvGQn8L0yS6qlxrn9A
         QKoBS9npWrI9cw0OOkwrdhJ15m/vg5dPpCLua01KkkpDV15EsGyQJI7E3LL6zE3QT2pz
         VDnuKc5KOCvoFrnwOdeVB5tqJV7/3XAWFoAmnx94nvioCq/tvQjEZKe6OfhQhgoTxu1a
         WNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QyPG1WEqZFTBuDaWcANV4HkcWu30kB5AaRBOC44dMcU=;
        b=Nok9SbiTEXbnDQL8AjqRK/5JA5sPvxPfyfbggOpKRxwZ5HeGf/4Tari5OmesF0OHDw
         8AI0pSM53XxhZaAj+32Rui89dNCzJYocrNbrwCSvMGWJ/xiPX/vEWBJ2jrsQcDH8VAZC
         pM/ghy9wuYdmDEHpVHoaFGXQ3ms6jYIEXOK03hdAeCvnKzRlwfVAjQYeh7qj4lk+LXca
         V+lqkLMOCiA2yHPxdefgXNX36AhfSa1V/F2aXccfkMGThDEXtyfHVJhPCK7kTxWtIbtn
         MueVZE1knyJgN/4VDMFDHScbfIfACSYbe9oAmUu6vAhqXSdeng/5cd/9YilKA4ZztzLR
         DpuQ==
X-Gm-Message-State: AOAM531UkCxpvrDeBz3JIXvYybxQ9ZGsrhMGmRG+Xw8F62xPmeNusNj+
        Q7N8GKp2YOaY7Ms3z1pUwZ+/Iw==
X-Google-Smtp-Source: ABdhPJwRwrC8EEYenWLs4RGZ9Kg2dyDeJq/LMFkNo2BqT3C9pBFeEJizZTNkRQh0YmvZI4K++sB9AQ==
X-Received: by 2002:a17:906:d114:: with SMTP id b20mr4911433ejz.449.1616607265313;
        Wed, 24 Mar 2021 10:34:25 -0700 (PDT)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id p19sm1466367edr.57.2021.03.24.10.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:34:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 17/25] HID: hid-uclogic-rdesc: Kernel-doc is for functions and structs
Date:   Wed, 24 Mar 2021 17:33:56 +0000
Message-Id: <20210324173404.66340-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210324173404.66340-1-lee.jones@linaro.org>
References: <20210324173404.66340-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/hid-uclogic-rdesc.c:645: warning: wrong kernel-doc identifier on line:

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/hid-uclogic-rdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index bf5da6de7bba9..6dd6dcd09c8bc 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -641,7 +641,7 @@ const __u8 uclogic_rdesc_pen_v2_template_arr[] = {
 const size_t uclogic_rdesc_pen_v2_template_size =
 			sizeof(uclogic_rdesc_pen_v2_template_arr);
 
-/**
+/*
  * Expand to the contents of a generic buttonpad report descriptor.
  *
  * @_padding:	Padding from the end of button bits at bit 44, until
-- 
2.27.0

