Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D9E34FD53
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhCaJmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbhCaJlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:41:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C55C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:15 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b7so29099087ejv.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uD+KHQGrcBkTxOsJmfiY4hqe1Z1zOaYtNrX0KuUk4UQ=;
        b=f5FuYCU1PWl1q0bRnqk60V0438yBuiZSUP8z1vIBN7tUgqtWnm4dw5gOiUgVFCYsnX
         QI0T75onNBerjsQUK3h31q1J7JdZdW+fCbFx28wyg29H1pSyMY1tWPpvLYJ3sosDeC4/
         6OxyKFDWf+Q7SWLZsDWy8Cx5AvQKHSUx3W4o9GND7/HeFQEXhH7ZuURcKI9LxL5TNAhU
         erG1HdhtjhxvG9OhYt7e5BzRa8boLJcQozRkfD0E9TfrRCr7AGmri5YM6aCFD0TxYB6S
         8DgD2jmsXHtLCxf5Zt/+98/4NEg8ITVNPxi2PDjlVCbZBiKYwJ0xKap4RcjAb2IZnqxD
         b9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uD+KHQGrcBkTxOsJmfiY4hqe1Z1zOaYtNrX0KuUk4UQ=;
        b=ICrZB2rhpQwsAAsN4thTiaZSINOPAsE8EcJrjihb96i8AuVNNiMf9teBk89HFhArNf
         3Fu27+sfxRlggo+qEsnBAtodOrGEAsHLBFjNYxBM/bC7RXkCKtSMtNTK5TZ2vga5ec4q
         hY7+uBeMItU8vepdOa5OH1zZBnMm649nticS5at3iyW5aihRuBOOa6eHu+e+vUQrL0uc
         HF2mtaB6arg1WgjXt/VP33FU16XVZT0+kYZDKoBvBza4HXKD+CE743npP9kKlV06sdJp
         KfLfOGCd1GLHmxRtsggBBUa1P6/v8LyFHo4YKEJ3LJziFAXd5ZZx9Ps7lAvZrLokZOKF
         N8/Q==
X-Gm-Message-State: AOAM530fXYT7JM0428VygwXzlq9bwEWEYIWJp9y8i7iY+C1+pKuludnB
        7Ge0uLT4m7M5A+jMSXlwSNg8HfmwRxaC1A==
X-Google-Smtp-Source: ABdhPJxwqbiWJSO7xBFH74FzTu9reUnb9bEoFIIR1BYNy66eqbr/vz4Bzcmh7dqpe8SQRb1X6xvPDA==
X-Received: by 2002:a17:906:5a8f:: with SMTP id l15mr2572372ejq.462.1617183674146;
        Wed, 31 Mar 2021 02:41:14 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id c17sm1266900edw.32.2021.03.31.02.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:41:13 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 33/40] staging: rtl8723bs: fix string format in os_dep/ioctl_cfg80211.c
Date:   Wed, 31 Mar 2021 11:40:01 +0200
Message-Id: <5d80bb72aee3a5755d4daf3a753c9581349bd83a.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix string format in log message in os_dep/ioctl_cfg80211.c

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 4f6398f86b75..260d9fa739ef 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1797,7 +1797,7 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 	}
 
 	if (ielen < RSN_HEADER_LEN) {
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("Ie len too short %d\n", ielen));
+		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("Ie len too short %ld\n", ielen));
 		ret  = -1;
 		goto exit;
 	}
-- 
2.20.1

