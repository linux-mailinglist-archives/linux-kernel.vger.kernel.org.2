Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9013CCBB2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 02:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbhGSAUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 20:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbhGSAUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 20:20:38 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F49FC061762;
        Sun, 18 Jul 2021 17:17:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h1so8688460plf.6;
        Sun, 18 Jul 2021 17:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NLsPKVoeMVht4+P1ydgwHccldQwBFO5L3840AETJle0=;
        b=n0nCZnpfvgqgzMa21iGDJM/Gef7+doJaZYBNoaTnXm4Nlz+DKppzwWMvCkf/v2Yetx
         lyMhMWmGZeo1U9tuMDAnOpXSlvjPVQ+IWwQ9NdTqmztvMAwrdblduUiJC5itGh6j/xcx
         GP6hkxGvtNK+QmtHQWp+P/OAga8jTaKAMe0T8TkzGKnwy3Fx15ufJ40774CWCCs5xki2
         LvXRGI995nNEgKUJMMLP/5rCVwDKczSednfe7wwLSqF1KSO4ViutbORfpxN9Dk4ODgwk
         QzLoLC4klCMIxJf1ViyqnKhvHnwq+y7ATLju+gw4NakXhzx6Q//yjq3s7C3FSSsJlXH5
         lyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NLsPKVoeMVht4+P1ydgwHccldQwBFO5L3840AETJle0=;
        b=im5/0joUcvZd9t9eBYcmS0ly0RBJARQQgxZmKZxILIUYpMhOAmz9zMB5kwIHV5Wpo1
         SMjqSyy2Ao4cX8Ub2ajDY4PxDaS9LThn3EOzzd1JSv4XtEc1qA1CbFOp2E96hQ+K3AoR
         EfBfDBxgXdgrFfbIDVh16Zs2inmCnH26/OrgsrXm+WyVgd+ly4LxsRiZwzwQaTQ+CNHj
         taM/AiRLYsoF87bHRyjy3Xhs16eRi7UnPN5xgCjXSms2GKqr3qnEpmcvo7efQ3q36Rao
         fWc4lm5vILHoKFtTGTm3tkZsApgrZDsVVT4rH22ap3kUMRk4CeDuapbTtpoZ5GUz03Ze
         EOlQ==
X-Gm-Message-State: AOAM532WhnLsXcHkm5+FBxmAt7cNO+b8pslTmR4lhZtR3UlIP+0VqpFJ
        vuztMfo0NfgGSD98YvQPvYQ=
X-Google-Smtp-Source: ABdhPJzSjcJ0Rgpfe24Eqls4CvRbdMZEACfvAqHQ9W1NWTo2cKRo5xMviWJLQGoF/2rkwHg/2fugeA==
X-Received: by 2002:a17:90a:4404:: with SMTP id s4mr27841136pjg.218.1626653857861;
        Sun, 18 Jul 2021 17:17:37 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id x7sm1059847pfn.70.2021.07.18.17.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 17:17:37 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 1/4] ARM: dts: aspeed: Enable ADC in Facebook AST2400 common dtsi
Date:   Sun, 18 Jul 2021 17:17:21 -0700
Message-Id: <20210719001724.6410-2-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210719001724.6410-1-rentao.bupt@gmail.com>
References: <20210719001724.6410-1-rentao.bupt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Enable ADC controller in "ast2400-facebook-netbmc-common.dtsi" because
the device is used on all the Facebook AST2400 BMC platforms.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi
index 73a5503be78c..4e5e786e18b7 100644
--- a/arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi
@@ -115,3 +115,7 @@
 &vhub {
 	status = "okay";
 };
+
+&adc {
+	status = "okay";
+};
-- 
2.17.1

