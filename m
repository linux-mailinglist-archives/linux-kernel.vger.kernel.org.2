Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5503392C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhCLQKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhCLQKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:10:06 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC3DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:10:05 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso16121918wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gefUvqZ+PVzm20AG/CnQcxDANW6owChYqRkVVyHl7s0=;
        b=Sl0VDnQt+1RMRe2Y4IFrR/8/2P1YiOj0dIPVJzK5P5ql0xp8SVr0TNOeh50qoDz6KD
         hdOoYBOgsVKy7cVzgXJv1JiPpZEF+nSTBzz7usopk2s6xefngtYEHb384LiWwhxSMbmx
         e1plY23jcwBWT1DPbVrVB1YLmWjjWw+Cotko0G3lt4jLVscvcoE3VJdNtSFjI4LemH31
         gXcI0B6CAuTmoDHKsCa9jUDVvjmWoNMCCoMxJT3XkRnk6fdxWNpcTSQDJa6WFVEObWsn
         T+I84DxSRkr23E4Q7v35GH+GquSxOd0wMCK8oJXnl6EEQe4bchcIBtvZD2/2G4XD2C9j
         Q13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gefUvqZ+PVzm20AG/CnQcxDANW6owChYqRkVVyHl7s0=;
        b=Oufllqd5LZs8POq7sei33mcT5+vkfOsEXuB3vB4NwRZI6w0PutUfj1fLJ5c5+buiOs
         hsIY8hg6V3tirre6Cx0LO+sdEyTPfUkCKo8ecCI5sOjH5QYjZm+42MaTlMW9on7xI/lB
         jo+9fBjFP6MKSfRBbbKyG/BUAMK1+PW7c6VrTXeZiCUA64kOfVq/mg9K8hIWWa3dK3T6
         v6yUR4+h5W4V3Oz8joVi7NeTTjsIjSoisetQHEzGK+cjTdgWKA1k/lXkMwx1xOTXB4Nt
         aWnJpoUaF+gV5x7cCzlo9BpQmCwba+ptIOyw6/ZZtIYxywB1YFiOYjnGWNE8XFqq72/J
         wrXQ==
X-Gm-Message-State: AOAM531ym2NbbhXwAS2x4VhGzKwykC5iX1exbRnsbQEqfxlNRcUBAIdg
        2n4SC7pBjx4JCKe5yZUivON3NlMrmcMA6g==
X-Google-Smtp-Source: ABdhPJwqnWyb5Onm4bEZd7t3tmBLv63GOvp+mvKlzmJbHrVGsAq6EM3W5O8PyIObMIqloZlcm09D7w==
X-Received: by 2002:a7b:c4d1:: with SMTP id g17mr13855852wmk.101.1615565404369;
        Fri, 12 Mar 2021 08:10:04 -0800 (PST)
Received: from agape.jhs ([5.171.80.73])
        by smtp.gmail.com with ESMTPSA id s23sm2524163wmc.35.2021.03.12.08.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 08:10:04 -0800 (PST)
Date:   Fri, 12 Mar 2021 17:10:01 +0100
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

