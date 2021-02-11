Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4198D318951
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 12:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhBKLWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 06:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhBKKvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:51:14 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FC3C061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 02:50:33 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o15so3326646wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 02:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=t7YihBQxYRS5RN6jojsfJMdgONSb0gB1jZLHcnUtfmU=;
        b=JxQaCBgQTgGeHQzJyczrS5ZQmlIiROaXTn+TAiFmlS2QSQnbEMQat3nkryp9ialTHI
         onM1aykeLwAl6wZVf6eQMdaxH6yNWy9qjOK6c39QOPfmLPY5WeLT/YpmyY/EESYGqtB3
         jZO5S+hBn01NH8zazACfvnBlfkBSa50L+B74BsrFxkFxnP8uUCg0I/sFy1qzqPkvETqj
         HeglHNZNcHrjhnu3CnZs9worLJgP4E2CTRAL6cvTI1PdapGKDKs1cVZhlpTo0A8fe+xm
         VXQ4WQ4svhjmD816h4jCYjY9OcquW4p3tUeBpD6VlDMaDb+4Wi86iyMt7qm69gSKBIpM
         Kvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=t7YihBQxYRS5RN6jojsfJMdgONSb0gB1jZLHcnUtfmU=;
        b=heXVsYCyv/9mUtj8y2OiFfoogwUBgAxOLoG+ug+VoJquKwNHF+tIxZtWO5a/wO5oEm
         WbrHtuONCzJLBvC6nLolUx63J6sesxr7oOTuFR5QH91snX+TG2a6TOI+oGR+uD4xsrFN
         O0K8Np7JzAr35ZecucZIee1RWLQT2vFrNCsf1h3AZ2RR7b6xwa9dpcyTNJtxYCpqFCNH
         ga1kTmK7dJqppqMvwywGOK4SFPh/LeZVb8CLDjAxDkxuBefMprAbUZz+o/0vPQuHWkd5
         J0NXA8KkCa+lu7dmi8+mrI/fDDgCoD1s6oDV3vjQrX2iPJZaGiAzLW1+C9UDgj1hQyxZ
         3gjw==
X-Gm-Message-State: AOAM5304TNkRY5cU9c3cnAciNItRIwp8n+L9Rf3i4r2vBHb9TC+XHn8r
        vy28Aps3SK8YaPmGf0dxDDk=
X-Google-Smtp-Source: ABdhPJwKhkASt6FipVvKwdf5qpPlgD+xcb35jFmko+dnjdHJJPmnL/CdJtS9+8zVjxeB1ajwi4CGVA==
X-Received: by 2002:a05:600c:4a09:: with SMTP id c9mr4414469wmp.91.1613040631942;
        Thu, 11 Feb 2021 02:50:31 -0800 (PST)
Received: from LEGION ([27.255.58.138])
        by smtp.gmail.com with ESMTPSA id h12sm4565086wru.18.2021.02.11.02.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 02:50:31 -0800 (PST)
Date:   Thu, 11 Feb 2021 15:50:26 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     musamaanjum@gmail.com
Subject: [PATCH] staging: wfx: avoid defining array of flexible struct
Message-ID: <20210211105026.GA45458@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this particular case, the struct element is already flexible struct.
Thus struct element ie[] is ambiguous inside another struct. The members
of struct element ie aren't being accessed in code anywhere. The data of
u8 type is copied in it. So it has been changed to u8 ie[] to make the
sparse happy and code simple.

Warning from sparse:
drivers/stagingwfx/hif_tx.c: note: in included file (through drivers/stagingwfx/data_tx.h, drivers/staging//wfx/wfx.h):
drivers/staging//wfx/hif_api_cmd.h:103:26: warning: array of flexible structures

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 drivers/staging/wfx/hif_api_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/hif_api_cmd.h b/drivers/staging/wfx/hif_api_cmd.h
index 11bc1a58edae..58c9bb036011 100644
--- a/drivers/staging/wfx/hif_api_cmd.h
+++ b/drivers/staging/wfx/hif_api_cmd.h
@@ -100,7 +100,7 @@ struct hif_req_update_ie {
 	u8     reserved1:5;
 	u8     reserved2;
 	__le16 num_ies;
-	struct element ie[];
+	u8     ie[];
 } __packed;
 
 struct hif_cnf_update_ie {
-- 
2.25.1

