Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49303263E3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhBZOPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhBZOO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:14:58 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A3DC061786
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 06:14:17 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gt32so3533937ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 06:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LUu93rGA1cHh0fyqCMn68WZCCrDnAzCezR4V6cd4F40=;
        b=af+gg5BZ4ZAapi4Qfsk9u7x2RNMSU0TV+BRUD5V4dMNR83ZAHBB/2nGj6S0A4j2K+0
         s7og7GkPbfioM1qaDCoKg0W8is2b0pJDWy5qXZsU8B/jbzYD3urYQL4odSEOMEVVH7Rc
         qeIxewcBW6HuJ75ZEUNeRzqU2cMv9wYlDkTkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LUu93rGA1cHh0fyqCMn68WZCCrDnAzCezR4V6cd4F40=;
        b=VNu4DLO4dYPq0amQA1gjURLqe6ZDXnKtGIQo767k29pAMCqKH5A1GHn4yZSehMc3yG
         KEcOQC+dX2cxxzL9nf4kpXw+VRr5W/3sKnfzmx347pQJ3vrm92GCF5fODkv5jyYvmAi7
         IweSb5mXSQ183RVF5NmGc1mb2WOGpfWv436H6gxuuzVUkcBLvONkZCMg+XdPfJnjmef4
         d69ytsWKMFxWDFdgBY8/UjqFzedYOEyCNuKZfnrfsY89glVnXdio25iUaTtO1q+W4Hee
         Kmqf2gxjfjMK+C+LU/thRUa5f1ItZZwbrFnFJtH/B8OCkMGliPIFqiaxPWIxEdF7cWaZ
         CY8A==
X-Gm-Message-State: AOAM5315IQELPiLV+KZvI4dnzKEYWDVJZ5wU2Rkj+zYYwkg30CSBqOf5
        ECaGmKK7WldASf5e7PxTC4W2gg==
X-Google-Smtp-Source: ABdhPJzabGx6JCofY0z/Cp5d89cR8H1+SNGOEkjVaC9c8nTuduiSccUfn/vsu5zSdaHECDAwJmIUCg==
X-Received: by 2002:a17:906:8147:: with SMTP id z7mr3451969ejw.436.1614348856083;
        Fri, 26 Feb 2021 06:14:16 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id g3sm5316838ejz.91.2021.02.26.06.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 06:14:15 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 1/2] dt-bindings: misc: add binding for generic ripple counter
Date:   Fri, 26 Feb 2021 15:14:10 +0100
Message-Id: <20210226141411.2517368-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210226141411.2517368-1-linux@rasmusvillemoes.dk>
References: <20210226141411.2517368-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While a ripple counter can not usually be interfaced with (directly)
from software, it may still be a crucial component in a board
layout. To prevent its input clock from being disabled by the clock
core because it apparently has no consumer, one needs to be able to
represent that consumer in DT.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 Documentation/devicetree/bindings/misc/ripple-ctr.txt | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/ripple-ctr.txt

diff --git a/Documentation/devicetree/bindings/misc/ripple-ctr.txt b/Documentation/devicetree/bindings/misc/ripple-ctr.txt
new file mode 100644
index 000000000000..1497d3a237a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/ripple-ctr.txt
@@ -0,0 +1,8 @@
+Generic ripple counter
+
+A ripple counter is a simple component that can for example be used to
+delay propagation of a signal.
+
+Required properties:
+- compatible: Must be "linux,ripple-ctr".
+- clocks: Input clock specifier. Refer to common clock bindings.
-- 
2.29.2

