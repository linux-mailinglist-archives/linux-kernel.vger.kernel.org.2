Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7E9354ADF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 04:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbhDFCcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 22:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239101AbhDFCcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 22:32:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52567C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 19:32:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d8so6648403plh.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 19:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=h8ugM46gCL76gBJzMhTW9CmhyaTuMvOLXXK4q2ofL4c=;
        b=jhLAfUpXkJozGAGaEGwbsNGpRtkiFeKIsZqaOQ1Szd5jb303YibVkasQ67Uag4uDa2
         3OCc/qfp+yHBerCudp+fhlvYhoUtShf8mQ3xKZA8mt+1blFwsChHjXFpvaXo8dt8steU
         dS1HTfZ2lMgDrPz+2xnJF8mHen5EW1R2W/smX8G3rEbMQ7Nudnae8d9iEJ8rSsO6sOIM
         sBU6LuNJd/n5jIIsvy2HFQrq6TVqJrUxyKhy759nOO+Gfr0Byd+ohaA/KrYB9ps8Gl1w
         nousXKJosPQs70z6cxYacA8aJ5Jrlg/JeKVdMdei+vc6IcSoZ9O3+xf6LqS/Lphepj4Y
         IQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=h8ugM46gCL76gBJzMhTW9CmhyaTuMvOLXXK4q2ofL4c=;
        b=LPiNLUbJX7or9fltnw79/E0WGtHRDp2K15Xt/DlU6OGlwS/USj5up+eSKn/vT/V8Oa
         g3hDrxiFM8MjilxcyNyKPV78wWe2UjXCaOeF8wxBXVuEAssDQRJvMqY19MVoXiOqENKY
         hx7frPzLwOM3GFwam7M+RnIRJ3/3AWcbs08e7s046kcUigGchXcKBJRo+K3LcU+Zl7HN
         Bf4Htbme/PW9Nc4uw07K9S2S5G9KrNySSgeL6szxRpSHAGHY6dDV4R6fSwfxILz1pRq+
         +iUeaNceLL/XwzCM4UXcECfco0m5rVfamSqlYf7F7+mPdjY9oUDKj2s9brcDwTs0nShV
         W0kA==
X-Gm-Message-State: AOAM53143vUocjB0rCOLZPQEg3cvy5MPDWOCfhG6r5Cw4OTTb2g9Rg9t
        nMSAa5TAS8JW7usnq+3mv6M=
X-Google-Smtp-Source: ABdhPJzRS2dRHe4IPn9ZnN4Gu/6Zi3PIBhHp5paudp88N/AZO8k3PGBpyn2QqnDGo8/9m9Gh3YgYww==
X-Received: by 2002:a17:90a:5d10:: with SMTP id s16mr2069094pji.204.1617676360898;
        Mon, 05 Apr 2021 19:32:40 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id e7sm281196pfv.107.2021.04.05.19.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 19:32:40 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH 1/4] staging: rtl8712: add period within a comment
Date:   Mon,  5 Apr 2021 19:32:17 -0700
Message-Id: <f9f48ac6e93e814c51a7ed370d0b2988d2e3a602.1617674639.git.deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1617674639.git.deborahbrouwer3563@gmail.com>
References: <cover.1617674639.git.deborahbrouwer3563@gmail.com>
In-Reply-To: <cover.1617674639.git.deborahbrouwer3563@gmail.com>
References: <cover.1617674639.git.deborahbrouwer3563@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a period to separate repeated words in a comment. The period preserves
the meaning of the comment while also stopping the checkpatch warning:
WARNING: Possible repeated word: 'fw'.

Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_xmit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl8712/rtl8712_xmit.c
index c247f92207f5..d8a366338a2b 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.c
+++ b/drivers/staging/rtl8712/rtl8712_xmit.c
@@ -507,7 +507,7 @@ static void update_txdesc(struct xmit_frame *pxmitframe, uint *pmem, int sz)
 
 		/*offset 12*/
 		/* f/w will increase the seqnum by itself, driver pass the
-		 * correct priority to fw
+		 * correct priority to fw.
 		 * fw will check the correct priority for increasing the
 		 * seqnum per tid. about usb using 4-endpoint, qsel points out
 		 * the correct mapping between AC&Endpoint,
@@ -560,7 +560,7 @@ static void update_txdesc(struct xmit_frame *pxmitframe, uint *pmem, int sz)
 			ptxdesc->txdw2 |= cpu_to_le32(BMC);
 		/* offset 12 */
 		/* f/w will increase the seqnum by itself, driver pass the
-		 * correct priority to fw
+		 * correct priority to fw.
 		 * fw will check the correct priority for increasing the seqnum
 		 * per tid. about usb using 4-endpoint, qsel points out the
 		 * correct mapping between AC&Endpoint,
-- 
2.17.1

