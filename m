Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD80E3545AE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 18:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhDEQup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 12:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhDEQuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:50:37 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBD4C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 09:50:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso7886607wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5lLBdOAva93h7sba5wfimP9PBGLz9NegQLKVskRq+74=;
        b=KIl2NCpe68hPJ/Tg2SAuV1834Z/8EqBVs3S5strfFb8PuIE6j1dWKUmUbDwOegTM/L
         mdBvwaVm6oVXKI0t1rYgj3vozJNjV9eGds8YShhq1P/+ZykaCBcL1WCSZ2Uv2JJ3B7qh
         pPni2wmJvFw4+e/MYY945GlH8SnePV8hmeVbHaf8VO1AsOoy9UbJAK6e0CgypOB1j+UW
         /CWkC/aknl1EZk2fAneVCTLYLNWrfYO36PxEBf2nqENddLJA8MztgdnpZmu2x7cqsCeS
         TDcLsu4vPvRDTPWgUkOxZHRBnnYzlfq0N6GlkqpkgpWYD8mOkw5eg+TeMWhM0LTh4cSS
         x6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5lLBdOAva93h7sba5wfimP9PBGLz9NegQLKVskRq+74=;
        b=s5vLMhpuZorwcrS5Q3HLP0H2PrYRK2Wdi42LqfTdHGhmiaXwOXNb22mYQyzO7VV74x
         bMtCMQhvcyiiZtrQDiPAGhOhYcaPzuszP4y3RAjTbtArdcbHKhXgxdPbWIoyJKQf1kja
         J506808aFNTWrwakOy6urRY0psMi6CVSxa9QCPvQdg8k3NYUkfA7OPRKpIa/F5dFyYa8
         Mf/XbKAl78XXbW146FZ5E7ZoRoubpDB1yIwxo8VoeyUy88B/PXPQaLZo05VDcp48UOE4
         //zr2UFcXaIpCQy7XBr9lPQogZ8SRdezfzwf/GBIJbWtEc/g2qMcGB6BKn3/gHfg5LMy
         T6vQ==
X-Gm-Message-State: AOAM533oLen8DqV/nzxUD8fE3580+uazRoFzujIs/F6NqLcAKMpBIpA2
        GcipxepbOoKmhVKdfm21owM=
X-Google-Smtp-Source: ABdhPJyhgyP9bhPh6qlT91x5gAJ3IFDsG2lhJjwkNcKL6WO46TXixiyX6F3LwK0KFGzX5uBbkJB4DQ==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr52738wmc.138.1617641429648;
        Mon, 05 Apr 2021 09:50:29 -0700 (PDT)
Received: from agape ([5.171.72.58])
        by smtp.gmail.com with ESMTPSA id c16sm34889822wrs.81.2021.04.05.09.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 09:50:29 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 09/10] staging: rtl8723bs: remove empty for cycles
Date:   Mon,  5 Apr 2021 18:49:56 +0200
Message-Id: <09875f599705d8f50af3511fa6bfaa54b9446a86.1617640221.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617640221.git.fabioaiuto83@gmail.com>
References: <cover.1617640221.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove for-cycles left empty after RT_TRACE deletion
and unused index variables

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 4c94202ac209..eaa9f9e2e6a4 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -3466,7 +3466,6 @@ s32 c2h_handler_8723b(struct adapter *padapter, u8 *buf)
 {
 	struct c2h_evt_hdr_88xx *pC2hEvent = (struct c2h_evt_hdr_88xx *)buf;
 	s32 ret = _SUCCESS;
-	u8 index = 0;
 
 	if (!pC2hEvent) {
 		DBG_8192C("%s(): pC2hEventis NULL\n", __func__);
@@ -3491,8 +3490,6 @@ s32 c2h_handler_8723b(struct adapter *padapter, u8 *buf)
 		break;
 
 	case C2H_HW_INFO_EXCH:
-		for (index = 0; index < pC2hEvent->plen; index++) {
-		}
 		break;
 
 	case C2H_8723B_BT_INFO:
@@ -3513,8 +3510,6 @@ s32 c2h_handler_8723b(struct adapter *padapter, u8 *buf)
 
 static void process_c2h_event(struct adapter *padapter, struct c2h_evt_hdr_t *pC2hEvent, u8 *c2hBuf)
 {
-	u8 index = 0;
-
 	if (!c2hBuf) {
 		DBG_8192C("%s c2hbuff is NULL\n", __func__);
 		return;
@@ -3537,8 +3532,6 @@ static void process_c2h_event(struct adapter *padapter, struct c2h_evt_hdr_t *pC
 		break;
 
 	case C2H_HW_INFO_EXCH:
-		for (index = 0; index < pC2hEvent->CmdLen; index++) {
-		}
 		break;
 
 	case C2H_8723B_BT_INFO:
-- 
2.20.1

