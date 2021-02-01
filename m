Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C51330AF50
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhBASar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbhBASPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:30 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A434EC06121E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:17 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id y205so12141646pfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFuVLB0cXXkCbZq5RshAnDWx0pBkz/WKfxxkwoPXbjk=;
        b=nMPWMiXPJizdFscCnDFFH3UbjG1xkfRaIs1iiscPr/JRkNG6JChOvOXWD1SOqSlHW1
         dHt/xwPCKLz0c8W4MuSx4e4dEpfFXdmpsLYcpk89MaTSH5uU6nFhhrBRWW4g9qSv9sXk
         URHVEteOG+Go5TWYNdctYs2kAbomqYXvidrJXeo4ac7EuKAVv61+/pg/GItv8ekuxw1E
         mM7mYu+x0NcQUxmOoD//zkrdYTDBysQTC4YPBrqVvXEjLcu0TLVSix6esovUcIMYWPd4
         cRRJVZroTJqNjdbAQml9nayDLXEdE2AEZjhnFx13ZSfUu/qE1omsq3gv/FgMBAw8ZUAa
         G/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFuVLB0cXXkCbZq5RshAnDWx0pBkz/WKfxxkwoPXbjk=;
        b=Chci0M3bzkWB7VoMfKTDgspiRnWdJwntJ173wIMZKwWdwFRAL1tnkyH6Ub/gPCA54l
         Rb9ZMpTJb6FIcUWkZtVVNXpCHY0X9U1yH1+M1CZA9+VD0V3VJupCXtl4EvN5cv9lk1In
         vNbIt87h8KBSXAO9ibkArZUunG5ygN8RCSa0dhy3ng2vCp+Ih+KH/ASi3XH3kYPGXEMK
         4mfqIRcbOSfdS5VQtwTaDhO9fA7q7OnxQaCBMiezuwK2BgMoao8jH53Ef7KtSdwqj3Nq
         bscO2SkZT7D4aWv/m3BXKMDnZn89yriFTYdzFZJT07aexEz3MeT9qGUUkbCiNOBvMaKV
         ksZA==
X-Gm-Message-State: AOAM531qtOn6wGbTxc9kKnPz6DwGo6LuF6kTe9WG45vVyZiI/ex1n0x/
        WFGYuJmG/zgRM/BIcuJJx1C6T0r7rNyQuw==
X-Google-Smtp-Source: ABdhPJxWbngpziKVIIg6rRKNSMKpa4KZhltNrUD8MuKX12sY9N8c5ytWprHm2L/1B0AIlAZfnTrSpA==
X-Received: by 2002:a63:5014:: with SMTP id e20mr18068896pgb.152.1612203257247;
        Mon, 01 Feb 2021 10:14:17 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:16 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/31] coresight: etm4x: Expose trcdevarch via sysfs
Date:   Mon,  1 Feb 2021 11:13:42 -0700
Message-Id: <20210201181351.1475223-23-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Expose the TRCDEVARCH register via the sysfs for component
detection. Given that the TRCIDR1 may not completely identify
the ETM component and instead need to use TRCDEVARCH, expose
this via sysfs for tools to use it for identification.

Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-21-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../ABI/testing/sysfs-bus-coresight-devices-etm4x         | 8 ++++++++
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c       | 1 +
 2 files changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
index 881f0cd99ce4..8e53a32f8150 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
@@ -371,6 +371,14 @@ Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
 Description:	(Read) Print the content of the Device ID Register
 		(0xFC8).  The value is taken directly from the HW.
 
+What:		/sys/bus/coresight/devices/etm<N>/mgmt/trcdevarch
+Date:		January 2021
+KernelVersion:	5.12
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(Read) Print the content of the Device Architecture Register
+		(offset 0xFBC).  The value is taken directly read
+		from the HW.
+
 What:		/sys/bus/coresight/devices/etm<N>/mgmt/trcdevtype
 Date:		April 2015
 KernelVersion:	4.01
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 45aeeac2f50e..b646d53a3133 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2442,6 +2442,7 @@ static struct attribute *coresight_etmv4_mgmt_attrs[] = {
 	coresight_etm4x_reg(trcoslsr, TRCOSLSR),
 	coresight_etm4x_reg(trcconfig, TRCCONFIGR),
 	coresight_etm4x_reg(trctraceid, TRCTRACEIDR),
+	coresight_etm4x_reg(trcdevarch, TRCDEVARCH),
 	NULL,
 };
 
-- 
2.25.1

