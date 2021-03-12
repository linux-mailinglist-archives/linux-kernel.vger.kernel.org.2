Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DC73385D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhCLGZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbhCLGZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:25:04 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72C3C061574;
        Thu, 11 Mar 2021 22:25:03 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d23so8233534plq.2;
        Thu, 11 Mar 2021 22:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5MyPBmk1C8ie7jP7O+6glrmTm0KIKY96spBPNQzghLQ=;
        b=ex0cOuUANAFDwsEUj7ZGRvRlguns98be6ws3vdkZJN0au3/3kuKzaQqr+xd7eGPOki
         uo+ZlQvhHpXoWRXGktNreXjgWBA3JeGijlV77SQZi0UmN1QhjR1y0fw2g1lyFc+tXqKh
         CiMxnGmRRUUu7lV0GL3oRwRP9aKUY7ymtr9l2B5agwRhHw9/WfOY+rN8d1hiZ7uJH+cF
         9fP3mFnFkgNCyX/O31ss51JX1CiaPoUi+ybRHIdR0VMoggigcIRMoRPvEJCtx5iHp4Ny
         KWdT1iJ1RMLPOtYGoz8lh5F7IbOYBQWdIfG2KuS76nGahojITkjkRAvJDg8XmUmYX3wt
         SlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5MyPBmk1C8ie7jP7O+6glrmTm0KIKY96spBPNQzghLQ=;
        b=eKx6jNyP4/ooCKqStvYHUs/pUnzKMzjVDLlHa48r3NAAMsi9FkeSAAMOPxKqtdeDnP
         W60GjMRO9N36c2ycRSYC5uW0RcQ7VqkgJHgjOfN6Xf6Bn7Jt3FB1KsYLX5yqWNUoEQCL
         XQjbkQWa3Vceq0r/DrEjvXSFcjLUwWLfG5Fomf6kfFnZhMY4jzH8O8Vk78NRwCG79u0j
         P/xWH7GgPgK4ecFVA39P37Qm0k05jy9Ik9GSjAc9s8FIajbwjJBRklorQCRDJTqNgG0b
         DoHFdo7sgynmjiC0vvjOlM1r862+VesmHXQpYb9Q/WBQ2rvoS5FGxyN/cQZEcYaF6cbO
         R8sw==
X-Gm-Message-State: AOAM533fI+/m39HxygRjwzE8CPOUHTAwv0zp0uHx5bhIYKONDOaSDPuB
        bZjh7lmOxarud8rxD/w36FJi9PPdIOeQag==
X-Google-Smtp-Source: ABdhPJzm5Z0nHh00gpWHKeoBmdB9evTXPx/W5Kbpwpegz8oOONb0Cx4COufEeadnwTzvbsfLLUMljw==
X-Received: by 2002:a17:902:cec8:b029:e4:a497:da8d with SMTP id d8-20020a170902cec8b02900e4a497da8dmr12138708plg.16.1615530303365;
        Thu, 11 Mar 2021 22:25:03 -0800 (PST)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id h6sm4048406pfb.157.2021.03.11.22.25.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 22:25:03 -0800 (PST)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, alexandre.torgue@foss.st.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v2 7/8] ARM: stm32: Add a new SOC - STM32H750
Date:   Fri, 12 Mar 2021 14:24:33 +0800
Message-Id: <1615530274-31422-8-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
References: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

The STM32H750 is a Cortex-M7 MCU running at 480MHz and containing 128KBytes
internal flash, 1MiB SRAM.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
v2: no changes

 arch/arm/mach-stm32/board-dt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
index 011d57b488c2..a766310d8dca 100644
--- a/arch/arm/mach-stm32/board-dt.c
+++ b/arch/arm/mach-stm32/board-dt.c
@@ -17,6 +17,7 @@ static const char *const stm32_compat[] __initconst = {
 	"st,stm32f746",
 	"st,stm32f769",
 	"st,stm32h743",
+	"st,stm32h750",
 	"st,stm32mp157",
 	NULL
 };
-- 
2.7.4

