Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB703F23ED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 02:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbhHTAB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 20:01:27 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:37569 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbhHTAB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 20:01:26 -0400
Received: by mail-ot1-f54.google.com with SMTP id i3-20020a056830210300b0051af5666070so1173253otc.4;
        Thu, 19 Aug 2021 17:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q7Md1SKC8t2SotEQAgga4ouGsRj8D4YBMiV2S+I75Ts=;
        b=VElfeH63O0DeZoN6bK2vxNltionC3xP6QPrc0NLh1Bxykhi2SODY6nlWV1jzG1uXnD
         RTRaPAyhdFCZZZ9M66uZL2hk/8OoysM2uN5VHb4Va46of0yrAEPCki6KzJla6kB/dqEI
         0mWNP0yImVYxO80kUVdCCV1FRBYOdhP3i2cUW8+FZSoabdCZMhY9tetxQo2mfhqdp8Rr
         1js3W66MVowDN2T55/cpnsF/8wtWaEIzQpfMC07WyriTMvMK/ArMffSXDEE2it26aFAu
         hMqT71ribCTE/N/E7yy5mjkg0VdZcR3hfGEUUaJX24rcBxAvZbnr+IS2/CHMl4RpLU5I
         s21g==
X-Gm-Message-State: AOAM530JeDfTr1QBc2Q+w99f4097rWgVhigpsaMaIGow2nzxe2hYQuJD
        QanqED21ANdPzmIW5PHpHHOKF3WZvg==
X-Google-Smtp-Source: ABdhPJwOD+YyhSwjyb7KMxOXII3HkvwDgfykHcIDukG0CQUoUFL2xk/2tmmyHZzrTMdav6XubaGHRg==
X-Received: by 2002:a9d:630e:: with SMTP id q14mr13952810otk.316.1629417649043;
        Thu, 19 Aug 2021 17:00:49 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id s10sm924691oog.14.2021.08.19.17.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:00:48 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Output yamllint warnings to stderr
Date:   Thu, 19 Aug 2021 19:00:47 -0500
Message-Id: <20210820000047.1667819-1-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yamllint warnings go to stdout which means on a quiet build no warnings
are output. Fix this and redirect the yamllint output to stderr.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 5ccfed90cc70..a072e95de626 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -28,7 +28,7 @@ find_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
 
 quiet_cmd_yamllint = LINT    $(src)
       cmd_yamllint = ($(find_cmd) | \
-                     xargs $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint) || true
+                     xargs $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint >&2) || true
 
 quiet_cmd_chk_bindings = CHKDT   $@
       cmd_chk_bindings = ($(find_cmd) | \
-- 
2.30.2

