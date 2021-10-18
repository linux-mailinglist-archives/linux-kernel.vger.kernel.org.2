Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C80C4323B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhJRQWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbhJRQWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:22:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BBCC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:20:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g10so1221765edj.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S1TymLQzs85RWsteQyxCWHUBdjbBqj0+p83DBGcUbRA=;
        b=OyOST35KhcFKGAdczMUOLR7Vq/TRywGXqrHTO64yHl8hZjUjJz7s8XSBtRegZ+1+u0
         eCkb/6QiZ2ZcEuOBqVq/opHNYX6f1KsHOuZlKMfr3KM9KM87/5u2F89L73ZQkt6qWLYZ
         M8hATyiPpwfE1zMLf2d3tElFMYBsf7ycx5dC/XA0KzMLLQ57O9ejBjGqMNm0/ZeRMe/l
         epGQGzmkuKSrGTxOI5GFOxD73SaDjj9RBy5Mf8yJWUNIkJliVjM0XMEdjHGuN2lrYj8g
         2/GJ6Uxse4t9MYIOOM+QGgWil80SkCHGBYOFIqBoa5TTOIddnnOaS8lUG30JI9pcNMFi
         p4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1TymLQzs85RWsteQyxCWHUBdjbBqj0+p83DBGcUbRA=;
        b=eqG1Eo26cP+to8qIiQh609775iKcjXaSbSA71j0RlYhDdu7FbgPiHbyugz/plWfFMZ
         msMGIhTuMc+wdUrHNkimXMQpCUdlEp5iNHwR/HX7wNzhfamAL2RMuTbDUwgtyyLLtgnX
         0o7dLdzIJCmwv1My1vTV1yOQwlOPe/s/d3mbIf7HtVbEyVporpYNuoEl+zXN5Bl7jTxO
         eWQURjoNSE2rGUkxvWV2me0lVJ3xz+9NQDnGjregR3HGEtcVjLTEKHfFuiAPtdWOA4CH
         GDNAmSxIvjP91KToks+ZnVooCeLpKmDrIsWwO4fm/zse3L7iFAxwA15Bb3299dwq+scc
         21nQ==
X-Gm-Message-State: AOAM532BY+4R/2Y6ud02WfEHsEu2bFXvkrmVjpvIh0ggTfdnuYRXMOCe
        3qCr2xo3vgx5oS7ylj+qLlI=
X-Google-Smtp-Source: ABdhPJzle8YS2LF0YCPa8fswLODhY44Jm6caxbNENXJnNWbWD4SUc+wwGqHCh2ZHepvLrZm1igHUkg==
X-Received: by 2002:a17:907:6010:: with SMTP id fs16mr30691838ejc.266.1634574014361;
        Mon, 18 Oct 2021 09:20:14 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id p7sm10045791edr.6.2021.10.18.09.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 09:20:13 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 3/3] staging: r8188eu: Remove redundant 'if' statement
Date:   Mon, 18 Oct 2021 18:20:06 +0200
Message-Id: <20211018162006.5527-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018162006.5527-1-fmdefrancesco@gmail.com>
References: <20211018162006.5527-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the redundant first 'if' statement of two identical ones.

In rtw_cmd_thread() there are two identical 'if' statement, one
immediately after the other. They check whether or not the device is
removed or the driver is stopped and, if true, they break a 'while'
loop.

The only noteworthy context difference is that the second statement is
within a block labelled "_next". The code has a 'goto' to the "_next"
label so that the checking is performed each time the above directive
is encountered. Instead, the first 'if' is before the "_next" label.

One of the two must be removed and that it must be the one before the
label because "bSurpriseRemoved" as well as "bDriverStopped" may be
changed asynchronously by other code of the driver and so they should be
checked at each jump to "_next".

Tested with "ASUSTek Computer, Inc. Realtek 8188EUS [USB-N10 Nano]".

Acked-by: Martin Kaiser <martin@kaiser.cx>
Acked-by: Phillip Potter <phil@philpotter.co.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 3b07328704bb..5d5f25364b2f 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -252,12 +252,6 @@ int rtw_cmd_thread(void *context)
 	while (1) {
 		wait_for_completion(&pcmdpriv->enqueue_cmd);
 
-		if (padapter->bDriverStopped ||
-		    padapter->bSurpriseRemoved) {
-			DBG_88E("%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
-				__func__, padapter->bDriverStopped, padapter->bSurpriseRemoved, __LINE__);
-			break;
-		}
 _next:
 		if (padapter->bDriverStopped ||
 		    padapter->bSurpriseRemoved) {
-- 
2.33.0

