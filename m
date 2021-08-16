Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80ACA3EDA59
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhHPP7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbhHPP7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:59:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A06C061796
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so269689wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ST/CqS76gXW84UrfFcjVMxVM5TUugWBRCp1rsIVvXzM=;
        b=c9E0txQJyXsoUeoMVbHMfDYwNpzq/zEENZTsWMtvlW4XfWszYpGX0VNDGbyq0U1XV8
         E/2TEhct++u7DZNINo+iRNZsngIIOhu3k/OmAtKZ595CeI2gJk5H2lTTn09kc2LPyTib
         wjzk2yFl9k0TB0RCCzS56fj/JuN5DlnV/zOL2k65PpFXt+8H1BvKuEceSdv9AV7iFj/a
         sKuQ1CnsvolfU2oSftK8J+lmwwgYttSasKMVsYgeTsIo4Bord2VPQgmdBWIoOrp9PL7Q
         MODErTGkdy7fZ906hJs9Iw/+7GSLPFywaMo6apEknysiMd+veJ3pa9e4U0YNquB3hxol
         wXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ST/CqS76gXW84UrfFcjVMxVM5TUugWBRCp1rsIVvXzM=;
        b=bFH4TAUO/sLFrwT0e5XZkHjyJ+aw5B6lOFCgyrWN+TSbfd5P2iuIu/DP8B4N0u9UfQ
         I3kMR6MEqu6LYFAmB5YsSZpZjGdCjkN5ETlFM5PnTbp9i0Nopfrdyni1sZaTikEpewB8
         HLRCkor9BxsvxC/RG2oGctpNpdgojS1JHJCJqnhSCSkD5xS2t9To47yGAvHdRERY6NUE
         9py+/SEocyrQ5UMag5XmhBnGFtbMKui0GVx0JDYGz8xdncqonpV1v8IW9zKqrUkqJl0E
         Z1OPcjt1m8csFnFJwexoez7JUYwgsxgSRySo9oeW/g+l/+A2xJkfZKNW4P6HZqVsWa2s
         DGhA==
X-Gm-Message-State: AOAM533rvc46WzRIl6FsSvypEWud9UGMl0W5NUVdY1FuiTM7kcIk55Rq
        So6xr2rTBFD1cNSjnUxj8GzjtoT9sZE=
X-Google-Smtp-Source: ABdhPJzmCNOVhLQudmqv6Uh7ayaBIoA6rIQpWn7fWm5sf/fTiFAC31Enyh1al6hvanZsCqm0EJHZJw==
X-Received: by 2002:a05:600c:a49:: with SMTP id c9mr15392618wmq.159.1629129558931;
        Mon, 16 Aug 2021 08:59:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 02/23] staging: r8188eu: rewrite subtraction in core/rtw_cmd.c
Date:   Mon, 16 Aug 2021 17:57:57 +0200
Message-Id: <20210816155818.24005-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite subtraction in core/rtw_cmd.c to clear missing spaces around
operator reported by checkpatch.

256-1 -> 255

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index e95cb27516b0..ff6c5fa71101 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -832,10 +832,10 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	psecuritypriv->authenticator_ie[0] = (unsigned char)psecnetwork->IELength;
 
-	if ((psecnetwork->IELength-12) < (256-1)) {
+	if ((psecnetwork->IELength-12) < 255) {
 		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], psecnetwork->IELength-12);
 	} else {
-		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], (256-1));
+		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], 255);
 	}
 
 	psecnetwork->IELength = 0;
-- 
2.32.0

