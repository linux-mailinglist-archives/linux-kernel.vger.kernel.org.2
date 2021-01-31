Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A648B309B15
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 09:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhAaIMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 03:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhAaILG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 03:11:06 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B53BC061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 00:10:23 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id a25so15635100ljn.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 00:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VXMDrOK2wYAdD9AnIGGKDk+V0hqpb9XtfbS5RIo5bX8=;
        b=tqdBWQWxpXuIo4/bRKgDNbLFcyBsEs0mz4mV4E9ov6aX5p7A+kfrTIQ8agJRtfim6Q
         MJA6+J9hNj/RVDmi8U/F0Nzg461c7PHCcln6jmUYrFQVPyh7eqxzbeWv1E2FuXlBy7fa
         OCaOPFzxLtGMlXkGWUnft6n5sZyI0VehWX2tFes6/BLv0jsJw6lEvgrbuRWXikIPLbrT
         nybwPt29ENeF51MTt1DV2pvthuGxRecnrDgd8OIC0UWlEOXzxcH7wShrq63jF7JLXqNp
         4Tp1ooqHwwuipc6zQhvItuDQeIQAHPjqrmOAzUwcl1Oq7NzFExoHKS7Q7GxQxONjdszJ
         5FzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VXMDrOK2wYAdD9AnIGGKDk+V0hqpb9XtfbS5RIo5bX8=;
        b=QU9k9gIgCPFloq60P1l32TwD5yErIRn9akQe4GJ7cKaaNw5uAXPvhFduC5CVURMeEt
         Wk9265AsgucPNkxgln6yrSdOs31hIXRtX3Kc0wej8w0X5wv3CrJYeoQ7Kbxu5mzJkIkc
         meBDOoRD92zFBRNOcRPyFNTptK1cvV3rCnNvIXU4i6LWvS21WyeynO9zoryHAlPMsWNc
         IJornKOuDjdOBVIpMCNdvkXlvCEBb+p4oG2dOAH94L5OnIlEXrNdU2sq7kVNOyocGKf0
         0ftfWn3E9rzDj/bJQS51n97TLTIImRZfc6/NjjcHH9NpDfv38+0rylF77MVtV5sEINMk
         Vx1A==
X-Gm-Message-State: AOAM532ZeBbrOwfynUcDjFPAgxXqsf+R6hQ3nD4EMpsUXWI7Xo4mbInc
        sbsLp0neOrscTvOhRuBgvKo=
X-Google-Smtp-Source: ABdhPJxhfUlaL+LZHKWobW2QhhbzABZvM3E5RZ52/smu6D+bfr0BMaijWFcrafNm762rB63RgLV4iw==
X-Received: by 2002:a2e:a555:: with SMTP id e21mr6980662ljn.423.1612080621747;
        Sun, 31 Jan 2021 00:10:21 -0800 (PST)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id 24sm2569970lfy.32.2021.01.31.00.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 00:10:20 -0800 (PST)
Received: (nullmailer pid 25313 invoked by uid 1000);
        Sun, 31 Jan 2021 08:09:32 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pascal Terjan <pterjan@google.com>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging:rtl8712: remove unused enum WIFI_STATUS_CODE
Date:   Sun, 31 Jan 2021 11:09:13 +0300
Message-Id: <20210131080912.25264-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve readability.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8712/wifi.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index 601d4ff607bc..1b32b3510093 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -101,20 +101,6 @@ enum WIFI_REASON_CODE	{
 	_RSON_PMK_NOT_AVAILABLE_	= 24,
 };
 
-enum WIFI_STATUS_CODE {
-	_STATS_SUCCESSFUL_		= 0,
-	_STATS_FAILURE_			= 1,
-	_STATS_CAP_FAIL_		= 10,
-	_STATS_NO_ASOC_			= 11,
-	_STATS_OTHER_			= 12,
-	_STATS_NO_SUPP_ALG_		= 13,
-	_STATS_OUT_OF_AUTH_SEQ_		= 14,
-	_STATS_CHALLENGE_FAIL_		= 15,
-	_STATS_AUTH_TIMEOUT_		= 16,
-	_STATS_UNABLE_HANDLE_STA_	= 17,
-	_STATS_RATE_FAIL_		= 18,
-};
-
 enum WIFI_REG_DOMAIN {
 	DOMAIN_FCC	= 1,
 	DOMAIN_IC	= 2,
-- 
2.26.2

