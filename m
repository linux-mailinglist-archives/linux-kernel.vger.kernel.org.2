Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E45235BA05
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 08:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhDLGLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 02:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhDLGL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 02:11:28 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE82C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 23:11:11 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id k8so8559066pgf.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 23:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=IYqQaJDmst//9bdnYVVyaSBsB447C8sYHCRi8q6qoSo=;
        b=W12j8BWHXgpL0vM/RczGUl98h72QC2rDYB2oFoqBObmeShy6F1t2KdJpuh1rkZaLTy
         T9vj6Rq3gKnLGfRtO1SReFA0QoPC6S011LhsgckVjgM2KZ+XHlYTh0TeIy6HIJdBk9e3
         dpc/x5nRU/MOkMPrsuOhfTtauaMDrVIIWBfyi0qWDRURsoHkJZgz0wzxmQb0/6uaHSQh
         VJk7bz3qrMJCb6Yaclo7nbOJ2A7BiXPBmFPIFgDCHpgdYxk3o4XtgiHoxQ/ZiccKGflA
         cExbgrWVLC3ukRoK4VFVKAll+jDa+FVRz9I/JCaw4LCr8ep7Mlm/xoVPP0b0LThdz1X+
         sQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=IYqQaJDmst//9bdnYVVyaSBsB447C8sYHCRi8q6qoSo=;
        b=Vm3dFsZDHGfFDdnE33iDkWfR9GjJoADotRGsiMgRcy5cvnPT+UTONAcGIHKgERkEOp
         TqFvBhJSBvSx8j9K4EbzwTuEpTIFk/agxEmMRaJJG8vmwwvsWaDhjxw2tGu4V/JSca2z
         6ArZLX7zLkwTKo/qy/UoQybZheTWQXOPYaAMenrJjqagN+Q7HQIZp0ATvEFSkXGUPGS1
         cypkwzAW9qIabLy5Dhi+uzHhzgDeLcmRJ4IlvT0gasU3BzBGPiGAuvihjf0riX4b87v2
         VyVNr+RlI9VChMKPuoYlfYPEGV7NJjtaG7f+pFCJKXLTZ+2t5mGLUTK/EW5F9E5hSC9J
         0dmQ==
X-Gm-Message-State: AOAM531SSbcjV4I9dtJEX+9IILQ1t6N8PA8ljbKURLz6kCvDICL28jAb
        qhnVxipoMN1h/6Cfa+soI8w=
X-Google-Smtp-Source: ABdhPJwfL47PPkhOmo5lvnsX2ttVihNr5nOth4H5yuMT/EHGfsD7lYdBLDOO+q23eRkOAiQnB0L1mQ==
X-Received: by 2002:a63:3dc7:: with SMTP id k190mr26403045pga.181.1618207870533;
        Sun, 11 Apr 2021 23:11:10 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id a25sm4251251pfo.27.2021.04.11.23.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 23:11:10 -0700 (PDT)
Date:   Mon, 12 Apr 2021 11:40:53 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH] staging: rtl8188eu: replaced msleep() by usleep_range()
Message-ID: <YHPkbTPPra2isn5e@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the warning:-msleep < 20ms can sleep for up to 20ms by replacing
msleep(unsigned long msecs) by usleep_range(unsigned long min, unsigned long max)
in usecs as msleep(1ms~20ms) can sleep for upto 20 ms.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 50d3c3631be0..6afbb5bf8118 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -5396,7 +5396,7 @@ u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
 			return H2C_SUCCESS;
 
 		if ((pstapriv->tim_bitmap & BIT(0)) && (psta_bmc->sleepq_len > 0)) {
-			msleep(10);/*  10ms, ATIM(HIQ) Windows */
+			usleep_range(10000 , 20000);/*  10ms, ATIM(HIQ) Windows */
 			spin_lock_bh(&psta_bmc->sleep_q.lock);
 
 			xmitframe_phead = get_list_head(&psta_bmc->sleep_q);
-- 
2.30.2

