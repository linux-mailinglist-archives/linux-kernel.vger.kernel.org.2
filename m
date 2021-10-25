Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2554395D0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhJYMRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhJYMRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:17:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90651C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:15:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n12so3109918plc.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Wl35bTMgdm50FXjVnlZEEjFDAcjupSKOXZyrA0S47QE=;
        b=XvAXyDun2bkUItZUlkomMCQyrY+Bj5Le4OuZvwl8L7ubouqW/a4TSauAuWeYIqk4Lt
         czhw6t00XUYxFW+51vOARyqtYTBnMJ6hR6jK3VJRUFOaw6ZgmpWHn3tE2PWmeNDJ+/dx
         0qgUqdv8NxSBTE+nJZwYknT10HZf2ACwSrDab27S7wEzmhJdZF8LO3fLvsQBC4Y8Yrm5
         +YvAUoHHybbKHnC9f0sy9fScjf1WHJ7WxbUfxDmtKIKNUpFKcdyo8k7LIEhpRCNDLQY9
         dM4Wd7pztdU+FVU+yX8Jv+syN+o9yOkT39NsV89Ol+aLf/sQDmmbso4R8M01HTN9jhDK
         6Z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Wl35bTMgdm50FXjVnlZEEjFDAcjupSKOXZyrA0S47QE=;
        b=ku5I5SEa39Lk+yveySNMrMp524KLpc6fPZK2LKsc9nvJsSqizqmAKC50DWvrC/OzcN
         A4w9rntoHdLJTQrq8A09dqoHswzZF3Z6RvSpGdRdAl+aD18H5icYE5KqbI9g4N3hI9Pg
         YN033nSWhJEMbT0vW94rIuCAgwIgt6bAzoZ+D0v40xpSm+ShqW3A8vh69bPoK3oZDb7i
         RbWFihb+P3Po4Q7qo1q+O3oB7JMUkPv4swkCGdZLI90g9NL/N0B7H/2X7lRZl/dsA2PF
         LPtxfdH3rnjykegSAw/yFiJSGiAqFFyHPSrjN5YO5RekfYTPAKpPrmfkslqDo5vgkkmO
         ZT8Q==
X-Gm-Message-State: AOAM531pNTkSZl73IAbRxex+R4ktaOF7uEYe1j7vBegnWg1QKVGkk/VD
        KElYkWct2H+LpLIyKZvsH+c=
X-Google-Smtp-Source: ABdhPJx3pIuwX5AE8QymqSDRb3UgBG6yxFyUL+uolvdTuVdlfJPKTE3U6/hpYqDXQ8zkYxKkTbYtWw==
X-Received: by 2002:a17:90a:2a41:: with SMTP id d1mr16246035pjg.153.1635164117969;
        Mon, 25 Oct 2021 05:15:17 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([59.95.95.35])
        by smtp.gmail.com with ESMTPSA id d24sm18259925pfn.62.2021.10.25.05.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 05:15:17 -0700 (PDT)
Date:   Mon, 25 Oct 2021 17:45:10 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        saurav.girepunje@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: core: remove goto statement
Message-ID: <YXafzp5F8T7/+tk2@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the goto statement from rtw_do_join(). In this function goto
can be replace by return statement. As on goto label exit, function only
return it is not performing any cleanup. Avoiding goto will improve
the function readability.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 2b54cdfa9d6e..411b06e135be 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -51,7 +51,7 @@ u8 rtw_do_join(struct adapter *padapter)
 			ret = _FAIL;
 		}

-		goto exit;
+		return ret;
 	} else {
 		int select_ret;

@@ -78,10 +78,9 @@ u8 rtw_do_join(struct adapter *padapter)

 				rtw_generate_random_ibss(pibss);

-				if (rtw_createbss_cmd(padapter) != _SUCCESS) {
-					ret =  false;
-					goto exit;
-				}
+				if (rtw_createbss_cmd(padapter) != _SUCCESS)
+					return false;
+
 				pmlmepriv->to_join = false;
 			} else {
 				/*  can't associate ; reset under-linking */
@@ -102,8 +101,6 @@ u8 rtw_do_join(struct adapter *padapter)
 		}
 	}

-exit:
-
 	return ret;
 }

--
2.33.0

