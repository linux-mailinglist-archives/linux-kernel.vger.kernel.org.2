Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D3F355136
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245206AbhDFKvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 06:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbhDFKuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:50:54 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A67C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 03:50:46 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 184so15942419ljf.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 03:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xqub4sjt54FzRQ/fvsCh/tHtwz+sQViLhigZ2eLngb4=;
        b=r9rPmSK181dTzIRu5W6qSmFwkzrtbKfqQSHTA3t6rYq2A+KdxCyylz2wmxcThUHcUE
         zThVGoqkt8SQA50Zc6kr47yE2tjG0BP4l/cghORZC8K/kHnQ7iunzjyZx0/xD3rOULv4
         89vbMiwn97pRzkhg43f6gpS8hfl3ppLDIFWhSyvnb0TEogtduBjTjyYkxatAGQRAekPq
         MiiFS74b2EEwG5IoBjT+kzfLeWLXkn2ihPft6fK2RlUPUyG+ZHMjk2bEz4v0uJpuVZmn
         TrO33fcnu99LSnzwUMDv7j2fArKcgROp5aF2UvrasSeblJztqvtW1s5GmjvmtA89u6/P
         XPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xqub4sjt54FzRQ/fvsCh/tHtwz+sQViLhigZ2eLngb4=;
        b=CbNwiQBJI6IsMJ3dvQVZme7zo24HynJ9G9A4/qKypdrnHU6kwomLsebWB/Kw09QdH4
         Km7RI/QQrYVUVDhLFYW3EPMc43syFYOn0GiNV7XPHSPc5Yq9LKMet+5qsKsW2ayp0T0I
         offUX5gFuwTd0Hz3mYyKm8TUg7Xfe3quCmKIlg/eirUa5JkuVE3QJam5zNvj29hS7VaK
         9Bj4RjWGGt85FR/oOZat/mXaG6pPhDq7/WR5WXVK8RU5EgsVBVUgRDqFxw9o/Pu9gWG/
         NokP0AK2VFT3J/dvYFg8N7vmM7jtm0fYz4evr/CZ5wiezIK1bHWJK1844AjsnItFCyQ3
         p2uQ==
X-Gm-Message-State: AOAM533DwZe5DAAokTAoZGjqt6fi0MqXghiH2ql536YxqccmnLdu+sEH
        yKZBSbnu5Up/I5BWsaQio8Y0fajqiSihyg==
X-Google-Smtp-Source: ABdhPJyf4qrI0zc+90wyKLaiwowtzMe3yzamhaT9FuRYnB7t5ZeGVwoENQmL6x8UqQWMEmvTnUbfAg==
X-Received: by 2002:a2e:9cd5:: with SMTP id g21mr17846362ljj.367.1617706245555;
        Tue, 06 Apr 2021 03:50:45 -0700 (PDT)
Received: from zhans ([37.151.32.231])
        by smtp.gmail.com with ESMTPSA id e15sm2235374ljg.54.2021.04.06.03.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 03:50:44 -0700 (PDT)
Date:   Tue, 6 Apr 2021 16:50:34 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 1/2] staging: rtl8712: Rewrite NULL comparisons
Message-ID: <5d2db1d233030ececcdd4934ca9c46cb998c0c5b.1617705825.git.zhansayabagdaulet@gmail.com>
References: <cover.1617705825.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617705825.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace NULL comparisons with boolean negation.
Reported by checkpatch.

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_recv.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_recv.h b/drivers/staging/rtl8712/rtl871x_recv.h
index 7c9995060a6f..4aa39f4f3b84 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.h
+++ b/drivers/staging/rtl8712/rtl871x_recv.h
@@ -135,7 +135,7 @@ int recv_func(struct _adapter *padapter, void *pcontext);
 static inline u8 *get_rxmem(union recv_frame *precvframe)
 {
 	/* always return rx_head... */
-	if (precvframe == NULL)
+	if (!precvframe)
 		return NULL;
 	return precvframe->u.hdr.rx_head;
 }
@@ -143,7 +143,7 @@ static inline u8 *get_rxmem(union recv_frame *precvframe)
 static inline u8 *get_recvframe_data(union recv_frame *precvframe)
 {
 	/* always return rx_data */
-	if (precvframe == NULL)
+	if (!precvframe)
 		return NULL;
 	return precvframe->u.hdr.rx_data;
 }
@@ -153,7 +153,7 @@ static inline u8 *recvframe_pull(union recv_frame *precvframe, sint sz)
 	/* used for extract sz bytes from rx_data, update rx_data and return
 	 * the updated rx_data to the caller
 	 */
-	if (precvframe == NULL)
+	if (!precvframe)
 		return NULL;
 	precvframe->u.hdr.rx_data += sz;
 	if (precvframe->u.hdr.rx_data > precvframe->u.hdr.rx_tail) {
@@ -170,7 +170,7 @@ static inline u8 *recvframe_put(union recv_frame *precvframe, sint sz)
 	 * return the updated rx_tail to the caller
 	 * after putting, rx_tail must be still larger than rx_end.
 	 */
-	if (precvframe == NULL)
+	if (!precvframe)
 		return NULL;
 	precvframe->u.hdr.rx_tail += sz;
 	if (precvframe->u.hdr.rx_tail > precvframe->u.hdr.rx_end) {
@@ -188,7 +188,7 @@ static inline u8 *recvframe_pull_tail(union recv_frame *precvframe, sint sz)
 	 * updated rx_end to the caller
 	 * after pulling, rx_end must be still larger than rx_data.
 	 */
-	if (precvframe == NULL)
+	if (!precvframe)
 		return NULL;
 	precvframe->u.hdr.rx_tail -= sz;
 	if (precvframe->u.hdr.rx_tail < precvframe->u.hdr.rx_data) {
-- 
2.25.1

