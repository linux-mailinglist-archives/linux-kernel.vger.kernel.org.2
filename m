Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428C332BBBB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446925AbhCCMrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842534AbhCCIG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:06:29 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D9DC061797;
        Wed,  3 Mar 2021 00:05:47 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c19so3661016pjq.3;
        Wed, 03 Mar 2021 00:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sDbztN44X/B/8dJkz0MmLiQc+JMIMWoneNFLgfTEAQg=;
        b=V18aHYAjb+sB7qRw721z+elzxN9FQUiIKjmzgUevEjnfPIOycyzsaOTwMoWZvI2f8O
         /87tyRjLuwT+MVqNxtVPjMzgE4TDQEwWwK/3rsAWY5t/b2oO0WlFW65jUAG/CuJvPDt4
         oaDcWbNI0Cee29rSQx3roq11xg4U8LBZK27I7ysA3vLChWzT5aMd/CrNy9+Spg8rRkqV
         HXE9GP21dXlMGeO0CHvyn2EpkINRIloS5fZV1YyXnu1D9/MVkW91YrdnXdR/6swF5fBT
         SUvGtVO46Uz16aGaxKXF1mKwBZ/H/e/gTxwS+cnSTIwM9+ofA0c44oMLgerZ8L9Wa/2y
         1eJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sDbztN44X/B/8dJkz0MmLiQc+JMIMWoneNFLgfTEAQg=;
        b=NqPNmOZh2AeriTzczYadZCoH4fniq8AQYgk6v+5EDmyiye076ddhSpqWmNiIceSEga
         An1Ou71HimKV61ad5ccY239A/LWgzZjkZq13oqPwqHSd9FRoikOfk95ZTAN5hg9w1iXb
         yuPLAG6JAgZ9Is7Y0DWy+VgxcdPuJ3bIJAvtQDW/96BBRWQ4rM0jQRnTMvq+GOaHHLxF
         yh7mYZarB1WJP9gO9OMn8POhalN62BFewf4rcgTedhdQ5S2HJFM9DEq57rfJF0S8MIg8
         JH0IT890HXadu4FbQ9Yr8VYiqUuERQzyWhCic0t+f32MQxGPL6IkRohC3JQRLMG8zsJs
         yrhw==
X-Gm-Message-State: AOAM530GhIiLlKrgMe0nL0xQTt4KEqhPqnpUxeuOzdCUDaxh48tjP5R1
        AQMCft8JhTQqXSHoKQzzB9w=
X-Google-Smtp-Source: ABdhPJw35HqF3ZjssyHn/UOSrDZ5l/gwsM+pD3UYkZksJ9N/8eqHLXTzgTIoUI0o2SZXNpEJJUULnQ==
X-Received: by 2002:a17:90a:4f85:: with SMTP id q5mr8157503pjh.42.1614758747054;
        Wed, 03 Mar 2021 00:05:47 -0800 (PST)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id h6sm22260887pfv.84.2021.03.03.00.05.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Mar 2021 00:05:46 -0800 (PST)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 8/8] ARM: stm32: add initial support for stm32h750
Date:   Wed,  3 Mar 2021 16:05:17 +0800
Message-Id: <1614758717-18223-9-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
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

