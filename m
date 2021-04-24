Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B66C36A049
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbhDXJD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbhDXJD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:29 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF37AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s7so50599785wru.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sc8HgTLbiRFbrMbWcYG4U/VQmwhqHIp2KM2VpwNB9S4=;
        b=DINlL7cgdm6ofNHkSC+4Uz4h7mlrgtA9skOb0zJolT9S7+z7+59WrgE52rybuJC6qg
         IGk8k+sbvY6VgYIUs6Q1aI5ns/vZEsKnsBS7jmdsjUmfCr3tqEjM9MVHlHYXEHZKJC1r
         i36YXZqV7nevohk7jW2B/QmGH8PPu25+mokKw+0K98volwtbG27KiA5bHAbe4rDE7clX
         Ik4qzA7kYbVL86AR48Pti11c/9kIP/K0dQHlsGt++IChQ2en//+EWb0A6vzz1UmSOBWK
         0ReKusZ8dMDMYMiohFQl6TyEWgvvDOq8eVyM8HIh+XsIU1AUBTMV9gfsSfhjkAOjdZJ6
         7tMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sc8HgTLbiRFbrMbWcYG4U/VQmwhqHIp2KM2VpwNB9S4=;
        b=V89TIeE68O29Q8c7f7q2CtvAcci5Pc16QGzJgTS4xTE5JIHl2MJgKKEVEFjhGZ4IHA
         4ZU+usAP+pyzPGxILDPVDyoqcF0DFtX7RzJS7SzDbLW/ajMyyknAo08m6iwVUGsfPu6y
         kpRQNYHS1X6GVySIgXByL+RUdfuphXT9AhZ/3nGU4QRihFlGN8HvxigTN0R+BkVox/HZ
         Jxl+SIh7b2Mc5Af5PKWM0R7Wd5ulJcFsK7oZ6c01WM9LGFN3gak6uriaFqtjuvUh9Hap
         tvadeXPmVZvwp5c0C6in9fa00Q+Mw4Y34vGopLQARjjES13BGmncSsM5Gk46Utdzy1X6
         YTUA==
X-Gm-Message-State: AOAM532fbygRW1aM6GPHJEpOFx8jySLAQ6ozdcp3MKIuz86sVKX0sVif
        7EOlM8a6DSpd925hBEltLeh80/gOqxWbRw==
X-Google-Smtp-Source: ABdhPJw15ct2KKVN9ZgqIw9JvwQbRPxI7aUDyOQ4TUjHh74IcqT4CixUw8LfsOMKQK7SYBP4UKCZKw==
X-Received: by 2002:adf:e741:: with SMTP id c1mr9698000wrn.49.1619254970548;
        Sat, 24 Apr 2021 02:02:50 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id l12sm1130404wrm.76.2021.04.24.02.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:02:50 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/50] staging: rtl8723bs: remove unused RTW_DBGDUMP macro definition
Date:   Sat, 24 Apr 2021 11:01:52 +0200
Message-Id: <5efe991636b899936f39a7efceaac9edce9da91e.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused RTW_DBGDUMP macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index fc187a4ed2c3..c7e8187ca7f5 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -144,8 +144,6 @@
 
 #if defined(_dbgdump)
 
-#define RTW_DBGDUMP NULL /* 'stream' for _dbgdump */
-
 #endif /* defined(_dbgdump) */
 
 void mac_reg_dump(struct adapter *adapter);
-- 
2.20.1

