Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36504398BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhJYOjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhJYOia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:38:30 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E99C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:36:08 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d5so10983999pfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=t4OQ66ZvBHAyhJ9uVXpAWQYYGEql5QgeKqi/VqWJk5A=;
        b=ns7WA1FnYweLTagGyjWNWbcw/2lrTx9JxiO/LTCLl5ud8GGsBGFhNc1covjTQoCyhc
         fMRzqFPA9+9qjWToypMCQU1oxCmhueld5xoARON/OTXMpfkFNtw/pEoWvzazch4EQlYW
         q5Mvad7YuoLqaUy9C7PaQxpR24y/NSOh28hDh19t3B8PzdpTcgPN7RpO15j0mi/KuHsR
         eAhnzyP4zN/DazCZFxnP0CHMPhHtvLjLvMfULrM9Zl07eb5EocL7y+HLzR8eJIxHs0mV
         Qh8NaDK2tJdL0qVpcn55LY1mV9yrUXgnpN54NxRIh+JkW0Os1K/jn2j6qPa47085cwej
         b1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=t4OQ66ZvBHAyhJ9uVXpAWQYYGEql5QgeKqi/VqWJk5A=;
        b=31rFIKqxvW2Sq5k7BbQ0v0NZ61elIvUohVx4/7vfmHo6j9IgPx7YCEvW+EhS+MqfTy
         JXH3nCXHe5ZkVEB1PXGaoFJbNHkN3tWRYOeYMwxhfLwQ48ZlMr6ERRQnmAiL8uJDoDT0
         joMJQNcFEX5ydIrb9BP1AbYfwTbQ9K1Kf/I7HKvQXy+eGSgn71Ul2bRJDL6VzNV+Smzt
         F1Zy7d2i5e4ZoGq+HBR+PAoPt5+tNLVxcLnwQR1rBEieG0lSWX2WNKvcmclD2HicsRX+
         Vt3iAdxPqypy29S2u5eEaggRAEdPf62xvdqUNFOKHgw11TsClV/PqTqWff9+10qwpPgN
         wqug==
X-Gm-Message-State: AOAM533z8HhLZ3/ZBcWx/L2LfnLgaLGguROh/iya8eszOOGqnO9VO6lA
        figALAGZqUFMOo7NAtmSRBl1FWHkXmU=
X-Google-Smtp-Source: ABdhPJxCyITT8b6HYMi39pH3t62DjoZV7i4NB5MGXRnJ8apjStyMCwhEVmSOglqnd2Jp2IWLbrnAxA==
X-Received: by 2002:a63:9212:: with SMTP id o18mr14147341pgd.392.1635172567564;
        Mon, 25 Oct 2021 07:36:07 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([59.95.95.35])
        by smtp.gmail.com with ESMTPSA id d19sm1320789pgk.81.2021.10.25.07.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:36:07 -0700 (PDT)
Date:   Mon, 25 Oct 2021 20:06:00 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH v2] staging: r8188eu: avoid use of goto statement
Message-ID: <YXbA0BgvKZKXApaW@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the goto statement from _rtw_init_cmd_priv(). In this function
goto statement can be replace by return statement. By replacing the
goto statement with return statement local variable "res" is also not
required. As on goto label exit, function only return it is not
performing any cleanup. Avoiding goto statement will simplify the function.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---

ChangeLog V2:

	-Add space after line end on changelog.
	-Remove addition blank link after the local variable res
	 as per the coding guidelines for linux kernel.

ChangeLog V1:

	-Remove the goto statement from _rtw_init_cmd_priv(). In this
	 function goto statement can be replace by return statement.
	 By replacing the goto statement with return statement local
	 variable "res" is also not required. As on goto label exit,
	 function only return it is not performing any cleanup.
	 Avoiding goto statement will simplify the function.

 drivers/staging/r8188eu/core/rtw_cmd.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index e17332677daa..c94b9559b5e4 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -19,8 +19,6 @@ No irqsave is necessary.

 static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 {
-	int res = _SUCCESS;
-
 	sema_init(&pcmdpriv->cmd_queue_sema, 0);
 	/* sema_init(&(pcmdpriv->cmd_done_sema), 0); */
 	sema_init(&pcmdpriv->terminate_cmdthread_sema, 0);
@@ -34,28 +32,23 @@ static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 	pcmdpriv->cmd_allocated_buf = kzalloc(MAX_CMDSZ + CMDBUFF_ALIGN_SZ,
 					      GFP_KERNEL);

-	if (!pcmdpriv->cmd_allocated_buf) {
-		res = _FAIL;
-		goto exit;
-	}
+	if (!pcmdpriv->cmd_allocated_buf)
+		return _FAIL;

 	pcmdpriv->cmd_buf = pcmdpriv->cmd_allocated_buf  +  CMDBUFF_ALIGN_SZ - ((size_t)(pcmdpriv->cmd_allocated_buf) & (CMDBUFF_ALIGN_SZ - 1));

 	pcmdpriv->rsp_allocated_buf = kzalloc(MAX_RSPSZ + 4, GFP_KERNEL);

-	if (!pcmdpriv->rsp_allocated_buf) {
-		res = _FAIL;
-		goto exit;
-	}
+	if (!pcmdpriv->rsp_allocated_buf)
+		return _FAIL;

 	pcmdpriv->rsp_buf = pcmdpriv->rsp_allocated_buf  +  4 - ((size_t)(pcmdpriv->rsp_allocated_buf) & 3);

 	pcmdpriv->cmd_issued_cnt = 0;
 	pcmdpriv->cmd_done_cnt = 0;
 	pcmdpriv->rsp_cnt = 0;
-exit:

-	return res;
+	return _SUCCESS;
 }

 static void c2h_wk_callback(struct work_struct *work);
--
2.33.0

