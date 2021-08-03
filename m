Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D887D3DE38F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 02:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhHCA2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 20:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhHCA2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 20:28:20 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EF6C06175F;
        Mon,  2 Aug 2021 17:28:10 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so566143wms.2;
        Mon, 02 Aug 2021 17:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=a6zMTnyhxtAg+is2Anr1ik8iwgNvzi3rO1H5TWqTrow=;
        b=ms3MufsY0PL33FUD0/BqRTZXAw5KkvYccyQI0Zm3JxM6faJ4hI2TDbztO8P3KdB/eP
         YZhL703hny09+LjmCtS4xoXL3vWDRgxGK88uUG1eAO0V+HSxY7VTEVjEFWQFjRkqvn5x
         j6vHBV7fsAtT2BKPa7mn3XYyeH8dg17bfqH3pYspa2epPBaW42eLHa8iioS0gaqTRNFT
         YewIsOQfGmIdYs9iz0RtmyqsMm3XdKszxurVJGrow551BcJHZ02RXGjVnCzuGv0QKHtH
         Gu+ldbHqXpO6YigUSXkFidRQhUgenFuvPz9asjrAr4bN7VHjzeG/RVctULO8lTuJwRxX
         0DiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=a6zMTnyhxtAg+is2Anr1ik8iwgNvzi3rO1H5TWqTrow=;
        b=SpIOdCS4CMC3sOHNUl2M6JeQKA3ERo7bOFVWdiukT68TK5tBkc1QRlhIFF1ox+z46c
         d2dyULUDZj4NK3igNpiPO3Wvd4jb9TyhZeIM07squooA5ltf4vty++YvAcmP+spXu1Dn
         vPzC1i+6Zwv2JsbO2M8EJrEBQYBb8Pqtq9ksYgpSOTsJPbZJDNulmT527M8rYvV7/ioz
         7awYWldeVKsrgi7ml9d07lQbS+IKyS2Nyhsyu9MFIxmgYnCGwSYtS+KCv6uNpCDqwn3Y
         bQTNiEhbh1yCg7Veu9Jm/TQnkInJM+AgkW+vPGJmrsEoKnkuE0/2KpcjI/028H/UzX+u
         inpA==
X-Gm-Message-State: AOAM530+mfNcbXHI3TCvahjkUZjtjfgJCYaOKsSeYQ0/rzHipCM3QxD7
        5XgSnCqDfkYDqtOZ0S27crzMTpAvavJMQg==
X-Google-Smtp-Source: ABdhPJxjXMWoX3k2SCMluZicxEDWkXd2ybcJDRCRobAWAQ1euGztEasOj3CA+RGWio6U3euXkv1giA==
X-Received: by 2002:a7b:c402:: with SMTP id k2mr1428731wmi.136.1627950488804;
        Mon, 02 Aug 2021 17:28:08 -0700 (PDT)
Received: from pc ([196.235.140.151])
        by smtp.gmail.com with ESMTPSA id l41sm12748562wmp.23.2021.08.02.17.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 17:28:08 -0700 (PDT)
Date:   Tue, 3 Aug 2021 01:28:06 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Pete Zaitcev <zaitcev@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: class: usblp: replace conditional statement with min()
Message-ID: <20210803002806.GA1541734@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace conditional statement with min() in order to make code cleaner. Issue
found by coccinelle.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/usb/class/usblp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
index f27b4aecff3d..fd779a989526 100644
--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -264,7 +264,7 @@ static int usblp_ctrl_msg(struct usblp *usblp, int request, int type, int dir, i
 	dev_dbg(&usblp->intf->dev,
 		"usblp_control_msg: rq: 0x%02x dir: %d recip: %d value: %d idx: %d len: %#x result: %d\n",
 		request, !!dir, recip, value, index, len, retval);
-	return retval < 0 ? retval : 0;
+	return min(retval, 0);
 }
 
 #define usblp_read_status(usblp, status)\
-- 
2.25.1

