Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C284A401251
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 03:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238572AbhIFBCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 21:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbhIFBCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 21:02:20 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39359C06179A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 18:01:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so3619289wml.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 18:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XTMuSXUGv6jORp8FoEcnxSrkC9WrOP9sRqE050m5myI=;
        b=csd0P3BaNla3NS1SJFCbvqIxlibZ7t4BIcND5DYDew4kCPWr+FUJuQqQrHCRIC4lzp
         rextAv9cL/8ArPm4C/DM4w4E+nWUKavWNCsXU9bqzznzOm0W+MdeVsSA72Xj1ESSaUCq
         BMW50TAqTTuzEhD6a1tcSi2P/ABFQUft/DgV3BMB7T+jUd1lxbvBvN4IbKDBhfh+WgFm
         wOFk4YWHRzWZ5AeT6QpKPInIFENXpRReUWvE5XDfz8cRbjyJU8zETa4goscVyHGOq6kr
         UOtEuUtcazL006PYmOfdilejmuXnPeeErnmRdykH5CiLQxZch13YwLIBFpFvbrk7E/30
         5auQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XTMuSXUGv6jORp8FoEcnxSrkC9WrOP9sRqE050m5myI=;
        b=BHs8HjhAyLeNnLRq9UGvbKJefhSdDDrPesTBOm9z615dgoAPbTkWe/g2GNtOXr2ejW
         PFk/q9HppUfUjSdu4Fi90etUyYTTQjhnLw+/8NyySopIWLBMVn4rNLg1POo0Szf/aNhD
         xkl0LhhsZTfgulPeYgYLC+CoVTTrcHiaK1xGdx1KmqkQEjOfHjZGxi2N5VoCXd2kCNIa
         uldXR3G6+Y3e4Rti96H1tqlfxeLNikGZw8CP5M8Zds83JCfzkhua/2a9vbjWxq1cEAz5
         YxR9JwufLckmUJAJwfg/Qhg01LsxIhIDskhWyQMH/0fgcptDm3mWUbkpP9c1kKNjPqmf
         S+Kg==
X-Gm-Message-State: AOAM531P2MArn1NT0cJedkPa6bHvWtXyoLpFnIxUh6gn4AJtqxJgTVi/
        6ixwIEL4IaT+cn/v17iQbc3r0Q==
X-Google-Smtp-Source: ABdhPJyiQPwYyWvYOo5nK/2zaln2xpF9bzTLWZqfbyWk5gEg13/vgLj7KyYs/B00J1/gyOWEf207TQ==
X-Received: by 2002:a1c:443:: with SMTP id 64mr8826261wme.180.1630890074812;
        Sun, 05 Sep 2021 18:01:14 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r25sm5151232wrc.26.2021.09.05.18.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 18:01:14 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 07/14] staging: r8188eu: remove rtw_hal_interrupt_handler function
Date:   Mon,  6 Sep 2021 02:00:59 +0100
Message-Id: <20210906010106.898-8-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210906010106.898-1-phil@philpotter.co.uk>
References: <20210906010106.898-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rtw_hal_interrupt_handler from hal/hal_intf.c, and remove its
declaration from include/hal_intf.h as well. This is just a wrapper
function that calls the function pointer interrupt_handler in struct
hal_ops if it is set, which it never is. In addition, this wrapper
function is unused anyway.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/hal_intf.c     | 7 -------
 drivers/staging/r8188eu/include/hal_intf.h | 2 --
 2 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 79cf6df0f598..8b90bf4f5e58 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -299,13 +299,6 @@ void rtw_hal_write_rfreg(struct adapter *adapt, enum rf_radio_path rfpath,
 					      bitmask, data);
 }
 
-s32 rtw_hal_interrupt_handler(struct adapter *adapt)
-{
-	if (adapt->HalFunc.interrupt_handler)
-		return adapt->HalFunc.interrupt_handler(adapt);
-	return _FAIL;
-}
-
 void rtw_hal_set_bwmode(struct adapter *adapt,
 			enum ht_channel_width bandwidth, u8 offset)
 {
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index f3951c405927..fa3c09e3c2f1 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -331,8 +331,6 @@ void	rtw_hal_write_rfreg(struct adapter *padapter,
 			    enum rf_radio_path eRFPath, u32 RegAddr,
 			    u32 BitMask, u32 Data);
 
-s32	rtw_hal_interrupt_handler(struct adapter *padapter);
-
 void	rtw_hal_set_bwmode(struct adapter *padapter,
 			   enum ht_channel_width Bandwidth, u8 Offset);
 void	rtw_hal_set_chan(struct adapter *padapter, u8 channel);
-- 
2.31.1

