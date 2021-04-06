Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F081E355C38
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 21:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbhDFTe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 15:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbhDFTez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 15:34:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACD4C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 12:34:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i18so11969891wrm.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 12:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8S3Uh23H+gQhsf7YASK94vXEdzHi8M0NhOcwtIIfD7A=;
        b=K1jhGkT0rQRrxYrdUccc9LKWjwtNtE9JBvnSETUmCSElTHz3NOMDx9VPkZFkQy2V3A
         CUvcwCNOaHGF6nFo9RaP8gIvxfiu+K9v2Ag/EaR3c9+GdJV21TX0oREV0piWy6RLVBvn
         evaQ5igK6kZvhfi0Dn7DSZYTP/pF0x6twRofcg0OqKpQ0r/uaFe63z/ZWeVMkr/oviF2
         TYPkZjPba4L358UAql88B6lSPqyq2FPTNyhwHN2jAKLQmiu8HN1Tyrkk18SQHEUWhz/J
         ugkzJOXqhPH23SbPD0Iezga5dB6M2Fk48fMh4ThAQq4tMx7xH0oW0oSZQYIa8YDlNway
         aKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8S3Uh23H+gQhsf7YASK94vXEdzHi8M0NhOcwtIIfD7A=;
        b=HEsE806+AIoW2/awj669/zgnwYVeYoClAfzl9S8SG2o9mfyRLRiBM6mXqYWSly3/rG
         4YSgMHbqwgtzc+dcU0PqCgIHyQJl1NiLKxFm948ZvV+fU9eX5qMwmDXr6yZe2YjKcu6W
         zzdevf4BK35TzT3lwECX2KkNhHYv0snhhFTS+l6Uli1B7n6X6/o30/xDXnzH5U41Taic
         Hnlc+sXtBCvVO6MRHXrvBVkN6KNbIrjTZE6WecdwzTcupe4akthGiK3i4GpmsoECEYTN
         RoCNfC4oCf0OGHi64ilsIib0KeaFKhom+o4B4oLZckP28yf5LXO//LYsys7EnHKM8m2b
         Ob7Q==
X-Gm-Message-State: AOAM533MqGSGEPl5T8lALnXg+xYajBBuCAe5ICwVFhBAu74O0FL3Pr+k
        HVp6S2HkagQ+qTk2uUWGT9I=
X-Google-Smtp-Source: ABdhPJz/zZHte4xMj1qmO9PuPTWmA+ei+0MmuKjvvtqrQohhqJyFRgyEP6VSgVJ9ZwybUo9jhUllaA==
X-Received: by 2002:adf:f645:: with SMTP id x5mr14835224wrp.314.1617737685884;
        Tue, 06 Apr 2021 12:34:45 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:ef5c:3f2a:a646:d6ec])
        by smtp.gmail.com with ESMTPSA id r11sm18793668wrp.70.2021.04.06.12.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 12:34:45 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org
Cc:     Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Subject: [RESEND PATCH] staging: emxx_udc: Ending line with argument
Date:   Tue,  6 Apr 2021 20:34:09 +0100
Message-Id: <20210406193409.96428-1-martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up check of "Lines should not end with a '('"
with argument present in next line in file emxx_udc.c

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 741147a4f0fe..20f53cf6e20f 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -1073,9 +1073,8 @@ static int _nbu2ss_epn_in_pio(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
 		i_word_length = length / sizeof(u32);
 		if (i_word_length > 0) {
 			for (i = 0; i < i_word_length; i++) {
-				_nbu2ss_writel(
-					&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
-					p_buf_32->dw);
+				_nbu2ss_writel(&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
+					       p_buf_32->dw);
 
 				p_buf_32++;
 			}
@@ -1225,8 +1224,7 @@ static void _nbu2ss_restert_transfer(struct nbu2ss_ep *ep)
 		return;
 
 	if (ep->epnum > 0) {
-		length = _nbu2ss_readl(
-			&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
+		length = _nbu2ss_readl(&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
 
 		length &= EPN_LDATA;
 		if (length < ep->ep.maxpacket)
@@ -1462,8 +1460,7 @@ static void _nbu2ss_epn_set_stall(struct nbu2ss_udc *udc,
 		for (limit_cnt = 0
 			; limit_cnt < IN_DATA_EMPTY_COUNT
 			; limit_cnt++) {
-			regdata = _nbu2ss_readl(
-				&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
+			regdata = _nbu2ss_readl(&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
 
 			if ((regdata & EPN_IN_DATA) == 0)
 				break;
-- 
2.25.1

