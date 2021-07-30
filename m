Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAAE3DBB70
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbhG3Oys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239424AbhG3OyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:54:23 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFFCC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:54:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x14so13539650edr.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jw0xLY+vm795MhFxQkfoXv1/Mq5jVRjAqI9LMouhf/s=;
        b=NdaU2lIE2VdmHidOsEjh3ssUPR26yIq0ttRCxSLGiclMYfLL5X8V0IYDS7lo6Wiu1R
         IIh3pzZi3AwUogrfsWc9U05ZJLPTquzIpN2I9RU7o0rPg1Tq4Z97nFCK7qFf4UkPw6M1
         dmMFTsob/aTSK9mgQz/VRQVfQZmEBOGCNWm5GebqTJPzCCD5yOe40hl+9aXiXmE8m35d
         NqyKxl1oCPwv5Oj1Ji89UHXy7oi4WK1kOshF3EXAePfqCUcboSIjxpiAoPZe0vzTgSjs
         XwbPGe6mh8gq0rwSV3cIJ/b1aivNrniM8QOUYb+tuWlLHzl25+LYhxyvo1q1NKHtvsRO
         gMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jw0xLY+vm795MhFxQkfoXv1/Mq5jVRjAqI9LMouhf/s=;
        b=ao8sxwhbXZ96gRcEeKee5UdV77vb7Q3tziLqYix+kAxQs+k4qmfb9w3d0Lr+qfNF7c
         5RCyS3VNV+ULHxMqyD4HHilpv0CTUWqH77EuYTiw6wHIKtmP3+WiVzvFKUXXqWstqxEE
         qX2v3xesf9MfaRuILez0wjYwS/ebSyETu/8dVaZ108kuOVaKgEZANbNB5qM2YXp4+YuC
         TlEsg6PVmbOypxnyEW3NyFkZcoN1mYGuZsuvPa5iq4mCnPMj+WOWqJlWy1sT+UjUEr3l
         t6CAqbej3jIQSBPoo1aMV0st3u5VKyWCAHTWMcYb3kt78Av6K8HworTEtnpK7L/h0tqK
         axIQ==
X-Gm-Message-State: AOAM5333HONROtQE8H4SO5bjCBd6E9jqspwVxbObIDFjzh1BzZ2RDKJi
        mxFf00MMpzigjffgabYQuf84FqkX9IM=
X-Google-Smtp-Source: ABdhPJwKFHy5TdGafmcw5J/0qFZuSmaO6yyDBNHHM8pE0s/Ni2+FENJD00zajqvnc1vdo41KVVSUUA==
X-Received: by 2002:a50:f1d8:: with SMTP id y24mr3373123edl.275.1627656856089;
        Fri, 30 Jul 2021 07:54:16 -0700 (PDT)
Received: from agape ([5.171.81.215])
        by smtp.gmail.com with ESMTPSA id o7sm616292ejy.48.2021.07.30.07.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:54:15 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: rtl8723bs: put condition parentheses at the end of a line
Date:   Fri, 30 Jul 2021 16:54:08 +0200
Message-Id: <295a41c98cd475ae25f9288d99a929b75492db3f.1627656773.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1627656773.git.fabioaiuto83@gmail.com>
References: <cover.1627656773.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

put the closing parenthese at the end of a line

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index d3d068babb5e..5ed13bf765d2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -606,8 +606,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 		/*  probe resp(3) > beacon(1) > probe req(2) */
 		if (target->reserved[0] != 2 &&
-		    target->reserved[0] >= pnetwork->network.reserved[0]
-			) {
+		    target->reserved[0] >= pnetwork->network.reserved[0]) {
 			update_ie = true;
 		} else {
 			update_ie = false;
-- 
2.20.1

