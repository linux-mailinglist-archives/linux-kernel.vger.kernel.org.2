Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD11353867
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhDDOLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhDDOKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FAEC061793
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:10:24 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v4so8747920wrp.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zv6blgVUmmcg0rrTba28HSVxaCH1kZzMtYvEm8Uvvjg=;
        b=Sd7DdYntWCEbA52OQ6osSzKs1EHKTdlo6ePTT0D8DGBA7eGRtt8J53UXh8nO2NBn73
         cAYk8exggiO3SgXP6+Cwfbh/jP+zL3McW/JFI9JaIo5nRZGONLrtLUD+fqVIbbAZ+jgH
         ETAraAFJ2bPuk08VVhlQaschmu3mkezAglt/bXUjZtULt8bDNKJ2No6kIXcGxGM8/ElK
         V73DfB4chG49wdj6gTourVz/h84CDfpvo4xtVj50xO//DP1wfBBbm99HaxqdxDzWqxJs
         asPOoI7Y6VyDd7idiW648NEGfZg+YQhK/Qw+uovvEUGbQMZOiHfYatIsx8AraV0XFsyF
         jqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zv6blgVUmmcg0rrTba28HSVxaCH1kZzMtYvEm8Uvvjg=;
        b=LCLnP2tv8RVprhx3/M/FOKdI0nz86zRL45inE+0vf/DMxEzoqSfT6dk0u15JFSsf5d
         cS84xJjRZZriLABPpSl9wHZyaSaX9/TNXb+RPoU7xXHgqMXwTCzluJ+q+1z6GifbxAiD
         1neCQtmei58pOAqwfXCQJeDFI+az5BY2f0x3emFLFcveG3+b/IDgCeWakALZSyRvs+nF
         qasd10J8jvkwYcLJLYozjhZnz0s3XSBvWHdfYU7ho+Q764RmgHWTT35aMMk2d9EW6i8i
         yN+nhPtgjpgv13RqWDc2qeeqmgZyMQYUcPpBBRo9G8nP1171nQidH5NH/FzvotkmZW9j
         uD4A==
X-Gm-Message-State: AOAM531x/+Hk9jURc+UyX4QEoqP/96EKgriVE+obCjPhGlNgqyzJjqta
        exWB7loju020vNED43KNf0I=
X-Google-Smtp-Source: ABdhPJzkucPICGsyiO+ELiRtEeLavjifxl/6wKTV/4kZKku5x5IaUrE0URa9UikX5QXtO3L8yPBDgw==
X-Received: by 2002:a5d:4e08:: with SMTP id p8mr2112737wrt.4.1617545423794;
        Sun, 04 Apr 2021 07:10:23 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id p18sm23322353wrs.68.2021.04.04.07.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:10:23 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 20/30] staging: rtl8723bs: added spaces around operator in core/rtw_recv.c
Date:   Sun,  4 Apr 2021 16:09:36 +0200
Message-Id: <6202df1b5383aa0a66810358495c2b1c9dd6c189.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit hook checkpatch issue:

CHECK: spaces preferred around that '+' (ctx:VxV)
60: FILE: drivers/staging/rtl8723bs/core/rtw_recv.c:359:
+				if (miccode[i] != *(pframemic+i))
 				                             ^

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 2d749341d47b..953351f896c3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -356,7 +356,7 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 			bmic_err = false;
 
 			for (i = 0; i < 8; i++) {
-				if (miccode[i] != *(pframemic+i))
+				if (miccode[i] != *(pframemic + i))
 					bmic_err = true;
 			}
 
-- 
2.20.1

