Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A883A999F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhFPL4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhFPL4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:56:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10649C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:54:28 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e33so1774155pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/huNvh8FcTl+3eIIL9X2XXyAfeSSuZDlj/u8PSM9yrQ=;
        b=OHb8tMfVL85uCUS+wgteKKQ+KxRN0dbYDRU09+owwjuoGJowCI0c0PrLNV8TI5wYQv
         w0NagKqnk/v4JLGHsbH2ugMCrLmx4HaRJFmwGHokKYl4yu5ozxnRvIPXZcSr27dCirne
         FYziFZAO8KBN1AK8k8fjnHFQiVX9te15xysWgig8LQZZAs5+DHveqUp8d6jUgzDuIYwO
         hoydsFVNpWH3NYv4dVCNQ1WakCrmIfpS8fygqcWOnwspiYs6mtuYdH0aealikwyruqCO
         XV8wPi5GlLzxo2koSWG2OiGRxnjC7HjZtuwNuCd3fiqCZOEWu9qqP1nG0IDesQarpYUx
         kq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/huNvh8FcTl+3eIIL9X2XXyAfeSSuZDlj/u8PSM9yrQ=;
        b=ktMBjusZ5BHShkxTbQw37Ov1+cQuVavOuv+agznQSM03sOy4fYJv/iQFPz/2BidELc
         88TW98UoorEFCGKuQT5xPj0bu2CNSrXwVkgIVhlxOb2h6e8ydl2j3owyVDucYYYyN7Pw
         Bdptvjq55dxCQbVrkr7AZ/NfrSYOlvgjOvJ0aiN4a2rXwRySctfE9bU1CRNKREpuqlMP
         FYuDGQXTcMGfizkBhLcSvLAO9RVUCzuXmijgHU8SoQhsIZiUtGPL0oDhXs9g5zvpFnam
         7LvSueRHSyZOND7+Rwq+SLgDIOdd3KLYKGhM8PmR/mlSOpvCU4M6pBShSJ1wrzVr4nCN
         Z/3Q==
X-Gm-Message-State: AOAM532hi/S+GzL2nv/X7H6PlyVtMCY7IFEwwnBIW6koilvvaW7IuvJu
        lndyBLlXV45K3H0G4Rf3+II=
X-Google-Smtp-Source: ABdhPJx4GEMY21afq3We29YrJ+5DYBXo3SCf7LGhI6s6iM8IloxqcxKKGEGg56d1KKmIuWg115A+ew==
X-Received: by 2002:a63:31c2:: with SMTP id x185mr4620146pgx.97.1623844467600;
        Wed, 16 Jun 2021 04:54:27 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id o186sm2091049pfb.59.2021.06.16.04.54.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jun 2021 04:54:27 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     zhenguo6858@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: n_gsm: CR bit value should be 0 when config "initiator=0"
Date:   Wed, 16 Jun 2021 19:53:22 +0800
Message-Id: <1623844402-4731-1-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <zhenguo.zhao1@unisoc.com>

config "initiator=0",gsmld will receives dlci SABM/DISC control command
frame,as slaver,the CR bit value check should be 1.

if check "cr == 0",it will goto invalid,so it can't send UA response
frame and open slaver dlci.

Signed-off-by: Zhenguo Zhao <zhenguo.zhao1@unisoc.com>
---
 drivers/tty/n_gsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5fea02c..becca2c 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1779,7 +1779,7 @@ static void gsm_queue(struct gsm_mux *gsm)
 
 	switch (gsm->control) {
 	case SABM|PF:
-		if (cr == 0)
+		if (cr == 1)
 			goto invalid;
 		if (dlci == NULL)
 			dlci = gsm_dlci_alloc(gsm, address);
@@ -1793,7 +1793,7 @@ static void gsm_queue(struct gsm_mux *gsm)
 		}
 		break;
 	case DISC|PF:
-		if (cr == 0)
+		if (cr == 1)
 			goto invalid;
 		if (dlci == NULL || dlci->state == DLCI_CLOSED) {
 			gsm_response(gsm, address, DM);
-- 
1.9.1

