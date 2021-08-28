Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D6D3FA799
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 23:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhH1VZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 17:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbhH1VZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 17:25:49 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C37C0613D9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 14:24:57 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u16so16197227wrn.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 14:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=odmscgsatQ8+oNWe7+/hsee6MsXCSaqxsyPuZo1ZOyc=;
        b=LD9IAM08AoX4xYOWefBzcwZgbLnWN2vsm19032Zdgz0iuzaiH6+wzwWRzB+DwSC44D
         vMwqt7UReddw+0YQojFa/YyV/6dD9tgLh3JmxnLyHrVOdorJMK7wXWcC9sU7paAEgk6O
         fO9Q5lJRCIIUSS+HD8CU7OTNwxtVQXu0XR/47cgC7AbFHETTTpCOvsIyUX/gBf5cbrBx
         HyshjbNHUK39N3XY4g6i8T2ADjZN/5s/oktnpZePHPoRQsnk2M7NtjpL6HvYxieCO3oI
         yZohZ56SXlHuRTlG9RKwqV6fnm3B+xMBehzTeda903Us8Z/oZ8yHmJqCXPgAebpTK+vk
         q9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=odmscgsatQ8+oNWe7+/hsee6MsXCSaqxsyPuZo1ZOyc=;
        b=kUlcRm4Ea0vpfrBkPFEzUKPqyp42bctkezvNZHnPCoLWrEpkUqEXHIzgkx+Yn2nAht
         Poa+r1j65ifBJnrr8/ZGmBozSjLxjM/IkMoF8b9Z0vxKJ1tablcBYCYefgOUpBduWD33
         m/bKS5s5LDwY/CBc9AWYFm72f61xcmRg0uyZGi9vC1ZJYUU+2H11L7qWUMkUCAoH6tI0
         M+PFXM8UxU2Y7IHbBJhK+M0UxwZu9gYzU1hQjT+3gjkX3OqHjv2YovWxKwY9gRhdDbXA
         7aaKbvCNNi1CovH0e3tDanSgNcT3ZGxRDQ01dFdonPgEHnaf3FEN/YwgOi3PSpRtfKTc
         BElw==
X-Gm-Message-State: AOAM530h2Nfz0K8GMi6+utYh+bm4fY+xns1RHh8Z8PKxV9cozF4mf/Gr
        u1uVVfmiyX5qSKwORbj8bSn0Pw==
X-Google-Smtp-Source: ABdhPJyp1xaWuDkKsOSw27yWD0xtDXRQNgcIRKX17qEvozirHwp3HOviYIB3oqmyW3pJGrXTraEiUg==
X-Received: by 2002:a5d:4c4c:: with SMTP id n12mr17838524wrt.19.1630185896628;
        Sat, 28 Aug 2021 14:24:56 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id u26sm8645847wrd.32.2021.08.28.14.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 14:24:56 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     straube.linux@gmail.com, fmdefrancesco@gmail.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: r8188eu: simplify c2h_evt_hdl function
Date:   Sat, 28 Aug 2021 22:24:52 +0100
Message-Id: <20210828212453.898-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210828212453.898-1-phil@philpotter.co.uk>
References: <20210828212453.898-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify c2h_evt_hdl function by removing majority of its code. The
function always returns _FAIL anyway, due to the wrapper function it
calls always returning _FAIL. For this reason, it is better to just
return _FAIL directly.

Leave the call to c2h_evt_read in place, as without it, event handling
semantics of the driver would be changed, despite nothing actually being
done with the event.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index ce73ac7cf973..b520c6b43c03 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1854,27 +1854,12 @@ u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt)
 
 static s32 c2h_evt_hdl(struct adapter *adapter, struct c2h_evt_hdr *c2h_evt, c2h_id_filter filter)
 {
-	s32 ret = _FAIL;
 	u8 buf[16];
 
-	if (!c2h_evt) {
-		/* No c2h event in cmd_obj, read c2h event before handling*/
-		if (c2h_evt_read(adapter, buf) == _SUCCESS) {
-			c2h_evt = (struct c2h_evt_hdr *)buf;
+	if (!c2h_evt)
+		c2h_evt_read(adapter, buf);
 
-			if (filter && !filter(c2h_evt->id))
-				goto exit;
-
-			ret = rtw_hal_c2h_handler(adapter, c2h_evt);
-		}
-	} else {
-		if (filter && !filter(c2h_evt->id))
-			goto exit;
-
-		ret = rtw_hal_c2h_handler(adapter, c2h_evt);
-	}
-exit:
-	return ret;
+	return _FAIL;
 }
 
 static void c2h_wk_callback(struct work_struct *work)
-- 
2.31.1

