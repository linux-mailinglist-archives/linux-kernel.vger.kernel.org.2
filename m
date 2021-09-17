Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5434F40F4C9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbhIQJ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:28:16 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48784
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343499AbhIQJYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:24:43 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1EE653F4B9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631870527;
        bh=0xA9iYVKPlBXWipAtGMdHpXi9msntAFNL6yrDBccejQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=LX/Is/S7s4WWXmxBRrD3BILuCRzUv5QRVZQQ8+CKszrojTIT/6mHxZQOwC4yUxaBZ
         aJVCe1nv2er/uLXzyTcvAeQ17rZ+UO//kc6kKRQOIR2+EqFeTk8jYd7HCebUsa+8gj
         080uiRVwwFZX+ELZ6YLQKNL2oGTqJBeSBmyKESXf6p1mrbZME3iPCMAXJR+FBc6iPV
         6Ov14EWa0814JM/EvRqS/ga224aU4mUhGNQ7Y94Zsp80rvNa9Mye6PYUhuowKK1b/V
         fsdNtgeqP/G4f8GqyS/p4Hfu8GLhMtPj0FNMZgdKaOJUBSeU03QnHclpmhoKRzFUno
         RkO8LrMkERwWw==
Received: by mail-wm1-f72.google.com with SMTP id c187-20020a1c35c4000000b00304b489f2d8so4364793wma.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 02:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0xA9iYVKPlBXWipAtGMdHpXi9msntAFNL6yrDBccejQ=;
        b=PQsClegQavkL3p6Za3wE4Jxq0bllEJGK2B7rZ7tBHMj5sWmuEJYH91PEXF8XE5JT8u
         CiCVpbg+QrSmN+Q+CIDw6PulAZt30ZRW81VUSy7OiW6h9D8NZn9EnRzNNqZ0gG2YWaoy
         TOb2ECOyyv8+dtnxLv3xQkrKL+ztEXjQB5AoNN/1ug7tySfdDZFhI4dcnr88l6020IuK
         ulbdvj6kl+EidI48dDbcB4Zb9NCIPka4OSRqfczWtu4qtAAUdT+yXmjRdKeaRPoNoVI4
         puoCMfc2PXGFIY1kRpIhN65hvgMW2xt43EF4x+lgVQgRHIvjV7Z+O5mWXbAjS2GcLC0l
         CihQ==
X-Gm-Message-State: AOAM530BInsm2/aljMkDK2lTBvh8NMBy3kL9gpFbGON6KvS68FU+vW4s
        1Zh0/nzk/CnXslCzgOsZi+z4txTTGuLr85dze1bUchC5alAog+/+U+STvGZahUqd8QWZnYyVjIS
        ib4mg8pwRW/YJP9MqXElEX8QwxENJBzO5MM3La4LVtQ==
X-Received: by 2002:a5d:64ea:: with SMTP id g10mr7870104wri.274.1631870526481;
        Fri, 17 Sep 2021 02:22:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyM4QLRlJ3XkBwIXnQxYsAEyBMDrbjCNY66KTEJUyx4rLj3D0co0hbQIOmIwZ6QAg/cfiiADw==
X-Received: by 2002:a5d:64ea:: with SMTP id g10mr7870084wri.274.1631870526335;
        Fri, 17 Sep 2021 02:22:06 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id d5sm6531260wra.38.2021.09.17.02.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:22:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: siano: remove duplicate USB device IDs
Date:   Fri, 17 Sep 2021 11:21:32 +0200
Message-Id: <20210917092132.19576-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devices 0x187f,0x0202 and 0x187f,0x0301 are already on the list.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/media/usb/siano/smsusb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
index df4c5dcba39c..fe9c7b3a950e 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -661,10 +661,6 @@ static const struct usb_device_id smsusb_id_table[] = {
 		.driver_info = SMS1XXX_BOARD_HAUPPAUGE_WINDHAM },
 	{ USB_DEVICE(0x2040, 0x5590),
 		.driver_info = SMS1XXX_BOARD_HAUPPAUGE_WINDHAM },
-	{ USB_DEVICE(0x187f, 0x0202),
-		.driver_info = SMS1XXX_BOARD_SIANO_NICE },
-	{ USB_DEVICE(0x187f, 0x0301),
-		.driver_info = SMS1XXX_BOARD_SIANO_VENICE },
 	{ USB_DEVICE(0x2040, 0xb900),
 		.driver_info = SMS1XXX_BOARD_HAUPPAUGE_WINDHAM },
 	{ USB_DEVICE(0x2040, 0xb910),
-- 
2.30.2

