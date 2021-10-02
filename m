Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE1341FC93
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 16:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbhJBOoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 10:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhJBOog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 10:44:36 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABA4C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 07:42:50 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l6so8190593plh.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=t0Eu+or4Zx1l/oph1/ldEs4+NBM0UXePlavm40JzuOw=;
        b=n1tBbcxo1UuzwW2C0/tMbR/wIjpcQLgxq/HNZ3l1PqrJ34OaPqIlZ8pGRJcsu2Wrex
         XnewG+oNVmxOQqWh4hPRMMTa3UkT3YKKcwM20omSOe6Jc/HLWKoCuG1R4xfzhAyHDDgw
         L5QJruf7D9WrrroUBO7AkFMtM22ntxfe0w1BLCwUp56+dcE4DVn/kuSt94yXH8npkzFL
         yFTw9jGBnu6QjfSvJf50LXVuotjZEHSOQDvUWhsKtK88dT3KutLCvT5Sg0U6yRzO9Udp
         4tvTUxtJIsErwbm40SlqKYXMOO4T2vjBtfKYIHyt3v2BpbWKCCbDDM0u+fGihH3ar2em
         7EIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=t0Eu+or4Zx1l/oph1/ldEs4+NBM0UXePlavm40JzuOw=;
        b=XM8fiFo/32GcAML+BmeD3zw0jE1iJ79xenDVat49HHbbGRmLdfkO4W5DrdfcT5ljAb
         fuU9sncFsEIB4svpS+xRAKyX5lDStiPYs8DFZqIUAMoVs/xivpYZgdSU+AkJvoObw6G2
         8QbQzfL3OCAtx9OQXmvQUB9+V5n3grrxXGjNjGwUFFe10S5PhICMCB4GO0fPgyvJMbBk
         1f+fTN+KZU5wBR0Wa0kj9NINDmtSyFTl/yrJHGPwwjGn46+U3mYdXPP5HY6UawYNBiL/
         OXcg/FVooStF30Gty8hGJWFA/d79AeRtz5MuNYpJbxS3Dmig8R5Xc/YV6ljl/nxkkHnf
         EaPg==
X-Gm-Message-State: AOAM532qUtn2VncmMeIch7t6UJksmKMlfGEAyBEQuTalupooFwgc5BUl
        irhQQprft+WqxPbzDHtB4eY=
X-Google-Smtp-Source: ABdhPJxgkSZn8MkgT6RrTefgWBBoPg/oHtnlXzWlFQK/RnxQJmdB3QwPaM7Csa1csFrUvEF6r429ug==
X-Received: by 2002:a17:90a:307:: with SMTP id 7mr19673013pje.176.1633185769726;
        Sat, 02 Oct 2021 07:42:49 -0700 (PDT)
Received: from user ([223.230.105.60])
        by smtp.gmail.com with ESMTPSA id i12sm9261448pgd.56.2021.10.02.07.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 07:42:49 -0700 (PDT)
Date:   Sat, 2 Oct 2021 20:12:44 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: core: remove power_saving_wk_hdl function
Message-ID: <YVhv5JiHovfdpNGg@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function power_saving_wk_hdl is it just calling rtw_ps_processor.
Instead of power_saving_wk_hdl() call  rtw_ps_processor().

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 3a70776f3304..44a1df4f51d1 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1649,11 +1649,6 @@ u8 rtw_antenna_select_cmd(struct adapter *padapter, u8 antenna, u8 enqueue)
 	return res;
 }

-static void power_saving_wk_hdl(struct adapter *padapter, u8 *pbuf, int sz)
-{
-	 rtw_ps_processor(padapter);
-}
-
 u8 p2p_protocol_wk_cmd(struct adapter *padapter, int intCmdType)
 {
 	struct cmd_obj	*ph2c;
@@ -1890,7 +1885,7 @@ u8 rtw_drvextra_cmd_hdl(struct adapter *padapter, unsigned char *pbuf)
 		dynamic_chk_wk_hdl(padapter, pdrvextra_cmd->pbuf, pdrvextra_cmd->type_size);
 		break;
 	case POWER_SAVING_CTRL_WK_CID:
-		power_saving_wk_hdl(padapter, pdrvextra_cmd->pbuf, pdrvextra_cmd->type_size);
+		rtw_ps_processor(padapter);
 		break;
 	case LPS_CTRL_WK_CID:
 		lps_ctrl_wk_hdl(padapter, (u8)pdrvextra_cmd->type_size);
--
2.32.0

