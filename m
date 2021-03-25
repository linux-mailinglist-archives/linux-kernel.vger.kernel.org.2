Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AF4348903
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 07:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhCYGUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 02:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhCYGT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 02:19:58 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDA1C06174A;
        Wed, 24 Mar 2021 23:19:58 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id v186so762600pgv.7;
        Wed, 24 Mar 2021 23:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y2ugCPlO8XWjx6bQzXAXSnErBAV9ElhMwDzxktw9ft8=;
        b=aGlhyI8r09B7KRQ4e5fGXcjPjRmsW0P/dClqRHyxUxiwyq/CTqr4wpYiXGvdl52Yx7
         VKHB+y+q0ABtZBK4lL8ciaGl1dtIurKvIUeeujK5XKw/Qnr/gy91Q7tA4/fjE/I0q7B7
         4ddfmYpR8bOZuOl6J+eLpaoj916b9AO9wHZkUTaaSX6ONH76RYlWtURTMqZOC6WUY4IJ
         C1IG9qhAL7V/bstfE8fMaNWk3AF6yfuxrHG4c+NJCLMyJbqRcFc9YAQ5mPhmkfugodgN
         B/Jpv6kMw1EeJAZH2n3GE2acGiIw/uyAp3N4+YDBnGOUANnB3C8Jj3kdmawmxjk9LWww
         RKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y2ugCPlO8XWjx6bQzXAXSnErBAV9ElhMwDzxktw9ft8=;
        b=HieCHIL3qJWXMvF7SU7pOmB/mG75Ep6s7JnH5qi8egE+wA2v1NmWv3ihhlwetqF44j
         7yjb8cTveCnUi0fIuT/HG+mtoivCECj49oe+49uD+0w2VmwRwMNFvzOm8frZC031mXi2
         XtgvglRVp4f3YSES3SazfE7Djz+OljgqH2z68VtP21dRH573h8Ry18F1QCRC8i5wFCeQ
         BezjCLj1bMKBfVM9D/jMrVQIZuzf3t2Z3AbyhTUgHu1AjrQ1tnu2ZS8Qtmil1ruBJtAo
         hl/ntwShr5dFKgkybGAA0Apsll+a7YwTDwqjgWP1/yw6RXkoTJCtoklKM4OjXNHqck69
         v13Q==
X-Gm-Message-State: AOAM530F98qOUW1o0T1gkYRs8+ZR7MhFaRVsh4WKqkflkqOIpi/TxAo1
        Z0c1okDh9TRCOIP3jJ+9z6Q=
X-Google-Smtp-Source: ABdhPJyjjw6N0G9zVOkj9wsRmVAMLRCK5yCcScA8pzH+IzNNVlZ4LF7um7yQEOrgUePXzn8yBgyBpg==
X-Received: by 2002:a17:902:b68b:b029:e6:cda9:39d with SMTP id c11-20020a170902b68bb02900e6cda9039dmr7838709pls.63.1616653198286;
        Wed, 24 Mar 2021 23:19:58 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id b19sm4393086pfo.7.2021.03.24.23.19.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:19:58 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh@kernel.org, valentin.caron@foss.st.com,
        Alexandre.torgue@foss.st.com, rong.a.chen@intel.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@foss.st.com, erwan.leray@st.com,
        linux-serial@vger.kernel.org, lkp@intel.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v5 9/9] dt-bindings: serial: stm32: Use 'type: object' instead of false for 'additionalProperties'
Date:   Thu, 25 Mar 2021 14:19:22 +0800
Message-Id: <1616653162-19954-8-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616653162-19954-1-git-send-email-dillon.minfei@gmail.com>
References: <1616653162-19954-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

To use additional properties 'bluetooth' on serial, need replace false with
'type: object' for 'additionalProperties' to make it as a node, else will
run into dtbs_check warnings.

'arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: serial@40004800:
'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'

Fixes: af1c2d81695b ("dt-bindings: serial: Convert STM32 UART to json-schema")
Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Valentin Caron <valentin.caron@foss.st.com>
Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

v5: accroding to rob's suggestion, replace false with 'type: object'
    of 'additionalProperties'.

 Documentation/devicetree/bindings/serial/st,stm32-uart.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 8631678283f9..865be05083c3 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -80,7 +80,8 @@ required:
   - interrupts
   - clocks
 
-additionalProperties: false
+additionalProperties:
+  type: object
 
 examples:
   - |
-- 
2.7.4

