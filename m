Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772DA360697
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhDOKIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbhDOKH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:07:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD4AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 03:07:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h4so13691636wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 03:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZeOoSTrmtcNAY29WBSl7pF72FqMaozdn6Exoiit6rA=;
        b=j9236lsxwlR31SRy+OP9n3GvpfSA0inJn4W/q48u7hWNAbq13L5VCzuaI290STNDhX
         6MTEGHaO5FhUdt4YTfVY6Gp9iHddq+nCvYbcKijcc1SsQiX1qnoFOjfgqxoF+lSmxIo8
         aJ9Ukhqmw4XqygKYQz5/bRF6irdDuQkyY0RqAm4eU6Zt9HkTsbZlcf2UxHdQ1Q6Jhuiz
         R7hIQtySzCPG1nSXazX6cptnaiLyGbhWs70CYkWxoeyj/8yFL8G5A/PMqyGpcj4z8j7d
         8Gph/2R4M+vQzIhNtt2UQItizbANYTBMa4VBpEGHBnd0ZvYqgf6dGbPW1tdKV5h8Zz5D
         k9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZeOoSTrmtcNAY29WBSl7pF72FqMaozdn6Exoiit6rA=;
        b=rAD7iEWk+Memjov14rMNq/Eh6dQf4hAMPJed5PX9+mCPi4pEZi/mIEmSA/YXuud/G/
         J2aUdTUryXA91evPr+MKSVCIpRfHikgaKV0eJ4LKgYxPl1Rfptfr9m90jqvpWjF65X9D
         +ABn7tfgG7jZDbLNyqA6Iqz/up+SlehYKLNFZn2mDLE5HxYeE460MDpY6aD0dqHLW4XJ
         3w7xj1QmMD3OiKU22xaSXSDeDuK9rdPeGlidEyWM6QxSG4ip+mzplwU66nQ8KjfIgC5x
         +RI7kNQ6ygJ4YreVkuB9kBAddBqRxijCungJFzdqJR6yR8EVNw6KwOwQqhPg5oYNVlj+
         Bq+g==
X-Gm-Message-State: AOAM533/rx9pq28DvvomdO1L6fwO7j5omCEsrFfh9tOHePc3RM1+49L6
        tovG0gHTB3xdljMQraDaEbsL/66zph0=
X-Google-Smtp-Source: ABdhPJzrI4+DL39WdB6fGpYzQOBlXP+eJV1XXlOhYP9qA8cTfez697sAu7nBzcJiBVJhhX6Y1U2mZQ==
X-Received: by 2002:adf:a3d3:: with SMTP id m19mr2643952wrb.24.1618481252397;
        Thu, 15 Apr 2021 03:07:32 -0700 (PDT)
Received: from agape ([5.171.72.223])
        by smtp.gmail.com with ESMTPSA id j14sm2105104wrw.69.2021.04.15.03.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 03:07:32 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] staging: rtl8723bs: fix indentation in if block
Date:   Thu, 15 Apr 2021 12:07:21 +0200
Message-Id: <7f548510ebe2427e85f3fe8b33ed937160c64e9f.1618480688.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618480688.git.fabioaiuto83@gmail.com>
References: <cover.1618480688.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit hook checkpatch issues:

WARNING: suspect code indent for conditional statements (32, 48)
323: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:708:
 				if (!ret) {
+
	netdev_dbg(padapter->pnetdev,

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 775e55ecac25..06544d0652b8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -706,10 +706,10 @@ unsigned int OnBeacon(struct adapter *padapter, union recv_frame *precv_frame)
 			if (psta) {
 				ret = rtw_check_bcn_info(padapter, pframe, len);
 				if (!ret) {
-						netdev_dbg(padapter->pnetdev,
-							   "ap has changed, disconnect now\n ");
-						receive_disconnect(padapter, pmlmeinfo->network.MacAddress, 0);
-						return _SUCCESS;
+					netdev_dbg(padapter->pnetdev,
+						   "ap has changed, disconnect now\n ");
+					receive_disconnect(padapter, pmlmeinfo->network.MacAddress, 0);
+					return _SUCCESS;
 				}
 				/* update WMM, ERP in the beacon */
 				/* todo: the timer is used instead of the number of the beacon received */
-- 
2.20.1

