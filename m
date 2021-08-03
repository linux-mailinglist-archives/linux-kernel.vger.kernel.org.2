Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482193DF831
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 01:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhHCXFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 19:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhHCXFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 19:05:52 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F120C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 16:05:40 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso2718553wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 16:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wGo+3f+0qTZCTY2bzh5gM59oDyvCliepgg7Xmjd7Xh0=;
        b=oUkS9JYYee2kyFpt73yJs8PEtusYbKrP9q59yi0PQ4mYkTtzQBfpQ2PuJbF8df8rbj
         r+aAybR1b2NuVC3slT7IzObd2AJw1GBTmNTWql2n4W2ddqxSbxe9anN52wAl04+OUj30
         y5H61VUEcT9xzTl5e4ARooKNRPviwR7Ozl0AbLrBwOz/ceC9R/zPMx2iCAKX4A+nZETM
         RXHpMZlFYCKTMStsS9a7japYgLVEzSbbaTE3Cbm5ye/xaaQLd57g/qtw4frkAG3P513v
         nEXUZFLhXE9ljUBqFd8zDRbVj2Ym+2uVFouDHt5kSnoyCyQx51y2SOkDWKYNRn7FOMEO
         7FUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGo+3f+0qTZCTY2bzh5gM59oDyvCliepgg7Xmjd7Xh0=;
        b=IiytrXfD4teEHTaLl8tG46/eSc7TydVZlumZlV0AY+9lcEA6HccA2KBzAUhrRtx+2e
         Ny/25ujI7e2LK/WAVeUrOt8fJ0L5M25OCLoTDb7s1lfOsrQOw2clYL11+rGy7h/AHQW0
         F9S6uskvLP+Q46VRLx8/S6ALTZzzMtZNys6xheB8YS1Rs4mLujyciTsOlLZr7K8tA3Tp
         9Bbhl/2IaD5UDXg1MCRoPYiRSsvLSOz1XUBtz64e7OUqNehOa+B7+BRHYgwqxLNjElxN
         aPnNtwXlSrJPbVTeMtHZMRni6630kLqexN4mIqiJBksBBv8Wtt3d+Z3cBCrxifEVIrWd
         fwOA==
X-Gm-Message-State: AOAM533jh5dbSI4UEfIOasakKTYON7NfTdusi+UqejCiTLzd++fscdfO
        kTDlJD/M5hvDB+OZEU9ZeEk4sCEIHdFi5cEDeWs=
X-Google-Smtp-Source: ABdhPJwMqQO7IKbT+ttT387aVvzDnJ1By97F1xzxR8yvA65qzG0BxKbQmt2TGNGIFFfdJmAVfJG9yA==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr6635299wmi.177.1628031938857;
        Tue, 03 Aug 2021 16:05:38 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id i29sm330045wmb.20.2021.08.03.16.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 16:05:38 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] staging: r8188eu: remove RT_TRACE calls from hal/rtl8188eu_recv.c
Date:   Wed,  4 Aug 2021 00:05:29 +0100
Message-Id: <20210803230535.74254-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210803230535.74254-1-phil@philpotter.co.uk>
References: <20210803230535.74254-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from hal/rtl8188eu_recv.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 2e3f624d0f22..c544e5d89226 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -47,7 +47,6 @@ int	rtl8188eu_init_recv_priv(struct adapter *padapter)
 	precvpriv->pallocated_recv_buf = rtw_zmalloc(NR_RECVBUFF * sizeof(struct recv_buf) + 4);
 	if (precvpriv->pallocated_recv_buf == NULL) {
 		res = _FAIL;
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("alloc recv_buf fail!\n"));
 		goto exit;
 	}
 	memset(precvpriv->pallocated_recv_buf, 0, NR_RECVBUFF * sizeof(struct recv_buf) + 4);
-- 
2.31.1

