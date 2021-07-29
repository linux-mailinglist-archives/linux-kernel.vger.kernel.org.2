Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FC83DA9C0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhG2RKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhG2RJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:09:55 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10FFC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:09:50 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso6562002otq.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y620cawYnn+4V0Xna0MPjJG1IYCOfnYjGSth9ffrkPU=;
        b=bnaU90Pbow0j2N/VSOEIDfj9td1aWUrUZz2/hhYEZSc4/Vb2/v1Btcfw8zeWRNQiIP
         Ds6r6roWPX9w8/Vcsfsj4CIIVo3trxmUHPqybbwtR8AV19d4el3RePdiikWW63kSVb5R
         s4roTm0cYRfS4eXlsQIFCJS1AeDfJv/hoV+hHC9G4LlxYl93SwOfsESrcu+S6WTVvqsl
         X+4lw6V+7mTS5exMxVVdpOkLmJsnf7QMQXVVfQ7UFeZvS7ThnHahxzIq+NtE46wjSEiW
         wHlRk8FnnpeJxoASbJC0503baUWm9FCz3FIM5fKiqN7nfSXUtghmZb2nmWEoKTDraO4b
         B4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=y620cawYnn+4V0Xna0MPjJG1IYCOfnYjGSth9ffrkPU=;
        b=TptNMD/w+LWHTcrrGPTgI0Q9HuueU2RLKx7ZeAmmc3fqdjfr+IMq4qCzQA99ITaVcu
         YDyKJNMQXBMFjOztCyLcHkxiNNFoEl5vugMVViQB2FnLZBBU3tP0z899Q3rDGII2rPJ1
         FLoUnhyrmbgtxIc8re3k1PCKqk38cbb5L+swBDJyAAiRSbpFsCQow+mxEVbIHhCkFgpc
         +BBLmWPBSIQKIMIxL0AwPPpVZcsAe+LOaeP1btsF3K/zKIbz981TYLDIJVMvlK86AJl/
         fAtWs87ESHm58TeYYRS4NRmKgD5n7A0FTJOgak0iYNJf/tCQOEGn63baJx+sBsHzrNFC
         Ac+w==
X-Gm-Message-State: AOAM531sbHotCVXIWgtXMynipO60uXfZS4cuuzz7qwTW4H2SGsoXiw59
        auUFh7DEV6/no5GEn/WERsQ=
X-Google-Smtp-Source: ABdhPJx8n5eGvUzd1xw+yysVYKBGYHpoXipWudoxZFQqXVWT6KvJxAMjaFLZYL/r+Hgte5i8MDIn0g==
X-Received: by 2002:a9d:1d7:: with SMTP id e81mr4208718ote.106.1627578590377;
        Thu, 29 Jul 2021 10:09:50 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id a23sm614358otv.79.2021.07.29.10.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 10:09:49 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 6/6] staging: r8188eu: Add "fallthrough" statement to quiet compiler
Date:   Thu, 29 Jul 2021 12:09:30 -0500
Message-Id: <20210729170930.23171-7-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729170930.23171-1-Larry.Finger@lwfinger.net>
References: <20210729170930.23171-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiler gcc11, and possibly others, emit a warning when a fall-through
case is found in a switch statement. Add a "fallthrough" statement to
eliminate this warning.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 021044768b61..488a18133e59 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -460,7 +460,7 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 			ptable->func = &OnAuth;
 		else
 			ptable->func = &OnAuthClient;
-		/* fall through */
+		fallthrough;
 	case WIFI_ASSOCREQ:
 	case WIFI_REASSOCREQ:
 		_mgt_dispatcher(padapter, ptable, precv_frame);
-- 
2.32.0

