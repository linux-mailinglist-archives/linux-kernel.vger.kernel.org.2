Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2473935528C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245714AbhDFLnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239082AbhDFLny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:43:54 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E42C061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 04:43:46 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id o10so22201338lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 04:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q9WBuK6OhOs9OaGEgKhL5YcwsAzLgbzYaT8/doodq88=;
        b=FGNFAZPqCEv3zJHnNSHZC66i9V/OZMZFSbChHMkmTFpg5xHD3JV14L7arnZXaRbOFl
         0xszyZD4NXj5rU0elJif8lA5NMQOIm4BrEEN1UqFo54CAC4CbLvkfvUU78n4/zN3xJbJ
         tMEtNUN4s2AVNWJx71ZTBR5tAEKO3+n+Hf48QFZPAh9ZgMWH50Ntz6rHRHQewePMiorp
         b2q3+/3hluoekjEmv8THygae5Vt2ka6RAoXD2oYWI3A66UhB1CMemAlBtbB77m3mt/CY
         ucO3T4oulrFvrU2G+m+OVeOHy8hH7acQ+9+KHVRZte1XD2+5huAXNbaUmKvx6Spr/umu
         qwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q9WBuK6OhOs9OaGEgKhL5YcwsAzLgbzYaT8/doodq88=;
        b=LxN3iVnRiGSA9EpSuGG5k3zlgO3ABmBchIb3UNZsaU3lqYgKDK2Bpt4hP7GQFmNwF7
         Y2m59rlQaok61PnuktxUwgjFj4EcbKiUnbksRvX0T/cJFomKYyKPzO1wFrux1EpoELva
         LygTbNPZfU+KXyAs/74pJuR90+ieH6p+eGUhUvuH8WYf0dHKmOy9Sl9HyYqLETQz0izN
         8RJiyw5X5OXPDQAlMv0Rj7F4YPiuXBADGkkKDHhVLrOuMWtjGuMExRPwFmFRzLD2PW/z
         yBGHonrSfCjH2QAcFtCuwaedejupAapD/lEcpL05u5QDfKWQTSqE037OypYq4+ElwolN
         vskQ==
X-Gm-Message-State: AOAM531sQIG6q5YxkV923uOxtVJNxsiGsst/8omiy5DTM0DoPlfA2UOT
        nglTfirim9VNWgXZHI4JBkY=
X-Google-Smtp-Source: ABdhPJzSmDvywKme+gC3EQ9MaqzfjJ43DnM1j7ttMF/OrHQs7HIopbK5dc+zZKkYN+Fj7K71YXEPSQ==
X-Received: by 2002:a19:cd1:: with SMTP id 200mr21004350lfm.480.1617709425433;
        Tue, 06 Apr 2021 04:43:45 -0700 (PDT)
Received: from zhans ([37.151.32.231])
        by smtp.gmail.com with ESMTPSA id h9sm2206860ljh.58.2021.04.06.04.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 04:43:45 -0700 (PDT)
Date:   Tue, 6 Apr 2021 17:43:44 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH v2 1/2] staging: rtl8712: Rewrite NULL comparisons
Message-ID: <74471865b399584d73a18696d2008006301dfd71.1617708653.git.zhansayabagdaulet@gmail.com>
References: <cover.1617708653.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617708653.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace NULL comparisons with boolean negation to be more consistent with
the rest of the Linux kernel code base.
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

