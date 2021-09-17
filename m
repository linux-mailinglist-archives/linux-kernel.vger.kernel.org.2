Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D8940F164
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 06:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244663AbhIQEkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 00:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244662AbhIQEkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 00:40:10 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D1FC061574;
        Thu, 16 Sep 2021 21:38:49 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id j66so12235567oih.12;
        Thu, 16 Sep 2021 21:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iHKwZS+aimcKzvLWTq+aBcYwRb/TW8RNbTdMXIa9CSw=;
        b=d8ELRas3EOVWZpf+bhTwTqVH24OSAlOW7uDbIDF3QA5TvhvQQjLpumarjo1xKSMSD1
         Ji/J6FLRBGRW4Ut787UtGnPIxOS/xYBc1wYbqX9Re3L06dnhHXj81Ab23GgeEqwaCmsr
         MXEpIskptKZ9d1e9d9B/QLAFakM8/MQBrBPeOF+IWH7l90EOq6swDS726wdELYd3WyUL
         qBn3tbmcAkG2rjCrjcp7k9gOmMWEERJ8EQcjymcMscfiGYffhrG5J4boBMgLCoksFcae
         GTK3HE8XXfQTiZD3J4iGj8MLA3taDnPt1DsKvjzOgs5lBGmMOsfgLnB5GXZ+ZaJODsl9
         bBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=iHKwZS+aimcKzvLWTq+aBcYwRb/TW8RNbTdMXIa9CSw=;
        b=oKhBMIyjzUNe/I93x8xrqeW09uYvcHIDLGblJ7K1KgRzNdjSewZb2SBaJex3YdXOB3
         MaQ+JWfPjy4K7OYWHgDcKYlqUwhU4Jwg0Xc0ph5bm/BO8JA0EtcILEuDlJlJZMkm2Wkr
         f0imucW8GH3hdll+96ZOkn1/Ak6naraAFrIAq9GiT+yFLNLre3HYsJb3hp1FpewTZd8Y
         SgAPCcEzjA1DCpTXaec4RhPgc3YztAkRx+2xQCc87yQvhe0EKpG7e7s6EuNzCSq88Og6
         qHOs8IiakTgPqFNnWvgFzj6HkslZ1/+th5ld2pJdwHOmQvmdW03jso2KFSg6n1LCYsS5
         GS4g==
X-Gm-Message-State: AOAM533LJ5MT2WWrnrvbR3vai0w45DiQTmkViggUb3YBAKX2eqYbQQxO
        evxYyh2Kh+rQ40C31MfHAioTSORd3W4=
X-Google-Smtp-Source: ABdhPJx4QnYFReu0mXkc43H5vzSp7fNs0ddsBsga+bNHSX1vHzAqS8kpoWYYSU0qeE7uOD9YxfAtIQ==
X-Received: by 2002:aca:5d04:: with SMTP id r4mr11744366oib.94.1631853528576;
        Thu, 16 Sep 2021 21:38:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n23sm607816otj.70.2021.09.16.21.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 21:38:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/3] csky: Make HAVE_TCM depend on !COMPILE_TEST
Date:   Thu, 16 Sep 2021 21:38:38 -0700
Message-Id: <20210917043838.3514789-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917043838.3514789-1-linux@roeck-us.net>
References: <20210917043838.3514789-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building csky:allmodconfig results in the following build errors.

arch/csky/mm/tcm.c:9:2: error:
		#error "You should define ITCM_RAM_BASE"
    9 | #error "You should define ITCM_RAM_BASE"
      |  ^~~~~
arch/csky/mm/tcm.c:14:2: error:
		#error "You should define DTCM_RAM_BASE"
   14 | #error "You should define DTCM_RAM_BASE"
      |  ^~~~~
arch/csky/mm/tcm.c:18:2: error:
		#error "You should define correct DTCM_RAM_BASE"
   18 | #error "You should define correct DTCM_RAM_BASE"

This is seen with compile tests since those enable HAVE_TCM,
but do not provide useful default values for ITCM_RAM_BASE or
DTCM_RAM_BASE. Disable HAVE_TCM for commpile tests to avoid
the error.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/csky/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 58ca3ef02bab..823d3d5a9e11 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -241,6 +241,7 @@ endchoice
 
 menuconfig HAVE_TCM
 	bool "Tightly-Coupled/Sram Memory"
+	depends on !COMPILE_TEST
 	help
 	  The implementation are not only used by TCM (Tightly-Coupled Meory)
 	  but also used by sram on SOC bus. It follow existed linux tcm
-- 
2.33.0

