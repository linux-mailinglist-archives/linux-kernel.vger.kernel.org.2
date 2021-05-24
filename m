Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF6C38E582
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhEXLgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhEXLgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:36:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7450EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 04:34:40 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id p24so40007135ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 04:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcnauAoKMjGNlUsDzSkeilOQyTIMkcoWQzdmXNNNOas=;
        b=fClq0uslXrKhWPECjmlTFEfOFcjxmXpfvfMJ7AeFDtwQLs4YYIS5aXVEf3ZcANENrR
         lDFx1hYzoyffYfiFxRGKK+5lruYqG2KwNWt1jTHmvgIpULSHMpEHcqTjVjw9GpOdxU/r
         s07UTqM898TfTbSXuTdCPBDlqDCeJ00dIpvlrtPkLhWKeQXm81i1xfFR71weALntROLV
         F6RbvYhbdfHm0TAxBINvkFnA2RI1FuyrJx8DZj5zyH+pHQGMjOs0TLxlYE4boWMpQzvP
         PzwhvB1KPhojpFK3HCCXStexHvLk4BQr0fLsr1UqIa9tP1z01sloaQwgkB5aHNGFo809
         GKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcnauAoKMjGNlUsDzSkeilOQyTIMkcoWQzdmXNNNOas=;
        b=pnfg9Ni2PLVoHjrJUiZdtW6hlnP3+rrc5jDxlckO2FMUdf9C8h3KZGafQ6E/y/VdfB
         tgPPKRYeJptU3msOjfZhLzVzNJulpmg58BAZqx1kj0d9Ho2GG64oZ1UeRyJVmg1c+DhD
         GXBqZJeaaXDTc14fPfbA+wqt/+vHaYr21VV+/wlKd1MYe4LVtS93YVuUnJMBs1OGoRFP
         bvAkY8lcTUWfGKIjagMsB0Q5G68gCbq55vVrVopjUrWxLcdTERmnPhEcQe0EHEPxQIU2
         QktIVUm8BG24jbHfTGAMsdczp8YKA7EfyMmSXNAeS+2L5RyFYVX2JLdFQ7qiDClG4adC
         JF1w==
X-Gm-Message-State: AOAM531V15caN1qrVtyVnawBtkZ9TBZ0TcKsxagNkDDwVdGq7oy9V5rp
        3o66Yb6qyqJAbCYsY9jLwuSqww3IIigvdg==
X-Google-Smtp-Source: ABdhPJzQt40/Kt6EHNtqFXhn8tnwr8JwIomvdyM4kG6h+lcUrqOwWL7HIk4N3wI5+02/D/Y8FhpgaA==
X-Received: by 2002:a17:906:594f:: with SMTP id g15mr22585028ejr.103.1621856078024;
        Mon, 24 May 2021 04:34:38 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id x16sm7675905eju.30.2021.05.24.04.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 04:34:37 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-staging@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] staging: rtl8723bs: core: rtw_mlme_ext.c: Remove set but unused variable
Date:   Mon, 24 May 2021 13:34:33 +0200
Message-Id: <20210524113433.25923-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed set but unused 'reason_code' variable. Issue detected by GCC
running with the warning option -Wunused-but-set-variable.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: As suggested by Dan Carpenter, removed call to
get_unaligned_le16() and modified the commit message accordingly.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 9fc612fb736f..97b3c2965770 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1721,7 +1721,7 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 	struct recv_reorder_ctrl *preorder_ctrl;
 	unsigned char 	*frame_body;
 	unsigned char 	category, action;
-	unsigned short	tid, status, reason_code = 0;
+	unsigned short	tid, status;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 *pframe = precv_frame->u.hdr.rx_data;
@@ -1790,9 +1790,6 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 					~BIT((frame_body[3] >> 4) & 0xf);
 				psta->htpriv.candidate_tid_bitmap &=
 					~BIT((frame_body[3] >> 4) & 0xf);
-
-				/* reason_code = frame_body[4] | (frame_body[5] << 8); */
-				reason_code = get_unaligned_le16(&frame_body[4]);
 			} else if ((frame_body[3] & BIT(3)) == BIT(3)) {
 				tid = (frame_body[3] >> 4) & 0x0F;
 
-- 
2.31.1

