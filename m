Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE0D44736A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 16:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhKGPF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 10:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbhKGPFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 10:05:52 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFE7C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 07:03:10 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id c12so6996185qtd.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 07:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5PiAUxlIouGkMo4Hs45dNAcVnUrnIKf4M+gHTrcC9v4=;
        b=ZGF646gUUDjQTtCac82GZJd95CvzwX9taQ2gibOGsCXYj/UrUM7prNoN2Z2MWTUtV3
         X+V13GtgKhLkaHYr3C703nFjxrlgVpbchR96LkMIfk+z3LHpSIoj630+Do6XBJniGh68
         qRUCeeRpbel6SZs3tnKBSWyH02C9k8R9g8UNKki/w/g49jiSjLhm7Qh24Vd+Xa2vIV1/
         Kmye1PqAnyZ0vo8/maoh1uwTTemzlUVrOJPQRb3IKmL8hv4/4yMzNbHV8lBkMfSbQ9eK
         l7KXGsgaEmYd4Mfp/q1sahbLNqg/f2yIy0CsAH53TLdL2Ldi4WwW4CVSTVW9qSSqojd+
         HO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5PiAUxlIouGkMo4Hs45dNAcVnUrnIKf4M+gHTrcC9v4=;
        b=FelNc5RRb+Y+cTklHB8FTTbq8vKK9Yx7HqVADcgMNsuHHQ6zlU/jc04XopbkF2IA8k
         d3REe813Lk6YzmZjib5vNvW4nibn+Ej9+LoL3LPAtRe8r6QafjiYzitB96gdKnJoe3zt
         1f4Kz5Yml6m/NH1G7BsHYmxt8VqX+ZjLwbdtNwhaFGPWupbRxEkGrwyZDiTxYkpYI6+F
         Y14JflyAkRoz03X2/sXoBeJD7rZ9Ons6cVBINxagn9T4JddlzzP31bTc/QHJpfl40U/T
         oGhsrLpn7KtoMrqPDxcKG72Sk8G4Bih0QG8K5MbcKI/4HS6aMRF2nthwstYXLSSVa623
         +kAw==
X-Gm-Message-State: AOAM530W+GYaqw05zoQ4U4v7lxjy8hm/GCr8P+YtbqMBeg9cevaLVeX+
        cyZCxYvZWj9p87y1UXHP3so=
X-Google-Smtp-Source: ABdhPJwv7s7X8+gewqUDkoBUoRbaWD8EM2EcjySJyUbbPQZO5D7Avtd9zAmZ/r4Zaz2pb+15gZwV+A==
X-Received: by 2002:ac8:5a4a:: with SMTP id o10mr78076033qta.318.1636297389317;
        Sun, 07 Nov 2021 07:03:09 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5c21:92d0:fc01:11b0:47fa:d730])
        by smtp.gmail.com with ESMTPSA id x11sm9554883qta.90.2021.11.07.07.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 07:03:09 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     ojeda@kernel.org
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH 1/2] auxdisplay: charlcd: fixing coding style issue
Date:   Sun,  7 Nov 2021 12:03:03 -0300
Message-Id: <20211107150304.3253-2-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211107150304.3253-1-sampaio.ime@gmail.com>
References: <20211107150304.3253-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing 'int' from 'unsigned long int' declaration, which is unnecessary.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/auxdisplay/charlcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 304accde365c..cca3b600c0ba 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -37,7 +37,7 @@ struct charlcd_priv {
 	bool must_clear;
 
 	/* contains the LCD config state */
-	unsigned long int flags;
+	unsigned long flags;
 
 	/* Current escape sequence and it's length or -1 if outside */
 	struct {
-- 
2.33.1

