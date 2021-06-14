Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F233A6595
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbhFNLlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:41:03 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:44585 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbhFNL12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:27:28 -0400
Received: by mail-wr1-f49.google.com with SMTP id f2so14132698wri.11;
        Mon, 14 Jun 2021 04:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aExKys5nPg/zXn5F7DojkmqPz+FIBM7Z0Dn8A8LEku4=;
        b=Ie24aQaoyChqcb+HNOMsLTUkczQc8SP6l2BP3Hf6Qu48t+V7K3taL3rqxFmTVtgM2O
         pizDcO9ixTJSIxoNRnvcC4rwKR5lAX5eWgd5KNwI9gO9xUjbdZmN7Bhaf1YN/EoBzRvO
         cYLLFyWBgA0u7m/kmf39btqJMJN2J6hHmbBoRqeLAubpTMSAWc4YxUZapjei3D4Zj+nL
         UWWvBwZk/7/BmTH15mV1BpUqUfi+MT2QdNnSwaSFbl9SYiO12usYrYhKRDT9Mfd88ubG
         7W0+bvZo6erPWGl79Y8/rNLJlXnM54CLHWFc+V4ZRJXT8QKHn2BY0wlKqAC1DtLpEVQe
         aevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aExKys5nPg/zXn5F7DojkmqPz+FIBM7Z0Dn8A8LEku4=;
        b=sKGKl8C3x9NAfmyJWmSmHdm5LgL3uyLFG1Y1neiCczZ9JSSr6ZvuzrP8S6wCcucTkg
         ovI0uWPtyS0A6pu1vR0mUVUB+cP0uvtjtGL6a7RnFv65QsJhtcJcfUayQL4Dl7hZ9U91
         En41FhgQfdOeAq0cQAXJZpapygtUeU9/fZHGsc7F3LPCFLlAfMQfWTnxvWEkTUx/bvEx
         dC0sUJ4cgtfSfcnL0EDmCM4cvG2HZ5CCOCaVOD9vssBywER7HmcTAO76L8teltkwjPT+
         QYToWqdpNp2fzhuTM39RHOecPUtAR9F6kzZLu2o6EJjsKhirQbr0k16XeGjebkepeRG4
         s27w==
X-Gm-Message-State: AOAM530VD9kKkDTYkREQ1CD2F4g1yNJV+jdM1VAL5L9wWhfEHhCJ8zPQ
        zznx4YILKx9SJKNcg384I4o=
X-Google-Smtp-Source: ABdhPJwwItFDBd59d0Z3WIlkUwimhgq5j5SPp5Xw+uvteNXopxbzmDC40kuQPmaoUjGaNQDdxUMeuw==
X-Received: by 2002:adf:efc3:: with SMTP id i3mr18139641wrp.356.1623669852100;
        Mon, 14 Jun 2021 04:24:12 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d62:e800:a8e7:80e:6e34:237d])
        by smtp.gmail.com with ESMTPSA id w13sm17269485wrc.31.2021.06.14.04.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 04:24:11 -0700 (PDT)
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
Subject: [PATCH v2 3/3] MAINTAINERS: rectify entry for INTEL KEEM BAY DRM DRIVER
Date:   Mon, 14 Jun 2021 13:23:49 +0200
Message-Id: <20210614112349.26108-4-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210614112349.26108-1-lukas.bulwahn@gmail.com>
References: <20210614112349.26108-1-lukas.bulwahn@gmail.com>
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

Fixes: ed794057b052 ("drm/kmb: Build files for KeemBay Display driver")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e8dfe48afd8..89089c7ed77b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9388,7 +9388,7 @@ INTEL KEEM BAY DRM DRIVER
 M:	Anitha Chrisanthus <anitha.chrisanthus@intel.com>
 M:	Edmund Dea <edmund.j.dea@intel.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/intel,kmb_display.yaml
+F:	Documentation/devicetree/bindings/display/intel,keembay-display.yaml
 F:	drivers/gpu/drm/kmb/
 
 INTEL KEEM BAY OCS AES/SM4 CRYPTO DRIVER
-- 
2.17.1

