Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E2835908E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 01:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhDHXpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 19:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDHXpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 19:45:43 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79974C061760;
        Thu,  8 Apr 2021 16:45:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a7so5831658eju.1;
        Thu, 08 Apr 2021 16:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=QhXqjewBtncdOCVUU5t44rbala3/r6RlbCvxFUCu3+M=;
        b=uA8WrQ0N22+iR9oeA1h8gASKkARO7xU5WR15k/IhN6w0VmVzJ/ctMncOyRSvrlawmZ
         9Y9hl3rY+3Jt7KcxhL3ZSceFm8fBZHSj8K65ahVdhaTobmUIOZHZOitOwaJsW+yIMGAG
         2sz1T44y5XyRbs3PPbMLJE0Ceo76TWUxE4/yueSRUHbhfg666K4d3NpEYsJS0LhQa0nK
         YEGTocAOSadgCqAfQReKpwIcs11SRclfg+DEbr3MHlsVCZDIXPTJmPYVuogeoft0TvOk
         od6I0utFQKakFwmn7R7i0teJ7kP9q37qU6++zTPpnV4pjJGxqkUPIKwIcDg58lQbWSgP
         VXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QhXqjewBtncdOCVUU5t44rbala3/r6RlbCvxFUCu3+M=;
        b=t/PqoKvetZoZCYlzJilgk52sxd8n7IeoMyRZgeagBDpr9ggzYJ6gWPyb68NJ95d5c3
         xvrpoy+FNS+cy/SoB77P3ecUJxoUiBSAs46xqIAI8PwhsOkQZko6JB5iURrWWDg0HxNz
         YFmHLrIjfZoiI1AGsLjcWJzMZB1RKjmaOzs+fIS82qEuBgI4biZyFGcZOiNd6y4GX1w8
         h/zEcuevWcXkznyiHCbLsOaqj90rLfFBTYVWm4T+9KV7/mXTBtoe4X8owJ62Jif753al
         nUoPD2E6eE8sFXg9JUY9dGNSN+EO21MqNIjVKtF1dIs5OybMHHUlfwm5q4W0yHY9Li9N
         UiSA==
X-Gm-Message-State: AOAM532lz8xvExQF5Plno9pkexRPL06oEJljxB+ys1ZXBSGM5Ymt2mCl
        hEpK2siNkYY+3GjqGutO5y0=
X-Google-Smtp-Source: ABdhPJxlmqZFXITOX8f8zYmoxVtOp+YhPyDdDgCXRVxxqPyk51MqeXJsMlFlQJT7QmBqwpsecshSwQ==
X-Received: by 2002:a17:906:3a94:: with SMTP id y20mr13368380ejd.35.1617925530313;
        Thu, 08 Apr 2021 16:45:30 -0700 (PDT)
Received: from test-VirtualBox ([87.116.181.227])
        by smtp.gmail.com with ESMTPSA id h25sm383175ejx.105.2021.04.08.16.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 16:45:30 -0700 (PDT)
Date:   Fri, 9 Apr 2021 01:45:27 +0200
From:   Sergei Krainov <sergei.krainov.lkd@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: rtl8712: fix wrong function output
Message-ID: <20210408234527.GA6893@test-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function r8712_find_network() were returning wlan_network even if it
didn't match required address. This happened due to not checking if
list end was reached and returning last processed wlan_network.

Signed-off-by: Sergei Krainov <sergei.krainov.lkd@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_mlme.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index 8a97307fbbd6..c38161114b80 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -146,6 +146,8 @@ static struct wlan_network *r8712_find_network(struct  __queue *scanned_queue,
 		if (!memcmp(addr, pnetwork->network.MacAddress, ETH_ALEN))
 			break;
 	}
+	if (plist == phead)
+		pnetwork = NULL;
 	spin_unlock_irqrestore(&scanned_queue->lock, irqL);
 	return pnetwork;
 }
-- 
2.25.1

