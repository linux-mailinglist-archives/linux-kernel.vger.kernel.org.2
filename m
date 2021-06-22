Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBDF3B0477
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhFVMdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhFVMcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:32:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648C4C0617AE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:30:06 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y7so23339731wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=77HnC0dTisnKWDPVh1Io+8wCN1+6InnJC2WdQmork9k=;
        b=rdIVl7ROyyVmuoqNAkV8dbJL+vZedB4CXaLyU7TGt8lH/W0VIBSY/UYiS/QSTR1fBs
         HoEppTeFdMHJp1T597KjgtlaavwOUcO4uF7NrfZLdKeMYs5/CpcoZsDDz6MngW2dEBJU
         MfGktjhlEA5EY6FnGDyOxaEHmX367iTKjFmwpI+iQdDccmqUaiKgpYHi2tp0jGuQGbr+
         u1CqawABMt8pUweKb7Jxsq7uXRoZ2B94VC3zUnYNK12gRmwop3at6ttrwQipF7eZuxpA
         fiUYY1ywEo8ZwVfuycTL+OZ4Aab+RmIbHGXK6wvhx8U6puoeH2Gyk7N0zMOuXCCUGh6a
         ZU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=77HnC0dTisnKWDPVh1Io+8wCN1+6InnJC2WdQmork9k=;
        b=EVoSCgg4ekHNIO5SFe/yfkUpmqbVg5gX44WnqmE0gaFeDQ3rkaMI+zVCcOLPcL8Pdq
         iAcNjBr9u9VDlvbkfqAhqL6hs/phKfoyCpLQvE7pkgLQgH/6ecxcKR80Ph8rJXpe3Q1c
         7KYTW2H04bIkfr+Lr4mKJvnb+CA/0SrAUDs50B3rP0U9ZzXTr6Fitx+IQwqQJvWxIQ01
         5SmHy7kDAoRNrIyN3/lfnEeFwwHKkV9UId+clhzC+otzqvuguW7tAoD9BWEq9K6gmHZr
         HGgORTol5WZtW/IPM8MMPNulYzLqyvUM/OJB+DqjEQDmjIioivnbtSjyFTyZtVWS+oya
         0Wpw==
X-Gm-Message-State: AOAM53305HzdeQ12kht0bzSMtM99GE1Oq1uvy2YCr8u3ux7yrOiZo7wo
        aW33D7Q7dcBDKp0H8+bcBiXZkFhMh8gYhg==
X-Google-Smtp-Source: ABdhPJz4Db5GSAdsilVCU398r/9Arl/eVVs48bqh6Y0/ht8xNGBP4uPkWEbO210Qaa5qHMIYPyQWuQ==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr4515535wrn.222.1624365004924;
        Tue, 22 Jun 2021 05:30:04 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id y15sm2142399wmq.17.2021.06.22.05.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:30:04 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/17] staging: rtl8723bs: fix macro value for 2.4Ghz only device
Date:   Tue, 22 Jun 2021 14:29:39 +0200
Message-Id: <d4dc048406bb8972b17db51a76a5dce0fa4eabaf.1624364582.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624364582.git.fabioaiuto83@gmail.com>
References: <cover.1624364582.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix IQK_Matrix_Settings_NUM macro value to 14 which is
the max channel number value allowed in a 2.4Ghz device.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index c349de205f93..abf6547518fb 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -195,10 +195,7 @@ struct odm_rate_adaptive {
 
 #define AVG_THERMAL_NUM		8
 #define IQK_Matrix_REG_NUM	8
-#define IQK_Matrix_Settings_NUM	(14 + 24 + 21) /*   Channels_2_4G_NUM
-						* + Channels_5G_20M_NUM
-						* + Channels_5G
-						*/
+#define IQK_Matrix_Settings_NUM	14 /* Channels_2_4G_NUM */
 
 #define		DM_Type_ByFW			0
 #define		DM_Type_ByDriver		1
-- 
2.20.1

