Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14C23396AF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhCLSeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbhCLSeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:34:11 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897F8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 10:34:10 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo15719917wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 10:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gefUvqZ+PVzm20AG/CnQcxDANW6owChYqRkVVyHl7s0=;
        b=tNfaRqIQDc771K3h+DqnDik5p/3ktVZzOnsrDjc5aoWX8WfMrOAzxMvfKrdD54awI6
         rmXNInKLormdl+pXjtXo5BX9k2AGDOagyvx2ObXqF2/5fppPG35i+Tg5P8Eh8m3poUpU
         3CIPNHyC+q6BRKs7iyBVP2pTYahlj0phPySyETbVDcS0GXS58sVYb/qCHJYmzlG3qdv2
         x8oJwtPCFCWmaJ1xdB9wAdEkGazaHyhcYOJ1UPu0LuNcxMcz7KCzv9g23WnQEKUvv2bz
         63sc0pLttI7lwWElMMGugQVPEC7xHTYK+oKL/ZTRzZ1LcT9fSI3OvJN3lDFPUMDkWtkF
         PoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gefUvqZ+PVzm20AG/CnQcxDANW6owChYqRkVVyHl7s0=;
        b=JZLa0DpyfFG1TBVbtPbkoefqwqFfk/JQuwiOSOuMMlhIetgpx4K7RC8huZNMWg8DL8
         5RdU9K9wJAAXhab5oDb8GHOtFgLLV1/tS54RtnQmmS7ggYNWDK5j9S4KSL/nlIx0ZS7N
         Av10n5yuf2GOPebzUtLpnR0mlaSIWtp//SG42KALEEXP5YRnQoRZm5P7A85g7XAm0WXQ
         fQjMZut7/Ou+/s3J53PMQ9IEuxZf4GpDCaZ7+SS5vP/2+CIGCc6m4hyM7gEvyrrFzFQM
         zoA1i3QDmPbOTGVf3vuRlykLhVHWfoMFtsQ92qgXcPszdfnlzEJ3rrGHXoPVTZ6Jf6W/
         ToXA==
X-Gm-Message-State: AOAM530kqA87sMm071A5eFhT74uLocQ6qsqssJTZJ1PUToJUrsQwzC7x
        tf5GFbojV4XLlxsvHYb/hYs=
X-Google-Smtp-Source: ABdhPJxPMHJAaDy3+9YtfH9VzWiqu8h81vx2+h496wEyPVDZPPqp4qsDpE3YZKpIZ3OQzPKYt2fbfg==
X-Received: by 2002:a05:600c:4305:: with SMTP id p5mr14198573wme.58.1615574049308;
        Fri, 12 Mar 2021 10:34:09 -0800 (PST)
Received: from agape.jhs ([151.57.163.80])
        by smtp.gmail.com with ESMTPSA id v2sm24905188wmj.1.2021.03.12.10.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 10:34:09 -0800 (PST)
Date:   Fri, 12 Mar 2021 19:34:06 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_TCP_CSUM_OFFLOAD_RX
Message-ID: <0975dcb60dfb6abdc6a3233283908bd57472c225.1615572985.git.fabioaiuto83@gmail.com>
References: <cover.1615572985.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615572985.git.fabioaiuto83@gmail.com>
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

