Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0E53424A7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhCSS2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhCSS2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:28:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389FDC06174A;
        Fri, 19 Mar 2021 11:28:10 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id dm8so11916086edb.2;
        Fri, 19 Mar 2021 11:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EM7JC43IVWcp3nEFu0gDCR5Wo09NKYkxznZ0QTA4BIY=;
        b=g0HxaZGZUz9eHQydmGhhhOzkdd7x7QGLC7lotAXvH6DCDD4me7BBoYKHvOdgUxntbp
         4YFgXEBoXjzy/J7wHtYznj0jTRQF19gwHhDf8NTP2jrlOYs1IrsZMRDaiClK0V+XBtFF
         5/WzixxeK0xIRqup/gczpB37jdDnVeUqIJ/BoOAcL6xZJ+eBeCAacE3OFKJB9cfcbjuj
         tBUY+2yxAg1K8eogQCmqPyFonGIKdpO0HOcODXPEM9Azudlt1zocMCDCEIem81koMhVT
         bZ6MNJl6xAGxmUri4gzHQnHdA8YLzJ0+ZNzDbeI/jxsSlBkTT2Rq848jKFRDt0s/dF2T
         zvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EM7JC43IVWcp3nEFu0gDCR5Wo09NKYkxznZ0QTA4BIY=;
        b=r7gaGNGquzcO2K0X+fXlwIbdvZXMC3lfNyo1usASelrLDbgWiKBWRFYv418GlnHxAd
         2XDC8cuWYhPqSUlEN+vNf3HkQQxJXwNToXgk7zpJnbNmTYi2swWBX9V8OnARS3XZrS82
         qBuvdbpa6RBsEeFzt4vEfolYzU2L3fIrXRNgwr0XfMtAS2/epbbCe4Zo7tphZBZHgwHa
         5M1/xTgQDryVuswg+4AkD9JRZ6yrnmo0zIITDqxZdouH5FITkS5FxCU2P2g+GutqLQ3s
         BjTqcDfI7mOKnTGnNXa0v6ru8GfzlgWH38I1f2lNOblzjFcGmn2J9JP36+gvNLjj79m1
         LZYQ==
X-Gm-Message-State: AOAM531k3O88ILmjKCzW+Sa54xmQ+bW6W0CHsYauv71MKEFBxFpnbk0c
        E8HhtVbNrISI0i+joAdNcxE=
X-Google-Smtp-Source: ABdhPJyDuDcix29yDHCqJv0NQ+RcQSRulZQgDhDYfs8irdBW4RY58iYdVJTBb+sJ3W526dqEMYt+yw==
X-Received: by 2002:aa7:da46:: with SMTP id w6mr11341879eds.40.1616178489040;
        Fri, 19 Mar 2021 11:28:09 -0700 (PDT)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id gb22sm3951070ejc.78.2021.03.19.11.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:28:08 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] MAINTAINERS: Add entry for Actions Semi Owl socinfo binding
Date:   Fri, 19 Mar 2021 20:28:02 +0200
Message-Id: <fc4dd769f497bcc955858cd5591d1e523d83d881.1616178258.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1616178258.git.cristian.ciocaltea@gmail.com>
References: <cover.1616178258.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the Actions Semi Owl socinfo binding.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20b8e37ea34c..21d54ddcceb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1533,6 +1533,7 @@ F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 F:	Documentation/devicetree/bindings/net/actions,owl-emac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,*
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
+F:	Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
 F:	arch/arm/boot/dts/owl-*
 F:	arch/arm/mach-actions/
-- 
2.31.0

