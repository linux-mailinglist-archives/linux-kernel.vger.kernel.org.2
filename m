Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD8D441CA8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhKAOfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbhKAOfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:35:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB378C061767
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 07:32:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id z200so12602163wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ccxJHQnZxwCRL5ALIeLwb3BTgkZUnkc6gC/ao5xjt48=;
        b=UqbfzRP2IFjComwjTeq/suWfT5hLr3qKp728wk8yf7PbLSdilMsp9Pec2Kug6ifr+d
         XsBAajd6tuaF50om8XOl7ys8YVIST46qAJSLWS6R6Wmh3OlHVHoBaYzfFb0BOVzAlerd
         za63p3FoJUrrPWy6PwNypcccCNHaUUa3H5SLep9zuSjLyeCdRMO8CELHpMvT+UP8Uizw
         ZGkJGnzmKtMGOS7YgYYY1CtEQRSkRsin71fK2u9I81fG8iv37aKNJoDECVtps7x11aI2
         GRppSF4yZixWNE8gaypQ6kvFHK0VoAkJCWKdfvY8AGz59myd03/tSIaU/U0y2TD3gCki
         xCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ccxJHQnZxwCRL5ALIeLwb3BTgkZUnkc6gC/ao5xjt48=;
        b=SLLfDuLFLXv/j0Wu/kT1CnxibR7/0zTKiocdI4e3Mxh6m3Ncl1aKUWvfTlqBWaWnJ6
         QmEgPy9WloFdCWfY+GHEOtdoDwKdMr3hi6xTUKz+0xBHXFuFwfUVaPEANXPKT05BG+bm
         i0XlG4R+r0MNvBNNeSWg848u1gQeDHMgzAeJrI+nWUtxJqapAaKHEejSaFcCxcWh1nI2
         8lUhXwNvAB8O6PnrdrkCkSXO9V+BoF8FoM7E30lTzUUW86zIkofiEMKC9UYcJoHl4i4B
         fPXYLxPXrJuNC3OFGUoeD98WE2L+p3q2dPbYyYbPi/GeUTjk/QRKJkyKAfBJR2jO6YEf
         SG1w==
X-Gm-Message-State: AOAM53206nBVIf1Fho0tATSThTfPoYM2y2EqomJgw12MuiEfmsFTS73/
        RTmFiJidKT2l1YB/dSQ7lwM=
X-Google-Smtp-Source: ABdhPJyl8/YXTsw3KMUGsWCkDJgqsHPHgJ1+y10+sD5BokuAuBu7wtuYj8oygI0D11+vWOE/TDf2sA==
X-Received: by 2002:a05:600c:378f:: with SMTP id o15mr32286025wmr.63.1635777144591;
        Mon, 01 Nov 2021 07:32:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id l8sm17157721wry.43.2021.11.01.07.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 07:32:24 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 3/8] staging: vt6655: Remove unused `i` increments
Date:   Mon,  1 Nov 2021 14:32:01 +0000
Message-Id: <79a4f03c8f2bfa555ea149ddd1c0f938dd431a0b.1635773680.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1635773679.git.karolinadrobnik@gmail.com>
References: <cover.1635773679.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c569952d92ba ("staging: vt6655: Use incrementation in `idx`")
rendered the incrementation of `i` outside of the loop unnecessary
so it can be deleted.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index c07653566d17..ea74701917e5 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -703,7 +703,6 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 			MACvSetMISCFifo(priv, idx++, al2230_init_table[i]);
 
 		MACvSetMISCFifo(priv, idx++, al2230_channel_table0[channel - 1]);
-		i++;
 		MACvSetMISCFifo(priv, idx++, al2230_channel_table1[channel - 1]);
 		break;
 
@@ -724,9 +723,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 		}
 
 		MACvSetMISCFifo(priv, idx++, al7230_channel_table0[channel - 1]);
-		i++;
 		MACvSetMISCFifo(priv, idx++, al7230_channel_table1[channel - 1]);
-		i++;
 		MACvSetMISCFifo(priv, idx++, al7230_channel_table2[channel - 1]);
 		break;
 
-- 
2.30.2

