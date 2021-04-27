Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956B536CA98
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbhD0Rui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236172AbhD0Ruh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:50:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DF3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:49:53 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so7664925pjv.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yA9WdPgXIZgxGfJrBsyNh8U+RFX+tzg70/IRFeEI7os=;
        b=Xe4ChCCKOyNEBF28z0nWa1x8TYCr8qZqXsYqWo/3juv0xyaAPIbIK8bCaRanG++5ud
         o5PUbaII5sIn9fzO5+rTOn/5lPh7qmLavC/9mjdZijowHihq5vJslk+w2Pn9nxAyz4uO
         c2U8vl4UXX6uNPiFS3PjZIt3TA2/fSmuTGUyBPAGHC5q2i9wC1g59ShW19XqLggJjQtm
         VJPgP+INO8A1zWRtncmdSodm8+Idbq95xLnk0HuflfSOcG48+jiwdnAEW1bRZdfdFdeU
         w+cUDm56YS1+7ioBCDyFbsuz66OW8wDjshndNHVb9wSCSjbnxE5rounHaIPDQV0AAoRi
         NsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yA9WdPgXIZgxGfJrBsyNh8U+RFX+tzg70/IRFeEI7os=;
        b=DkXyM5J2w7duwKEGDlymbWrVGnPMhhTqpt5DHIWALJpNInUHCUYadQA5cNVhwwcKCy
         cIJzMsOml1ioFlLK0liCrIw7wDnT3WjDfoSpgXiBSVifg/7wDdgmYhZFEfhZY3dfq5qK
         PxkBwlKyfTRdCIfPKOdiQ1lQ4PhmSjA/XyiArzrIU6RaxOoLdcZ7rVigukLi2+mBquYi
         7HR6Yc3Cc6fGnvdhmnw4dHcjWaJUMnuf5/0wWM1D2/lrNR7Dp/7dpexcIgAA5Lrox35h
         1x+p7l6x0CHC4VCediiWdxXNIytPTpNPz5qm1bZgh/M+LMnU9czgQcPqQ8mQo/r9rBwH
         z15w==
X-Gm-Message-State: AOAM530hengBGSt7WLwrH94pHS6GGNmpheqDoj4IIK1ZuM6Q5ROHSoyy
        Dlr0tJ4M7x5skWKY6XUXUiM=
X-Google-Smtp-Source: ABdhPJxLRn3CSaprpXp/9FwYm9WQCOFnBrodvXbqcdSZJ0/Mh++rtn4qAJuZGG8KT6sUy4VdOXHBnQ==
X-Received: by 2002:a17:90a:3948:: with SMTP id n8mr2927079pjf.32.1619545792604;
        Tue, 27 Apr 2021 10:49:52 -0700 (PDT)
Received: from localhost.localdomain ([103.52.209.34])
        by smtp.googlemail.com with ESMTPSA id gx21sm2990284pjb.29.2021.04.27.10.49.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Apr 2021 10:49:51 -0700 (PDT)
From:   Jitendra Khasdev <jkhasdev@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     jkhasdev@gmail.com
Subject: [PATCH] staging: rtl8192e: fix array of flexible structures
Date:   Tue, 27 Apr 2021 23:19:45 +0530
Message-Id: <20210427174945.1323-1-jkhasdev@gmail.com>
X-Mailer: git-send-email 2.13.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes sparse warning "array of flexible structures"
for rtllib.h.

eg. drivers/staging/rtl8192e/rtllib.h:832:48: warning: array of
flexible structures

Signed-off-by: Jitendra Khasdev <jkhasdev@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 4cabaf2..c7cb318 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -802,7 +802,7 @@ struct rtllib_authentication {
 	__le16 transaction;
 	__le16 status;
 	/*challenge*/
-	struct rtllib_info_element info_element[];
+	struct rtllib_info_element *info_element;
 } __packed;
 
 struct rtllib_disauth {
@@ -818,7 +818,7 @@ struct rtllib_disassoc {
 struct rtllib_probe_request {
 	struct rtllib_hdr_3addr header;
 	/* SSID, supported rates */
-	struct rtllib_info_element info_element[];
+	struct rtllib_info_element *info_element;
 } __packed;
 
 struct rtllib_probe_response {
@@ -829,7 +829,7 @@ struct rtllib_probe_response {
 	/* SSID, supported rates, FH params, DS params,
 	 * CF params, IBSS params, TIM (if beacon), RSN
 	 */
-	struct rtllib_info_element info_element[];
+	struct rtllib_info_element *info_element;
 } __packed;
 
 /* Alias beacon for probe_response */
@@ -840,7 +840,7 @@ struct rtllib_assoc_request_frame {
 	__le16 capability;
 	__le16 listen_interval;
 	/* SSID, supported rates, RSN */
-	struct rtllib_info_element info_element[];
+	struct rtllib_info_element *info_element;
 } __packed;
 
 struct rtllib_assoc_response_frame {
@@ -848,7 +848,7 @@ struct rtllib_assoc_response_frame {
 	__le16 capability;
 	__le16 status;
 	__le16 aid;
-	struct rtllib_info_element info_element[]; /* supported rates */
+	struct rtllib_info_element *info_element; /* supported rates */
 } __packed;
 
 struct rtllib_txb {
-- 
1.8.3.1

