Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0C83A8BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 00:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhFOWif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 18:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhFOWiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 18:38:24 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B044CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:36:19 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id d184so85572wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p3xtY9mPoivqNlxlTxZKv34gtKqQm9nsURNrhy81q2A=;
        b=Ci7VJYN0rCSCmIXqe49IueJeE4nNGn5FtJO63nb+NNydpvZ7lIHbFiLzBQIQJXD/f/
         WIgMNZjAC95AHsDLRGROFfArBwoKWmTLiOTioi56jzpuMTMQqbjqefqB9oq8+LSGJIA0
         lDdMZAs80ee2B84FusxB1bJmG4qHAYSgThESnfzX7UpUyFxDFWi3yIdsiXGqJtSOX5uK
         Yo8tRcEBzRzXsQbssXhOAv4b7ShZw1CLiXqb3/qWawIPYXYj4rR9WM+Q7Ub4zJwQsadO
         9SVUIrMD/jQYxRsDlSSfOuttFRYTjdqKjAAwUXn0Bogdq3EhiWWKSPHFHuW1/ZKa7nkm
         FOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3xtY9mPoivqNlxlTxZKv34gtKqQm9nsURNrhy81q2A=;
        b=lyr9IqeWIZMS9DM01pTd5Wed4EU56Ds7nQaxbe0wX/egFrLNSlJV4ciCW+sfL5xQUq
         8OJKxWKoH69Gm6r4+cC9Vgrfs9AzyuHwSslVkGK5GxFF1NiYYC34liwXh2mqMQr+QUdc
         WrN9btZXo9R4hI2B08o5pPeJEbrb8Z4QgUaT9cz9HikVrC6WX1oolyJSWNFxQwbempvf
         3yYKhqF5lBH1DLtiwV3aexKuGBgeGdMsYCanUZMyUuvJ8DYri86WCKOLz67Mr3x+zZMG
         h8PQPdHBOong//TlFZ6l811bw9CVii/1yhDW0Ra0RhJq9dA6J+qFdB91R5KB7jcLQjaB
         IbfA==
X-Gm-Message-State: AOAM531MbHlSR+MC2meFhIA2cAlmv/IjiKXuLiS/AZdpI+RCF+WgVRQS
        iwnGkkzOxVGzlsi6tFCLUhYVcg==
X-Google-Smtp-Source: ABdhPJyjBpt7Dzscmq1yI6ao0PppHxeTfUZpKwqbfixDLkMzsydDIYZ0NnVeo26TplSifH8/sMowrA==
X-Received: by 2002:a05:600c:3b1e:: with SMTP id m30mr583978wms.101.1623796578316;
        Tue, 15 Jun 2021 15:36:18 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id m23sm3934791wml.27.2021.06.15.15.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 15:36:17 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 7/7] staging: rtl8188eu: remove _dbg_dump_tx_info function
Date:   Tue, 15 Jun 2021 23:36:07 +0100
Message-Id: <20210615223607.13863-8-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615223607.13863-1-phil@philpotter.co.uk>
References: <20210615223607.13863-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the _dbg_dump_tx_info function from hal/rtl8188e_xmit.c, as
it doesn't actually do anything and is only called from one place.
It used to have some redundant debugging statements in it, but these
have now been removed anyway, so all it does is read information from
the adapter to set a variable 'dump_txdesc' which is then never used.
This fixes a kernel test robot warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c   | 17 -----------------
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c  |  1 -
 .../staging/rtl8188eu/include/rtl8188e_xmit.h   |  3 ---
 3 files changed, 21 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c
index 0d5608766a0e..efa8960a7eb5 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c
@@ -23,20 +23,3 @@ void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf)
 					RTW_SCTX_DONE_CCX_PKT_FAIL);
 	}
 }
-
-void _dbg_dump_tx_info(struct adapter *padapter, int frame_tag,
-		       struct tx_desc *ptxdesc)
-{
-	u8 dmp_txpkt;
-	bool dump_txdesc = false;
-
-	rtw_hal_get_def_var(padapter, HAL_DEF_DBG_DUMP_TXPKT, &(dmp_txpkt));
-
-	if (dmp_txpkt == 1) {/* dump txdesc for data frame */
-		if ((frame_tag & 0x0f) == DATA_FRAMETAG)
-			dump_txdesc = true;
-	} else if (dmp_txpkt == 2) {/* dump txdesc for mgnt frame */
-		if ((frame_tag & 0x0f) == MGNT_FRAMETAG)
-			dump_txdesc = true;
-	}
-}
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
index 7ca0a45dd0c7..729d3bbf4343 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
@@ -318,7 +318,6 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 	rtl88eu_dm_set_tx_ant_by_tx_info(odmpriv, pmem, pattrib->mac_id);
 
 	rtl8188eu_cal_txdesc_chksum(ptxdesc);
-	_dbg_dump_tx_info(adapt, pxmitframe->frame_tag, ptxdesc);
 	return pull;
 }
 
diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h b/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h
index 617c2273b41b..72a2bb812c9a 100644
--- a/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h
+++ b/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h
@@ -154,7 +154,4 @@ bool rtl8188eu_xmitframe_complete(struct adapter *padapter,
 
 void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf);
 
-void _dbg_dump_tx_info(struct adapter *padapter, int frame_tag,
-		       struct tx_desc *ptxdesc);
-
 #endif /* __RTL8188E_XMIT_H__ */
-- 
2.30.2

