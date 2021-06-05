Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600BB39C637
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 08:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhFEGZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 02:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFEGZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 02:25:52 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9963C061766;
        Fri,  4 Jun 2021 23:24:04 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id f22so9083408pfn.0;
        Fri, 04 Jun 2021 23:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mRLzIEsUR/L5fTfNptj18L/QHNRpPol1gX/tfrGQ/rY=;
        b=qjR3K7Y6bnavkxQ2PlGFoAdxV2duS8lTe7alKIVqY/p6DtShc2wS3dsn0KCq+JT+KL
         lmmrTHCnXMvlFjqVUu3tJ20Vk9ZWeAA+hIargnOSpHI23KQagmLqbSiUL9CupmiplG9E
         GiBlnRUQCRrLiMASOD76WI949ayVGPPXY0W5FhNxaXnatlhNKRBFbEzSAjuBYA+KoZb3
         h/Q8YBdp3iCUNKEyLOlBDLexkiW++IOZ7OJ8h72kvwr/Xk7w/YpUqMwz0n8EWwq7ub/w
         VYPOOfA0qra99l0gWWFTmmb6XUZcu0VXxz9G9oBpJlB3pA06qCjEvA5vVd09Zf4Fyn3o
         XrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mRLzIEsUR/L5fTfNptj18L/QHNRpPol1gX/tfrGQ/rY=;
        b=IhQpTPRgo4DXB1EWH8Y65vFdyv89QnWVtTSZAv3WmZtnKB5Lw638rNH0j6Z+ci7bq1
         0A7aGe7nJJGusVF+TJEDFL+3M36UFE959920W2XtbddBYamfwhyBanhS+0givhJAJO1z
         KQ34/5TYWUxygUurijF9Yk1Hk3DX8/DeYvZA5GFst7uBbMRdTS3Ji4y3zj1+Iz2P+nJS
         UJnBV6ZytN4xaLkGlFfmIwZnjKOzZUryhH9M3t9AFJ+nGnGv2EKI9zngjiRVkqwuNbQ/
         S6y5ywk5dfmsFLfm5Z6WmjfYPNSo1DRmpFE29bc/SXocUFV2Gb9YDfTtHWXRofzZzhYG
         tY+g==
X-Gm-Message-State: AOAM531HeGwIS/FtLodR4cAjOHJe3Mn0I19e/dYn/0EjIldHXXFHIq2O
        N2gCHgEy+cWhXglTQS6bZUs=
X-Google-Smtp-Source: ABdhPJyuKkPF0M7qEYRAx+3TGanu2WwwR8XDOK7b9zvGa8OuSNfGhn+gKmyZurDZQtX+VAoFro0tmA==
X-Received: by 2002:a62:2c0e:0:b029:2e9:dcb9:4a09 with SMTP id s14-20020a622c0e0000b02902e9dcb94a09mr8027048pfs.75.1622874244454;
        Fri, 04 Jun 2021 23:24:04 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id v14sm2800870pgo.89.2021.06.04.23.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 23:24:04 -0700 (PDT)
From:   xieqinick@gmail.com
To:     robh+dt@kernel.org, narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
Subject: [PATCH 5/6] arm64: dts: meson: vim1: add i2c aliases
Date:   Sat,  5 Jun 2021 14:23:12 +0800
Message-Id: <20210605062313.418343-6-xieqinick@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210605062313.418343-1-xieqinick@gmail.com>
References: <20210605062313.418343-1-xieqinick@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Xie <nick@khadas.com>

Add i2c aliases for Khadas VIM1.

Signed-off-by: Nick Xie <nick@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index f116a9d91633..d175d6cae535 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -32,6 +32,8 @@ aliases {
 		serial2 = &uart_B;
 		serial3 = &uart_C;
 		serial4 = &uart_AO_B;
+		i2c0 = &i2c_A;
+		i2c1 = &i2c_B;
 		ethernet0 = &ethmac;
 	};
 
-- 
2.25.1

