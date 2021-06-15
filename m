Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C8D3A72E0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhFOASf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhFOASd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:18:33 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BB0C0617AF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:16:17 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id if15so10616107qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qyXNLMjCXEao6Ywzi7tBuduMSl89KvisGli0TKHERis=;
        b=e5PdQGJZzlp+vKSz7M1eAh93YZ4QMweQgNIX7AkIljYkBeF5YJiy7Fh3f8bEcticwp
         ypE246brTfY504j5XJFmEcXNBn/EZTNCvd8g1zjs9jbDDbEaTVSgEQpbrpdXnM4hT69O
         BktdSC86tRW99cyIYM+syATrcnJf08iZH9YtYYllt7vPstVJxdR3PatutDkXFMhFnKO8
         +5K5PV0XOzdRQOacc0r+GHGwO5P+woAieZKvvAnLe727PUlSCUgacqRO4aSISAk80/J+
         Ht3Wz1Uppatrwv7lAJWiCgXA83JfDe/SBr2mFihSdw1s9q9JzS4fQok71htT/hu0BWOE
         HP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qyXNLMjCXEao6Ywzi7tBuduMSl89KvisGli0TKHERis=;
        b=s+gPFJdNP2eOlaq/VSnEv+0EA2QU/O8V6D8wEjpGwlc4fz/ch5XiyAoJbFSEHX1D5r
         R5O4fbkVWI75CVIFlYEhw6kKAY/cbX2n9ezlW81TJG0eYbxtonjm2qTNcj8/gIxDmDTl
         Wqm/w9LHz9qnEDrDq3txvBj69cQKCrcgcRWMyLL66lD3jSYwQpXByiEG+KIOW0gONm0e
         J0DVfSu2dsWPVyZCyGubke8NBq64NjAJqlmcAma5un2q/KBjm7c3qpSSrmolx/enXVq8
         JyrCkY1F3TNraplnKy5f7nx+KPqzQzNRVS9IDhhzpd5I8KVfqdw+k2ceO2Pnz38ke53d
         4ePQ==
X-Gm-Message-State: AOAM533DNdpbeCgCMuT4r6CmE0nb2fmNEMBP9qBB+HqRUOQDKdgE97KH
        dMrj2ndcIFGChacbfPFM4Eovig==
X-Google-Smtp-Source: ABdhPJxwWhsQPD9Dh8PPO+M5eBShwEK0qTzxKGr8GS9HMrvUwIZvdiqaCf3UHPAONrAsm+B4hwnRzA==
X-Received: by 2002:a0c:d7c4:: with SMTP id g4mr1494428qvj.23.1623716176287;
        Mon, 14 Jun 2021 17:16:16 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:16:16 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 19/28] staging: rtl8188eu: remove all DBG_88E calls from hal/pwrseqcmd.c
Date:   Tue, 15 Jun 2021 01:14:58 +0100
Message-Id: <20210615001507.1171-20-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from hal/pwrseqcmd.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/pwrseqcmd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/pwrseqcmd.c b/drivers/staging/rtl8188eu/hal/pwrseqcmd.c
index 34784943a7d1..fb3b0f5e8f28 100644
--- a/drivers/staging/rtl8188eu/hal/pwrseqcmd.c
+++ b/drivers/staging/rtl8188eu/hal/pwrseqcmd.c
@@ -74,10 +74,8 @@ u8 rtl88eu_pwrseqcmdparsing(struct adapter *padapter, u8 cut_vers,
 					else
 						udelay(10);
 
-					if (poll_count++ > max_poll_count) {
-						DBG_88E("Fail to polling Offset[%#x]\n", offset);
+					if (poll_count++ > max_poll_count)
 						return false;
-					}
 				} while (!poll_bit);
 				break;
 			case PWR_CMD_DELAY:
-- 
2.30.2

