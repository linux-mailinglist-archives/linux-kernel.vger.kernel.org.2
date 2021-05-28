Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3983942DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbhE1Moq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:44:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42554 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbhE1MoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:44:01 -0400
Received: from mail-vs1-f72.google.com ([209.85.217.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmbon-00082Q-Kn
        for linux-kernel@vger.kernel.org; Fri, 28 May 2021 12:42:25 +0000
Received: by mail-vs1-f72.google.com with SMTP id t3-20020a67d9030000b02902367c8db155so950460vsj.19
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fEIoPxNrP5T6kipF7UD+JljPXbq0d6mIipwUTUc2Oss=;
        b=MH21XOuSz9BQWJKx2h3FrB4N8ae52LkVbNOFukiM5G+AK/E+VgbT61+Hu+ovqBro9A
         arjz6jkZF9kt7iu6QzRagriKFM7LcLPRDB4jyvRetnKYydn/NJZrVJ7AgA0dOLVTmUeJ
         vYZxppSGCZHt4KdOKANwMv4hgRm5JnmhkgK0mKL3eEOzAqgnCCBrKRuTFr+O1nKVfcPE
         SYHDgtOBzUs+CTcAqERF0A71Ckzoe0U+p8HKyIJmxiezcLCZhFrwyjzgu2DyHQtWQch+
         Rszz3n08DceDkxiw5+4OV9annk4wYKIB7XHXvUdbHUd7AZA9y325hH82U+i8CbpegOBK
         Tb+w==
X-Gm-Message-State: AOAM533Qt22DQWQJ+MO1yAvqNzDFgHdeJTd+GG/qNCxZjwMRAOhHl8kq
        JM9nIzaK4JMboFtSGh+BQBPral21ZGaL0DlMOQf2bgvmOp7+pHVe/l3aBKXaChJMvVJAPzJEaRJ
        RGKuaVdV/dmKYgois9U+E/UGCZ1t2L9skxvKpaJa3yA==
X-Received: by 2002:a67:eccc:: with SMTP id i12mr6543363vsp.45.1622205744540;
        Fri, 28 May 2021 05:42:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDadRXlslcePxNwoxbVhHp/mJrPYDYLe6dnq3jjs9H35NrGNs3pqvcHUUKSdLjy0Qc0iiMKA==
X-Received: by 2002:a67:eccc:: with SMTP id i12mr6543352vsp.45.1622205744385;
        Fri, 28 May 2021 05:42:24 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id b35sm782328uae.20.2021.05.28.05.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:42:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] nfc: st21nfca: mark ACPI and OF device ID tables as maybe unused
Date:   Fri, 28 May 2021 08:41:59 -0400
Message-Id: <20210528124200.79655-11-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528124200.79655-1-krzysztof.kozlowski@canonical.com>
References: <20210528124200.79655-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match either via OF or ACPI ID tables.  If one
configuration is disabled, the table will be unused:

    drivers/nfc/st21nfca/i2c.c:593:34: warning:
        ‘of_st21nfca_i2c_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/st21nfca/i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/st21nfca/i2c.c b/drivers/nfc/st21nfca/i2c.c
index 23ed11f91213..cebc6c06a1b6 100644
--- a/drivers/nfc/st21nfca/i2c.c
+++ b/drivers/nfc/st21nfca/i2c.c
@@ -584,13 +584,13 @@ static const struct i2c_device_id st21nfca_hci_i2c_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, st21nfca_hci_i2c_id_table);
 
-static const struct acpi_device_id st21nfca_hci_i2c_acpi_match[] = {
+static const struct acpi_device_id st21nfca_hci_i2c_acpi_match[] __maybe_unused = {
 	{"SMO2100", 0},
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, st21nfca_hci_i2c_acpi_match);
 
-static const struct of_device_id of_st21nfca_i2c_match[] = {
+static const struct of_device_id of_st21nfca_i2c_match[] __maybe_unused = {
 	{ .compatible = "st,st21nfca-i2c", },
 	{ .compatible = "st,st21nfca_i2c", },
 	{}
-- 
2.27.0

