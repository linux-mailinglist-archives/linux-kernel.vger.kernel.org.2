Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7933874F1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347421AbhERJV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:21:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43134 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240078AbhERJVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:21:23 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14I9Ct0k023204;
        Tue, 18 May 2021 09:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=n8e6VGBvsEJjz8jZNXiVgvyKjF6tuVQmtskn3RF1rFc=;
 b=F1Z3+HjIpu2VLqZj+6IImaud6ddlLKvI5yuSt3L+3KAn9/P+sStIEQY4VzubmJzuqV8G
 ioigVJBjDbFVJwW74ZrvqJYGVZFCA04MPDux/khlD/io/PTD5AdXQNTEDqQGpfuHNkjc
 n9E/Dbih/rshzYp/mNDeA+GOtjArDO/iz9bLc32PWd58Yx9gMziogIFOLYkUc9uZ97dO
 D8yC7ePbxMN/nmISSz01szddAbPkkN8Q2MmhASW+NXTWYaaEfNUu98W6t1JApjM8zU8k
 kFGhc668mKlBvRYyKK56xXWn57y7ZB/jPj5G0/oR9XNE0eQ6wmuDGgM5X5WcU79fJ3v3 sw== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38m9bgg1aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 09:19:53 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14I9AtTB090680;
        Tue, 18 May 2021 09:19:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38j3du6x53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 09:19:52 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14I9JpEC109238;
        Tue, 18 May 2021 09:19:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 38j3du6x4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 May 2021 09:19:51 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14I9Jdlx012420;
        Tue, 18 May 2021 09:19:39 GMT
Received: from mwanda (/62.8.83.26)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 May 2021 02:19:39 -0700
Date:   Tue, 18 May 2021 12:19:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/bridge: ti-sn65dsi86: fix a ternary type promotion bug
Message-ID: <YKOGogHasIyvF8nj@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: b9ooFrFJESALkdzw1ESlb6Ymmjg1FYhe
X-Proofpoint-GUID: b9ooFrFJESALkdzw1ESlb6Ymmjg1FYhe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ti_sn_aux_transfer() function returns ssize_t (signed long).  It's
supposed to return negative error codes or the number of bytes
transferred.  The "ret" variable is int and the "len" variable is
unsigned int.

The problem is that with a ternary like this, the negative int is first
type promoted to unsigned int to match "len" at this point it is a high
positive value.  Then when it is type promoted to ssize_t (s64) it
remains a high positive value instead of sign extending and becoming a
negative again.

Fix this by removing the ternary.

Fixes: b137406d9679 ("drm/bridge: ti-sn65dsi86: If refclk, DP AUX can happen w/out pre-enable")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index bb0a0e1c6341..45a2969afb2b 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1042,7 +1042,9 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 	pm_runtime_mark_last_busy(pdata->dev);
 	pm_runtime_put_autosuspend(pdata->dev);
 
-	return ret ? ret : len;
+	if (ret)
+		return ret;
+	return len;
 }
 
 static int ti_sn_bridge_parse_dsi_host(struct ti_sn65dsi86 *pdata)
-- 
2.30.2

