Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364714398AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhJYOfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbhJYOex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:34:53 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC25C061220
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:32:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5so1220504wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WMuNnARhjHt6/JUj94F/2jFoX5OqvXl5QIdO5Zu2H9E=;
        b=EyxP2thHsuQUqXfoLtwECPCS5y+h7xJtbCvGUwCoqOZrpChwq0PlLYnTVQwT7v5Myt
         SWOFvU7Tc9POSethN2PaA6ZA1Nab3QdxDsuA1xhfA9xJUzJTWDoRBhI5vtEnc+mKoHRy
         aiVLmRMBqC16W2uOqBdZZ7qupPuyhfidMDZ/cgDrWAgqXpW1IQ5UsGdv5XaFaDxpXBay
         hp1iVwA2ndCoj6hkesZ+2a+tWu3tmv2so8HfPpOk0igiHMqEbxBCFK3j0Fh4XNUnQBCY
         Y9PvAOrGwP9C3oyIQKmaBsjSQt1h65hwFkVSyBPkeJnrixc7G44vidBqNDb8eNVpwslC
         g42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WMuNnARhjHt6/JUj94F/2jFoX5OqvXl5QIdO5Zu2H9E=;
        b=wXgzre1wXnFgWVFOd8vmJHreQZLEWH/PTj0lr9puKzucQpEZAsVGaBMJc0srlGDT5/
         64yXjU53BUZsEyu5AY4VydwQ4vBrMsKJ+/WmPkZdYSkSvJedUtoN7hon6FraOvD7VDSe
         2B+9kXxjEKYALE+BW4BCN53k/WRZkWLOR2xlIGtv6/+L60SwIoknrzp927L8ufriguQs
         0JLtduO/itoQfKfmioXiULahlQ6l6KL2DO9cKhbk5vGzFUJbJTYNaO5Kc0tiNgfjWdpB
         SuGk2QeSsZtlHYcTXovemSsEfTFj1uh61IZAY9G2BhUqci3WMtGn9DI5PTCpHJY/HVW/
         KSdQ==
X-Gm-Message-State: AOAM533e89Sx+S5DukSYIEm9B5M8LOJsIb+WeVP0oy0YKPNe+dHbR2/D
        XtYs5cBM3N+Z0aCCMGRzb9E=
X-Google-Smtp-Source: ABdhPJxhbKi7MWbJbJH1x+kT/8eddvmnLW3DtPYzlorRR/j124VK0BRUZnrjMkQOg0kHQ1sLseo92w==
X-Received: by 2002:a05:600c:2199:: with SMTP id e25mr8004109wme.157.1635172346443;
        Mon, 25 Oct 2021 07:32:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id x8sm13011500wrr.53.2021.10.25.07.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:32:26 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 7/8] staging: vt6655: Rename `dwAL2230PowerTable` array
Date:   Mon, 25 Oct 2021 15:31:33 +0100
Message-Id: <69eb06ced0d039b238c1ab6d3fb70b5ee1288a8a.1635171519.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1635171518.git.karolinadrobnik@gmail.com>
References: <cover.1635171518.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To align with the kernel coding style, remove the type from
the variable name and do not use CamelCase.

Fix issue detected by checkpatch.pl:
  CHECK: Avoid CamelCase: <dwAL2230PowerTable>

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index d132a21faf24..1c81c44f086c 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -85,7 +85,7 @@ static const unsigned long al2230_channel_table1[CB_MAX_CHANNEL] = {
 	0x06666100 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW  /* channel = 14, Tf = 2412M */
 };
 
-static unsigned long dwAL2230PowerTable[AL2230_PWR_IDX_LEN] = {
+static unsigned long al2230_power_table[AL2230_PWR_IDX_LEN] = {
 	0x04040900 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW,
 	0x04041900 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW,
 	0x04042900 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW,
@@ -834,7 +834,7 @@ bool RFbRawSetPower(struct vnt_private *priv, unsigned char byPwr,
 
 	switch (priv->byRFType) {
 	case RF_AIROHA:
-		ret &= IFRFbWriteEmbedded(priv, dwAL2230PowerTable[byPwr]);
+		ret &= IFRFbWriteEmbedded(priv, al2230_power_table[byPwr]);
 		if (rate <= RATE_11M)
 			ret &= IFRFbWriteEmbedded(priv, 0x0001B400 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW);
 		else
@@ -843,7 +843,7 @@ bool RFbRawSetPower(struct vnt_private *priv, unsigned char byPwr,
 		break;
 
 	case RF_AL2230S:
-		ret &= IFRFbWriteEmbedded(priv, dwAL2230PowerTable[byPwr]);
+		ret &= IFRFbWriteEmbedded(priv, al2230_power_table[byPwr]);
 		if (rate <= RATE_11M) {
 			ret &= IFRFbWriteEmbedded(priv, 0x040C1400 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW);
 			ret &= IFRFbWriteEmbedded(priv, 0x00299B00 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW);
-- 
2.30.2

