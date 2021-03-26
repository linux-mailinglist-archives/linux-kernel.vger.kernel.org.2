Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4977B34A3C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCZJKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhCZJJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:09:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3335C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b9so4868320wrt.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jmSO/BQjCtFc+8Wa4RmTfHsYvqFzvyXvihga913X5Ts=;
        b=A8vPDJMwLCdYkMzcOBzZxeA/iRkfPQ2ddmgMD/rsQCD5Bg2nV7uzeTrBiAYe/vQFJ1
         tgnPuzq1rXhJ7zRIxUTXOHVkWwUB4KmYEYMMRJe274Am1W6S9jRd0STYvLqed4vyOYVl
         OP18vEVVhjah0uzpwD/G03LZubZAvcovVSORsBnjsSUqs1tlffLrh6POVN5ueGNDu39w
         wNmPZ+uSRaUPsAO9ZhTCscSfauvbcB9iBMlCAzb6ib6rJiuLF2htys9wQm4svhiwcEjX
         SKmANLLTEom3TyP7G1C/P8/nt9bNidvq/Rae6/AO3k+wlhElwP9OAlFExgh4hYGrxoBL
         d1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jmSO/BQjCtFc+8Wa4RmTfHsYvqFzvyXvihga913X5Ts=;
        b=mG+O9KmlC1xdzTBpDb8I4Oex79IHE7qVUA/6KXqRdUeds8ADH2z4BKMFyuQrhOAaGq
         yZRJ1DaAn/Xhr7VErbcXHZlZTvUCaQtyH0JC14/p2O/n0Y5YW+frr6U40iEOrBno9Mn6
         Gk+9/DO/84wIFEL2R8/pCJnvjiQ9l9wtyuoFF+dxRacTpUVMHwsjThNksMVy07zRgeCW
         FRwV/4aSz5el5V6f3H9My5cKA+ncGjmK+L2/HKTLhvLmKl42YFDWqvroxlPO05EYfopB
         uMOprkfJcLmNif5LMTFmhL3jjjPB5qJPedHmv8xsB60+gQPJkj0PPg8o4pyIp7raNyFY
         UBNQ==
X-Gm-Message-State: AOAM531DajCKS3nH2NP02GSQzvBwsNlcSXyPI2jufm462qp5t4U/2xJM
        y/4iP8ORmhex6rq7ODhy8c4=
X-Google-Smtp-Source: ABdhPJwo1tHNtq1ZBWqxd+4pwlbMe8/jVZF26EUNkDqIO2+Ytv2vc6jQXTJuAEJi0zBFa/h+3BAQjg==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr13422471wrt.203.1616749790732;
        Fri, 26 Mar 2021 02:09:50 -0700 (PDT)
Received: from agape ([5.171.81.75])
        by smtp.gmail.com with ESMTPSA id j123sm9761878wmb.1.2021.03.26.02.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:09:50 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 06/15] staging: rtl8723bs: put parentheses on macros with complex values in include/hal_com.h
Date:   Fri, 26 Mar 2021 10:09:13 +0100
Message-Id: <afb537f2865a76db0c071eaed3d0fff41f730711.1616748885.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616748885.git.fabioaiuto83@gmail.com>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warnings:

ERROR: Macros with complex values should be enclosed in parentheses
187: FILE: drivers/staging/rtl8723bs/include/hal_com.h:187:
+#define PageNum_128(_Len)
		(u32)(((_Len)>>7) + ((_Len)&0x7F ? 1:0))
--
ERROR: Macros with complex values should be enclosed in parentheses
188: FILE: drivers/staging/rtl8723bs/include/hal_com.h:188:
+#define PageNum_256(_Len)
		(u32)(((_Len)>>8) + ((_Len)&0xFF ? 1:0))
--
ERROR: Macros with complex values should be enclosed in parentheses
189: FILE: drivers/staging/rtl8723bs/include/hal_com.h:189:
+#define PageNum_512(_Len)
		(u32)(((_Len)>>9) + ((_Len)&0x1FF ? 1:0))
--
ERROR: Macros with complex values should be enclosed in parentheses
190: FILE: drivers/staging/rtl8723bs/include/hal_com.h:190:
+#define PageNum(_Len, _Size)
		(u32)(((_Len)/(_Size)) + ((_Len)&((_Size) - 1) ? 1:0))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/hal_com.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index 28451385dec3..0bc0e1361765 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -184,10 +184,10 @@ enum firmware_source {
 #define TX_SELE_NQ			BIT(2)		/*  Normal Queue */
 #define TX_SELE_EQ			BIT(3)		/*  Extern Queue */
 
-#define PageNum_128(_Len)		(u32)(((_Len)>>7) + ((_Len)&0x7F ? 1:0))
-#define PageNum_256(_Len)		(u32)(((_Len)>>8) + ((_Len)&0xFF ? 1:0))
-#define PageNum_512(_Len)		(u32)(((_Len)>>9) + ((_Len)&0x1FF ? 1:0))
-#define PageNum(_Len, _Size)		(u32)(((_Len)/(_Size)) + ((_Len)&((_Size) - 1) ? 1:0))
+#define PageNum_128(_Len)		((u32)(((_Len)>>7) + ((_Len)&0x7F ? 1:0)))
+#define PageNum_256(_Len)		((u32)(((_Len)>>8) + ((_Len)&0xFF ? 1:0)))
+#define PageNum_512(_Len)		((u32)(((_Len)>>9) + ((_Len)&0x1FF ? 1:0)))
+#define PageNum(_Len, _Size)		((u32)(((_Len)/(_Size)) + ((_Len)&((_Size) - 1) ? 1:0)))
 
 
 u8 rtw_hal_data_init(struct adapter *padapter);
-- 
2.20.1

