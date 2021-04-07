Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8EC356DCA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347614AbhDGNuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347588AbhDGNuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:06 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7557FC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:49:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id d191so9062057wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dkjimhjDd9u/y2YdPJ4t6EDrMe97yh+nEoGhNNKYzQA=;
        b=dYwi0ietfEob54IKIQye9xDmJmJNeltd1q1eFzgnbXjCf4xQ02Z/71Z917OvAiF1RX
         m2W+ZD4Cy6ZVNTpfUkEXEG7XE1wp/xEPtnfH1QX70n/MMfS52JtCzDnyWVnayvMUTtjQ
         DNnoWwSvkdpirBNHdOUv0X1ObSgCtKO1E6R+j9KhGAap1Tej+hOmYKkyU3qUGcsupsj2
         ROCR0aIKG9X1p9Kl3fNCa1JaSUXQcplNsuQoGzvfSw+g324d8aaggeUapi+pjGCguO5L
         oEMgBLWAwBjPd8bKizNjj2KnPAmarmwrS8QSOtEDeLtO2Z//eHInLHPHBOxk1TFCdnLt
         ww7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dkjimhjDd9u/y2YdPJ4t6EDrMe97yh+nEoGhNNKYzQA=;
        b=gQIg0V2C8ycZk85l73/U0Ws3Y6WLrr/AF+JZTUJ/czQTtj1tW6zCP4C/Su+PaUTqAy
         9LIDGr8vIOVxRx6Gc/MawnsJ8MF+0+zEYkNILQEDW79UErqur8kXCeyY773cNtdRoj3z
         bLfpk10lv/A5LlnZQ1sBMh0jOZgxOlTIDZ7SYYW1rFZN/mrQB8WExcW8mxYPc384OnCm
         JXFMOSC6nS9S7XobSLG7l8SGkTVVQSdOyDBj+2U9YmUqUF9ch8o2Cjv+80l2G3iNn/9g
         Z+Y8B0JdJAiaE1/v3ChM3coT1eFXUq7uI9VDMItxks+lHPr5tTZ/grZaSRruAwQ5Pc5h
         30pw==
X-Gm-Message-State: AOAM5319JQuWBagxw5ZKEJAxQ5cYGjtfZLkZnD3jf19CX7Edzv19753I
        9TqRG2JD+dg/k4s40bFe2skuDkzbmZvR3A==
X-Google-Smtp-Source: ABdhPJyL7+Lls+1JEjbmaOvWqid65ZWj3PZdWaCDPEp+d1ON4mSbDq+YNB48fRvaDJzGcoKXC03oNw==
X-Received: by 2002:a05:600c:4103:: with SMTP id j3mr3168538wmi.175.1617803394209;
        Wed, 07 Apr 2021 06:49:54 -0700 (PDT)
Received: from agape ([5.171.81.68])
        by smtp.gmail.com with ESMTPSA id o14sm31915253wrh.88.2021.04.07.06.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:49:53 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 01/19] staging: rtl8723bs: remove DBG_871X log argument
Date:   Wed,  7 Apr 2021 15:49:25 +0200
Message-Id: <3473925ae9ee5a3bcd0ab86613dbce80b6d3f33f.1617802415.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617802415.git.fabioaiuto83@gmail.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prepares the application of the semantic
patch aimed to remove all DBG_871X logs.

One occurrence of the DBG_871X macro has one
repeated argument, that's not even comma separated
value with the previous one nor a format string
parameter associated.

In normal conditions this worked, for the macro
is usually not expanded (the do nothing behaviour),
but if I try to apply the sempantic patch to remove
all macro occurrences, all macros call after that
abnormal declaration are left untouched (not removed).

Remove all of the DBG_871X logs as they currently
do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged, so just remove them as they are unused.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index eac663119290..f18a7afcc0d3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -823,7 +823,7 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 			#ifdef DBG_RX_DROP_FRAME
 			DBG_871X("DBG_RX_DROP_FRAME %s BSSID =%pM, mybssid =%pM\n",
 				__func__, MAC_ARG(pattrib->bssid), MAC_ARG(mybssid));
-			DBG_871X("this adapter = %d, buddy adapter = %d\n", adapter->adapter_type, adapter->pbuddystruct adapter->adapter_type);
+			DBG_871X("this adapter = %d, buddy adapter = %d\n", adapter->adapter_type, adapter->pbuddystruct);
 			#endif
 
 			if (!bmcast) {
-- 
2.20.1

