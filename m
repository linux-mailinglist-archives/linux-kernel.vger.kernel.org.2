Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9217636724C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242225AbhDUSMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:12:14 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:34570 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbhDUSMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:12:13 -0400
Received: by mail-lj1-f172.google.com with SMTP id o5so15685680ljc.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 11:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FshtPtqL0ksVrY8bdhcz625mBO/aW3jq0x3t2qg++OI=;
        b=Pwv/BV6YP4IexP0FkQHJxOu2Er3GKTcUh0SK5b8nk6WNihvCOlhMIyjKDTS7XHXac4
         YP0shKn4Bu3R0WWaKM08Tw9OfkfalSOiSBHHKUF0rWqfK9S04bWkMutZbB+A+kr2jouW
         Qy9C4xGmOBwyPjJCEuPiGWgHgGnlLPkAAmY0bvZqnWzgUxm9PylBHL81EUpm6nYOX4ih
         bedjr6bsxKbdqFwd15OZEClB3gQoHL7rCE1RsA3xVVkjNy2NpxwBG/pEMDy9o/3yvAVv
         YM40BkMyDF1a7Prrm+hxh6VgS7ozv3bduJn08oVwh9QLSGUrWIRZSgPON+1Rf7RwgRJ2
         IJnA==
X-Gm-Message-State: AOAM533HPIB+IRhU7J5KICgCXoshD1nlz2sZQORPygZi59+D+7g1E5qJ
        3ANE+J1OaCGa47Ru3FMRlWE=
X-Google-Smtp-Source: ABdhPJyv3N2DfF2XXFofnr7XUQQ0B1HJNMjdJZEHCNtSGXDPRniq4X+hREjnMTVsRvGOqHas7cnBZA==
X-Received: by 2002:a2e:97d2:: with SMTP id m18mr5197249ljj.13.1619028698404;
        Wed, 21 Apr 2021 11:11:38 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id t14sm30853lfp.6.2021.04.21.11.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 11:11:37 -0700 (PDT)
Date:   Wed, 21 Apr 2021 21:11:32 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCHi RESEND] devm-helpers: Fix devm_delayed_work_autocancel()
 kerneldoc
Message-ID: <db3a8b4b8899fdf109a0cc760807de12d3b4f09b.1619028482.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kerneldoc for devm_delayed_work_autocancel() contains invalid
parameter description.

Fix the parameter description. And while at it - make it more obvous that
this function operates on delayed_work. That helps differentiating with
resource-managed INIT_WORK description (which should follow in near future)

Fixes: 0341ce544394 ("workqueue: Add resource managed version of delayed work init")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
Sorry for the resend folks. I did accidentally send this first time off-list.
Luckily Greg spotted that. So, resending with proper recipients - no
other changes.

 include/linux/devm-helpers.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/devm-helpers.h b/include/linux/devm-helpers.h
index f64e0c9f3763..f40f77717a24 100644
--- a/include/linux/devm-helpers.h
+++ b/include/linux/devm-helpers.h
@@ -32,13 +32,14 @@ static inline void devm_delayed_work_drop(void *res)
 }
 
 /**
- * devm_delayed_work_autocancel - Resource-managed work allocation
- * @dev: Device which lifetime work is bound to
- * @pdata: work to be cancelled when driver is detached
+ * devm_delayed_work_autocancel - Resource-managed delayed work allocation
+ * @dev:	Device which lifetime work is bound to
+ * @w:		Work item to be queued
+ * @worker:	Worker function
  *
- * Initialize work which is automatically cancelled when driver is detached.
- * A few drivers need delayed work which must be cancelled before driver
- * is detached to avoid accessing removed resources.
+ * Initialize delayed work which is automatically cancelled when driver is
+ * detached. A few drivers need delayed work which must be cancelled before
+ * driver is detached to avoid accessing removed resources.
  * devm_delayed_work_autocancel() can be used to omit the explicit
  * cancelleation when driver is detached.
  */

base-commit: bd2a895f21eb9195a42e52e5f451dccc854cc71d
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
