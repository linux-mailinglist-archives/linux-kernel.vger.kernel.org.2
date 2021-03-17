Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E24C33EC04
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhCQI6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhCQI5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:57:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8E8C061765
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:57:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b9so950053wrt.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHS0YjWdwFJSN1VWVbYNsptYDs5Fwc3UmjtJJxuBnoI=;
        b=bd2kG5EPTmQJeA6t8WaOQnFRXKkDR3BMi8kDcQikR5twG4YRU3gLdOjJDKAoej7ZGL
         wZwGwuS6cWBS81PFhdOHVoQ7Oljwl88rHPcre4OcRLOHZwlSXHmEUJ4hSTxFOiRoBwjB
         QpqGk74mim16Za7N+MVQrY5SBbtJNkB28Z3/FJtEXQyY/W0FV69s/uSl74HmJxzVYUg0
         NMJVuqubf2JLrHVLNaC4rW7xWh1JoWKbWJYCcTyp66H2SJpwWlqXWcvZT8Y+5Bg+9kCC
         efO2hQ6/rbEVfQGOW05A7XwV0Qazx5BbzjQpUtvzKfQHsdIk2BkWl9XvvlqP3FZzv7yR
         b1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHS0YjWdwFJSN1VWVbYNsptYDs5Fwc3UmjtJJxuBnoI=;
        b=XJND3DR8n7PgqRA+S7jSLmkR88jFnINyWtwW7ze03edF4An48SBrCBZZgd8uw1P6P0
         OPZ6yo+37UDkrfUHPKtbagfZZCp2AMsHzi2NwXUA1aLCKcj/6KcTTn68vi8zPbwf04X2
         Vxt8oh0VW5YpKbB64U36lvOxpBo8fD2VuuQhvngWI/KhBB/V2Cg86iaRXpw317fRg+yB
         SP5YIFAHMzDib/dwTR41qLbLoaNzKQtQEDob5GnksG4MgcisntpCqaS9mmQN1n4Ccv0d
         kKqWtH9HTQ1/AD72Euz/kwXgqc3ihgNTCTt3JcYKGJcDuzfEtlOdWjagyWRuMbBADG6V
         JLPg==
X-Gm-Message-State: AOAM531XCAXB5c6isishiksrQ58o0hvVjkbN307ZOnrRPwuI4cuP2Grz
        JHvrAP+GT0w3uYVj7npuv3LfJA==
X-Google-Smtp-Source: ABdhPJw7IDG/Hu+h6a5Wu25E5StVwC8pvUyd1nxG8QhvDpv4nG2qOmqcsEVTeYDANh7nkWJteGYFsQ==
X-Received: by 2002:adf:ea47:: with SMTP id j7mr3121325wrn.377.1615971439380;
        Wed, 17 Mar 2021 01:57:19 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j123sm1807243wmb.1.2021.03.17.01.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:57:18 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 14/18] scsi: FlashPoint: Remove unused variable 'TID' from 'FlashPoint_AbortCCB()'
Date:   Wed, 17 Mar 2021 08:56:57 +0000
Message-Id: <20210317085701.2891231-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317085701.2891231-1-lee.jones@linaro.org>
References: <20210317085701.2891231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/FlashPoint.c: In function ‘FlashPoint_AbortCCB’:
 drivers/scsi/FlashPoint.c:1618:16: warning: variable ‘TID’ set but not used [-Wunused-but-set-variable]

Cc: Khalid Aziz <khalid@gonehiking.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/FlashPoint.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/FlashPoint.c b/drivers/scsi/FlashPoint.c
index f479c542e787c..0464e37c806a4 100644
--- a/drivers/scsi/FlashPoint.c
+++ b/drivers/scsi/FlashPoint.c
@@ -1615,7 +1615,6 @@ static int FlashPoint_AbortCCB(void *pCurrCard, struct sccb *p_Sccb)
 
 	unsigned char thisCard;
 	CALL_BK_FN callback;
-	unsigned char TID;
 	struct sccb *pSaveSCCB;
 	struct sccb_mgr_tar_info *currTar_Info;
 
@@ -1652,9 +1651,6 @@ static int FlashPoint_AbortCCB(void *pCurrCard, struct sccb *p_Sccb)
 			}
 
 			else {
-
-				TID = p_Sccb->TargID;
-
 				if (p_Sccb->Sccb_tag) {
 					MDISABLE_INT(ioport);
 					if (((struct sccb_card *)pCurrCard)->
-- 
2.27.0

