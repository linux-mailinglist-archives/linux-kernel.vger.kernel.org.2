Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA829359F05
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhDIMqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDIMq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:46:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F66FC061760;
        Fri,  9 Apr 2021 05:46:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 12so2855080wmf.5;
        Fri, 09 Apr 2021 05:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=KlSRX8zU0KTuE/qKWYqizNg9JGBt025L2E4igOAe0/s=;
        b=h7poIT8bwExI/TCmdJHHT3BNh+Imp230eLBnKUq1rGm8O3Fp1/pLUjLDlp52DPWAwB
         TMALSKeLMq1a9zIgudAPNVdNZvuCuwqScMANowOAo3B0UULTsqCRvPkbhzaFo8A3lfhP
         7OIBBcQ/wz1mnXv55CD4g0SM8Rgi58I6f4L+iSTlOkPg0Tw356Iq3DvwbX+HUji5PKvn
         4vKCMjzeZ+8694e/nePPLBsIm+5zRvKzP9lsKuuCjCcFwBD8XWAGuQQnfxV6cqqnX8Ig
         +5sugpZJm8fnxr0jMQngF1l5aa9VM/OMqqBSN432LVfAnibnj9bbVzvEACtbpdtT/xfv
         dnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KlSRX8zU0KTuE/qKWYqizNg9JGBt025L2E4igOAe0/s=;
        b=Y03Mf+dwMFqmsRtA60RXsUMlwcyXunFFZmOzsmO/K9PYEZZTNKYDGpvZWmTqdEN1AA
         hlmduNqWRLcht1ROP7WtCE4nVJA2qIPYT/NfV+l0Bpp4I8Sxnq0Truf4IwTchkYyT9Gy
         0JLAwQtd+iTkYM/3NlsmCv3pr7uEYIBufu19TGdC/FPsfUbUW0TW0cPJt7BAdusOTdwK
         jyUduJxoDrPlxz9l3sfew3D5g9mX2e3PzSR4LohGDjZtavc8Y3PIAQZtTwyD5KBBIqq4
         tb4w4TN29xPkR1H0zrgk5chywAkmsCCuwTwzlP42WOsi39pEwxwsG1KVyaS4bvHB6Cdu
         IA3w==
X-Gm-Message-State: AOAM531Onl5YsM9WKJsZth6I98AKEYnYw99Z5JXhQhwLEv4JMDZP/A7l
        vZjppkhVxWAPdhsghxaAuTEUqBPYGu0s7Q==
X-Google-Smtp-Source: ABdhPJx33HYypTGXE4AUKki/UmoaGB6AYtLBPnpcbIuOWYpzdkVhe+9R7QfIy31CD/k7pwDoIR5XXw==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr9021126wmp.165.1617972374293;
        Fri, 09 Apr 2021 05:46:14 -0700 (PDT)
Received: from test-VirtualBox ([87.116.165.76])
        by smtp.gmail.com with ESMTPSA id e23sm3745970wmk.15.2021.04.09.05.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 05:46:14 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:46:11 +0200
From:   Sergei Krainov <sergei.krainov.lkd@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] staging: rtl8712: fix wrong function output
Message-ID: <20210409124611.GA3981@test-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return NULL from r8712_find_network() if no matched wlan_network
was found. Code with a bug:

while (plist != phead) {
	pnetwork = container_of(plist, struct wlan_network, list);
	plist = plist->next;
	if (!memcmp(addr, pnetwork->network.MacAddress, ETH_ALEN))
		break;
}
spin_unlock_irqrestore(&scanned_queue->lock, irqL);
return pnetwork;

In this code last processed pnetwork returned if list end was reached
and no pnetwork matched test condition.

Signed-off-by: Sergei Krainov <sergei.krainov.lkd@gmail.com>
---
Changes from v1: Updated description

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

