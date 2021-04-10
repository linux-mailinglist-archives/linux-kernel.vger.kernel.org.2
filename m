Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B952A35AD66
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 15:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhDJNBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 09:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbhDJNBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 09:01:03 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B72C061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 06:00:47 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b26so924373pfr.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 06:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=UGb+/+QBTdjcmOPBbleKfKtPLJksnQcPm+n3W+gASt8=;
        b=TNlJKk2QHf6DUMp1ExtSa9uXzuPXSFsvUI9AIaxi0RSotv+edjw4EGp2O2eWCE0oPj
         /LPgHODBcQAisZRiC5RED/ojXSmMfIMNe7hUTeDeFF5aSHOs2dzW/aVWT2ziTXOVwccf
         zKobpEx50W4hK9CacwVdZpXVDsZSiifnLbhbzKP5n5ExBeM9zGVQxgnLuI2o1vpzJoNB
         WilMwRTNfeIr0uqY3RvKuHY4BRY7Y8Zs0n59P9C03385+fgVHUxkCpOum1fEXwq9/zx8
         s+h0+UroOX1gOV7BR/OSsy+57K6/ttdxXte0qcyH6ItEoiIlfoai8+ufOgOxoiACG70K
         3s6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UGb+/+QBTdjcmOPBbleKfKtPLJksnQcPm+n3W+gASt8=;
        b=nQtuPcSIvmuS3/LA+w5BijKojoQO35aXibQLr0EUfy/3LSt+tTEPqKKDI4jVXxJfTP
         zBIvhGG5aakO198rRdGrWrQ3n1tjLU7F9Jp+WvFi2AW80gA+HGrjRzHynEN6f/vO9A0m
         Jkw5sjFazojsWflCQjm8cghGchTCIaLQljb95MDKl9zKbEJCL/48ANCmM6Kmsa3iIdb0
         75j0W4NOOtUQrdwfZPI4NhtAJ3d8zXwtry1xvXlKGqWzVoJBxClElMin98KuIGro11g+
         8tz9cteVHaqHo3GiwNK8m88J48jHyRHsCEKKAcnc+7+6nzbC9fCHK8vldbw0kiDoeh8i
         iy+Q==
X-Gm-Message-State: AOAM530JconzQM2jCbmn51yy+veNeqXCKgPjKWCc6mcEO6UPnFRTRVSb
        rW1t0a3YXObraBRtZOcjZgQDrxwj5EsP7Q==
X-Google-Smtp-Source: ABdhPJzYcgjyDUn60FRqPJgIQ5PQzJNmo6DputF6cIdX/GoHkLkoq0eh8PueuMkvs04lk4BB3wgyeQ==
X-Received: by 2002:a63:3649:: with SMTP id d70mr17542761pga.1.1618059647127;
        Sat, 10 Apr 2021 06:00:47 -0700 (PDT)
Received: from kali ([106.195.15.71])
        by smtp.gmail.com with ESMTPSA id 12sm1694822pfi.204.2021.04.10.06.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 06:00:46 -0700 (PDT)
Date:   Sat, 10 Apr 2021 18:30:38 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v2] staging: rtl8192e: fixed pointer error by adding '*'
Message-ID: <YHGhdtldqAlRsPHT@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed Comparison to NULL can be written as '!...' by replacing it with
simpler form i.e. boolean expression. This makes code more readable
alternative.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
Changes from v1:- added pointer to the function, which was missed during
fixing v1.

 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 4457c1acfbf6..78b5b4eaec5f 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -327,7 +327,7 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 	}
 
 	*ppTS = SearchAdmitTRStream(ieee, Addr, UP, TxRxSelect);
-	if (ppTS)
+	if (*ppTS)
 		return true;
 
 	if (!bAddNewTs) {
-- 
2.30.2

