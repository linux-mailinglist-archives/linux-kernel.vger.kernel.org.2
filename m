Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345BF3B241A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 01:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhFWXvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 19:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFWXvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 19:51:37 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E40C061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:18 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c22so3527766qtn.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fz6Uuyh6sRmvq83eP2Z1h7AResvYGcXTWKNxvlCvilU=;
        b=zhFyFp1kwMjp+G+eb/qWIFi/JNiYlUW5yKxkVcyinMlVwt1NCW9C0QAHrd1hfLfGay
         xnGn1wZdf6uytsznzm4dtQmkvPBGkGQ7MK1jPI2Y7iKq6ykVN9Dqg6H2YXFp14t2e2fK
         R8NEslmeu/E5yWKHhGOotP3dpiriJrlVR11tVlolo1B3AEUo3mIlmhSkXIWiubGMWb4o
         cm12yON1VQU/FKPnzuceLMmCg0Vy0Bw4nVjbWKpNeT7WVXFEV8M79pgYXNfv54fczRI+
         7Bl1neqNW7ZomHTQ8cEslQE8mg1wQc6wPi9bbHNgPcIHDGvXRi22lLq3PqPC+V9pA3XR
         +4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fz6Uuyh6sRmvq83eP2Z1h7AResvYGcXTWKNxvlCvilU=;
        b=Za4RZU5mUs7n5vRY9uxemhlKiJnXRUIWwyWusq2jLs98UxOR6bc3avnbjAWO8xrUQx
         kZ8IC7tQLCAwr0wfLpdgrUGbbJHq5s9TADOCHnq5ccLvv4S1r+/ZwGK9yiTwGXjGNepB
         t726GWVDllSabm+ODjYYIuTr3QJ8ov0tpA0nCWsfflPcFCTFJOSgFvdZ4y4ObeeWBIW0
         Pg8R20xasf/1iQjtzG9anOtyWVJapyrQfRrBO+kePTXAIV64Kb6RNNVlISHQ6FjRMXw2
         5vuxKlmP7pUfjzQ2lEpi5O7coa9QjJrc+Kkdv/Zx7+/6EE2qcAickHoI6nnuLjd8UlkQ
         v6EQ==
X-Gm-Message-State: AOAM533XnB+XFgpaPrNqvnZW8eAZPgpCa5G2vXqxsMU55Asko6eZA9Fp
        8ncngl+BwOTNu+xBurIjhWnQKA==
X-Google-Smtp-Source: ABdhPJxMcsRNz95A3x0PY/7qIZy2+HXw+OkuF80368AT/Un5zI7k69Jrp+G/6rSvUJ1hZTTA3qJ8OA==
X-Received: by 2002:ac8:12c6:: with SMTP id b6mr2341172qtj.352.1624492158164;
        Wed, 23 Jun 2021 16:49:18 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id w2sm992387qto.50.2021.06.23.16.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 16:49:17 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 8/9] staging: rtl8188eu: remove MSG_88E calls from hal/usb_halinit.c
Date:   Thu, 24 Jun 2021 00:49:01 +0100
Message-Id: <20210623234902.7411-9-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210623234902.7411-1-phil@philpotter.co.uk>
References: <20210623234902.7411-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove both MSG_88E calls from hal/usb_halinit.c, as well as the
unused local 'jiffies' variables from the rtw_hal_read_chip_info
function. This macro is unnecessary, and removing all calls will
ultimately allow the removal of the macro itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index dcdf868b394d..093aa4ab3ad4 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -1056,14 +1056,7 @@ static void _ReadPROMContent(struct adapter *Adapter)
 
 void rtw_hal_read_chip_info(struct adapter *Adapter)
 {
-	unsigned long start = jiffies;
-
-	MSG_88E("====> %s\n", __func__);
-
 	_ReadPROMContent(Adapter);
-
-	MSG_88E("<==== %s in %d ms\n", __func__,
-		jiffies_to_msecs(jiffies - start));
 }
 
 #define GPIO_DEBUG_PORT_NUM 0
-- 
2.31.1

