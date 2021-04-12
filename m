Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810A935C4ED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbhDLLWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbhDLLWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:22:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBC9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:21:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t22so5863035ply.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yFCTQ7PANP8vxmOvU5wLD2Qh5bIpwPlUD14vZ3d3jUE=;
        b=tMH9P9QwjcyO5zX9ktssrTVitZPAiaYYMrggHxfNArDTjcfL4XdY7CPu4PTIQvd8c6
         AHbwi5iSqBFEND1f9GiyiQw/QEK29GviiHFvq+OK90OSqsvWv8qrT1Uh4Qke7Y9GMJ5I
         O4EqzwzV41S88KsvPj8UWk/o6gY/4stw2N5k19qLBLeL4K43oU0qKnAPgbLTDP9LLjFG
         0wCgLhegkGtpPUo4vlkV6BMK5qntqd3wtzEzK88IBlsATFQl/K3MAR3HqYK6vO7RY9OE
         rYBiCVCtiKdSd7dbp8wr4AkYVBBGRLYMW2+opXg0Ge4YDt2lB7dN1zgPLTjj6Gh2GQWh
         /Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yFCTQ7PANP8vxmOvU5wLD2Qh5bIpwPlUD14vZ3d3jUE=;
        b=berwmFTX6UqOkqSrh6U77ug3jL+PPTReSbLC3uEc1mZv1j7l3RgKF5Yz5RE31pfx/Q
         +yY9R65HerFGrNqkQMw5jkHGVn8Jxz9X2DRy/D7ataW02Dt1tSTI9h6j11JoG+mF+2T7
         SSJI4Q/vEM1jTy21RL+cCTtleHExwQdAWUByIa/4jePZYaRGpTjCybrvgrqdYdUp9v/B
         BeLf1qZIue2tpnXsQLhiqj8Vofq75TW5P6emDwIGWTyjg/WvuB1A4rFBWfOqCNz9r7O7
         sjqI3RSeh6hamSXglqxar6BPnYJNMB2FOe4wMdxfMPP/HzWPMXgKR2aHrCRgwh+xchD0
         vbwA==
X-Gm-Message-State: AOAM530GtaMYuYO/TDgXfAahhASpVZfdKUIc6VOZMd0xbaIPdWnRE0lN
        MzyC46ngVre/5ZImuuCnAxk=
X-Google-Smtp-Source: ABdhPJzb1vNFSs24X1lKcswhqA9q1ByK9t1DDRWeEsUwY+IQZ+b+dgX5Z6RS13ojOUVhpbOEwIibsg==
X-Received: by 2002:a17:90a:bf17:: with SMTP id c23mr18470563pjs.12.1618226509560;
        Mon, 12 Apr 2021 04:21:49 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id o8sm1859156pjh.20.2021.04.12.04.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:21:49 -0700 (PDT)
Date:   Mon, 12 Apr 2021 16:51:40 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v4 1/3] staging: rtl8192e: remove parentheses around boolean
 expression
Message-ID: <596aa7e6d4e8ce80eaa98519001e17cf9d370f45.1618224838.git.mitaliborkar810@gmail.com>
References: <cover.1618224838.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618224838.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary parentheses around '!xyz' boolean expression as '!'
has higher precedance than '||'

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 
Changes from v3:- No changes.
Changes from v2:- Modified subject description. Changes has been made in
v3.
Changes from v1:- Removed unnecessary parentheses around boolean
expression. Changes has been made in v2.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index b1fa8e9a4f28..431202927036 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -276,7 +276,7 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 	struct rt_hi_throughput *pHT = ieee->pHTInfo;
 	struct ht_capab_ele *pCapELE = NULL;
 
-	if ((!posHTCap) || (!pHT)) {
+	if (!posHTCap || !pHT) {
 		netdev_warn(ieee->dev,
 			    "%s(): posHTCap and pHTInfo are null\n", __func__);
 		return;
-- 
2.30.2

