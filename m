Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C343FAF1D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 01:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhH2Xqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 19:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbhH2Xqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 19:46:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3300C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 16:45:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u16so19907042wrn.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 16:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVXToEeLg0M09BUE8KQM9xZTB6xeGgMlFFRYEbET7Tk=;
        b=Ca0L4/TSNSSUyTBGE9U79sUsrlSRD7qc2fRALCbUBoKGKzUA7a1aL3nwFgLZ174Mnq
         VnoCzlZz/O0sA0J8s4L4wBWxLyKwBKkHPMm1V2mZF4ykLQAvuxjMM292ROpyYRSIHZ0G
         MbMtnICT5eA+gnZ3/YGBRJq9Ka3GOMR02F0SDIuC4LshGIfUZyp/WZPLypleocKfCKu9
         ekUQqwR/kqA2xFI+7Ds8VqpTCIEhVUv74id+YKKEtrF1mNqAm5IDi1xIqK8fnvQJylY/
         RWRfYylTC98paDEq03nBggb1DeP43VZKJftza/L2MGHtiOXRmDFRsVwWjShbzvlNnR0b
         qbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVXToEeLg0M09BUE8KQM9xZTB6xeGgMlFFRYEbET7Tk=;
        b=rtXupyxXhT4KL8INIufpNUfoRdkdeJq87KHqfC5geIZmavBHbf0gZQFe9piqVXP8lP
         htTdCcF2p3gAbIfxmxtnBc18BmiA+Gx16s8/1a8dZs2Rvn0eSxibpecuHylIbigUD985
         kwkFhPg9mtiORjQQGZxv1HhCEktw9rZF3fYv9OGbEqjRtOByWVplmUVLeT+jAjH5rAqb
         e8LokvtVS4VmfDKlqQ15xU6x7oqWePjGCpDVC3rE58JdcV2Sx2bCimQml7VTb8YmaeLm
         sV1Gg5lJokmtaydc3pTdb811GfghLOBw8/tTmP9D0r+wL/PtwgsWsmBmAKxM4HSI2iPC
         Eurg==
X-Gm-Message-State: AOAM532RsDPP+JCx3YF+AqIatXj1JqMgQhmGXIi0+mqTW1Wh2u8NacvP
        MLi5Cx0E01B9mDQKVFgn7kW5Ig==
X-Google-Smtp-Source: ABdhPJzAf9SIwHMYjZ+Z6+rIKxlq/yy2TnqnK8btZumGAdtbQNuoJscNaJZ1eyb/q4l5klgYBgGkbw==
X-Received: by 2002:adf:d0cf:: with SMTP id z15mr22755166wrh.356.1630280745355;
        Sun, 29 Aug 2021 16:45:45 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r25sm14500574wra.12.2021.08.29.16.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 16:45:44 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     straube.linux@gmail.com, fmdefrancesco@gmail.com,
        Larry.Finger@lwfinger.net, paskripkin@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] staging: r8188eu: simplify c2h_evt_hdl function
Date:   Mon, 30 Aug 2021 00:45:40 +0100
Message-Id: <20210829234541.946-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210829234541.946-1-phil@philpotter.co.uk>
References: <20210829234541.946-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify c2h_evt_hdl function by removing majority of its code. The
function always returned _FAIL anyway, due to the wrapper function it
calls always returning _FAIL, and its one caller doesn't use the return
value, so this function should just have a return type of void.

Leave the call to c2h_evt_read in place, as without it, event handling
semantics of the driver would be changed, despite nothing actually being
done with the event.

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Acked-by: Michael Straube <straube.linux@gmail.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---

V2: Changed return type to void, based on comment by Pavel Skripkin.

---
 drivers/staging/r8188eu/core/rtw_cmd.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index ce73ac7cf973..14b74f92cd0f 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1852,29 +1852,12 @@ u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt)
 	return res;
 }
 
-static s32 c2h_evt_hdl(struct adapter *adapter, struct c2h_evt_hdr *c2h_evt, c2h_id_filter filter)
+static void c2h_evt_hdl(struct adapter *adapter, struct c2h_evt_hdr *c2h_evt, c2h_id_filter filter)
 {
-	s32 ret = _FAIL;
 	u8 buf[16];
 
-	if (!c2h_evt) {
-		/* No c2h event in cmd_obj, read c2h event before handling*/
-		if (c2h_evt_read(adapter, buf) == _SUCCESS) {
-			c2h_evt = (struct c2h_evt_hdr *)buf;
-
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
+	if (!c2h_evt)
+		c2h_evt_read(adapter, buf);
 }
 
 static void c2h_wk_callback(struct work_struct *work)
-- 
2.31.1

