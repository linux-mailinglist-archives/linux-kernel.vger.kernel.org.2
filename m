Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C76401254
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 03:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbhIFBCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 21:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237128AbhIFBCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 21:02:22 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92214C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 18:01:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso3781934wmb.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 18:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kg+wkIsJvugQzYYd9VoPwfr1sfAxVMJnOuxjBgJqvgQ=;
        b=q+RcmpdcWp2/T+c4qm3rKWDHqDJhV2LiDW728JghmS8Rfbj0umCUeWmljsF46Gx5SD
         VduHRsL3ETm2Rg0zGFbzZQoQxoflwnjiA9O7BdUtm+GrU4MQVIhClanDVU3DQqQ3o7Dp
         gU8PRImoEURDRIWI9GuC1n/v9gokYck9DACfi9kiI72mOZeidYHlCNj5BiuMcs80f0hQ
         fxFhXanrC5WezvkpzwDuLXU4UXVd6aSmIP6KGCcOOd5x/py/FJZUJwfKQcLpgSt/Aygl
         Hj7+iIFZlRtTpJ229pKG/3PC89zBlwCbkASpGbq7QQDDKXQwtd32vW1Oi3/Judiw1en6
         oTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kg+wkIsJvugQzYYd9VoPwfr1sfAxVMJnOuxjBgJqvgQ=;
        b=gHsxFoZx43gF10/c83LROvfDIctOlREbITPUlbUbOZTL2PJw4Lj5rjZ05DebU88VWH
         MgGNNEBEczUlr6zPdQikEkz/6OyuLRKAKOiig3Th0LidP+t3mgcUReT+pRmRW5WCmF2e
         ouNlwkUpfzGfEiMxbvsLaEiTUEiGQCpS+jcz+zcSDtkpj+lb45cZwep10Xj+CQ13d7OF
         HV4RyumkSSyxeePcCjfXpXuBH11Pnm2pL1NhB2gg0WESd0MVo8oGnYjKLaQI3/c/8QGM
         g9rERLLJw1OW1j9TCPvuY9NcSdRAOpiul26WNzXuxxuhKqoRr17Q9mjB+ZrIf9grlWyg
         QrNg==
X-Gm-Message-State: AOAM532tmpfM4IINdIylvdt9OmHUOP6VDEcevlwqVuiuw8+cLBqShuKB
        nnzYNCLdvm6eGiyKYH+NsgSTDw==
X-Google-Smtp-Source: ABdhPJwxrocPwckLhyNGSywhwMgBpEEwk4LJWLg1XvQpuhig8Ty5FSipbjigf7IeL6dbkbYvRHs1tA==
X-Received: by 2002:a05:600c:a44:: with SMTP id c4mr8904435wmq.83.1630890077189;
        Sun, 05 Sep 2021 18:01:17 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r25sm5151232wrc.26.2021.09.05.18.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 18:01:16 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 10/14] staging: r8188eu: remove hal_xmitframe_enqueue from struct hal_ops
Date:   Mon,  6 Sep 2021 02:01:02 +0100
Message-Id: <20210906010106.898-11-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210906010106.898-1-phil@philpotter.co.uk>
References: <20210906010106.898-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove hal_xmitframe_enqueue function pointer from struct hal_ops, as it
is unused.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/hal_intf.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index b30968a94fbf..b47fcdcf2027 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -202,8 +202,6 @@ struct hal_ops {
 			    struct xmit_frame *pxmitframe);
 	s32 (*mgnt_xmit)(struct adapter *padapter,
 			 struct xmit_frame *pmgntframe);
-	s32 (*hal_xmitframe_enqueue)(struct adapter *padapter,
-				     struct xmit_frame *pxmitframe);
 
 	u32	(*read_bbreg)(struct adapter *padapter, u32 RegAddr,
 			      u32 BitMask);
-- 
2.31.1

