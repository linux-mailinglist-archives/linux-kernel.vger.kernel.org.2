Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4BC444D75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 04:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhKDDFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 23:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhKDDFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 23:05:43 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C43C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 20:03:05 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q126so213936pgq.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 20:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3TbuVrqIHgoJItA0iZIsVPVT8KU30Jz3Smu+Nxso5mw=;
        b=X3Up2YGaJ2EQyVHNyGp+Md+8unbD3tz2EwR8DJc0mDIncnRmdMumaTj17ZZWskrz19
         uwPnu0WQ1JNIJH8NAmj4CKtrhISKBuyJZRjC82gln8gd7O6qQ9npyAZE97/1MzSoqyM+
         hN958CQo1eND3gnqpM5S+QwGGZ9DfWjgusVGU+cm9oP6RBAPR+7PNojDZulTfzQEd+a5
         3XQPmx2goitRYohc45ZKh3H7o4Byf8ofCiEvBDCSZMEe+EQMIYLfEpoGTjsVuAzoCEji
         PcoKHdU3StS2gvjY5RLSGnXY9L7GUCSAxHGRYSyWxS6GV4xR809MAPSQaJSWgpys/GjV
         XEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3TbuVrqIHgoJItA0iZIsVPVT8KU30Jz3Smu+Nxso5mw=;
        b=ohjXaG0o/zopf83OjIanMiygJV0v/G+qernxfPibmluQDFtHcVWJqTHSZDoKLPgFFk
         0fbDggFO4b+dOn2/xxVX1nYcf7jqQoP0VrMw8gt9OUOmkCQpWIQpRtp4eGGttvOhhSl8
         nyk2f2Nv/1Z8LQvA22I6HH0godnu6uaRAq8Z22vcJ7A0Z8iJG/dZltk7lxUWlFzcFnqu
         dyWsI8s9wiarhqPRIYpgiUZMkij+OTgt6RWS0DaTSjx9F6QTQpoJ8dweaIf5zmkWASKp
         g5iSK0eb5R30wfYhWjRngC1g0mWKGMVpRwNDqGeg3pEOTJoTCBxmKuMLeVwqkYinKGuE
         WwzQ==
X-Gm-Message-State: AOAM533JuRJtUjUPYF+A0KahYOsALfaqRH77zmNTy43cQa4lbAOCvq9u
        WwMZlY2Q+aiCDZWk56iEDd8=
X-Google-Smtp-Source: ABdhPJy1HKFE4qWdl7sA91g3enosuIJfnU1FFZH9a5c+8iIl+dTuaSsEcf/W8BQSIezcA3K7Bo09rQ==
X-Received: by 2002:a63:cf48:: with SMTP id b8mr15940318pgj.434.1635994985308;
        Wed, 03 Nov 2021 20:03:05 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([59.95.84.218])
        by smtp.gmail.com with ESMTPSA id z10sm3665213pfh.106.2021.11.03.20.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 20:03:05 -0700 (PDT)
Date:   Thu, 4 Nov 2021 08:32:58 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: core: remove unused variable sz
Message-ID: <YYNNDXtkICWpk6qj@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused variable sz from function dynamic_chk_wk_hdl.
This variable is not used on function.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index e17332677daa..d456c7e8089d 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -961,7 +961,7 @@ static void traffic_status_watchdog(struct adapter *padapter)
 	pmlmepriv->LinkDetectInfo.bHigherBusyTxTraffic = bHigherBusyTxTraffic;
 }

-static void dynamic_chk_wk_hdl(struct adapter *padapter, u8 *pbuf, int sz)
+static void dynamic_chk_wk_hdl(struct adapter *padapter, u8 *pbuf)
 {
 	struct mlme_priv *pmlmepriv;

@@ -1382,7 +1382,7 @@ u8 rtw_drvextra_cmd_hdl(struct adapter *padapter, unsigned char *pbuf)

 	switch (pdrvextra_cmd->ec_id) {
 	case DYNAMIC_CHK_WK_CID:
-		dynamic_chk_wk_hdl(padapter, pdrvextra_cmd->pbuf, pdrvextra_cmd->type_size);
+		dynamic_chk_wk_hdl(padapter, pdrvextra_cmd->pbuf);
 		break;
 	case POWER_SAVING_CTRL_WK_CID:
 		rtw_ps_processor(padapter);
--
2.33.0

