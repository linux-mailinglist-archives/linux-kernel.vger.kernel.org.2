Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DDA3AF69A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 22:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhFUUHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 16:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbhFUUHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 16:07:44 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCCDC061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 13:05:28 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id g13so16612286ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 13:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6aAyIi+XtBCw6wYHWjVuD7ADYttGvdZ1z2bvHqZj1U=;
        b=CB1YfmSkP5KLCU5a4n59qBKb4NQk7ovW7vCE1BkkSMe8nAJJYjMjjy86CslKSGGUkL
         hX1sP7jxhYjtWY+4fiyr0+H2KTMQGIaamTA4yKU3fyCrGuxu+UYgfXjJvBFN++C/Vfw0
         qLaqDifr1Gzodo9s5cUxdvbDscADRuEwhEjgxfIFINfAnuI3GvQjAu5sipTfyEYbuKVh
         BKuZLe+/+xbZxP0+Q9q/BXprhBtjSH3JDbxeedh9Bma8vMNqNeB9cPwYaHWVIgEXCTUx
         58v10sza/xjekeBZMIMTk1IpRHZpI9fyFk5PG+ZP4ngGuEmOxG2OPi5j0Z8aIrTvmvny
         FV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6aAyIi+XtBCw6wYHWjVuD7ADYttGvdZ1z2bvHqZj1U=;
        b=sP3zGLRw4mVQaAgLjcYw9ahu28JcfqDj+Zbj6Qm+5NAAKMyYQb1YtlVdRZkxgnf5LN
         jJHEwBS8XZvm6WSsQ3umoS8Lzb8xI0ZW4wvkdRF1yDRS6bfz4AqpIJl2n/RRrq2+Qs6j
         ENZw8qxns8la11YjzUEk/QUk26a2woRtQ/glJJAIyguda4TeRlmcZX1G6su4GOsgiwXV
         2SaAHkLkstufDxkhXK1VLyC+fCtQz3cyqcv6Qywk+QQKfdhwpr7BoUlY/9Ci5/j2nAEU
         axxQXVHU36z7+aZjKZKBq7cSZyZWJfWB87vMt1koOYKTN6ieubWEJTT2WYnNo55faY3v
         c8YQ==
X-Gm-Message-State: AOAM531jBStsyO5YvPzh+cJZ3PlQRowxKTU65i3MS5StREPeykQgA1pb
        Acit0mrT43xCWXUHK3lJoazbbx52QdJaBw==
X-Google-Smtp-Source: ABdhPJzsj6xCgfa2wIRqTg20r4G81qjBd+Mlwr1su74cWgm3AMYoE7btXEgJSOmT3QctpSiqmr13PQ==
X-Received: by 2002:a2e:a263:: with SMTP id k3mr73471ljm.41.1624305927219;
        Mon, 21 Jun 2021 13:05:27 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id c12sm1968828lfp.179.2021.06.21.13.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 13:05:26 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org
Cc:     jaz@semihalf.com, gjb@semihalf.com, upstream@semihalf.com,
        Samer.El-Haj-Mahmoud@arm.com, jon@solid-run.com, tn@semihalf.com,
        rjw@rjwysocki.net, lenb@kernel.org, erik.kaneda@intel.com,
        robert.moore@intel.com, Marcin Wojtas <mw@semihalf.com>
Subject: [net-next: PATCH v3 1/1] ACPI: SPCR: Add new 16550-compatible Serial Port Subtype
Date:   Mon, 21 Jun 2021 22:04:59 +0200
Message-Id: <20210621200459.3558199-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microsoft Debug Port Table 2 (DBG2) specification revision
May 31, 2017 adds support for 16550-compatible Serial Port
Subtype with parameters defined in Generic Address Structure (GAS) [1]

Add its support in SPCR parsing routine.

[1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-debug-port-table

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 include/acpi/actbl1.h | 1 +
 drivers/acpi/spcr.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index ce59903c2695..f746012eba8d 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -498,6 +498,7 @@ struct acpi_dbg2_device {
 #define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
 #define ACPI_DBG2_ARM_DCC           0x000F
 #define ACPI_DBG2_BCM2835           0x0010
+#define ACPI_DBG2_16550_WITH_GAS    0x0012
 
 #define ACPI_DBG2_1394_STANDARD     0x0000
 
diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 88460bacd5ae..25c2d0be953e 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -136,6 +136,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 		break;
 	case ACPI_DBG2_16550_COMPATIBLE:
 	case ACPI_DBG2_16550_SUBSET:
+	case ACPI_DBG2_16550_WITH_GAS:
 		uart = "uart";
 		break;
 	default:
-- 
2.29.0

