Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602A733D77E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbhCPPbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbhCPPbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:31:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D142BC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:31:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g8so10346063wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xkkz4qFDCYezzcD58zfpYKxKF1qCq8JreKSFWUuXhwI=;
        b=NnYEhjWkh5mSf8B3jqCCngmLral9xAMV12mzGTVtb/SeS7aQ+6Mqnm6Rp1lkWd96fI
         2Z3pUod1sHFcH/CAbqj6bXWHdihPXJQCPHaarljHtePY3wxqQR19DCK9o0HhUb6DRpir
         A/ijeOpkExxe2eAQF0zmWOaByPAsUKfRGnf+EEvnkDsAtPNOig/Cz8uYfI7nEF3NG8dk
         Ld4ZJ6gH+Yx/xluTe5d0oh3K66fD61XwoqjRR1adCcwf5sv2tGhoG1nBLVWmQjF2rjpa
         uHjKQ7GRxnmMGZl42CvIxy3K284qWkEc45zNNZBWtu4NVz1F2f/EJL+Iqgm5wvtSn8Ea
         WPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xkkz4qFDCYezzcD58zfpYKxKF1qCq8JreKSFWUuXhwI=;
        b=HikC7sI7p6hFYRO12s2R8t66/KEXvZWhheZY6FS9LA/drRc1Fxe5jG40MXNMonmglr
         MoaJotsMP8RizdJetCCu5hX/+neEASbnl9VWxgznln38kFO36a2kx4wXJlsXf77IQWLB
         PzvWZqqUHkM5klydOrRJlC2NwAzvTM3JTkJLnq3tGpju6CMrtPkaUe0PeSsrLHMpV3ZN
         m0uf2Kp64V9HCTbQWIZcGroRTnm1+LxWI+JVwIvsTLGUXaPH+sXZX1DJPj7CMIedl/JX
         d0gRO06uRg7uM1DgQ/oo+au5VD+grL/btrWB+jSrTzOQbkAvBUI8wT3MkGvfVrbCbqF3
         M5fQ==
X-Gm-Message-State: AOAM533RZE7tJsULL3bx2/g7x7gOIOixmJp+6zXgta53idgAJy2bhvxy
        NrqxzwrOyRqjg7R3Blt4AhQ=
X-Google-Smtp-Source: ABdhPJzcWzdUD4ECfZSm5UKn7dJW6GFGjculnxAmM6rt4p/B80/gDAp8lW35WQhQtAMFGoWVa5FVwQ==
X-Received: by 2002:a1c:2683:: with SMTP id m125mr209385wmm.178.1615908688656;
        Tue, 16 Mar 2021 08:31:28 -0700 (PDT)
Received: from agape.jhs ([5.171.72.71])
        by smtp.gmail.com with ESMTPSA id h9sm2116330wmb.35.2021.03.16.08.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:31:28 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:31:25 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_VALIDATE_SSID
Message-ID: <d1eb0c9ca2309f87e346ce71febb870872bf2cff.1615907632.git.fabioaiuto83@gmail.com>
References: <cover.1615907632.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615907632.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused
CONFIG_VALIDATE_SSID

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index c9418bfb2a00..5929a7bf7db6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -33,17 +33,6 @@ u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid)
 		goto exit;
 	}
 
-#ifdef CONFIG_VALIDATE_SSID
-	for (i = 0; i < ssid->SsidLength; i++) {
-		/* wifi, printable ascii code must be supported */
-		if (!((ssid->Ssid[i] >= 0x20) && (ssid->Ssid[i] <= 0x7e))) {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("ssid has non-printable ascii\n"));
-			ret = false;
-			break;
-		}
-	}
-#endif /* CONFIG_VALIDATE_SSID */
-
 exit:
 	return ret;
 }
-- 
2.20.1

