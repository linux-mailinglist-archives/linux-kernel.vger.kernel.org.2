Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE86833D798
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbhCPPd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238036AbhCPPcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:32:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE64C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:32:51 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l12so10701963wry.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oWQ6OIsRDcKO27uNJJ+4rAAZ4GQmFLXXw3hOBTbFDWY=;
        b=fZvJW0AvwTfsbRqI8dznMHkiGQRN+fHxMnwNmoa/MjenBeViCQOIRx6GmPw4uy8PRC
         Jnar7jX43ZNDt5KkD7uLqr/za11euvdXxtVkb0OdVpky1rXteDYo63+7Mcxvw4WRb2T3
         o5AmKX5l4CjGdhUC/QFbvRp5s8dp76Nyrv514xGXoT+uDBNdrHaVOrP17LHN22E7BxHv
         vNl5I4riH6MRrTkcAx95casBT3/3ZF/9xjTeLj0yG56FmelmfAa3kIgBn0KHbIMfyubK
         kU0/lkTAXfRxVDdQdiFZfPLPoace0NwpmL79U78uudVksmRSH16pQGGML9suLtZOhGjz
         HsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oWQ6OIsRDcKO27uNJJ+4rAAZ4GQmFLXXw3hOBTbFDWY=;
        b=KPB6s0swV7057y6dkRG1WE0rMESppQ/8KWa0YH8BFax/NNyEQpFcujMHcXv3ynZGAj
         zODaCfxHbziSb/rQ3kYn+PxcYH9NytU2gCoxMac9k0f1z+QUtqPB17etC7GrnOD9EMGx
         kJtyIoTSVNRM75YYdqHJ6d4eQnPEcCBne3gkxgP71HNRY11K/UnGInEC0rss0X1BmUUz
         R+LH26reCkz2Ak1IC4JDeSs3b5eh00sGGLjjjSj3sa/B+kgg3jtEJhyzgxKqUcoW7UOy
         YMSK7ICeFQt7IsKyZxfi5ODfmu7YcD150kMJO9Ukkj83V9J3qyd/57YjVooLZ6HOmMe1
         v3vQ==
X-Gm-Message-State: AOAM533lxF8lsc5maY56lh2lc3JiCuQjlXU66HQaycDRWcjXJPcRrL1c
        4Ucmo9/x4Q9f4EXUjTyaZhN3JEXjO9k=
X-Google-Smtp-Source: ABdhPJyrKTWi6fmzZOmU08lMmubTx5kuRmyFj9aM5EI/mC4baczwD0iTjp86C57yDOnt3/Uv6m/c0Q==
X-Received: by 2002:adf:e548:: with SMTP id z8mr5672857wrm.246.1615908770351;
        Tue, 16 Mar 2021 08:32:50 -0700 (PDT)
Received: from agape.jhs ([5.171.72.71])
        by smtp.gmail.com with ESMTPSA id s8sm23408659wrn.97.2021.03.16.08.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:32:50 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:32:47 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_BSD_RX_USE_MBUF
Message-ID: <b65806d8bbbb686af247d945cc25e73234e4cbb4.1615907632.git.fabioaiuto83@gmail.com>
References: <cover.1615907632.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615907632.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused
CONFIG_BSD_RX_USE_MBUF

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_recv.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
index 3443cb7d0467..b298ec121ee9 100644
--- a/drivers/staging/rtl8723bs/include/rtw_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
@@ -317,13 +317,8 @@ struct recv_buf {
 */
 struct recv_frame_hdr {
 	struct list_head	list;
-#ifndef CONFIG_BSD_RX_USE_MBUF
 	struct sk_buff	 *pkt;
 	struct sk_buff	 *pkt_newalloc;
-#else /*  CONFIG_BSD_RX_USE_MBUF */
-	struct sk_buff	*pkt;
-	struct sk_buff *pkt_newalloc;
-#endif /*  CONFIG_BSD_RX_USE_MBUF */
 
 	struct adapter  *adapter;
 
-- 
2.20.1

