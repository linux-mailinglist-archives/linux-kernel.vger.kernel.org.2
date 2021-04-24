Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA6E36A0E8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 13:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhDXLaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 07:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbhDXLas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 07:30:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159CFC061574;
        Sat, 24 Apr 2021 04:30:11 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s14so19564657pjl.5;
        Sat, 24 Apr 2021 04:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=d2cfy0czkhhODFr2sP3gFkniZsVBfz3kDKZyM0CWgIc=;
        b=GBJaw17lHlQza7L9TpWhT771unQgnzqFEUqOM0DzKIJNeIJkF87BAxYV/wr1HqAfG6
         BQ7AXTySOoOWUXlsl21ZFicj3coNuUUJ+iUsxRjqVM4nAYj2BYPQTA/l3qTzJqtyudWb
         RxnQbdRC66Yi1OD1G6qXSkRI7RvyJ+9q7v80cDHlo+8Uo+j/cXcPuTpaHgYFa6sL6tPy
         5nDNlnw8ETav5rM1Ywspct5cG4wWp9HPmTkXZSqY2fgRBHayXJWIO/KXBbhTu6CUbkxQ
         1sqmchCtYLBmdD/1+BHdoW+zUWcufxHe2yiTqUx4K6SzUnck8cNGc1rWnKJI7SzWLhFC
         hWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d2cfy0czkhhODFr2sP3gFkniZsVBfz3kDKZyM0CWgIc=;
        b=mVGnuEfHcrqpQJ2rYsFLCQ1vLKUSBHFl9MMaPcy6Fr2KgE7x+Acl+4nhw8tv5qyCuk
         cw+9G0LRPAPYxUt6JaNeYGZEiqhaeiDeAMcXC0F8fpdd2lKPobH/OXKIXCJkHRHRCrh7
         mXo4tKt9YlzvDgzrias3LxpnseZ6IBkfr1hYb77+6yZmd9JlDzfCXt05ZBfopx7LcyXQ
         BN830MAG0+ClTut8r7BSSlCbrpj6w5ERiUdEdyTa1CMi4809z7n817MH9RKS5rLS63/5
         W6J09zlgth1S2BqxG0t4LC2XbgpNsd1TBClHZoysKsBu140FMf2REJ3+aMl9f29A0aiK
         9wuQ==
X-Gm-Message-State: AOAM533H2BrOYL0V7dV2gy/Iv6s+P+RJ6scryRK5e4Jhwn9zSVOgxTWF
        v/Ss6SI/G2eAs2TRPdIsjV4=
X-Google-Smtp-Source: ABdhPJyK2Up1CCQsOX04j4tYo0lv7EWxXBuhepY9Twu0owftfdKWgxo74a8HT6X+IXqu+sLxYj6swg==
X-Received: by 2002:a17:90b:2409:: with SMTP id nr9mr1028400pjb.198.1619263810567;
        Sat, 24 Apr 2021 04:30:10 -0700 (PDT)
Received: from localhost.localdomain ([49.37.81.172])
        by smtp.gmail.com with ESMTPSA id z1sm6990106pgz.94.2021.04.24.04.30.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Apr 2021 04:30:09 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] usb: cdns3: Corrected comment to align with kernel-doc comment
Date:   Sat, 24 Apr 2021 17:00:01 +0530
Message-Id: <1619263801-5319-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot throws below warning ->

drivers/usb/cdns3/cdns3-gadget.c:487: warning: This comment starts with
'/**', but isn't a kernel-doc comment. Refer
Documentation/doc-guide/kernel-doc.rst

This patch will silence the warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/usb/cdns3/cdns3-gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 9b1bd41..0280a38 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -483,7 +483,7 @@ static void __cdns3_descmiss_copy_data(struct usb_request *request,
 	}
 }
 
-/**
+/*
  * cdns3_wa2_descmiss_copy_data copy data from internal requests to
  * request queued by class driver.
  * @priv_ep: extended endpoint object
-- 
1.9.1

