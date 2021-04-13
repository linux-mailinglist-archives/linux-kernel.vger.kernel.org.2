Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AFC35D5E6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242544AbhDMDZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242503AbhDMDZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:25:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA04C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:25:28 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 20so3503150pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pb7k5gcwx2hPb9DsQiJub5fjyYCpgcCw0SGHu/Bvicc=;
        b=eyLGoPCXFnG89ajHudvpOQd5GhZxWcC0Q9dKKfYJPAoqSep4Fe8iYcPs5vP/ZsRIKO
         px/ioy62DAQ8QXrZmr5/2A/ctwuMjA11Nrzybl0vxaRtBGyKpFBInXY/U/MU4CZG4eJE
         fsjAuu2HnocgIhyg89ojgybwY6qQHmB6x5wDZA5lGgsUjA7levkx2phhjns2LP28adyH
         qSTTgQQnTwdADfFFcD/ukie1AWbNYyLT7mMHBwthoSG42Xyqg4Yzd06NajkkWgHU+XO/
         0obGieEXj5aDPnMX+HwSv/lvBVIoENudyoI0+94GqlvF/+rcZaHxvsHZlVeIWHZu0vTA
         BetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pb7k5gcwx2hPb9DsQiJub5fjyYCpgcCw0SGHu/Bvicc=;
        b=slCCZfJ6u5X3t+nsNQR/GNYiiZBEx4a3KVYgmz13NWe3uZjCnNTKbR5QsubyU7tj4h
         fCVdmdAQEZGWXtFEWm/4OSFBZv8dPUIP7dwt3WRAXxRmw9OgoO2NiZRo1L+aUkxgKuxR
         Y41iOPdFPFdaNuDQTc13g1ViAgpijodoRTH8ynYj0iCdluSbKsqd2p0hvPyUrnkg5hfw
         8JQbPVFIcDDI/ZkS3DA2kj952sR1db0fKBsMNifLC8BbrTOvk1tJqdXwFpdoiUqgtZc5
         3ADxlWHuBmy2tDyJnZ04FtsivbanoOsT3lwS4hMbQCf+2vMjhBZnFCdAQEPQ4MAtl7PB
         G/Lg==
X-Gm-Message-State: AOAM5309UGjsealjZ2tcGBbw0be1RTT2XkCUDS42NdY9HLfQU71t6u0N
        oyR6aWpKJcJJ3HVbAoUP8Nk=
X-Google-Smtp-Source: ABdhPJwObgy3r3Q6U3/WcSGyVSOKW4dX0p7tKwhvgpSgZqsclPzdBZluDlXYCwDhHaaUs7nH2ve55g==
X-Received: by 2002:a17:90a:af87:: with SMTP id w7mr2496370pjq.187.1618284327677;
        Mon, 12 Apr 2021 20:25:27 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id e65sm11549793pfe.9.2021.04.12.20.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 20:25:27 -0700 (PDT)
Date:   Tue, 13 Apr 2021 08:55:21 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v5 1/3] staging: rtl8192e: remove parentheses around boolean
 expression
Message-ID: <596aa7e6d4e8ce80eaa98519001e17cf9d370f45.1618283232.git.mitaliborkar810@gmail.com>
References: <cover.1618283232.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618283232.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary parentheses around '!xyz' boolean expression as '!'
has higher precedance than '||'

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---

Changes from v4:- No changes.
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

