Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EAE40E5C7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351319AbhIPRP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:15:26 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54312
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347669AbhIPRIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:08:32 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F07A9402A0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 17:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631811934;
        bh=xmMlFpxNYUGHhWNpAFsSQHnuFL2wu1djSf/pThsAMRw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=RTUe6+LUJnJhHIddAHptDxOSdL5xPGpCviAAE+7NWTZLTPY+dlxcjG1O1TvxXjV5E
         JTw9nTxLoALMrGKZcsNPXUKh2cLeBEcEaEFerWzavjzV8R3Yoaef6HAMqdAM42kEoo
         qXirkkQHkf22OWCARxAH1K33udJKhai6y+gwcGUCSZVPdthYrrWH645RtbnYfQqXiY
         S2uEAFlI5VYK+sNWuZUxV9vwwLUWSckJa4GxjkBcZK1wQkRdZAIYwuS/4qAICgqVuf
         QrlkGFPa2J2UgYjV7vPG3kKkG5wgWWYVg2WSCeSnonrrO7M4g1R2ZHGq3kBfziPp79
         u3MF8KwrEYt7g==
Received: by mail-wm1-f70.google.com with SMTP id y12-20020a1c7d0c000000b003077f64d75fso3389061wmc.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 10:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmMlFpxNYUGHhWNpAFsSQHnuFL2wu1djSf/pThsAMRw=;
        b=XKtxi5+51mf+UDjkKnvOv7w4FWqV0XF2Wc0UoOXyjJt25FeEt4vlIS2m9YTni7geox
         3rjw/DT5fboW61J03H66ZrDavNkJ/MGDhJR7jl2wlRh9foohy9F70/EfTvo12JVP3ibk
         iKJ/L0c76nMDIpHD4by1fxRU4dnpCKSsaJYKmT1YFbFNMt5eJa8Aq7Fp+em9DbRjOgSg
         gpA+6TnYW51Y7SBtKG1eVml4b+SxFWCGZZW4DjzvC+2OBv4XjIrBTePwxATasdnQJErh
         YHR9wAUpYZeUvjxvEQVnpSMEQ/3uwTORdKG2nbVi9WhJMPiBAYpo10SF/8jU4AQ9uzLk
         n6qQ==
X-Gm-Message-State: AOAM533u9w2xkSESSqM/Q0ZePHDbXmLosp+tyL2Xa+RdXgSqTZgaUo/h
        WPJf73aJrXq1kNI2hTd5c/y/uQS4ibMdsUGcP8Csn30ntE5VyZ0zoJ7pP6ip3SF0t8ZMWKPeNBH
        5yof/HeUs2Y8a6XLfDoVN67dhapyUYeMpAO3+gMI4cQ==
X-Received: by 2002:adf:e384:: with SMTP id e4mr7278490wrm.163.1631811934458;
        Thu, 16 Sep 2021 10:05:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmMz9cgr5kJ+3gR03Sf0NrO0bEAz5zD+KEznHUHd9k7UtPSJUPKB5wOA6I1DqE0hLK+jXvKg==
X-Received: by 2002:adf:e384:: with SMTP id e4mr7278470wrm.163.1631811934335;
        Thu, 16 Sep 2021 10:05:34 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id u25sm4425269wmm.5.2021.09.16.10.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:05:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-usb@vger.kernel.org
Subject: [PATCH] usb: host: ehci-mv: drop duplicated MODULE_ALIAS
Date:   Thu, 16 Sep 2021 19:05:31 +0200
Message-Id: <20210916170531.138335-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is one MODULE_ALIAS already.

Fixes: 0440fa3d1b4e ("USB: EHCI: make ehci-mv a separate driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/usb/host/ehci-mv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 8fd27249ad25..fa46d217dd10 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -258,8 +258,6 @@ static int mv_ehci_remove(struct platform_device *pdev)
 	return 0;
 }
 
-MODULE_ALIAS("mv-ehci");
-
 static const struct platform_device_id ehci_id_table[] = {
 	{"pxa-u2oehci", 0},
 	{"pxa-sph", 0},
-- 
2.30.2

