Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4157351220
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhDAJXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbhDAJWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028CCC06178A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w18so1202700edc.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UBiqXm6cwJ7LWWqnMz3cZaa8qrYLYBPI/KRdxCadpa4=;
        b=QHlklOPvTuHZmcv2dl4QgZKmKsckjPlbd4XvViIh4sCYoodKS4yqhv6rZvm/Wd33iv
         X/Lc32VSGMSpn/Uf/IBHGoJDA8PSyh+/VxTVLwVSbYBv1YhGHCNPRLzFEO9olLegcf+H
         xuz/72Ogx9HnB5pnSsmzPsUsxO0mNpHhks1VAWb+9OR6NSqIMDPp2pM210/9sz1Ci/Ee
         6+9YNLwqQb9t+GLG2UOUjy5gzAd3rMkA/V+sED1koSn1NLGC8v/JrmxYVLRnH9kHrxR3
         4mkICfS49iebpB3/1irDw3Rxgnwkjk2HGCrt2Kd36BKXOOusR/kXfiWaQpi1RujjfHRE
         rozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UBiqXm6cwJ7LWWqnMz3cZaa8qrYLYBPI/KRdxCadpa4=;
        b=DVWBkvwViGSzp1KPveDC5PK/YJZyhVqReSjVW6ijKElAa+W9LkhZ09p0h8l6uQHAz+
         f1OG2BsAtkKju9KJdMnzfX1eG+Vmn0ooUq+QZDVyQo9IlTmnqZctKQ52sWJNgjW6A9JE
         i8KQrkW1UAe8N227MflyPHQ9y2bjjGlI/ai+yt+3bz+c7OKc6wDi6/P+jWiCofdimfP0
         8x9Pik9DmTeonKuey/rY0A0rBGCcuuphVxxjRlheyhQ8XrdIM7V9+bABt7Fdt6Eavhqm
         e/ur5Esfr0SvKXMYCQ9DGFh6X+JgBgwLcGwZxX2TpIoIKkNDvoEGfw87leipPiHmfmK3
         NJHQ==
X-Gm-Message-State: AOAM530uDJQN5DYJWmgd9RoRam05gWoMjPEQKjoSc58i4xDmBBGs4ME2
        uOJjCxQh5pJbBD235izQ3Gg=
X-Google-Smtp-Source: ABdhPJyXfHEcxqO7VCbik/mZSwglEiKiyxg6nDyl2BGoG23CgHXXtll50pP0vjGhOD3v5S6vgeO1Yg==
X-Received: by 2002:a50:bb47:: with SMTP id y65mr8883592ede.305.1617268954785;
        Thu, 01 Apr 2021 02:22:34 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id gz20sm2517539ejc.25.2021.04.01.02.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:34 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 44/49] staging: rtl8723bs: remove RT_TRACE logs in os_dep/recv_linux.c
Date:   Thu,  1 Apr 2021 11:21:14 +0200
Message-Id: <5038103639bc55ffb6bd8d0b8acbebe55d273ef7.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove RT_TRACE logs

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index fbdbcd04d44a..a2a28803c8d9 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -202,22 +202,15 @@ int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *precv_frame
 
 	skb = precv_frame->u.hdr.pkt;
 	if (skb == NULL) {
-		RT_TRACE(_module_recv_osdep_c_, _drv_err_, ("rtw_recv_indicatepkt():skb == NULL something wrong!!!!\n"));
 		goto _recv_indicatepkt_drop;
 	}
 
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("rtw_recv_indicatepkt():skb != NULL !!!\n"));
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("rtw_recv_indicatepkt():precv_frame->u.hdr.rx_head =%p  precv_frame->hdr.rx_data =%p\n", precv_frame->u.hdr.rx_head, precv_frame->u.hdr.rx_data));
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("precv_frame->hdr.rx_tail =%p precv_frame->u.hdr.rx_end =%p precv_frame->hdr.len =%d\n", precv_frame->u.hdr.rx_tail, precv_frame->u.hdr.rx_end, precv_frame->u.hdr.len));
-
 	skb->data = precv_frame->u.hdr.rx_data;
 
 	skb_set_tail_pointer(skb, precv_frame->u.hdr.len);
 
 	skb->len = precv_frame->u.hdr.len;
 
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("\n skb->head =%p skb->data =%p skb->tail =%p skb->end =%p skb->len =%d\n", skb->head, skb->data, skb_tail_pointer(skb), skb_end_pointer(skb), skb->len));
-
 	rtw_os_recv_indicate_pkt(padapter, skb, pattrib);
 
 	/* pointers to NULL before rtw_free_recvframe() */
@@ -225,8 +218,6 @@ int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *precv_frame
 
 	rtw_free_recvframe(precv_frame, pfree_recv_queue);
 
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("\n rtw_recv_indicatepkt :after rtw_os_recv_indicate_pkt!!!!\n"));
-
 	return _SUCCESS;
 
 _recv_indicatepkt_drop:
-- 
2.20.1

