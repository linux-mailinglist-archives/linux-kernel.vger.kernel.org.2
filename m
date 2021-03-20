Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A553429D4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 02:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCTB5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 21:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhCTB47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 21:56:59 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249E2C061760;
        Fri, 19 Mar 2021 18:56:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id k4so3752819plk.5;
        Fri, 19 Mar 2021 18:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8FTVU3LWtPn+X8DSzdXj1PWQwyL9r/ZJgzNh2Y8x2JQ=;
        b=N4ffAJyFhchEB9erJdyTbYkCV7fliK1eaTj8SSzIoqTM96hCNNzHOOyyhGSlEp324g
         tTSX+zx1HHGkxFj/dIq3AfobJrcxn25EC4ntuSe05yO8y9EYtsrCFQuLN69I+DpWGTTP
         R+JSYrAV6prz7dj0sBoOj24pRFoi0T+FHWp9o5lIL6ZsLoNS4LJb0JQ2e8e4EvdNeXaf
         X3DpOfixb/K2Zsb2D4fX9jnEbm2laabpibfj0rk/Tj5+0jMlnG2kRHodxJIoRoruG3nb
         U075xRBivMpvnvnDxUrCjU49UYQijGJkefwNdvqrLT9SGa0fF0R/iF+pHNzP0mv1LoSo
         th3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8FTVU3LWtPn+X8DSzdXj1PWQwyL9r/ZJgzNh2Y8x2JQ=;
        b=TvjbWRAm0HKh0YM3vIe+feRybnQ2kJjdIrkuw8eeFszK/sKO1rDw13hsXanxf6fJrT
         ytgKXZO266LRFhP+3SZQfQ/dogKhsz2jyV1FDPWwGk8AEfa3u2ErpvOd63CUyBAedV8L
         QEvpStwiQvym6SusiHAnYrZmXvNPT0zgqvU0Uz9sZIMI+Qr3sVIjW7HZw1KMX95EVV6D
         uNieTetI1vTpJSMFVnixqpWghIB4h1P7llIo1j/Y9GVAPQRdNPTA19usacgk9G9HN6mT
         jfUrhfqW1R85irbhLUYTyqsn3jRCxLkFXP61rV4AdYo+2q9a9g8MqJhVF1k8//WtSx/t
         3kgw==
X-Gm-Message-State: AOAM531hse12vjDYe+pSiBxIIEbh0Ox0qEEYawVi2k/q0gUYDLEPalKP
        2mOGwcaz7IXL487IuMmAwjs=
X-Google-Smtp-Source: ABdhPJxTphiaQnw5fxGiRHrAbaU/EVBReiXVAXwkfAT8d8Q6KR/qIc9IIz10+kKQ/fdVMlelOpcdVQ==
X-Received: by 2002:a17:90a:ff91:: with SMTP id hf17mr1430826pjb.34.1616205418820;
        Fri, 19 Mar 2021 18:56:58 -0700 (PDT)
Received: from localhost.localdomain ([204.44.111.4])
        by smtp.gmail.com with ESMTPSA id y7sm5755904pgp.23.2021.03.19.18.56.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 18:56:58 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     alexandre.torgue@foss.st.com, rong.a.chen@intel.com,
        robh+dt@kernel.org, a.fatoum@pengutronix.de,
        mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@foss.st.com, linux-serial@vger.kernel.org,
        lkp@intel.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v4 7/9] ARM: stm32: Add a new SOC - STM32H750
Date:   Sat, 20 Mar 2021 09:56:21 +0800
Message-Id: <1616205383-24114-6-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1616205383-24114-1-git-send-email-dillon.minfei@gmail.com>
References: <1616205383-24114-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

The STM32H750 is a Cortex-M7 MCU running at 480MHz
and containing 128KBytes internal flash, 1MiB SRAM.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

v4: no changes

 arch/arm/mach-stm32/board-dt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
index 011d57b488c2..a766310d8dca 100644
--- a/arch/arm/mach-stm32/board-dt.c
+++ b/arch/arm/mach-stm32/board-dt.c
@@ -17,6 +17,7 @@
 	"st,stm32f746",
 	"st,stm32f769",
 	"st,stm32h743",
+	"st,stm32h750",
 	"st,stm32mp157",
 	NULL
 };
-- 
1.9.1

