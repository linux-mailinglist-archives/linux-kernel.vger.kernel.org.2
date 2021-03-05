Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7C232F3B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhCETRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhCETRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:17:20 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294E5C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 11:17:20 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n22so2391567wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 11:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IUbT1zmuEif6gXHUXSht41xJpgFrGQqg35onE4jbGCA=;
        b=IFWHQoDzfiBa88b0bv5dhO328KQhLqJ1TyPOTh6klAnYn9IarWDYad7FJRJFGb7tsI
         7B6RMLEnObBUq2GvcsQqE7cYXnhqWYo7vBcxrUpxSOdNLp4cV3FGA91AKPdKRoX31uRS
         3/IG4M2h64hej9nG7zsnw1LgTWpgUTS94FYigUC/KU7jAME3Up0CspP5LMdlg/H4Xi4E
         l7MzaJCJvSeVCebbvDjux93r+hMocEhpjwEaQmLiCXk0HFs3DUys+HcVfuSdhYBlXL5a
         TNUnxJMm1agooNybpYrvVJ20iJ9ZXUuWrex3r8v1wIA1aaLHZZ/gMlVRNJBLWyM6Wyfj
         wkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IUbT1zmuEif6gXHUXSht41xJpgFrGQqg35onE4jbGCA=;
        b=HLAfVu2CQ7NMRI4r66rBwk70jC2Y+4mqwT+P09f8DQzcsQXqTTlK5J7S1WtcyngM9m
         VtiCxcJDpfPdSDdiUrv3KknB1Sx/+iBg9W8Gp5ul2F49xC4y9h7a96MjS9Wh7PTOKEQK
         veafZ9a2TDp05J+iMP5eaf2qGKyaINA7nYL1IKjjqytAnhnpAmAunyA8QIyZiUOrMXm5
         ji+rEp5QVtfq0M4YNx3uGOiyIVoZq4CaIe+rpBT+CI/cBOBZOEosag0c1vva6fXSmQEm
         tHSkRODyIZ0hvE252HdYc/Mlk+uEC+jqNEW+NPEKuAX+wC7ydHQZUPan3qs6TUhR+/H2
         dKHg==
X-Gm-Message-State: AOAM532f0erqDjx+QGJ2s7nJ6FZA1X+UAfuZw3UMFDsVfc8nMOg09bs1
        N8ppTAxGpZNeTyyOJkFB3bs=
X-Google-Smtp-Source: ABdhPJzKH7zZX+w1/CASV/hsPLF789vKTPNChepV0A8YkSwDeqrptp1bQ7mY2d3qx22qc7Un4ogTKA==
X-Received: by 2002:a7b:c92d:: with SMTP id h13mr10307101wml.96.1614971838913;
        Fri, 05 Mar 2021 11:17:18 -0800 (PST)
Received: from agape.jhs ([5.171.73.233])
        by smtp.gmail.com with ESMTPSA id a75sm6034433wme.10.2021.03.05.11.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 11:17:18 -0800 (PST)
Date:   Fri, 5 Mar 2021 20:17:16 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: removed unused code block
Message-ID: <20210305191713.GA2466@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed conditional code block checked by unused CONFIG_TX_BCAST2UNI

This patch does the cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 1c23fbe58881..a89b88eaed39 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -212,9 +212,6 @@ int _rtw_xmit_entry(_pkt *pkt, _nic_hdl pnetdev)
 		&& check_fwstate(pmlmepriv, WIFI_AP_STATE) == true
 		&& (IP_MCAST_MAC(pkt->data)
 			|| ICMPV6_MCAST_MAC(pkt->data)
-			#ifdef CONFIG_TX_BCAST2UNI
-			|| is_broadcast_mac_addr(pkt->data)
-			#endif
 			)
 		&& padapter->registrypriv.wifi_spec == 0) {
 		if (pxmitpriv->free_xmitframe_cnt > (NR_XMITFRAME / 4)) {
-- 
2.20.1

