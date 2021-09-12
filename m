Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95FF407ED1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 18:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhILQ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 12:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhILQ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 12:58:41 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B71CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 09:57:27 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso4920268pji.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 09:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=5ZnW7wgIj8v2huwzv9gIOWbfF2fYK1I8klziVJNMEds=;
        b=Kso+8M10k6HyHFtMApN4h/SBDgeknyXjl7Mqng251vsIUfAPSks8qfIg0PtoezlifQ
         hlrb97XvvAIaO2jYHk+WLDVH5tgsXgucMDloNfqG54gvxLsRxbqAmhLH+1od04RmWdpY
         Z2TJUOhIqk+rSBIzYUTdWZxw2Xk1TprDVip5qqat+x+LJWl0tlmEzc3OQwiXnJA8vCou
         U0H3irTBlgMsJ+qs9aTFjs2TNYdf4HFzZBsNrrTtLi3WZim84yjkRUYp43UO0sNtPj2H
         olC2DMaEK6XeOLbgS19KSHnhcdf76nlSbLDVIpiixZtWwpVFkQPTF+X1YIxaeFYc4n0H
         ZTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=5ZnW7wgIj8v2huwzv9gIOWbfF2fYK1I8klziVJNMEds=;
        b=K31lrJw61qZUGe6Dcz0p9AbL1E+jHGNipb/nHneGzO9fYxKi3KDoV9hQLa6ckVtjTw
         Tuo5ZtaZMuY3ntcajDthH40SYlCCOb531W4NelpO/pipahLErb3FvF+OU0xGTTAU/tLR
         M8ueed08EFYWGAmpfA06es/JjKtEWo3w3f+WgHpj9ifGsBFJIikcc3CEr0mXn0TxpVgJ
         50waNRXxzCvnRO+6Mh+4GUrl+vewW7gSINY6aMouj/hTvgbNyuG0wpYRdiEPBQTabtxX
         NTd1Qmb65jflhLKdIrD98EQqmQRi4T80UnfWA/ern8Mbs2bcUR4K1pBZRm6MZJa6i/1P
         4NdA==
X-Gm-Message-State: AOAM532F9Fb/BkE955y/j/0eVbVMyservLd29DdRkZaeNGZ3QGMc0J1T
        I6bhrdEGJNZJNPg4QqhuuKY=
X-Google-Smtp-Source: ABdhPJzQWmbq9YyoQJArd4nyaXUsoXVQDRS4qqokBtyjokkzVO32TpPbn8X/tsAUX9CM4mCdKAKiMg==
X-Received: by 2002:a17:902:9a04:b0:13a:1ae3:add2 with SMTP id v4-20020a1709029a0400b0013a1ae3add2mr6842092plp.28.1631465846549;
        Sun, 12 Sep 2021 09:57:26 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id x22sm4487828pfm.102.2021.09.12.09.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 09:57:26 -0700 (PDT)
Date:   Sun, 12 Sep 2021 22:27:20 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        linux@roeck-us.net, dan.carpenter@oracle.com, martin@kaiser.cx,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: core: remove unused function
 rtw_set_tx_chksum_offload
Message-ID: <YT4xcJvvlPSIS+T6@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function rtw_set_tx_chksum_offload.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c      | 2 --
 drivers/staging/r8188eu/include/xmit_osdep.h | 2 --
 drivers/staging/r8188eu/os_dep/xmit_linux.c  | 4 ----
 3 files changed, 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 46fe62c7c32c..324ab2db674f 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -576,8 +576,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 	else
 		pattrib->bswenc = false;

-	rtw_set_tx_chksum_offload(pkt, pattrib);
-
 	update_attrib_phy_info(pattrib, psta);

 exit:
diff --git a/drivers/staging/r8188eu/include/xmit_osdep.h b/drivers/staging/r8188eu/include/xmit_osdep.h
index 191c36361b63..3e778dff0ed8 100644
--- a/drivers/staging/r8188eu/include/xmit_osdep.h
+++ b/drivers/staging/r8188eu/include/xmit_osdep.h
@@ -37,8 +37,6 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter,
 void rtw_os_xmit_resource_free(struct adapter *padapter,
 			       struct xmit_buf *pxmitbuf, u32 free_sz);

-void rtw_set_tx_chksum_offload(struct sk_buff *pkt, struct pkt_attrib *pattrib);
-
 uint rtw_remainder_len(struct pkt_file *pfile);
 void _rtw_open_pktfile(struct sk_buff *pkt, struct pkt_file *pfile);
 uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen);
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 565ac5be7db3..088c294f2586 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -65,10 +65,6 @@ int rtw_endofpktfile(struct pkt_file *pfile)
 	return false;
 }

-void rtw_set_tx_chksum_offload(struct sk_buff *pkt, struct pkt_attrib *pattrib)
-{
-}
-
 int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitbuf, u32 alloc_sz)
 {
 	int i;
--
2.32.0

