Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB30339295
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhCLP7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhCLP7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:59:06 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B067DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:59:05 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j2so5076477wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gefUvqZ+PVzm20AG/CnQcxDANW6owChYqRkVVyHl7s0=;
        b=gCauilkWy0v9euw5fGyJ7PnNGhvzAnprPg5JozU2kmU3KtD57PebSfGk/6Fp4K57qv
         cfyuxdLmO34VZiAMY6P/vRYAKmn/9jJvpcpD+6BBIBTVo6F8YpXi+SPxanEennMvJ02u
         JRvRi8yzoOvQQHRJKQovQlhm0QvdhlGnRoM7KkE6Kdlk70l60XVvE0xjTUGvcfzksipK
         yl1+rjSLP9sTY2Ma7L8/0dUE2P8NmKUZNja0xXv3GzPZa8f4r3iS76sCY7KAbb0Ns8/h
         ni2krnPqS6qM0kld3sRBDVKGBFHgnC4YyiSyENf5p7DAd9UdMa3inWXss08e1TW7xwBR
         Tpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gefUvqZ+PVzm20AG/CnQcxDANW6owChYqRkVVyHl7s0=;
        b=rXKrQBPYLv+jwwf6gtEczCUeXfJrZi9tIqvwF7DE5WUYViGZSSEdHLkNQ8MpDc1i3v
         33RSXcQDk50JHJiRZY3E1ENuco2QrOwE/jSeMOmDU17OJe+E3DZS21+2RC9lQ4WSuNZE
         5fPQSJiKzAlpD4KS3iN91jFYmrDAtGktnmkOj50EqOZd+jWmd+ZFspnjg/94RwJKQAcr
         8tJSCa9SW50NktlVPwYxEEE5SFUIaaIKOZ9NcfCQ+8etG8UKapmQft2T6qsEVb4DC7Rw
         S7ZPdpSIFHJtLlhGdu5nHl0BcjZeguCi5USVGcjCJpsB94DDniudwJrVsy2f115OcuL5
         4W5g==
X-Gm-Message-State: AOAM532Y3K0R6eXn7bb3GaFCWlD3naqRQeoOPUNeme9+8an2yKpCGkZR
        7PjVVl61yKB3JcsMX+8kkDQ=
X-Google-Smtp-Source: ABdhPJx5sRlKADvu2Mizzkmg4c61CPj3z3qQQIUzLt3LLT74J7waTqUFNKJKoVz4iRURyFQlW4Ebvg==
X-Received: by 2002:adf:f94c:: with SMTP id q12mr14441265wrr.283.1615564744526;
        Fri, 12 Mar 2021 07:59:04 -0800 (PST)
Received: from agape.jhs ([5.171.80.73])
        by smtp.gmail.com with ESMTPSA id s16sm8267410wru.91.2021.03.12.07.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:59:04 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:58:58 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: rtl8723bs: remove unused code blocks
Message-ID: <a3b0b72da950353afdd813ea6dabffa5004d5a92.1615561447.git.fabioaiuto83@gmail.com>
References: <cover.1615561446.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615561446.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused CONFIG_TCP_CSUM_OFFLOAD_RX

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_recv.h  | 5 -----
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 8 --------
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
index b4aeb44d5d6e..078854a55a31 100644
--- a/drivers/staging/rtl8723bs/include/rtw_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
@@ -159,11 +159,6 @@ struct rx_pkt_attrib	{
 
 	u8 ack_policy;
 
-/* ifdef CONFIG_TCP_CSUM_OFFLOAD_RX */
-	u8 tcpchk_valid; /*  0: invalid, 1: valid */
-	u8 ip_chkrpt; /* 0: incorrect, 1: correct */
-	u8 tcp_chkrpt; /* 0: incorrect, 1: correct */
-/* endif */
 	u8 key_index;
 
 	u8 data_rate;
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index f52802f24466..78d5b6913467 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -138,15 +138,7 @@ void rtw_os_recv_indicate_pkt(struct adapter *padapter, _pkt *pkt, struct rx_pkt
 		pkt->protocol = eth_type_trans(pkt, padapter->pnetdev);
 		pkt->dev = padapter->pnetdev;
 
-#ifdef CONFIG_TCP_CSUM_OFFLOAD_RX
-		if ((pattrib->tcpchk_valid == 1) && (pattrib->tcp_chkrpt == 1))
-			pkt->ip_summed = CHECKSUM_UNNECESSARY;
-		else
-			pkt->ip_summed = CHECKSUM_NONE;
-
-#else /* !CONFIG_TCP_CSUM_OFFLOAD_RX */
 		pkt->ip_summed = CHECKSUM_NONE;
-#endif /* CONFIG_TCP_CSUM_OFFLOAD_RX */
 
 		ret = rtw_netif_rx(padapter->pnetdev, pkt);
 	}
-- 
2.20.1

