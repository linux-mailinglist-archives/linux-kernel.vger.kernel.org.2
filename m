Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E652640A268
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 03:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbhINBWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 21:22:02 -0400
Received: from stud.cs.msu.ru ([188.44.42.49]:65454 "EHLO stud.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhINBWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 21:22:00 -0400
X-Greylist: delayed 2332 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Sep 2021 21:22:00 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=stud.cs.msu.ru; s=dkim; h=Content-Transfer-Encoding:Content-Type:Message-ID
        :Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+gbv1hu/j1NA3HNw34/MRbSihzr01uwAahcg8iNAZw8=; b=LfT/dinYFP8jEKcoy2QsNbNbgl
        opip7LKee2kq2b1fv+to0x2vpyv1DmH5pYQnY1/0lFhNsgpwSiNut03KlJoKweJfZfP96OvqITNiw
        aX0sN9CO+b37tWX9oPVHZS4EZs62QMgZkbHQmBzN0kBiEHXumU4nNN/JSZsHEEtdJpKrGhq8AMwf1
        CST+mzwsGwtXcAYaNPr39W5A4PO88qVxmlNFB5t11RA5nvhkHIZ+rkrgJkAUaqjKWd1iGF/J2/f2C
        EJayev2X0ryi5PwpBaacFSvoLvZnuVA94NryIE6S8SgyOaYJ2A/YYjtEifYk31zGcbnBE2SJw9Oc9
        fYd5dOBw==;
Received: from [127.6.6.109] (port=59083 helo=webmail.cs.msu.ru)
        by stud.cs.msu.ru with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <s02200455@stud.cs.msu.ru>)
        id 1mPwWD-000AHN-3O; Tue, 14 Sep 2021 03:41:49 +0300
MIME-Version: 1.0
Date:   Tue, 14 Sep 2021 03:41:48 +0300
From:   Panin Kirill <s02200455@stud.cs.msu.ru>
To:     "marcel@holtmann.org johan.hedberg@gmail.com luiz.dentz@gmail.com
        davem@davemloft.net" <kuba@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org netdev@vger.kernel.org" 
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] L2CAP receive buffer overflow
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <06ec9b9168eae566c07c920b0b97ae4a@stud.cs.msu.ru>
X-Sender: s02200455@stud.cs.msu.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.6.6.109
X-SA-Exim-Mail-From: s02200455@stud.cs.msu.ru
X-SA-Exim-Scanned: No (on stud.cs.msu.ru); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 From 716e6b5b15eb5d7f87c799b545aeb5188128c36f Mon Sep 17 00:00:00 2001
 From: Kirill Panin <s02200455@stud.cs.msu.ru>
Date: Tue, 14 Sep 2021 02:41:58 +0300
Subject: [PATCH] Increase L2CAP default MTU.

Some Android devices transmit packets with length bigger than MTU.
For more information refer to: 
https://github.com/anonymix007/libldacdec/issues/1
Changes: Increase default MTU up to 688

Signed-off-by: Kirill Panin <s02200455@stud.cs.msu.ru>
---
  include/net/bluetooth/l2cap.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/l2cap.h 
b/include/net/bluetooth/l2cap.h
index 3c4f550e5a8b..db2a4ebc375b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -31,7 +31,7 @@
  #include <linux/atomic.h>

  /* L2CAP defaults */
-#define L2CAP_DEFAULT_MTU		672
+#define L2CAP_DEFAULT_MTU		688
  #define L2CAP_DEFAULT_MIN_MTU		48
  #define L2CAP_DEFAULT_FLUSH_TO		0xFFFF
  #define L2CAP_EFS_DEFAULT_FLUSH_TO	0xFFFFFFFF
-- 
2.20.1
