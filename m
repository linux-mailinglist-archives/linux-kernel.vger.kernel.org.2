Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B412735532F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343740AbhDFMKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242958AbhDFMKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:10:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B14C061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 05:10:00 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b4so22330462lfi.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 05:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q9WBuK6OhOs9OaGEgKhL5YcwsAzLgbzYaT8/doodq88=;
        b=lEgLOvzIKJ5bhK8vpMojTcxMOI2srsJUbA0cmAWbtDpyYtzKh0OyK4e9qe+f0bBg6G
         VnFiVxTaQEBGun2Pp+Zd7XrHiixkAgnSsXJXDKvx0RlQIn9zlhs006Oe9oSEQTo/47GM
         fVE2Hf4rigm9aNECIAnbYhWOa0/mbvWiNp4rmv/LwNWe3YH7EtURckj6phDmIXZuT5JN
         skxq4o6TQD5J5nWa2CLHAQ5hMvwOX9RVAv13ZzEJPlSMbPKxfmGV4SRUleXzS8yM6IUw
         YtXKBAAR2YWMeX3c4+P3ls8ddbgA2uIE/00O57vXuP9O+pPMD6wgk93Jb+YA6ADTRGuB
         wSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q9WBuK6OhOs9OaGEgKhL5YcwsAzLgbzYaT8/doodq88=;
        b=StRgDQXta+aoKKl/ZTmfey4zuXNIEScBv7ZHOmpbl7D41h1ztRyYNArBtkjRIxklpF
         dc5Hh0la19vPM4baaJtENKKQd4kUcufLBL7I6NUGJvjpkD2HtCDjPvtGnQww/AZUpAeT
         6ds8NGJN2tjjhO+FH5W822nXDWN9lsA7DNW74dZN5kxhziBUauXTabnNOs+Q1lxAnlgB
         oOSW1S4SssDVGiDc2ZJmzNACjN5vS89+I75aaN5b1TKLPIiTk1RCVkfrZguJ6/XS79nw
         tUiXEKN+om7CGKDusNAjYBlYE/7au1N3vwscb6GcQaGH4BsSgn1omWzWN/9lAbJC2qTX
         Gb7Q==
X-Gm-Message-State: AOAM53002OOHGS96im45T40v1kin/mP5THt/z58YFYJ3/g7rQZ5ajM5s
        hL77TcM05WHM/G8tgP/ECmg=
X-Google-Smtp-Source: ABdhPJw+iVRP+GEZvT2rCwytIxgNxOiVkZCy29EzmWh6/4ZXAxyMolXcr2rferfK10rUNCDzxPqhXg==
X-Received: by 2002:a19:6910:: with SMTP id e16mr20427477lfc.482.1617710998819;
        Tue, 06 Apr 2021 05:09:58 -0700 (PDT)
Received: from zhans ([37.151.32.231])
        by smtp.gmail.com with ESMTPSA id g11sm234319lfc.255.2021.04.06.05.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 05:09:58 -0700 (PDT)
Date:   Tue, 6 Apr 2021 18:09:56 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH v2 1/2] staging: rtl8712: Rewrite NULL comparisons
Message-ID: <74471865b399584d73a18696d2008006301dfd71.1617710602.git.zhansayabagdaulet@gmail.com>
References: <cover.1617710602.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617710602.git.zhansayabagdaulet@gmail.com>
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

