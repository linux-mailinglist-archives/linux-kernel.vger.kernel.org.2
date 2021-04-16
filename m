Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3E33627B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244825AbhDPS2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 14:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244793AbhDPS2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:28:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FCDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 11:27:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s14so9621027pjl.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 11:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kb5JlZumFtGfUsottCjSrMXQXUi7GXV/EO7R62/wUoc=;
        b=E9XTkheBLEHZwDZlP2OKfqmwMmO5WZtJKjGOm051EE3lwNC0sUaazBfGmNrHFCxxVO
         ZJ0DfE62O5WEhLTDU+AxQOgWFDx+iN+3JX0Aw8TvlgPBb9ZyIk7UgYpbp6pUnW0DIabb
         P+YD26wWtLoVsJHgtGD96dM4cONd4AqyZ+RFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kb5JlZumFtGfUsottCjSrMXQXUi7GXV/EO7R62/wUoc=;
        b=QuiszDtayI3KT46hjnDMPgzxvjwauGa97Ir5WmFA7N5AGIgpcUsEiN2v/Z7tYbwE2u
         3P55X4VlsYgVeYspdXYM394GkU1OVpTTrYCLxAN5aJA5uMgTvEouVeVxnxxWuz3ksUF+
         r1grhnxMCEQLBIbHlNPDG64udZelmgzHIn+3wkP/nPcuqpFx3HI4p5oUQLaVw9L4gABn
         fRdjPLXAn0fQffGLMsTEOKuLhpx8afGAPqznP891CXlzHqmFoZwmoKOlqaLX4hvEV5ez
         pY+pcqUSdKI0Wgl4LljRtTF7WzcNfC/zOLS0oX30t2+UXN1NRV8MHrbM502z5e4v85hO
         +wtw==
X-Gm-Message-State: AOAM530TnRlEplAhTaudzoYWlCfHn1uSpf+4Bh97hw5WnUmRfth5EC9Q
        cZtl3Ia2egMFWWIhnK/cmOeXFNXOYnM3/g==
X-Google-Smtp-Source: ABdhPJwIqHYbp+28rn8REFXP3i6l3BJ9TvKy4FrZIzeOKlKEZIocvdMLpThf96VvDhHD35Av3XsKWQ==
X-Received: by 2002:a17:90a:cb10:: with SMTP id z16mr10913811pjt.106.1618597668290;
        Fri, 16 Apr 2021 11:27:48 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:2272:aa80:99d6:697c])
        by smtp.gmail.com with ESMTPSA id f5sm5391308pfd.62.2021.04.16.11.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 11:27:47 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>
Subject: [PATCH v2 1/2] platform/chrome: cros_ec: Add Type C hard reset
Date:   Fri, 16 Apr 2021 11:27:33 -0700
Message-Id: <20210416182739.2938473-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the EC command header to include the new event bit. This bit
is included in the latest version of the Chrome EC headers[1].

[1] https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h

Change-Id: I52a36e725d945665814d4e59ddd1e76a3692db9f
---
v2 is the first version the patch was introduced.

 include/linux/platform_data/cros_ec_commands.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 5ff8597ceabd..9156078c6fc6 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -5678,6 +5678,7 @@ enum tcpc_cc_polarity {
 
 #define PD_STATUS_EVENT_SOP_DISC_DONE		BIT(0)
 #define PD_STATUS_EVENT_SOP_PRIME_DISC_DONE	BIT(1)
+#define PD_STATUS_EVENT_HARD_RESET		BIT(2)
 
 struct ec_params_typec_status {
 	uint8_t port;
-- 
2.31.1.368.gbe11c130af-goog

