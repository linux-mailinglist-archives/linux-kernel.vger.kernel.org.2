Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9F5410DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 01:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhISX5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 19:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbhISXzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 19:55:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4D9C061768
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g8so54010535edt.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uDnPnwL+7XkZTxo58W8/NTcNsnLRwxUMFNIfr0Kxy7I=;
        b=pZyQ5qa2TK3BdsKWPDGNS/snLnDRx+5G36Et14fO1W+J7qAjQcZfwx8cqJx1lhvyrS
         4zMttTXdznbO73vVyZ5PE/KgzZ5bsPhQEd1o7l7joZdN8205rTAqM3/k0ogM/FGeSoSB
         jjBzWnuzIisrSEpR6K28rotjJnEOXuvd8Agiiyo4vv3Sx8ONTpoN39BMU319vT1XFszk
         +PI2a/wMce1LXf1OdJv/XcEl8NotZtA5Q0aGwjtO9OZpvM8e2vpBts8nhgLcmB4MKrkb
         BcJk/sK5DijyF/e1jQAIf1GyRgRK6l0rZBfm/V/M7wbUy5BzLObf91UAmyiBA7xhtVzQ
         yZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uDnPnwL+7XkZTxo58W8/NTcNsnLRwxUMFNIfr0Kxy7I=;
        b=oywDj9hwmfrjaU9vAyZYs44TjZRtDuEXZzuFic6yz+9rdNsLIMNxnlAiLainr/KvPc
         G3yE7Fr4uZPeWBiicuvPmouLsZ8Wz3FS91ry1mT89RCbqEbyvL8jT/HBt6xzDA0lUrRI
         HismxBKZAShl89Cx8yvTvdtfMfw/uzJQRanccziUPPTIblrBHJRhrxTT6Vs9HTKS2cMB
         lRJxguUihHse7qx9GxzgQ5j8/EUepmZlsuP0ArogueL4LsgbATTloFmZArmm+dH3/Ipv
         p/RZsrEo8OOxb4n0JdNJAKZX2rYMrxwHwEVThSO20x8i3CKb8IIBsIeFhSUBoJ92brgR
         A1gg==
X-Gm-Message-State: AOAM532PGNgBMi3MxItJNr0Lam6xo43CpDQDfCMW5f5Hd6fyx/Bwssej
        fEmQzqHWJsb5dor3CwRXPU4=
X-Google-Smtp-Source: ABdhPJzkbdLZxls26VaGH1peQvTKahCXxu7PElxN/zHBV0I+XHit/Sf3dGLtM3BSStpHvgL1cZEU2A==
X-Received: by 2002:a05:6402:2cd:: with SMTP id b13mr26036625edx.267.1632095652780;
        Sun, 19 Sep 2021 16:54:12 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id e11sm5353636ejm.41.2021.09.19.16.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 16:54:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v8 08/19] staging: r8188eu: fix grammar mistake in usbctrl_vendorreq()
Date:   Mon, 20 Sep 2021 01:53:45 +0200
Message-Id: <20210919235356.4151-9-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919235356.4151-1-fmdefrancesco@gmail.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a grammar mistake in usbctrl_vendorreq(): "checksumed" =>
"checksummed".

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index fc3da0fbf474..3ca2959f4bcd 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -85,7 +85,7 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
 
 		}
 
-		/*  firmware download is checksumed, don't retry */
+		/*  firmware download is checksummed, don't retry */
 		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || status == len)
 			break;
 	}
-- 
2.33.0

