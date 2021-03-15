Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FCF33C136
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhCOQF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhCOQFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:05:12 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25596C06174A;
        Mon, 15 Mar 2021 09:05:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id dm8so17984632edb.2;
        Mon, 15 Mar 2021 09:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FljM5O4no01T3zMPSj+9HrXILkQkfa5uYRr3HKS0+KQ=;
        b=ZxWdOQ1fxdryYMQ1jE0BHV06hBmUh7f4HL9gSza3U/XeT4M+px/Ef6DOjP0LtHoPvs
         F+cU7JCfPOvCEDGfyD5a9K6Ps67aOJZzvj+gL4p3CdEeznO/4kAzMcCDCbCFCVIiDeVU
         LPNp1jXRNBZ9t0qfaUTT/MGa9kb5UMPSH+gDWmZoCCjpIIrKZxailZZD5dByW8k+8YmE
         ohQCagRNNvjjRHtjrALmOWyOmiQUx6CyrrkxS8jYMCFHQ3laV8IJCELznk/9wjrxT5R7
         onTfM0jm+6Elh8POIIXz4axhq8pb1P4H6Da1GN6INJ0jQAUPzQiwVCona1+QsbtshdTP
         TloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FljM5O4no01T3zMPSj+9HrXILkQkfa5uYRr3HKS0+KQ=;
        b=tbZXUdbJ6+DHovQkc1zP/hE7rhLRDZ874sBEkqHi1JHp9wKMX+me+yaes5dP+2D8UL
         cC3U/+7/Lw9N27chxTvods5fiAAS7ctRUMFRY+sQH88ZiAfkyhIUeAsBe0zUZsZOoW56
         cvAIEXv4NtFZLtD1pUjVyFeL1PHnv9c5PmxiI3ywFwfWADBWJZ5fsqXwrFzjeFjLQh9O
         evDSF+MA41Z0XvzkzmFeXEmHgEYIS0+gAntQKN1yf9QJv/YIjqzVVuN2i+q8oenpjaAG
         60MmpxmFcZp6IROS9auPh2ryKcqlq3gEqM/XEKQXMF4kF6/G/oHHVxmwv0znVOyLfu6E
         B9sQ==
X-Gm-Message-State: AOAM533lOJCByCPAqh2zEnQTgfraGRILuW88mr+r+Vl5VjtWolID0LEG
        iwdAgDQ0LOvkGDJKXvgXv4k=
X-Google-Smtp-Source: ABdhPJwHjwHX30y7hobuNM0cAWlvVgM0lNp/sF6RUOa/7cUxPaE0sSvqYX1tk01ufTh/vSZetEtvtQ==
X-Received: by 2002:aa7:cf95:: with SMTP id z21mr30258658edx.76.1615824310865;
        Mon, 15 Mar 2021 09:05:10 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d28:c000:5c39:c910:15c8:a935])
        by smtp.gmail.com with ESMTPSA id z17sm7748510eju.27.2021.03.15.09.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:05:10 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 4/5] MAINTAINERS: rectify entry for INTEL KEEM BAY DRM DRIVER
Date:   Mon, 15 Mar 2021 17:04:50 +0100
Message-Id: <20210315160451.7469-5-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210315160451.7469-1-lukas.bulwahn@gmail.com>
References: <20210315160451.7469-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ed794057b052 ("drm/kmb: Build files for KeemBay Display driver")
refers to the non-existing file intel,kmb_display.yaml in
./Documentation/devicetree/bindings/display/.

Commit 5a76b1ed73b9 ("dt-bindings: display: Add support for Intel KeemBay
Display") originating from the same patch series however adds the file
intel,keembay-display.yaml in that directory instead.

So, refer to intel,keembay-display.yaml in the INTEL KEEM BAY DRM DRIVER
section instead.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66c756c68bfd..a046e62b619d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9096,7 +9096,7 @@ INTEL KEEM BAY DRM DRIVER
 M:	Anitha Chrisanthus <anitha.chrisanthus@intel.com>
 M:	Edmund Dea <edmund.j.dea@intel.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/intel,kmb_display.yaml
+F:	Documentation/devicetree/bindings/display/intel,keembay-display.yaml
 F:	drivers/gpu/drm/kmb/
 
 INTEL KEEM BAY OCS AES/SM4 CRYPTO DRIVER
-- 
2.17.1

