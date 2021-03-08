Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED09331172
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhCHO4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhCHOzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:55:40 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0C4C061762
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 06:55:40 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id lr13so20975825ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 06:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLj7Gp4AXNBIRfM05Fb/npNKmdzGnIj+j8T+QIUmIp0=;
        b=GYwAt5N11Htctvk5vaStUU1oMV8AcHJat8k+JeWcUlAP6NIzKfpP2octcY7sipgk3Q
         q2JbUqobc5/wdXMc3ss58YGJM1/dfaYyxxVtxbzbXRmGPABKNLCY4f8p9dE17XRZWR4P
         G4eWbUvaydrHkOhcAKITzQ4XatIdcCRogDyorfkg9j9xZPTLwSBwVpPrx36/8lCWs64y
         AmnbbHYZYZRjlVXrAFO8UFbyNEm3nAGU280MlSxCdKPqrVn6TGqZM6/tk9WeB3xyULdp
         duSPWwZG4Bs2YEcTeTv9hOjWQC+g8vtDuFJLHkEArTfM+f7c3u1IiTVgSOgSM1mvqH1E
         MAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLj7Gp4AXNBIRfM05Fb/npNKmdzGnIj+j8T+QIUmIp0=;
        b=QYuYRwHMvFd1BVbHSJRKQGaC4dNg4unZ++fYa06wE4orOcdK5lW9f+LzmgETLUJN4M
         km8oTfvGJWvbCfy3m2eSAYAhNxjKfvQRaKYMwVGv07qrIEB+GxYwCD9IfrWBjWB7qMEH
         ibQbyFkGo9XEi0vGy5PSR8nqfVILMsKlnNF61dC5AwVddypPMyE6caUduje3iNeTJPbA
         s0YjJsOpMpPmNoM2froKGIhDBqzgSOmpXmGGgjRgFkt15kcMY7b6XYH+i+LoI8cD8xPv
         6VQy1uxscxti15XaFioMQ0DBSkqA7T4jkKPOpGhK0K2nZL3kzZRrte4I07spoc2o+GE2
         bwVA==
X-Gm-Message-State: AOAM530leUTaIKezrkG+j5vS0K76QiWUX9AJcFOkJXZOVDPp26wP6QKt
        lDsZog7lB/D9OwL9DG+5Fc8lzg==
X-Google-Smtp-Source: ABdhPJwujoxKBULC2TiDF0uTmZ725nCMJDdNLnOASHbIowxRxu7/T7o0BEees1GbdUH3W536CdvnxQ==
X-Received: by 2002:a17:906:2804:: with SMTP id r4mr15241523ejc.521.1615215339299;
        Mon, 08 Mar 2021 06:55:39 -0800 (PST)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id bt14sm7411234edb.92.2021.03.08.06.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 06:55:38 -0800 (PST)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, elder@kernel.org,
        johan@kernel.org, vireshk@kernel.org, rmfrfs@gmail.com,
        f.fainelli@gmail.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 10/10] spi: docs: update info about 'delay_usecs'
Date:   Mon,  8 Mar 2021 16:55:02 +0200
Message-Id: <20210308145502.1075689-11-aardelean@deviqon.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210308145502.1075689-1-aardelean@deviqon.com>
References: <20210308145502.1075689-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'delay_usecs' field is no longer present on the spi_transfer struct.
This change updates the doc to mention the usage of the (relatively) new
'delay' field.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 Documentation/spi/spi-summary.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
index f1daffe10d78..d4239025461d 100644
--- a/Documentation/spi/spi-summary.rst
+++ b/Documentation/spi/spi-summary.rst
@@ -411,8 +411,11 @@ any more such messages.
         duplex (one pointer is NULL) transfers;
 
       + optionally defining short delays after transfers ... using
-        the spi_transfer.delay_usecs setting (this delay can be the
-        only protocol effect, if the buffer length is zero);
+        the spi_transfer.delay.value setting (this delay can be the
+        only protocol effect, if the buffer length is zero) ...
+        when specifying this delay the default spi_transfer.delay.unit
+        is microseconds, however this can be adjusted to clock cycles
+        or nanoseconds if needed;
 
       + whether the chipselect becomes inactive after a transfer and
         any delay ... by using the spi_transfer.cs_change flag;
-- 
2.29.2

