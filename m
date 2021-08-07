Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5415D3E347F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhHGJtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhHGJtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:49:03 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4598C061799
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:48:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z4so14323386wrv.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2aWYRmpVXXmfCzc0hGXLln/sWneJEQ0/P7zXh3U4+pM=;
        b=Zru0D7EX4YflMhBX95pCSQbZQMsezC5CFExQ6KVQvW0G77g7U72gqzD2R3GKONI3Zc
         Xe1/sIsxSNaQ/HYA2yT8BShZtG+5V2LjyW9TyyD3F2A5C46TpxY7cG0j/S/v3G1NklQ4
         MA9poRvOHwBZ0XvqQnXZsFDJCR1vz6Fqy+2K3d/Xe7cXBhlYbwff6jHXrIGfFv0pAIix
         kaL16l1W+FavoWQYNpeUyFpZ5058Q9Z+mE8j+aDLj8QnY+HD8jvQ3/IH+1oyCOZsU2kb
         1CCffOpXORbLuanZ0465ttJU+TCPmk99NCDEhacOnYG4VDgjFWq+ynXmQjRNHQpWgEYX
         uw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2aWYRmpVXXmfCzc0hGXLln/sWneJEQ0/P7zXh3U4+pM=;
        b=c/q05UHNcfAhGY71IzDZTu2IDANBNCbXauHE0jBO7ctadMVsb4FgRI3pYYYk6plXv5
         0H85YfRJvjIUpb121SQ272Mw8tRMTJH52puBPYLfIbNkjId11KNKLJUDHHnovsvM+Wlg
         PKjfSX990K1M8ABQMpBRisJD34wIMGjB6REA7lm+ylckQkbO3+rc/+wC9RITv2wzF5E9
         TeOkctXeaMd9qtlXEmmvOxt89x24NziB16V6H+izX4Gy9iecbXvEVYpKLTd9nlB+KfAp
         aOA+JgueM9EpdPZKgXT5mWMcIYGwt5zCEiKcn/xbsRWqDtGWhkvbRZstc4yQT6fPHG87
         prLg==
X-Gm-Message-State: AOAM533dH0vvUpCqb7MIFEIHniBbqpXhm6CDdGC3UGiY/4K1iL1nw3c7
        cv/vWyvtE47DxW0cMJTF0CYy5i2nYCc=
X-Google-Smtp-Source: ABdhPJzRGXKifkn8+7Zc4MzQYDICoV2uQ3OOL/kgODoErz8+VC8FREiXB0MkbHsA1T6hkQrYSENLXg==
X-Received: by 2002:a5d:4562:: with SMTP id a2mr14825092wrc.347.1628329723336;
        Sat, 07 Aug 2021 02:48:43 -0700 (PDT)
Received: from agape ([5.171.80.112])
        by smtp.gmail.com with ESMTPSA id g16sm14699013wro.63.2021.08.07.02.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 02:48:43 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 21/21] staging: rtl8723bs: remove unused RF_*T*R enum
Date:   Sat,  7 Aug 2021 11:48:13 +0200
Message-Id: <2f2f185a80fbec71af4a165180ed0156d194c96e.1628329348.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1628329348.git.fabioaiuto83@gmail.com>
References: <cover.1628329348.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused RF_*T*R enum, for rtl8723bs is
only capable of 1T1R rf path so selection is not needed.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_rf.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_rf.h b/drivers/staging/rtl8723bs/include/rtw_rf.h
index 6c25707f4ec8..718275ee4500 100644
--- a/drivers/staging/rtl8723bs/include/rtw_rf.h
+++ b/drivers/staging/rtl8723bs/include/rtw_rf.h
@@ -97,16 +97,6 @@ enum {
 	HT_DATA_SC_20_LOWER_OF_40MHZ = 2,
 };
 
-/* 2007/11/15 MH Define different RF type. */
-enum {
-	RF_1T2R = 0,
-	RF_2T4R = 1,
-	RF_2T2R = 2,
-	RF_1T1R = 3,
-	RF_2T2R_GREEN = 4,
-	RF_MAX_TYPE = 5,
-};
-
 u32 rtw_ch2freq(u32 ch);
 
 #endif /* _RTL8711_RF_H_ */
-- 
2.20.1

